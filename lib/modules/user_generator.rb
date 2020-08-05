require 'faker'

module UserGenerator
  def self.included(base)
    base.extend(UserGeneratorClassMethods)
  end

  module UserGeneratorClassMethods
    def generate(user_count = 1)
      user_count.times do
        begin
          user_name = Faker::JapaneseMedia::OnePiece.character
          create(login: user_name)   
        rescue ActiveRecord::RecordNotUnique
          retry
        end
      end       
    end
  end  
end