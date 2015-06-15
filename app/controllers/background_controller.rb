class BackgroundController < ApplicationController
  def new
    if !current_user
      not_found
    else
    end
  end

  def create
    if !current_user
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

  def edit
    if !current_user
      not_found
    else
    end
  end

  def submit_edit
    if !current_user
      not_found
    else
      background = Background.find_by(:label => params[:label])
      evaluate_new_label_input(background)
      evaluate_new_image_input(background)
      background.save
      redirect_to background_path 
    end
  end

  def destroy
    if !current_user
      not_found
    else
      background = Background.find_by_label(params[:label])
      background.delete
      redirect_to '/list/backgrounds'
    end
  end

  def list
    if !current_user
      not_found
    end
  end

  private
    def evaluate_new_label_input(background)
      new_label = params[:edit][:label]
      if !!new_label
        background.label = new_label
      end
    end

  private
    def evaluate_new_image_input(background)
      new_image = params[:edit][:image]
      if !!new_image
        background.image = new_image
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
