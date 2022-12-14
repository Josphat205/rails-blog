class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable
  validates :name, :photo, :bio, presence: true
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy
  before_validation :default_values
  has_secure_password
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def fetch_recent_posts
    posts.order('created_at DESC').last(3)
  end

  private

  def default_values
    self.posts_counter = 0
    self.photo = 'https://img.myloview.com/posters/social-media-user-icon-default-avatar-profile-image-400-251200036.jpg'
  end
end
