class HomeController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @post = Post.new
    @all_posts = Post.all
  end
end
