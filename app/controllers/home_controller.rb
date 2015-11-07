class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @post = Post.new
    @post_collection = Post.all
  end
end
