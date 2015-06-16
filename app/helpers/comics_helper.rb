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

  def category_labels
    labels = []
    Category.all.each do |category|
      labels << category.label
    end
    return labels
  end

end
