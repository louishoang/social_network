class ApplicationController < ActionController::Base
  include CanCan::ControllerAdditions
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_post_id
    params[:post_id] || nil 
  end

  def owner?(params)
    current_user.id == @user.id
  end

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end
end
