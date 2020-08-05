require './models/application_record'
require './lib/modules/review_generator'

class Review < ApplicationRecord
  include ReviewGenerator
  
  belongs_to :post
end
