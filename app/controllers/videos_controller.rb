class VideosController < ApplicationController
	require 'nokogiri'
	before_action :authenticate_supervisor, only: :index
	before_action :set_video, only: [:show, :edit, :update, :destroy, :base64_upload]

  def index
    @videos = Video.all.page params[:page]
  end

  def new
	@video = Video.new
	
	if Image.find_by_path('default_video.png').present?
		@default_image_path = Image.find_by_path('default_video.png').id
	else
		raise StandardError.new('No default image. Please upload a default video image before proceeding.')
	end

  rescue StandardError => e
		@error = e.message

    #@default_image_path = Image.find_by_path('default_video.png').id
  end

	def show
		@path = ''
		if @video.image.video_path.present?
			@path = @video.image.video_path.url
		elsif @video.image.path.present?
			@path = @video.image.path.url
		end

		@images = image_search

		respond_to do |format|
			format.html
			format.js
		end
		
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

	def base64_upload
		@base64 = params[:base64]
		@video.update(base64: @base64)
		# redirect_to @video
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
	end

  def video_params
    params.require(:video).permit(:path, :name, :image_id, :description, :base64)
  end
end
