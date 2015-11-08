class Post < ActiveRecord::Base
  self.per_page = 15
  belongs_to :user
  has_many :comments

  validates :content, presence: true
  validates :user, presence: true
end
