class Connection < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  validates :friend, presence: true
  validates :user, presence: true
  validates :status, presence: true
end
