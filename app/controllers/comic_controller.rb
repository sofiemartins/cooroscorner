class ComicController < ApplicationController

  def archive
    @all_comics = Comic.all 
  end

  def offensive
  end
 
  def random
  end

  def mayuyu
  end

  def tina
  end

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
      comic = Comic.new(title: params[:comic][:title], 
			category: params[:comic][:category],
			authors_comment: params[:comic][:authors_comment],
			image: params[:comic][:image])
      if comic.save
        flash.now[:success] = "The image has been uploaded successfully!"
      else
        flash.now[:alert] = "An error occurred. The image could not be saved."
      end
    end
    redirect_to upload_path
  end

  def destroy
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
