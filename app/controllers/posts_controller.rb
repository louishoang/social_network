class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      respond_to do |format|
        format.json {render json: {
          :post_valid => true,
          :message => "Post is created successfully",
          :prepend_content => render_to_string(:partial => 'entity.html',
            locals: {:entity => @post}
          )}}
      end
    else
      respond_to do |format|
        format.json {render json: { :post_valid => false, status: :unprocessable_entity, :message => @post.errors.full_messages.to_sentence }}
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id)
  end
end
