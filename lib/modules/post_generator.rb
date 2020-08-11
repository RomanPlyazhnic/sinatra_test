require 'faker'
require './models/user'
require './lib/classes/base_ip_storage'

module PostGenerator
  def self.included(base)
    base.extend(PostGeneratorClassMethods)
  end

  module PostGeneratorClassMethods
    def generate(post_сount = 1)      
      post_сount.times do
        title = random_title
        content = random_content
        user_ip = random_ip
        
        User.transaction do
          user = random_user
          Post.external_create(title: title, content: content, user_ip: user_ip, user: user)
        end
      end      
    end

    private

    def random_title
      Faker::Quote.most_interesting_man_in_the_world.gsub("'", "''")
    end

    def random_content
      Faker::JapaneseMedia::OnePiece.quote.gsub("'", "''")
    end

    def random_ip
      BaseIpStorage.ip_array.sample
    end

    def random_user
      User.lock.limit(1).order("RANDOM()").first
    end
  end  
end