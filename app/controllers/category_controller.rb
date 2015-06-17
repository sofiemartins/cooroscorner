class CategoryController < ApplicationController
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
      category = create_category
      if category.save
        flash.now[:success] = "Category has been saved successfully!"
      else
        error_message = ""
        category.error.each do |error|
          error_message += "/n" + error
        end
        flash.now[:alert] = "Category could not be saved, due to..." + error_message
      end
      redirect_to "/category"
    end
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
      category = Category.find_by(:short => params[:short])    
      evaluate_new_label_input(category)
      evaluate_new_short_input(category)
      evaluate_new_background_input(category)
      category.save
      redirect_to "/#{category.short}" 
    end
  end

  def destroy
    if !current_user
      not_found
    else
      category = Category.find_by(:short => params[:short])
      category.delete
      redirect_to root_path 
    end
  end
 
  def list
    if !current_user
      not_found
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
    def create_category
      category = Category.new(label: params[:category][:label],
				short: params[:category][:short],
				background: params[:category][:background])
    end

end
