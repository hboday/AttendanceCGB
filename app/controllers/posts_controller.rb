class PostsController < ApplicationController
  def new
    @post = Post.new
  end
  def create
    #@post = Post.new(post_params)
    @post = Post.new(title:params['title'], body:params['body'])
    if @post.save
      render json: @post
    else
      render json: { errors: @post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  #def post_params
    #params.require(:post).permit(:title, :body)
  #end
end