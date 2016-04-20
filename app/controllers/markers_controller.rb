class MarkersController < ApplicationController

  def show
    @markers = Marker.all
    render json: @markers
  end

  def new
  end

  def create
    @marker = Marker.new
    @url = params[:url]
    @id = @url.split("/")[-1]
    @group = Group.find(@id)
    @member = Member.where(group: @group).find_by(user: current_user)
    @marker.latitude = params[:latitude]
    @marker.longitude = params[:longitude]
    @marker.member = @member
    @marker.title = "WOAH"
    @marker.save
    @markers = Marker.where(group: @group)
    render json: @markers
  end
end
