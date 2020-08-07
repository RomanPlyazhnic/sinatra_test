#require './models/application_record'
require './lib/modules/user_generator'
require 'sinatra/activerecord'

class User < ActiveRecord::Base
  include UserGenerator

  has_many :posts, dependent: :destroy
end
