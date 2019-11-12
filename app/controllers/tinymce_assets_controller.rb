class TinymceAssetsController < ApplicationController
  def create
    # Take upload from params[:file] and store it somehow...
    # Optionally also accept params[:hint] and consume if needed
    image = Image.create params.permit(:url, :alt, :hint)

    render json: {
      image: {
        url: image.url.url
      }
    }, content_type: "text/html"
  end
end