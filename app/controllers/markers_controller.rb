class MarkersController < ApplicationController

  def show
    @markers = Marker.all
    render json: @markers
  end

  def new
  end

  def create
    @marker = Marker.new
    @id = params[:group_id]
    @group = Group.find(@id)
    @members = @group.members
    @member = Member.where(group: @group).find_by(user: current_user)
    @marker.latitude = params[:latitude]
    @marker.longitude = params[:longitude]
    @marker.member = @member
    @marker.title = "Title: "
    @marker.description = "Description: "
    @marker.user = current_user.email
    @marker.save
    @markers = Marker.where(member: @members)
    @lastmarker = @markers.last
    render json: @lastmarker
  end
end
