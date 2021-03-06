require './lib/modules/post_generator'
require 'sinatra/activerecord'
require './models/validators/post_validator'
require './models/user_ip'
require 'pry'

class Post < ActiveRecord::Base
  include PostGenerator

  has_many :reviews, dependent: :destroy
  belongs_to :user
  validates_with PostValidator 

  def self.external_create(**fields)    
    post = create(fields)
    create_user_ip_field(post)

    post
  end 

  def calculate_avg_rating
    reviews_for_post_query = "SELECT * FROM reviews WHERE post_id = #{id} FOR UPDATE"
    calculate_avg_rating_query = "SELECT avg(mark) FROM reviews WHERE id in (%s)"

    transaction do          
      review_ids = self.class.connection.execute(reviews_for_post_query).map { |review| review["id"] }
      avg_rating = self.class.connection.execute(calculate_avg_rating_query % review_ids.join(', ')).first["avg"] if !(review_ids.empty?)
      update(avg_rating: avg_rating)      
    end
  end

  private 

  def self.create_user_ip_field(post)
    transaction do
      different_ip_user_post_query = "SELECT user_ip, user_id FROM posts WHERE user_ip = '#{post[:user_ip]}' GROUP BY user_ip, user_id"
      different_ip_user_post = connection.execute(different_ip_user_post_query)
      same_userips = Userip.lock.where(user: post.user, user_ip: post["user_ip"]).to_a

      if same_userips.count == 0 && different_ip_user_post.count > 1
        Userip.create(user: post.user, user_login: post.user["login"], user_ip: post["user_ip"])
      end
    end
  end
end
