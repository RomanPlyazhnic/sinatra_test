class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.random_record
    order('RANDOM()').first
  end
end
