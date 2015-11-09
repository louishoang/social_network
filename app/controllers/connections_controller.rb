class ConnectionsController < ApplicationController
  before_action :authenticate_user!

  def new
    current_user.connections << Connection.new(user_id: current_user.id, friend_id: params[:friend_id]) 
    if current_user.save
      respond_to do |format|
        format.json {render json: { :message => "Friend request sent"}}
      end
    else
      respond_to do |format|
        format.json {render json: { status: :unprocessable_entity, :message => current_user.errors.full_messages.to_sentence }}
      end
    end
  end

  def update
    @connection = Connection.find(params[:id])
    @connection.status = params[:status]
    if @connection.save
       respond_to do |format|
        format.json {render json: { :request_status => @connection.status }}
      end
    else
      respond_to do |format|
        format.json {render json: { status: :unprocessable_entity, :message => @connection.errors.full_messages.to_sentence }}
      end
    end
  end
end
