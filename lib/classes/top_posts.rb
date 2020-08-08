require './models/post'

class TopPosts
  def initialize(top_amount)
    @incorrect_number = false
    @top_posts = find_top_posts(top_amount)
  end

  def result
    @top_posts
  end

  def errors
    { number: "top amount number has incorrect format" } if @incorrect_number
  end

  private 

  def find_top_posts(top_amount)
    if correct_top_amount(top_amount)
      top_posts = Post.select(:title, :content).order("avg_rating desc").limit(top_amount.to_i).to_a

      return top_posts.map do |post|  
        {
          title: post["title"],
          content: post["content"]
        }        
      end
    else
      @incorrect_number = true
      []
    end
  end

  def correct_top_amount(top_amount)
    !!(top_amount.to_i > 0)
  end
end