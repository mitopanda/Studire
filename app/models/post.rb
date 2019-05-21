class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence:true, length: { maximum: 50 }
  validates :content, presence:true
  validates :book, presence:true
  validates :direction, presence:true
  validates :summary, presence:true

  #タグ用
  acts_as_taggable
end
