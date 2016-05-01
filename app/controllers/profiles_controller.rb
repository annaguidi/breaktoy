class ProfilesController < ApplicationController
  before_action :authorize_user, only: [:show, :edit, :update]

  def index
    @profiles = Profile.all
  end

  def show
    @profile = Profile.find(params[:id])
    @invites = Invite.where(user: current_user).where(accepted: false)
    @user = @profile.user
  end

  def edit
    @profile = Profile.find(params[:id])
    if current_user.email == @profile.user.email
      render :edit
    else
      redirect_to root_path
    end
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
      :location,
      :about,
      :avatar_url,
      :remove_avatar_url
    )
  end

  def authorize_user
    if !user_signed_in?
      redirect_to root_path
    end
  end
end
