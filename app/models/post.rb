class Post < ActiveRecord::Base
  belongs_to :user

  validates :content, presence: true
  validates :user, presence: true
end
