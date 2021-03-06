require './lib/modules/review_generator'
require 'sinatra/activerecord'
require './models/validators/review_validator'
require 'pry'

class Review < ActiveRecord::Base
  include ReviewGenerator  
  belongs_to :post
  validates_with ReviewValidator

  def self.external_create(**fields)    
    review = create(fields)
    
    review.save
    review.post.calculate_avg_rating
    review
  end  
end
