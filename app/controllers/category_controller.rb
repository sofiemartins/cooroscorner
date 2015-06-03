class CategoryController < ApplicationController
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
      if save_category
        flash.now[:success] = "Category has been saved successfully!"
      else
        flash.now[:alert] = "Category could not be saved."
      end
    end
  end

  def edit
    if !current_user || !current_user.admin?
      not_found
    else
    end
  end

  def submit_edit
    if !current_user || !current_user.admin?
    else 
    end
  end

  private

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
 
    def save_category
      @category = Category.save(label: params[:category][:label],
				background: params[:category][:background])
      @category.save
    end

end
