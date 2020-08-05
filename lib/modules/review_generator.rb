require 'faker'
require './models/user'
require './models/post'

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

        #transaction do
        #  random_post = Post.random_record            
        #  create(mark: mark, post: random_post)
        #end

        generate_query = "INSERT INTO reviews(mark, post_id) SELECT #{mark}, id FROM posts ORDER BY random() LIMIT 1"
        connection.execute(generate_query)
      end      
    end
  end  
end