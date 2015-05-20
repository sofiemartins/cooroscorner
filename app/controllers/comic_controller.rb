class ComicController < ApplicationController

  def archive
    @all_comics = Array(Comic.all) 
    @comic = @all_comics.last
    @index = @all_comics.index(@comic)
  end

  def offensive
    @all_comics = Array(Comic.find_by_category("offensive"))
    @comic = @all_comics.last
    @index = @all_comics.index(@comic)
  end
 
  def random
    @all_comics = Array(Comics.find_by_category("random"))
    @comic = @all_comics.last
    @index = @all_comics.index(@comic)
  end

  def mayuyu
    @all_comics = Array(Comics.find_by_category("mayuyu"))
    @comic = @all_comics.last
    @index = @all_comics.index(@comic)
  end

  def tina
    @all_comics = Array(Comic.find_by_category("tina"))
    @comic = @all_comics.last
    @index = @all_comics.index(@comic)
  end

  def back
    @index -= 1;
    @comic = @all_comics.fetch(@index)
  end

  def random
    @index = Random.rand(@all_comics.length) 
    @comic = @all_comics.fetch(@index)
  end

  def next
    @index += 1;
    @comic = @all_comics.fetch(@index)
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

  def not_found
    raise ActionController::RoutingError.new('Not Found')
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
end
