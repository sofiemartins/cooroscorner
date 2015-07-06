module ApplicationHelper

  def archive_index(category, index)
    if !category
      return index
    else
      comic = Comic.where(:category => category).fetch(index.to_i - 1)
      archive_index = Comic.all.index(comic) + 1
      return archive_index
    end
  end

  def current_background
    if params[:category]
      category = Category.find_by(:abbreviation => params[:category])
      background = category.background
    else
    end
  end

end
