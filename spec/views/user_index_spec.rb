require 'rails_helper'
RSpec.describe 'Index page', type: :feature do
  before(:each) do
    @user = User.create(
      name: 'Josphat',
      bio: 'Software Developer',
      photo: 'http://hello.com/org.png',
      posts_counter: 0
    )
    @user_two = User.create(
      name: 'Kiploman',
      bio: 'Graphic designer',
      photo: 'http://hello.com/ogene.png',
      posts_counter: 0
    )
  end
  describe 'index page' do
    it 'shows the right content' do
      visit users_path
      expect(page).to have_content('Josphat')
      expect(page).to have_content('Kiploman')
    end
    it 'should have the profile picture' do
      visit users_path
      expect(page).to have_xpath("//img[contains(@src,'http://hello.com/org.png')]")
      expect(page).to have_xpath("//img[contains(@src,'http://hello.com/ogene.png')]")
    end
    it 'should redirect to users show page' do
      visit users_path(@user.id)
      click_on 'show user', match: :first
      expect(page).to have_current_path user_path(@user.id)
    end
  end
end