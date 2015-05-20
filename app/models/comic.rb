class Comic < ActiveRecord::Base
  mount_uploader :image, ComicImageUploader 
end
