require 'sinatra/activerecord'

class Validator < ActiveModel::Validator
  VALIDATE_MESSAGES = {
    incorrect_format: "incorrect format", 
    empty: "empty",
    not_a_string: "not a string",
    out_of_range: "out of range" 
  }

  def validate(record)

  end
end