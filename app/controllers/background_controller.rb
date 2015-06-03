class BackgroundController < ApplicationController
  def new
    if !current_user || !current_user.admin
      not_found
    else
    end
  end

  def create
    if !current_user || !current_user.admin
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

  def destroy
    if !current_user || !current_user.admin
      not_found
    else
      background = Background.find_by_label(params[:label])
      background.delete
      redirect_to '/list/backgrounds'
    end
  end

  private 
    def save_background
      background = Background.new(:label => params[:background][:label],
				:image => params[:background][:image])
      background.save
    end

  private
    def upload_image
      uploader = BackgroundUploader.new
      uploader.store!(params[:background][:image])
    end

  private
    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
end
