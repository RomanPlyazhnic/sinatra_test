require './models/user'
require './models/post'
require './models/review'
require 'pry'

User.generate(100)
Post.generate(3)
Review.generate(100)