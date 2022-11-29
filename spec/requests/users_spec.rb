require 'rails_helper'

RSpec.describe 'Users', type: %w[request feature] do
  before :each do
    @user = User.create(
      name: 'Waleed',
      bio: 'Web Developer',
      photo: 'http://waleed.png',
      posts_counter: 0
    )
  end

  it 'renders the index template' do
    get '/users/'
    expect(response.status).to eq(200)
    expect(response).to render_template('index')
  end

  it 'renders the show template' do
    get "/users/#{@user.id}"
    expect(response.status).to eq(200)
    expect(response).to render_template('show')
  end

  it 'renders index template with right text' do
    visit '/users/'
    expect(page).to have_text('users')
  end

  it 'renders show template with right text' do
    visit "/users/#{@user.id}"
    expect(page).to have_text('Sigle user goes here')
  end
end
