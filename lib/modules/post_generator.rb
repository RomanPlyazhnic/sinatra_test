require 'faker'
require './models/user'
require './lib/classes/ip_storage'
require 'pry'

module PostGenerator
  post_generate_query = "INSERT INTO posts(title, content, user_ip, user_id) SELECT %s, %s, %s, id FROM users ORDER BY random() LIMIT 1"

  def self.included(base)
    base.extend(PostGeneratorClassMethods)
  end

  module PostGeneratorClassMethods
    def generate(post_сount = 1)      
      post_сount.times do
        title = Faker::Quote.most_interesting_man_in_the_world.gsub("'", "''")
        content = Faker::JapaneseMedia::OnePiece.quote.gsub("'", "''")
        user_ip = IpStorage.ip_array.sample
        
        connection.execute(post_generate_query % [title, content, user_ip])
      end      
    end
  end  
end