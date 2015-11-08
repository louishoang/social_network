class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts

  extend FriendlyId
  friendly_id :full_name, use: :slugged

  def full_name
    string = ""
    if self.first_name && self.last_name.present?
      string = "#{self.first_name} #{self.last_name}"
    else
      string = self.email.match(/^([\w.]*)/).to_s
    end
    string
  end

  def should_generate_new_friendly_id?
    new_record?
  end
end
