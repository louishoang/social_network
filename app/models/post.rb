class Post < ActiveRecord::Base
  self.per_page = 15
  belongs_to :user
  has_many :comments

  validates :content, presence: true, length: { in: (1..1000) }
  validates :user, presence: true
end
