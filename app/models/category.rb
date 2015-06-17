class Category < ActiveRecord::Base
  validates :label, presence: true, length: { maximum: 50 }, uniqueness: true
  short_regex = /\A+[a-z]+\z/i
  validates :short, presence: true, length: { maximum: 10 }, uniqueness: true, format: { with: short_regex }
end
