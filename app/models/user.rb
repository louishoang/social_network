class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :connections
  has_many :friends, :through => :connections

  has_attached_file :avatar, styles: { medium: "150x150>", thumb: "50x50>" },
    default_url: "missing.png",
    :storage => :s3,
    :s3_credentials => Proc.new{|a| a.instance.s3_credentials }

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

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

  def s3_credentials
    {:bucket => "cholon", :access_key_id => ENV['AWS_ACCESS_KEY_ID'], :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']}
  end

  def has_friend_request?(user)
    self.connections.map(&:id).include?(user.id) ? true : false
  end
end
