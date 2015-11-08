class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :text, presence: true, length: { in: (1..250) }
  validates :user, presence: true
  validates :post, presence: true

  before_save :populate_commentor_name

  private

  def populate_commentor_name
    if self.user_id.present?
      self.author = User.find(self.user_id).email
    end
  end
end
