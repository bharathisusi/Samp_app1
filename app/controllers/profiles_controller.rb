class ProfilesController < ApplicationController
  before_action :set_profile, only: [:edit, :update]
  # before_action :set_question, only: [:show]

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to questions_path, notice: t(:question_create)
    end
  end

  def index
    @profiles = Profile.all
  #   @questionss = Question.all
  end

  def edit
  end
  def update
    if @profile.update(profile_params)
      redirect_to questions_path, notice: t(:profile_update)
    end

  end


  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  # def set_question
  #   @question = Question.find(params[:question_id])
  # end

  def profile_params
    params.require(:profile).permit(:first_name, :last_name, :tag, :organization, :description, :country, :state, :city, :image, :image_cache, :remove_image)
  end
end
