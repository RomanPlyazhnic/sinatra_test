require 'faker'
require './models/user'
require './lib/classes/ip_storage'
require 'pry'

module PostGenerator
  def self.included(base)
    base.extend(PostGeneratorClassMethods)
  end

  module PostGeneratorClassMethods
    def generate(post_сount = 1)      
      post_сount.times do
        title = Faker::Quote.most_interesting_man_in_the_world.gsub("'", "''")
        content = Faker::JapaneseMedia::OnePiece.quote.gsub("'", "''")
        user_ip = IpStorage.ip_array.sample
        
        #transaction do          
        #  user = User.random_record
        #  create(title: title, content: content, user: user, user_ip: user_ip)
        #end
        
        generate_query = "INSERT INTO posts(title, content, user_ip, user_id) SELECT \'#{title}\', \'#{content}\', \'#{user_ip}\', id FROM users ORDER BY random() LIMIT 1"
        connection.execute(generate_query)
      end      
    end
  end  
end