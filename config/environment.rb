# Load the Rails application.
ENV['RAILS_ENV'] ||= 'production'
require File.expand_path('../application', __FILE__)
require 'rubygems'
require 'mini_magick'
require 'carrierwave/orm/activerecord'

# Initialize the Rails application.
Rails.application.initialize!


