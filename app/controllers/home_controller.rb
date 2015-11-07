class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @post = Post.new
    @post_collection = Post.order("created_at DESC").paginate(page: params[:page], per_page: 15).order('created_at DESC')

    respond_to do |format|
      format.html
      format.js
    end
  end
end
