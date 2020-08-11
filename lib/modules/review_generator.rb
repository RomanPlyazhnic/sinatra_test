require 'faker'
require './models/user'
require './models/post'
require 'pry'

module ReviewGenerator
  MINIMAL_MARK = 1
  MAXIMAL_MARK = 5

  def self.included(base)
    base.extend(ReviewGeneratorClassMethods)
  end

  module ReviewGeneratorClassMethods
    def generate(review_count = 1)
      review_count.times do 
        mark = random_mark
        
        transaction do
          post = random_post
          external_create(mark: mark, post: post) if post
        end        
      end      
    end

    private 

    def random_mark
      Faker::Number.between(from: MINIMAL_MARK, to: MAXIMAL_MARK)
    end

    def random_post
      Post.lock.limit(1).order("RANDOM()").first
    end
  end  
end