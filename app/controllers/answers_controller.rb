class AnswersController < ApplicationController


  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :find_question, only: [:create, :show, :edit, :new, :update, :destroy]
  before_filter :require_permission, only: [:new ,:create]

  #before_filter :require_permission, only: [:edit, :destroy]

  def index
    @answers=Answer.all
  end

  def show

  end

  # GET /posts/new
  def new
    @answer= @question.answers.new
    #@answer= Answer.new
  end

  def edit

  end

  # GET /posts/1/edit


  # POST /posts
  # POST /posts.json
  def create
    @answer= @question.answers.new(post_params)
    @answer.user = current_user

    params[:test_date]

    #@question = @user.questions.build(post_params)
    if @answer.save
      redirect_to @question, notice: 'Answer was successfully created.'
      #format.json { render :show, status: :created, location: questions(@answer)}
    else
      render :new
      #format.json { render json: @answer.errors, status: :unprocessable_entity }
    end
  end


  # DELETE /posts/1
  # DELETE /posts/1.json
  def update
    if @answer.update(post_params)
      redirect_to @question, notice: 'Answer was successfully updated.'
      #format.json { render :show, status: :ok, location: @article }
    else
      render :edit
      #format.json { render json: questions_path.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    p request.method
    @answer.destroy
    redirect_to @question, notice: 'Answer was successfully destroyed.'

  end




  private
    # Use callbacks to share common setup or constraints between actions.
  def set_post
    @answer = Answer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:answer).permit(:answer)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end
  def require_permission
      unless current_user.answers.where(question_id: @question).first.blank?
        redirect_to @question, notice: 'You are not allowed to answer this question again'
    #Or do something else here

      end
  end

end


