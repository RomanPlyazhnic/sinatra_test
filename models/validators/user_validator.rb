require "./models/validators/validator"

class UserValidator < Validator
  def validate(user)
    check_login(user)
  end

  def check_login(user)
    login = user.login
    user.errors.add(:login, VALIDATE_MESSAGES[:empty]) if login.nil? || login.empty?
    user.errors.add(:login, VALIDATE_MESSAGES[:incorrect_format]) if !(login.kind_of?(String))
  end
end