class ComicController < ApplicationController
  include ActionView::Helpers::UrlHelper

  before_action :authenticate_user!, :only => [ :comment ] 

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
    @comic = @all_comics.fetch(params[:index].to_i - 1)
  end

  def archive_last
    @index = Comic.count
    redirect_to "/archive/#{@index}"
  end

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
      if save_comic_from_params && upload_image
        flash.now[:success] = "The image has been uploaded successfully!"
      else
        flash.now[:alert] = "An error occurred. The image could not be saved."
      end
    end
    redirect_to upload_path
  end

  def edit
    if !current_user
      not_found
    end
  end

  def submit_edit
    if !current_user
      not_found
    else
      comic = Comic.where(:category => params[:category]).fetch(params[:index].to_i - 1)
      evaluate_new_title_input(comic)
      evaluate_new_authors_comment(comic)
      evaluate_new_image(comic)
      evaluate_new_category_input(comic)
      comic.save
      redirect_to "/#{params[:category]}/#{params[:index]}"
    end
  end

  def destroy
    if !current_user
      not_found
    else
      comic = Comic.where(:category => params[:category]).fetch(params[:index].to_i - 1)  
      if comic.destroy
        flash.now[:success] = "The image has been deleted successfully!"
      else
        flash.now[:alert] = "An error occurred. The image couldn't be deleted."
      end
      if params[:index] == "1"
        redirect_to root_path
      else
        redirect_to "/#{params[:category]}/#{params[:index].to_i - 1}"
      end
    end
  end

  def comment
    comment = Comment.new(:content => raw(params[:comment][:content]),
	:username => current_user.username, 
	:comic_index => params[:index])
    comment.save    
    if !params[:category]
      redirect_to "/archive/#{params[:index]}"
    else
      redirect_to "/#{params[:category]}/#{params[:index]}"
    end
  end
 
  def list
    if !current_user
      not_found
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

  private 
    def evaluate_new_title_input(comic)
      new_title = params[:comic][:title]
      if !!new_title
        comic.title = new_title
      end
    end

  private
    def evaluate_new_authors_comment(comic)
      new_authors_comment = params[:comic][:authors_comment]
      if !!new_authors_comment
        comic.authors_comment = new_authors_comment
      end
    end

  private
    def evaluate_new_image(comic)
      new_image = params[:comic][:image]
      if !!new_image
        comic.image = new_image
      end
    end

  private 
    def evaluate_new_category_input(comic)
      new_category = params[:comic][:category]
      if !!new_category
        comic.category = new_category
      end
    end

  private
    def upload_image
      uploader = ComicImageUploader.new
      uploader.store!(params[:comic][:image]) 
    end

  private
    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
end
