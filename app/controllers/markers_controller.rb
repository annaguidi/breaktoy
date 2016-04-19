class MarkersController < ApplicationController

  def show
    @markers = Marker.all
    render json: @markers
  end

  def new
  end

  def create
    @marker = Marker.new
    @group = Group.create(name: "Happy Friends")
    @member = Member.create(user: current_user, group: @group)
    @marker.latitude = params[:latitude]
    @marker.longitude = params[:longitude]
    @marker.member = @member
    @marker.save
    @markers = Marker.all
    render json: @markers
  end
end
