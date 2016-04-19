class StaticpagesController < ApplicationController
  def index

    # @markers = Marker.all
    # render json: @markers
    render :index
  end

  def markers
    @markers = Marker.all
    render json: @markers
  end

end
