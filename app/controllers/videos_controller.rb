class VideosController < ApplicationController
  before_action :authenticate_supervisor, only: :index

  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
    @default_image_path = Image.find_by_path('default_video.png').id
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
