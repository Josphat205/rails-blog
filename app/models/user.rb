class User < ApplicationRecord
  validates :name, :photo, :bio, presence: true
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  def fetch_recent_posts
    posts.order('created_at DESC').last(3)
  end
end
