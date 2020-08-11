require './models/post'
require './models/user'

class PostCreator
  def errors  
    @post.errors.messages if @post
  end

  def result
    @post.attributes if @post
  end 

  def create(title:, content:, user_login:, user_ip:)
    User.transaction do
      found_user = search_user(user_login)
      user = found_user.nil? ? create_user(user_login) : found_user
      @post = Post.create(title: title, content: content, user: user, user_ip: user_ip)
    end

    self
  end

  private 

  def search_user(user_login)
    User.lock.where(login: user_login).first
  end

  def create_user(user_login)
    User.lock.create(login: user_login)
  end
end