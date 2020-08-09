require 'faker'
require './models/user'
require './lib/classes/ip_storage'

module PostGenerator
  def self.included(base)
    base.extend(PostGeneratorClassMethods)
  end

  module PostGeneratorClassMethods
    def generate(post_сount = 1)      
      post_сount.times do
        title = Faker::Quote.most_interesting_man_in_the_world.gsub("'", "''")
        content = Faker::JapaneseMedia::OnePiece.quote.gsub("'", "''")
        user_ip = BaseIpStorage.ip_array.sample
        
        User.transaction do
          user = User.lock.limit(1).order("RANDOM()").first
          Post.external_create(title: title, content: content, user_ip: user_ip, user: user)
        end
      end      
    end
  end  
end