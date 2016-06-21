class TagsController < ApplicationController

  def index
    @tags =  ActsAsTaggableOn::Tag.all
  end

  def new
    @tag = ActsAsTaggableOn::Tag.new
    p @tag
    p "gggggggggggggggggg"
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
    params.require(:tag).permit(:name, :description)
  end

end
