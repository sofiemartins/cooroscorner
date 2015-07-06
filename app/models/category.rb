class Category < ActiveRecord::Base
  validates :label, presence: true, length: { maximum: 50 }, uniqueness: true
  abbreviation_regex = /\A+[a-z]+\z/i
  validates :abbreviation, presence: true, length: { maximum: 10 }, uniqueness: true, format: { with: abbreviation_regex }
end
