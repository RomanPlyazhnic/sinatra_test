require './models/application_record'
require './lib/modules/post_generator'

class Post < ApplicationRecord
  include PostGenerator

  has_many :reviews, dependent: :destroy
  belongs_to :user

  def calculate_avg_rating
    #marks_count = reviews.count
    #marks = reviews.map { |review| review.mark }

    #update(avg_rating: marks.sum.to_f / marks_count) 
    4
  end
end
