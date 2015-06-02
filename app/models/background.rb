class Background < ActiveRecord::Base
  mount_uploader :image, ComicImageUploader
end
