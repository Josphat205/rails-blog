class User < ApplicationRecord
  validates :name, :photo, :bio, presence: true
  has_many :posts, foreign_key: 'author_id'
  has_many :comments, foreign_key: 'author_id'
  has_many :likes, foreign_key: 'author_id'

  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def fetch_recent_posts
    posts.order('created_at DESC').last(3)
  end
end
