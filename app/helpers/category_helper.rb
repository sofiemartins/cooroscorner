module CategoryHelper

  def array_of_background_labels
    labels = []
    Background.all.each do |background| 
      labels << background.label
    end
    return labels
  end

end
