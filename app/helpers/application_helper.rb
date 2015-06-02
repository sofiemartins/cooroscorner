module ApplicationHelper

  def archive_index(category, index)
    if !category
      return index
    else
      comic = Array(Comic.find_by_category(category)).find_by_index(index)
      archive_index = Comic.index(comic)
      return archive_index
    end
  end

end
