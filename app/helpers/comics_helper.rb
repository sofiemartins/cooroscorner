module ComicsHelper

  def last_comic
    if !params[:category]
      last = (params[:index].to_i == Comic.all.count)
    else
      last = (params[:index].to_i == Comic.where(:category => params[:category]).count)
    end
  end

  def first_comic
    params[:index].to_i == 1
  end

  def last_comic_number
    if !params[:category]
      number = Comic.all.count
    else
      number = Comic.where(:category => params[:category]).count
    end
  end

  def random_comic_index 
    if (!!params[:category])
      number_of_comics_in_category = Comic.where(:category => params[:category]).count
      new_index = 1 + Random.rand(number_of_comics_in_category)
    else
      number_of_comics_in_category = Comic.count
      new_index = 1 + Random.rand(number_of_comics_in_category)
    end
  end

  def category_labels
    labels = []
    Category.all.each do |category|
      labels << category.label
    end
    return labels
  end

end
