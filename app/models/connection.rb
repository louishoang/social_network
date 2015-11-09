class Connection < ActiveRecord::Base
  STATUS_PENDING = "Pending"
  STATUS_ACTIVE = "Active"
  STATUS_DECLINED = "Declined"

  belongs_to :user
  belongs_to :friend, :class_name => "User"

  validates :friend, presence: true
  validates :user, presence: true
  validates :status, presence: true

  scope :active, -> {where("status = ?", STATUS_ACTIVE)}
end
