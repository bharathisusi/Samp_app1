class AnswersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :find_question, only: [:create, :show, :edit, :new, :update, :destroy]
  before_filter :require_permission, only: [:new ,:create]

  def index
  end

  def show
  end

  def new
    @answer= @question.answers.new
    render json: {html: render_to_string("/answers/_form", layout: false, locals: {question_id: @question})} and return
  end

  def edit
    render json: {html: render_to_string("/answers/_form", layout: false, locals: {question_id: @question, answer_id: @answer})} and return
  end

  def create
    @answer= @question.answers.new(answer_params)
    @answer.user = current_user
    respond_to do |format|
      @answer.save
        format.html {redirect_to @question, notice: t(:question_comment_create)}
        format.js { render '/answers/show.js.erb'}
    end
  end

  def update
    old_id = params[:id]
    if @answer.answer!= params[:answer][:answer]
      @answer.histories.new(description: @answer.answer)
      @answer.update_attributes(answer_params)
    else
      @answer.update_attributes(answer_params)
    end

    respond_to do |format|
      @answer.save
      format.html {redirect_to  @question, notice: t(:answer_updated)}
      format.js { render '/answers/answer_edit.js.erb',locals: {question: @question, answer: @answer, id: old_id}}
    end

  end

  def destroy
    @answer.destroy
    render :nothing => true
  end

  def answer_history
    @answer_history = Answer.list_comment_history(params[:history_id])
  end

  private
  def set_post
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:answer)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end
  def require_permission
    unless current_user.answers.where(question_id: @question).first.blank?
      redirect_to @question, notice: 'You are not allowed to answer this question again'
    end
  end

end


