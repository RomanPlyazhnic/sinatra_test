require 'sinatra'
Dir["#{Dir.pwd}/models/*.rb"].each { |file| require file }

get '/articles' do    
  Article.all.map { |article| article.content }.join(", ")  
end