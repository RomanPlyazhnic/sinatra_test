#require './models/application_record'
require './lib/modules/user_generator'
require './models/validators/user_validator'
require 'sinatra/activerecord'

class User < ActiveRecord::Base
  include UserGenerator
  validates_with UserValidator

  has_many :posts, dependent: :destroy
end
