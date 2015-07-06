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
        flash.keep[:alert] = category.errors.full_messages.to_sentence
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
      old_abbreviation = params[:abbreviation]
      new_abbreviation = params[:edit][:abbreviation]
      category = Category.find_by(:abbreviation => params[:abbreviation])    
      evaluate_new_label_input(category)
      evaluate_new_abbreviation_input(category)
      evaluate_new_background_input(category)
      if category.save
        update_corresponding_comics(old_abbreviation, new_abbreviation)
        flash.keep[:success] = "Changes have successfully been submitted."
        redirect_to "/list/categories"
      else
        flash.keep[:alert] = "Changes could not be saved due to invalid input data. \n" + error_instructions
        redirect_to "/edit/category/#{params[:abbreviation]}"
      end
    end
  end

  def destroy
    if !current_user
      not_found
    else
      category = Category.find_by(:abbreviation => params[:abbreviation])
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
    def evaluate_new_abbreviation_input(category)
      new_abbreviation = params[:edit][:abbreviation]
      if !!new_abbreviation
        category.abbreviation = new_abbreviation
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
				abbreviation: params[:category][:abbreviation],
				background: params[:category][:background])
    end

  private
    def update_corresponding_comics(old_abbreviation, new_abbreviation)
      Comic.where(:category => old_abbreviation).each do |comic|
        comic.category = new_abbreviation
        comic.save
      end
    end

  private
    def error_instructions
      instructions = "Please be sure that your label "
      instructions += "is not empty,  "
      instructions += "is not longer than 50 signs, "
      instructions += "is not already in use. "
      instructions += "Also be sure that the abbreviation "
      instructions += "is not empty, "
      instructions += "is not longer than 10 signs, "
      instructions += "is not already in use, "
      instructions += "does not contain any whitespace, numerals or special signs."
    end

end
