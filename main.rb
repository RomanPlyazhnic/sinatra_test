require 'sinatra'
require './lib/classes/post_creator'
require './lib/classes/review_creator'
require './lib/classes/response_handler'

put '/create_post' do
  begin    
    parametres = JSON.parse(request.body.read)
    post_title, post_content, post_user_login, post_user_ip = parametres["title"], parametres["content"], parametres["login"], parametres["ip"]
    post = PostCreator.new(title: post_title, content: post_content, user_login: post_user_login, user_ip: post_user_ip)
    post.create
  rescue => exception
    status 500
    body exception.message
  else
    ResponseHandler.new(post, self).response
  end
end

post '/set_mark_on_post' do 
  begin
    parametres = JSON.parse(request.body.read)
    post_id, post_mark = parametres["id"], parametres["mark"]
    review = ReviewCreator.new(post_id: post_id, post_mark: post_mark)
    review.create
  rescue => exception
    status 500
    body exception.message
  else
    ResponseHandler.new(review, self).response
  end
end

get '/ips_many_authors' do
  puts 'ips_many_authors'
end