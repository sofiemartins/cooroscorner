class ComicsController < ApplicationController
  def archive
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
      comic = Comic.new
      comic.image = params[:files]
      comic.save!
    end
  end

  def destroy
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
