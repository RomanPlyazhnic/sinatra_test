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
        mark = Faker::Number.between(from: MINIMAL_MARK, to: MAXIMAL_MARK)
        
        transaction do
          random_post = Post.lock.limit(1).order("RANDOM()").first
          add(mark: mark, post: random_post) if random_post
        end        
      end      
    end
  end  
end