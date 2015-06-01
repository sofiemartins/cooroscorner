class ComicController < ApplicationController
  include ActionView::Helpers::UrlHelper

  def show 
    # begin
      @all_comics = Array(Comic.find_by_category(params[:category]))
      new_index = params[:index].to_i - 1
      @comic = @all_comics.fetch(new_index)
    # rescue IndexError => e
    #  not_found  
    #end
  end

  def show_last
    @last_index = Array(Comic.find_by_category(params[:category])).count
    redirect_to "/#{params[:category]}/#{@last_index}"
  end

  def back
    new_index = params[:index].to_i - 1
    redirect_to "/#{params[:category]}/#{new_index}"
  end

  def next
    new_index = params[:index].to_i + 1
    redirect_to "/#{params[:category]}/#{new_index}"
  end

  def random
    total_number_of_comics = @all_comics.count
    new_index = 1 + Random.rand(total_number_of_comics)
    redirect_to "/#{params[:category]}/#{new_index}"
  end

  def archive
    @all_comics = Array(Comic.all)
    @comic = @all_comics.fetch(params[:index].to_i)
  end

  def archive_last
    @index = Comic.count - 1
    redirect_to "/archive/#{@index}"
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
     if save_comic_from_params
        flash.now[:success] = "The image has been uploaded successfully!"
      else
        flash.now[:alert] = "An error occurred. The image could not be saved."
      end
    end
    redirect_to upload_path
  end

  def destroy
  end

  private

    def save_comic_from_params
      comic = Comic.new(title: params[:comic][:title],
			category: params[:comic][:category],
			authors_comment: params[:comic][:authors_comment],
			image: params[:comic][:image])
      return comic.save
    end

    def upload_image
      uploader = ComicImageUploader.new
      uploader.store!(params[:comic][:image]) 
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
end
