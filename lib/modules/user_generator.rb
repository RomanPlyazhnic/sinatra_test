require './lib/classes/unique_db_value'
require 'faker'

module UserGenerator
  def self.included(base)
    base.extend(UserGeneratorClassMethods)
  end

  module UserGeneratorClassMethods
    def generate(user_count = 1)
      user_count.times do
        user_name = UniqueDbValue.new.generate(model: User, field: "login") { Faker::JapaneseMedia::OnePiece.character }
        user_name.nil? ? break : create(login: user_name)
      end       
    end
  end  
end