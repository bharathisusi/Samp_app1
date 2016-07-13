class TagsController < ApplicationController
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'


  def index
    if params[:tag] && params[:user_id]
      if current_user
        @questions = current_user.questions.tagged_with(params[:tag])
        render '/questions/index'
      end

    elsif params[:tag]
      @questions= Question.tagged_with(params[:tag])
      render '/questions/index'
    else
      @tags =  ActsAsTaggableOn::Tag.all
    end

  end

  def new
    @tag = ActsAsTaggableOn::Tag.new
  end

  def create
    @tag =  ActsAsTaggableOn::Tag.new(tag_params)
    if @tag.save
      redirect_to questions_path, notice: t(:question_create)
    else
      render :new
    end

  end

  private

  def tag_params
    params.require(:tags).permit(:name, :description)
  end

end
