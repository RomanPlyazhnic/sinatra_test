require './models/review'
require './models/post'

class ReviewCreator
  def initialize(post_id:, post_mark:)
    @post_id, @post_mark = post_id, post_mark

    create
  end

  def errors  
    @review != nil ? @review.errors.messages : { post_id: "post with this id doesn't exists" }
  end

  def result
    @post.avg_rating if @post
  end

  private

  def create
    Post.transaction do
      @post = search_post
      @review = Review.add(mark: @post_mark, post: @post) if @post
    end      
  end

  def search_post
    Post.lock.where(id: @post_id).first
  end
end