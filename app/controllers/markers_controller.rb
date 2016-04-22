class MarkersController < ApplicationController

  def show
    @markers = Marker.all
    render json: @markers
  end

  def new
  end

  def create
    binding.pry
    @marker = Marker.new
    @id = params[:group_id]
    @group = Group.find(@id)
    @member = Member.where(group: @group).find_by(user: current_user)
    @marker.latitude = params[:latitude]
    @marker.longitude = params[:longitude]
    @marker.member = @member
    @marker.title = "Title: "
    @marker.description = "Description: "
    @marker.save
    @markers = Marker.where(group: @group)
    render json: @markers
  end
end
