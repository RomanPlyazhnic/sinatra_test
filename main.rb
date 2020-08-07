require 'sinatra'
require './lib/classes/post_creator'

put '/create_post' do
  #begin    
    parametres = JSON.parse(request.body.read)
    post_title, post_content, post_user_login, post_user_ip = parametres["title"], parametres["content"], parametres["login"], parametres["ip"]
    post = PostCreator.new
    post.create(title: post_title, content: post_content, user_login: post_user_login, user_ip: post_user_ip)
  #rescue => exception
  #  status 422
  #  body exception.message
  #else
    if post.errors.empty? 
      status 200
      body JSON(post.post_attributes)
    else
      status 422
      body JSON(post.errors)
    end
  #end
end

post 'set_mark_on_post' do 
  puts 'set_mmark_on_post'
end

get 'ips_many_authors' do
  puts 'ips_many_authors'
end