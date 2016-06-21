class QuestionsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :append_question_vote, :edit, :update, :destroy]
  before_filter :require_permission, only: [:edit, :destroy]

  def index
    if params[:tag]
      @questions= Question.tagged_with(params[:tag])
    else
      @questions=Question.includes(:user, :votes, :answers, :histories, :tags).order("created_at DESC").paginate(page: params[:page], per_page: params[:per_page])
      #
    end

  end

  def show

  end

  def new
    @question= current_user.questions.new

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
      @question.histories.new(description: @question.question_box, title: params[:question][:title], tags: params[:question][:tag_list])
      @question.update_attributes(question_params)
    else
      @question.update_attributes(question_params)
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
    @question_history = Question.list_comment_history(params[:history_id])
  end

  private

  def set_post
    @question = Question.find(params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :question_box, :user_views, :tag_list)
  end

  def require_permission
    if current_user != @question.user
      redirect_to questions_path, notice: 'You are not allowed to edit this question'
    end
  end

end



