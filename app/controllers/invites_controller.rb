class InvitesController < ApplicationController

  def create
    @invite = Invite.new
    @invite.group = Group.find(params[:group_id])
    @invite.user = User.find(params[:invite][:user_id])
    @invite.save
    redirect_to group_path(@invite.group)
  end

  def acceptgroup
    @member = Member.new
    @member.user = current_user
    @member.group = Group.find(params[:group_id])
    @member.save!
    @invite = Invite.where(user: current_user).find_by(group: @member.group)
    @invite.destroy!
    redirect_to group_path(@member.group)
  end

  def denygroup
    @group = Group.find(params[:group_id])
    @invite = Invite.where(user: current_user).find_by(group: @group)
    @invite.destroy!
    redirect_to profile_path(current_user.profile)
  end
end
