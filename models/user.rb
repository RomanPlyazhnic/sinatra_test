require './models/application_record'
require './lib/modules/user_generator'

class User < ActiveRecord::Base#ApplicationRecord
  include UserGenerator

  has_many :posts, dependent: :destroy
end
