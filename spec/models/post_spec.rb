require 'rails_helper'

RSpec.describe Post, type: :model do
  before(:all) do
    @user = User.create(
      name: 'Loman',
      bio: 'Software Developer',
      photo: 'http://hey.com/og.png',
      posts_counter: 0
    )
    @post = Post.create(
      title: 'Hello',
      text: 'Software Developer',
      author_id: @user.id,
      comments_counter: 0,
      likes_counter: 0
    )
  end

  it 'post title should be present' do
    @post.title = nil
    expect(@post).to_not be_valid
  end

  it 'A posts likes_counter should be >= 0' do
    @post.likes_counter = -4
    expect(@post).to_not be_valid
  end

  it 'A posts comments_counter should be >= 0' do
    @post.comments_counter = -4
    expect(@post).to_not be_valid
  end

  it 'A posts likes_counter should be numeric' do
    @post.likes_counter = 'One'
    expect(@post).to_not be_valid
  end

  it 'should not accept more than 250 character' do
    @post.title = '
    Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula
    eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient
    montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque
    eu, pretium quis,'
    expect(@post).to_not be_valid
  end
end
