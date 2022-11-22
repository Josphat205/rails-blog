class AddCommentCounterAndLikesCounter < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :commentsCounter, :integer
    add_column :posts, :likesCounter, :integer
  end
end
