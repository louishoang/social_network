class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    # User model
    can :read, User do |person|
      to_return = false
      if person.id == user.id
        to_return = true
      elsif user.connections.active.map(&:id).include?(person.id) || user.inverse_connections.active.map(&:user_id).include?(person.id)
        to_return = true
      end
    end
    can [:edit, :update], User, :id => user.id

    #Post model
    can :create, Post

  end
end
