class Connection < ActiveRecord::Base

  STATUS_PENDING = "Pending"
  STATUS_ACTIVE = "Active"
  STATUS_DECLINED = "Declined"

  belongs_to :user
  belongs_to :friend, :class_name => "User"

  validates :friend, presence: true
  validates :user, presence: true
  validates :status, presence: true

  after_commit :send_notification_email, on: :create

  scope :active, -> {where("status = ?", STATUS_ACTIVE)}
  scope :pending, -> {where("status = ?", STATUS_PENDING)}  

  def send_notification_email
    if self.status.present? && self.status == STATUS_PENDING  
      BackgroundWorker.perform_async(self.id)
    end
  end
end
