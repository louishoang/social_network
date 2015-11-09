class UsersController < ApplicationController
  before_action :authenticate_user!
  before_filter :find_user, :only => [:show, :edit, :update]

  def show
    @rand_users = User.order("RANDOM()").take(20)
    @post = Post.new
    @post_collection = Post.includes(:comments).order("created_at DESC").paginate(page: params[:page], per_page: 15).order('created_at DESC')

    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to(user_path(@user))
      flash[:notice] = "Updated successfully"
    else
      render "edit"
      flash[:alert] = @user.errors.full_messages.to_sentence
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :bio, :avatar)
  end

  def find_user
    @user = User.friendly.find(params[:id])
  end
end
