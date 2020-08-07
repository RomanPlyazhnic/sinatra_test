#require './models/application_record'
require './lib/modules/review_generator'
require 'sinatra/activerecord'
require 'pry'

class Review < ActiveRecord::Base
  include ReviewGenerator  
  belongs_to :post
  #after_create :calculate_avg_rating

  def self.add(**fields)    
    review = create(fields)
    
    review.save
    review.post.calculate_avg_rating
  end  
end
