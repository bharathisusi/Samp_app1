class QuestionsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :append_question_vote, :edit, :update, :destroy]
  before_filter :require_permission, only: [:edit, :destroy]

  def index
    @questions=Question.paginate(page: params[:page], per_page: params[:per_page])
  end

  def show
    @answer=Answer.paginate(page: params[:page])
  end

  # GET /posts/new
  def new
    @question= current_user.questions.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @question = current_user.questions.new(post_params)
    if @question.save
      redirect_to @question, notice: t(:question_create)
    else
      render :new
    end
  end

  def update
    if @question.check_history?
      params = post_params.merge(history_id: @question.id)
      @question = current_user.questions.new(params)
      @question.save
    else
      params = post_params.merge(history_id: @question.history_id)
      @question = current_user.questions.new(params)
      @question.save
    end

    if @question.save
       redirect_to questions_path, notice: t(:question_updated)
    else
      render :edit
    end
  end


  def destroy
    @question.destroy
    redirect_to questions_url, notice: t(:question_destroy)
  end

  def question_history
    @question_history = Question.list_comment_history(params[:history_id], params[:dont_show])
  end

  private

  def set_post
    @question = Question.find(params[:id])
  end


  def post_params
    params.require(:question).permit(:title, :question_box, :user_views)
  end

  def require_permission
    if current_user != @question.user
      redirect_to questions_path, notice: 'You are not allowed to edit this question'
    end
  end

end


