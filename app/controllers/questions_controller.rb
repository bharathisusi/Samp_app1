
class QuestionsController < ApplicationController


  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :require_permission, only: [:edit, :destroy]

  def index
    @questions=Question.all
  end

  def show
  end

  # GET /posts/new
  def new
    @question= current_user.questions.new
  end

  def edit
  end

  # GET /posts/1/edit


  # POST /posts
  # POST /posts.json
  def create
    @question = current_user.questions.new(post_params)
    if @question.save
      redirect_to questions_path, notice: 'Question was successfully created.'
    else
      render :new
    end
  end

  def update
    if @question.update(post_params)
       redirect_to questions_path, notice: 'Question was successfully updated.'

    else
      render :edit

    end

  end


  def destroy
    @question.destroy
    redirect_to questions_url, notice: 'Question was successfully destroyed.'

  end



  private

    def set_post
      @question = Question.find(params[:id])
    end


    def post_params
      params.require(:question).permit(:question_box)
    end
    def require_permission
      if current_user != @question.user
        redirect_to questions_path, notice: 'You are not allowed to edit this question'
      end
    end
end


