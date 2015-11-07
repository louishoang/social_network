class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @post = Post.new
    @post_collection = Post.all.order("created_at DESC")
  end
end
