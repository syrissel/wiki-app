class VideosController < ApplicationController
	require 'nokogiri'
	before_action :authenticate_supervisor, only: :index
	before_action :set_video, only: [:show, :edit, :update, :destroy]

  def index
    @videos = Video.all
  end

  def new
    @video = Video.new
    @default_image_path = Image.find_by_path('default_video.png').id
  end

	def show
		
		# @video.description = @base64
		
	end
	
	def edit
	end

  def create
    @video = Video.new(video_params)

    if @video.save
      redirect_to video_path @video
    else
      render 'new'
    end
	end
	
	def update
		if @video.update(video_params)
			redirect_to @video, notice: "#{@video.name} created."
		else
			render :edit
		end
	end

  def destroy
    redirect_to videos_path
    @video.destroy
	end
	
	def parse_html
		@video = params[:id]
		@base64 = params[:base64]
		# render text: @base64
		# @video.description = @base64
		# @video.save
		# @element = Nokogiri::HTML(html)
		# @element.xpath("//img").first["src"]
	end

	private
	
	def set_video
		@video = Video.find(params[:id])
		if params[:base64].present?
			@base64 = params[:base64]
		end
	end

  def video_params
    params.require(:video).permit(:path, :name, :image_id, :description)
  end
end
