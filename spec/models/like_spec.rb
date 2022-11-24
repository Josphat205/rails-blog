require 'rails_helper'

RSpec.describe Like, type: :model do
  before(:all) do
    @user = User.create(
      name: 'loman',
      photo: 'https://loman.com/loman.jpg',
      bio: 'This is loman!',
      posts_counter: 0
    )
    @post = Post.create(
      title: 'Lets get in touch',
      text: 'Dancer',
      author_id: @user.id,
      comments_counter: 0,
      likes_counter: 0
    )
  end

  it '@posts like_counter should increase by one' do
    Like.create(author_id: @user.id, post_id: @post.id)
    Like.create(author_id: @user.id, post_id: @post.id)
    post = Post.find(@post.id)
    expect(post.likes_counter).to eq(2)
  end
end
