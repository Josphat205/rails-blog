class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :text, presence: true

  after_save :update_counter


  def update_counter
    post.increment!(:commentsCounter)
  end
end
