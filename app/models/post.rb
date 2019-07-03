class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 2000 }
  validates :book, presence: true, length: { maximum: 2000 }
  validates :direction, presence: true, length: { maximum: 2000 }
  validates :summary, presence: true, length: { maximum: 2000 }

  has_many :favorites
  has_many :liked_users, through: :favorites, source: :user

  acts_as_taggable
end
