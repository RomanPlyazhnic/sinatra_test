require "ipaddress"
require "./models/validators/validator"

class PostValidator < Validator
  def validate(post)
    check_title(post)
    check_content(post)
    check_user_ip(post)
    check_user(post)
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

  def check_user_ip(post)
    user_ip = post.user_ip.to_s
    post.errors.add(:user_ip, VALIDATE_MESSAGES[:incorrect_format]) unless IPAddress.valid?(user_ip)
  end  

  def check_user(post)
    user_id = post.user_id
    post.errors.add(:user, VALIDATE_MESSAGES[:empty]) if user_id.nil?
    post.errors.add(:user, VALIDATE_MESSAGES[:incorrect_format]) if !(user_id.kind_of?(Integer))
  end
end