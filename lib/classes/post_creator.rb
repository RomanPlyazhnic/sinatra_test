require './models/post'
require './models/user'

class PostCreator
  attr_accessor :errors, :post_attributes

  def create(title:, content:, user_login:, user_ip:)
    User.transaction do
      found_user = search_user(user_login)
      user = found_user.nil? ? create_user(user_login) : found_user
      post = Post.create(title: title, content: content, user: user, user_ip: user_ip)
      @errors = post.errors.messages.merge(user.errors.messages)
      @post_attributes = post.attributes
    end
  end

  private 

  def search_user(login)
    User.lock.where(login: login).first
  end

  def create_user(login)
    User.lock.create(login: login)
  end
end