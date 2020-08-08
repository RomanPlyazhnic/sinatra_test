require "./models/validators/validator"

class ReviewValidator < Validator
  def validate(review)
    check_mark(review)
    check_post(review)
  end

  def check_mark(review)
    mark = review.mark
    review.errors.add(:review, VALIDATE_MESSAGES[:empty]) if mark.nil?
    review.errors.add(:review, VALIDATE_MESSAGES[:incorrect_format]) if !(mark.kind_of?(Integer))
  end

  def check_post(review)
    post_id = review.post_id
    review.errors.add(:review, VALIDATE_MESSAGES[:empty]) if post_id.nil?
    review.errors.add(:review, VALIDATE_MESSAGES[:incorrect_format]) if !(post_id.kind_of?(Integer))
  end
end