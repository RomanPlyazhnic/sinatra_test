class Validator < ActiveModel::Validator
  VALIDATE_MESSAGES = {
    incorrect_format: "incorrect format", 
    empty: "empty",
    not_a_string: "not a string"    
  }

  def validate(record)

  end
end