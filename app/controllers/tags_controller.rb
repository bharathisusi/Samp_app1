class TagsController < ApplicationController
  autocomplete :tag, :name


  def index
    if params[:tag]
      p "tagggggggggggggggg"
      @questions= Question.tagged_with(params[:tag])
      render '/questions/index'
    else
      @tags =  ActsAsTaggableOn::Tag.all
    end

  end

  def new
    p "tagggggggnewwwwwwwwwwwww"
    @tag = ActsAsTaggableOn::Tag.new
  end

  def create

    @tag =  ActsAsTaggableOn::Tag.new(tag_params)
    p "ddddddddddddddddddddddd"
    if @tag.save
      redirect_to questions_path, notice: t(:question_create)
    else
      render :new
    end

  end

  private

  def tag_params
    params.require(:tag).permit(:name, :description)
  end

end
