require './main'
require 'rack/test'
require './models/post'
require './models/user'
require './lib/classes/unique_db_value'
require 'faker'
require 'pry'

describe 'Sinatra App' do
  include Rack::Test::Methods

  def app
    SinatraApp.new
  end

  # CREATE POST
  it "create post with correct parameters(user exists)" do 
    expected_code = 200
    user_login = User.limit(1).order("RANDOM()").first["login"]
    user = User.where(login: user_login).first
    user_id = user["id"]
    title, content, user_ip = "test post", "content of test post", "26.80.103.13/32"
    user_ip_compact = "26.80.103.13"
   
    put '/create_post', "{ \"title\": \"#{title}\", \"content\": \"#{content}\", \"login\": \"#{user_login}\", \"ip\": \"#{user_ip}\" }" 

    # test result
    expect(last_response.body).to include(title)
    expect(last_response.body).to include(content)
    expect(last_response.body).to include(user_id.to_s)
    expect(last_response.body).to include(user_ip_compact)
    expect(last_response.status).to eq(expected_code)
  end

  it "create post with correct parameters(user does not exists)" do 
    expected_code = 200
    user_login = UniqueDbValue.new.generate(model: User, field: "login") { Faker::JapaneseMedia::OnePiece.character }
    title, content, user_ip = "test post", "content of test post", "26.80.103.13/32"
    user_ip_compact = "26.80.103.13"

    put '/create_post', "{ \"title\": \"#{title}\", \"content\": \"#{content}\", \"login\": \"#{user_login}\", \"ip\": \"#{user_ip}\" }"
    user_id = User.where(login: user_login).first["id"]
    
    # test result
    expect(last_response.body).to include(title)
    expect(last_response.body).to include(content)
    expect(last_response.body).to include(user_id.to_s)
    expect(last_response.body).to include(user_ip_compact)
    expect(last_response.status).to eq(expected_code)
  end

  it "create post with incorrect parameters" do 
    expected_code = 422
    user_login = User.limit(1).order("RANDOM()").first["login"]
    title, content, user_ip = "", "", "26.80.103.13/32"
   
    put '/create_post', "{ \"title\": \"#{title}\", \"content\": \"#{content}\", \"login\": \"#{user_login}\", \"ip\": \"#{user_ip}\" }"
    
    # test result
    expect(last_response.status).to eq(expected_code)
  end

  it "create post with invalid request" do 
    expected_code = 422
    invalid_json = "{ s"
 
    put '/create_post', invalid_json
    
    # test result
    expect(last_response.status).to eq(expected_code)
  end

  # CREATE MARK
  it "create mark for post with correct values" do 
    expected_code = 200
    post = Post.limit(1).order("RANDOM()").first
    post_id = post["id"]
    mark = 5

    previous_marks = post.reviews.map(&:mark)
    post '/set_mark_on_post', "{ \"mark\": #{mark}, \"id\": #{post_id} }"
    new_avg_rating = ((previous_marks.sum + mark) / (previous_marks.count + 1))

    # test result
    expect(last_response.status).to eq(expected_code)
    expect(last_response.body).to include(new_avg_rating.round(2).to_s) # "select (sum(mark) + mark/ (select (count(*) + 1) from reviews where post_id = #{post_id})) from reviews where post_id = #{post_id}"
  end

  it "create mark for post with incorrect values" do 
    expected_code = 422
    post_id = 0
    mark = 0

    post '/set_mark_on_post', "{ \"mark\": #{mark}, \"id\": #{post_id} }"
    
    # test result
    expect(last_response.status).to eq(expected_code)
  end

  it "create mark for post with invalid request" do 
    expected_code = 422
    invalid_json = "{ s"

    post '/set_mark_on_post', invalid_json
    
    # test result
    expect(last_response.status).to eq(expected_code)
  end

  # TOP POSTS
  it "get top posts correctly" do 
    expected_code = 200
    top_posts_amount = 3

    get '/top_posts', { number: top_posts_amount }
    
    # test result
    expect(last_response.status).to eq(expected_code)
  end

  it "get top posts incorrectly" do 
    expected_code = 422
    top_posts_amount = "chetire"

    get '/top_posts', { number: top_posts_amount }
    
    # test result
    expect(last_response.status).to eq(expected_code)
  end

  # IPS USER
  it "get ips with multiple users with correctly" do 
    expected_code = 200

    get '/ips_many_authors'
    
    # test result
    expect(last_response.status).to eq(expected_code)
  end
end

