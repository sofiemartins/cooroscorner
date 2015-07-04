class Background < ActiveRecord::Base
  mount_uploader :image, ComicImageUploader
  validates :label, presence: true, uniqueness: true
end
