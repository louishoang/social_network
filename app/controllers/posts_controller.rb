class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      respond_to do |format|
        format.json {render json: { :post_valid => true }}
      end
    else
      respond_to do |format|
        format.json {render json: { :post_valid => false, status: :unprocessable_entity }}
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id)
  end
end
