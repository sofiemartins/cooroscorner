class Background < ActiveRecord::Base
  mount_uploader :image, ComicImageUploader
  validates :label, presence: true
end
