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
        flash.keep[:success] = "Category has been saved successfully!"
      else
        flash.keep[:alert] = "Category could not be saved due to invalid input data. \n" + error_instructions
      end
      redirect_to "/list/categories"
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
      old_short = params[:short]
      new_short = params[:edit][:short]
      category = Category.find_by(:short => params[:short])    
      evaluate_new_label_input(category)
      evaluate_new_short_input(category)
      evaluate_new_background_input(category)
      if category.save
        update_corresponding_comics(old_short, new_short)
        flash.keep[:success] = "Changes have successfully been submitted."
        redirect_to "/list/categories"
      else
        flash.keep[:alert] = "Changes could not be saved due to invalid input data. \n" + error_instructions
        redirect_to "/edit/category/#{params[:short]}"
      end
    end
  end

  def destroy
    if !current_user
      not_found
    else
      category = Category.find_by(:short => params[:short])
      category.delete
      redirect_to "/list/categories" 
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

  private
    def update_corresponding_comics(old_short, new_short)
      Comic.where(:category => old_short).each do |comic|
        comic.category = new_short
        comic.save
      end
    end

  private
    def error_instructions
      instructions = "Please be sure that your label...\n"
      instructions += "\t...is not empty, \n"
      instructions += "\t...is not longer than 50 signs, \n"
      instructions += "\t...is not already in use. \n"
      instructions += "Also be sure that the abbreviation...\n"
      instructions += "\t...is not empty, \n"
      instructions += "\t...is not longer than 10 signs, \n"
      instructions += "\t...is not already in use, \n"
      instructions += "\t...does not contain any whitespace, numerals or special signs."
    end

end
