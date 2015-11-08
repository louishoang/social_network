class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    @comments = Comment.where("post_id = ?", current_post_id).order("created_at")
    render :partial => "index"
  end

  def new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.json {render json: {
          count: @comment.post.comments.count,
          :comment_content => render_to_string(:partial => 'entity.html',
            locals: {:entity => @comment}
          )}}
      end
    else
      respond_to do |format|
        format.json {render json: { status: :unprocessable_entity, :message => @comment.errors.full_messages.to_sentence }}
      end
    end
  end

  private
  
  def comment_params
    params.require(:comment).permit(:text, :user_id, :post_id)
  end
end
