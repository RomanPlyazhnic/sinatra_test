require 'sinatra/activerecord'

class Userip < ActiveRecord::Base
  belongs_to :user
end
