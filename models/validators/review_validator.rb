require "./models/validators/validator"

class ReviewValidator < Validator
  def validate(review)
    check_mark(review)
  end

  def check_mark(review)
    mark = review.mark
    review.errors.add(:review, VALIDATE_MESSAGES[:empty]) if review.nil? || login.empty?
    user.errors.add(:login, VALIDATE_MESSAGES[:incorrect_format]) if !(login.kind_of?(Integer))
  end
end