require "./models/validators/validator"
require "./models/review"

class ReviewValidator < Validator
  def validate(review)
    check_mark(review)
    check_post(review)
  end

  def check_mark(review)
    mark = review.mark
    review.errors.add(:review, VALIDATE_MESSAGES[:empty]) if mark.nil?
    review.errors.add(:review, VALIDATE_MESSAGES[:incorrect_format]) if !(mark.kind_of?(Integer))
    review.errors.add(:review, VALIDATE_MESSAGES[:out_of_range]) if !correct_mark_in_range?(mark)
  end

  def check_post(review)
    post_id = review.post_id
    review.errors.add(:review, VALIDATE_MESSAGES[:empty]) if review.post.nil?
    review.errors.add(:review, VALIDATE_MESSAGES[:empty]) if post_id.nil?
    review.errors.add(:review, VALIDATE_MESSAGES[:incorrect_format]) if !(post_id.kind_of?(Integer))
  end

  private def correct_mark_in_range?(mark)
    mark.to_i > Review::MINIMAL_MARK && mark.to_i <= Review::MAXIMAL_MARK
  end
end