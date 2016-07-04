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
    render :nothing => true
    # if(@commentable.commentable_type == "Question")
    #   redirect_to @question, notice: t(:question_comment_destroy)
    # else
    #   redirect_to @question, notice: t(:answer_comment_destroy)
    # end
  end

  def update
    commentable = find_commentable
    old_id = params[:id]
    p "=============id=======#{old_id}"
    p  @commentable.comment
    p params[:comment][:comment]
    if @commentable.comment != params[:comment][:comment]
      @commentable.histories.new(description: @commentable.comment)
      @commentable.update_attributes(comment_params)

    else
      p "jjjjjjjjjjjjjjjjjjjjj"
      @commentable.update_attributes(comment_params)
    end
    @commentable.save
    respond_to do |format|
      if(@commentable.commentable_type == "Question")
        format.js { render '/questions/comment_edit.js.erb',locals: {question: @question, comment: @commentable, id: old_id}}
      else
        format.js { render '/answers/answer_comment_edit.js.erb',locals: {question: @question, comment: @commentable, id: old_id}}
      end
    end
  end

  def create
    commentable = find_commentable
    @commentable = commentable.comments.new(comment_params)
    @commentable.user = current_user
    respond_to do |format|
      @commentable.save
        #format.json {}
      if(@commentable.commentable_type == "Question")
        # render js: {action: 'show', status: :created, location: commentable}
        format.html {redirect_to @question, notice: t(:question_comment_create), id: "question_comment"}
        # format.js { render action: 'append', status: :created, location: commentable }
        format.js { render '/questions/show.js.erb'}
      else
        format.html {redirect_to @question, notice: t(:answer_comment_create), id: "answer_comment"}
        format.js { render '/answers/show_comment.js.erb'}
      #   redirect_to @question, notice: t(:answer_comment_create)
      end
    end
  end

  def edit
    render json: {html: render_to_string("/comments/_form", layout: false, locals: {question_id: @question, comment_id: @commentable})} and return

  end


  def comment_history
    @comment_history = Comment.list_comment_history(params[:history_id])
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def comment_params
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

