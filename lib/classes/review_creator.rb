require './models/review'
require './models/post'

class ReviewCreator
  def errors  
    error_message = "post with this id doesn't exists"
    @review != nil ? @review.errors.messages : { post_id: error_message }
  end

  def result
    @post.avg_rating if @post
  end

  def create(post_id:, post_mark:)
    Post.transaction do
      @post = search_post(post_id)
      @review = Review.external_create(mark: post_mark, post: @post) if @post
    end 

    self
  end

  private

  def search_post(post_id)
    Post.lock.where(id: post_id).first
  end
end