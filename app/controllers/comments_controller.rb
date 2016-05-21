class CommentsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :find_question, only: [:create, :show, :edit, :new, :update, :destroy]

  def new
    commentable = find_commentable
    @commentable= commentable.comments.new
  end

  def index
    @comments=Comment.all
  end

  def destroy
    @commentable.destroy
    if(@commentable.commentable_type == "Question")
      redirect_to @question, notice: 'Question_Comment was successfully destroyed.'
    else
      redirect_to @question, notice: 'Answer_Comment was successfully created.'
    end
  end

  def update
    commentable = find_commentable
    if @commentable.check_history?
      p true
      params = post_params.merge(history_id: @commentable.id)
      @commentable = commentable.comments.new(params)
      @commentable.user = current_user
      @commentable.save
    else
      p false
      params = post_params.merge(history_id: @commentable.history_id)
      @commentable = commentable.comments.new(params)
      @commentable.user = current_user
      @commentable.save

    end
    # @commentable.update(post_params)
    if(@commentable.commentable_type == "Question")
      redirect_to @question, notice: 'Question_Comment was successfully updated.'
    else
      redirect_to @question, notice: 'Answer_Comment was successfully updated.'
    end

  end
  def create
    commentable = find_commentable
    @commentable = commentable.comments.new(post_params)
    @commentable.user = current_user
    if @commentable.save
      if(@commentable.commentable_type == "Question")
        redirect_to @question, notice: 'Question_Comment was successfully created.'
      else
        redirect_to @question, notice: 'Answer_Comment was successfully created.'
      end
    else
      render :new
    end
  end

  def edit
  end


  def comment_history
    @comment_history = Comment.list_comment_history(params[:history_id], params[:dont_show])
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:comment).permit(:comment)
  end

  def find_commentable
    if params[:question_id] && params[:answer_id]
      klass = "answers"
      id = params[:answer_id]
    else
      klass = "questions"
      id = params[:question_id]
    end
    return "#{klass}".singularize.classify.constantize.find(id)
  end

  def set_post
    @commentable = Comment.find(params[:id])
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

end

