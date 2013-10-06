require 'spec_helper'

feature 'user signs in', %Q{
  As an unauthenticated user
  I can sign in to my account
  So that I can access my profile
} do

  # Acceptance Criteria
# * I must specify my e-mail address
# * I must specify my password
# * If I do not enter the correct information I will be prompted to 
#   enter it again
# * If I enter my e-mail address and password correctly I will be
#   signed into the application

  scenario 'specifies valid information' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password
    click_button 'Sign in'
    expect(page).to have_content(user.email)
  end

  scenario 'specifies invalid password' do
    visit new_user_session_path
    fill_in "Email", with: 'graham.jackson07@gmail.com' 
    fill_in "Password", with: 'fakepassword'
    click_button 'Sign in'
    expect(page).to have_content('Invalid email or password.')
  end

end