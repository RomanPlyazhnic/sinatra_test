require './models/user'
require './models/post'
require './models/review'
require 'pry'

USER_COUNT = 100
POST_COUNT = 1000
REVIEW_COUNT = 200

#begin
  User.generate(USER_COUNT)
  Post.generate(POST_COUNT)
  Review.generate(REVIEW_COUNT)
#rescue => exception
  
#end
