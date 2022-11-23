class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post
  validates :text, presence: true

  after_save :update_counter

  def update_counter
    post.increment!(:commentsCounter)
  end
end
