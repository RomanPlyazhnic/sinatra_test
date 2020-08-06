require './models/application_record'
require './lib/modules/post_generator'
require 'pry'

class Post < ActiveRecord::Base#ApplicationRecord
  include PostGenerator

  has_many :reviews, dependent: :destroy
  belongs_to :user

  def calculate_avg_rating
    reviews_for_post_query = "SELECT * FROM reviews WHERE post_id = #{id} FOR UPDATE"
    calculate_avg_rating_query = "SELECT avg(mark) FROM reviews WHERE id in (%s)"

    transaction do          
      review_ids = self.class.connection.execute(reviews_for_post_query).map { |review| review["id"] }
      avg_rating = self.class.connection.execute(calculate_avg_rating_query % review_ids.join(', ')).first["avg"]
      update(avg_rating: avg_rating)      
    end
  end
end
