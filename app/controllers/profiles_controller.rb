class ProfilesController < ApplicationController
  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
    @user = @profile.user
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])
    if @profile.update(profile_params)
      flash[:notice] = "Profile updated!"
      redirect_to profile_path(@profile)
    else
      flash[:error] = "Did not manage to update profile. #{@profile.errors.full_messages.join(', ')}."
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(
      :name,
      :location,
      :about,
      :avatar_url
    )
  end
end
