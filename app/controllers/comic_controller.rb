class ComicController < ApplicationController
  include ActionView::Helpers::UrlHelper

  before_action :authenticate_user!, :except => [:show, :show_last, 
	:back, :next, :random, :archive, :archive_last, :new, :create,
        :destroy ]

  def show 
    begin
      @all_comics = Comic.where(:category => params[:category])
      new_index = params[:index].to_i - 1
      @comic = @all_comics.fetch(new_index)
    rescue IndexError => e
      not_found  
    end
  end

  def show_last
    @last_index = Comic.where(:category => params[:category]).count
    redirect_to "/#{params[:category]}/#{@last_index}"
  end

  def back
    new_index = params[:index].to_i - 1
    if !params[:category]
      redirect_to "/archive/#{new_index}"
    else
      redirect_to "/#{params[:category]}/#{new_index}"
    end
  end

  def next
    new_index = params[:index].to_i + 1
    if !params[:category]
      redirect_to "/archive/#{new_index}"
    else
      redirect_to "/#{params[:category]}/#{new_index}"
    end
  end

  def random
    if params[:category] == "archive" 
      total_number_of_comics = Comic.count
      new_index = 1 + Random.rand(total_number_of_comics)
      redirect_to "/archive/#{new_index}"
    else
      all_comics = Comic.where(:category => params[:category])
      total_number_of_comics = all_comics.count
      new_index = 1 + Random.rand(total_number_of_comics)
      redirect_to "/#{params[:category]}/#{new_index}"
    end
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
     if save_comic_from_params && upload_image
        flash.now[:success] = "The image has been uploaded successfully!"
      else
        flash.now[:alert] = "An error occurred. The image could not be saved."
      end
    end
    redirect_to upload_path
  end

  def destroy
  end

  def comment
    comment = Comment.new(:content => raw(params[:comment][:content]),
			:username => current_user.username, 
			:comic_index => params[:index])
    comment.save    
    ## find a better solution?
    if !params[:category]
      redirect_to "/archive/#{params[:index]}"
    else
      redirect_to "/#{params[:category]}/#{params[:index]}"
    end
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
