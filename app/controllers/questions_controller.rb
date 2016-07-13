class QuestionsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :append_question_vote, :edit, :update, :destroy]
  before_filter :require_permission, only: [:edit, :destroy]
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'
  autocomplete :question, :title

  def index
    @questions=Question.questions_list(params)
  end

  def show
  end

  def new
    @question= current_user.questions.new
    @modal_dialog = false
    if request.format == :json
      @modal_dialog = true
      render json: {html: render_to_string("/questions/_form", layout: false)} and return
    end
  end

  def edit
  end

  def create
    @question = current_user.questions.new(question_params)
    if @question.save
      redirect_to @question, notice: t(:question_create)
    else
      render :new
    end
  end

  def update
    if @question.question_box!= params[:question][:question_box]
      @question.save_history(params)
    end
    @question.update_attributes(question_params)

    if @question.save
      redirect_to questions_path, notice: t(:question_updated)
    else
      render :edit
    end
  end

  def destroy
    # p params[:question_id]
    # p params[:answer_id]
    @question.destroy
    redirect_to questions_url, notice: t(:question_destroy)
  end

  def question_history
    @question_history = Question.list_comment_history(params[:history_id])
  end

  private

  def set_post
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :question_box, :user_views, {:tag_list => []})
  end

  def answer_params
    if request.post?
      params.require(:answer).permit(:answer)
    end
  end



  def require_permission
    if current_user != @question.user
      redirect_to questions_path, notice: 'You are not allowed to edit this question'
    end
  end

end



