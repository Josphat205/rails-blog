class Post < ApplicationRecord
  has_many :comments
  belongs_to :user
  validates :title, :text, presence: true
end
