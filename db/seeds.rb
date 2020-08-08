require './models/user'
require './models/post'
require './models/review'
require 'pry'

User.generate(100)
Post.generate(200000)
Review.generate(1000)