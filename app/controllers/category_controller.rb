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
      not_found
    else 
      category = Category.find_by(:short => params[:short])    
      evaluate_new_label_input(category)
      evaluate_new_short_input(category)
      evaluate_new_background_input(category)
      category.save
    end
  end

  def destroy
    if !current_user || !current_user.admin?
      not_found
    else
      category = Category.find_by(:short => params[:short])
      category.delete
    end
  end

  private 
    def evaluate_new_label_input(category)
      new_label = params[:edit][:label]
      if !!new_label
        category.label = new_label 
      end
    end

  private 
    def evaluate_new_short_input(category)
      new_short = params[:edit][:short]
      if !!new_short
        category.short = new_short
      end
    end

  private 
    def evaluate_new_background_input(category)
      new_file = params[:edit][:background]
      if !!new_file
        category.background = new_file
      end
    end

  private
    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
 
  private
    def save_category
      @category = Category.save(label: params[:category][:label],
				background: params[:category][:background])
      @category.save
    end

end
