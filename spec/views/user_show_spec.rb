require 'rails_helper'
RSpec.describe 'User', type: :feature do
  user = User.first
  before(:each) do
    visit(user_path(User.first.id))
    @user = User.create(
            name: 'Kiploman',
            bio: 'Graphic designer',
            photo: 'http://hello.com/org.png',
            posts_counter: 0
          )
  end
  it "has users's profile picture." do
    visit user_path(@user.id)
     expect(page).to have_xpath("//img[contains(@src,'http://hello.com/org.png')]")
  end
  it "has users's username." do
    expect(page).to have_content(user.name)
  end
  it "has users's bio." do
    expect(page).to have_content(user.bio)
  end
  it 'has users number of posts' do
    expect(page).to have_content("Posts: #{user.posts_counter}")
  end
  it 'has link to all posts' do
    expect(page).to have_link('Posts')
  end
  it 'has recent three posts' do
    expect(page).to have_selector('.post-card', count: 1)
  end
  it 'redirects to all user posts page' do
    click_link('Posts')
    expect(page.current_path).to eql(user_posts_path(user_id: user.id).to_s)
  end
end