class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(params[:comment])
    @comment.save 
    redirect_to @post # can use @post the object and Rails will figure out what we mean
  end
end
