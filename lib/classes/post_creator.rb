require './models/post'
require './models/user'

class PostCreator
  attr_accessor :errors, :post_attributes

  def initialize(title:, content:, user_login:, user_ip:)
    @title, @content, @user_login, @user_ip = title, content, user_login, user_ip

    create
  end

  def errors  
    @post.errors.messages.merge(@user.errors.messages) if (@post && @user)
  end

  def result
    @post.attributes if @post
  end 

  private 

  def create
    User.transaction do
      found_user = search_user
      @user = found_user.nil? ? create_user : found_user
      @post = Post.create(title: @title, content: @content, user: @user, user_ip: @user_ip)
    end
  end

  def search_user
    User.lock.where(login: @user_login).first
  end

  def create_user
    User.lock.create(login: @user_login)
  end
end