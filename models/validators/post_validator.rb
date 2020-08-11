require "ipaddress"
require "./models/validators/validator"

class PostValidator < Validator
  def validate(post)
    check_title(post)
    check_content(post)
  end

  private

  def check_title(post)
    title = post.title
    post.errors.add(:title, VALIDATE_MESSAGES[:empty]) if title.nil? || title.empty?
    post.errors.add(:title, VALIDATE_MESSAGES[:incorrect_format]) if !(title.kind_of?(String))
  end

  def check_content(post)
    content = post.content
    post.errors.add(:content, VALIDATE_MESSAGES[:empty]) if content.nil? || content.empty?
    post.errors.add(:content, VALIDATE_MESSAGES[:incorrect_format]) if !(content.kind_of?(String))
  end
end