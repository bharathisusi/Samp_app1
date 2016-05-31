
class CommentsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :find_question, only: [:create, :show, :edit, :new, :update, :destroy]

  def new
    commentable = find_commentable
    @commentable= commentable.comments.new
    render json: {html: render_to_string("/comments/_form", layout: false, locals: {question_id: @question, comment_id: @commentable})} and return
  end

  def index
    @comments=Comment.all
  end

  def destroy
    @commentable.destroy
    if(@commentable.commentable_type == "Question")
      redirect_to @question, notice: t(:question_comment_destroy)
    else
      redirect_to @question, notice: t(:answer_comment_destroy)
    end
  end

  def update
    commentable = find_commentable
    if @commentable.check_history?
      params = post_params.merge(history_id: @commentable.id)
      @commentable = commentable.comments.new(params)
      @commentable.user = current_user
      @commentable.save
    else
      params = post_params.merge(history_id: @commentable.history_id)
      @commentable = commentable.comments.new(params)
      @commentable.user = current_user
      @commentable.save

    end
    if(@commentable.commentable_type == "Question")
      redirect_to @question, notice: t(:question_comment_updated)
      redirect_to @question, notice: t(:answer_comment_updated)
    end

  end

  def create
    commentable = find_commentable
    @commentable = commentable.comments.new(post_params)
    @commentable.user = current_user
    respond_to do |format|
      @commentable.save
        #format.json {}
        # if(@commentable.commentable_type == "Question")
          # render js: {action: 'show', status: :created, location: commentable}
          format.html {redirect_to @question, notice: t(:question_comment_create), id: "question_comment"}
          # format.js { render action: 'append', status: :created, location: commentable }
          format.js { render '/questions/show.js.erb'}
        # else
        #   redirect_to @question, notice: t(:answer_comment_create)
        # end
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

