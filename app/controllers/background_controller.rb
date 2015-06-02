class BackgroundController < ApplicationController
  def new
    if !current_user || !current_user.admin?
      not_found
    else
    end
  end

  def create
    if !current_user || !current_user.admin?
      not_found
    else
      if save_background && upload_image
        flash.now[:success] = "The background has been saved successfully!"
      else
        flash.now[:alert] = "An error occurred. The background could not be saved..."
      end
    end
    redirect_to background_path
  end

  private 

    def save_background
      background = Background.new(:label => params[:background][:label],
				:image => params[:background][:image])
      background.save
    end

    def upload_image
      uploader = BackgroundUploader.new
      uploader.store!(params[:background][:image])
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
end
