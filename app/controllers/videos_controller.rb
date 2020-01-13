class VideosController < ApplicationController

  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
  end

  def show
    @video = Video.find(params[:id])
  end

  def create
    @video = Video.new(video_params)

    if @video.save
      redirect_to video_path @video
    else
      render 'new'
    end
  end

  def destroy
    @video = Video.find(params[:id])
    redirect_to videos_path
    @video.destroy
  end

  private

  def video_params
    params.require(:video).permit(:path, :name, :image_id)
  end
end
