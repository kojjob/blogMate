class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments

  enum status: { draft: 0, published: 1 }

  validates :title, presence: true, uniqueness: true
  validates :content, presence: true
  validates :user_id, presence: true
end
