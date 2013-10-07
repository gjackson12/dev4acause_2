require 'spec_helper'

feature 'user views a profile', %Q{
  As an authenticated user
  I can edit my profile
  So that I can share updated information about myself
} do

  # Acceptance Criteria
# * I have the ability to enter a new value for my first name, last name, city, state, zipcode,
#   about me, and current company 
# * If I leave first name, last name, city, state, or zipcode blank I will be prompted to re-
# * enter them 
# * If I enter all specified information in a valid format my profile should be updated

  scenario 'user views their own profile' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password
    click_button 'Sign in'
    
    visit profile_path(user)

    expect(page).to have_content(user.email)
  end

  scenario "user views another user's profile" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user1.email 
    fill_in "Password", with: user1.password
    click_button 'Sign in'
    
    visit profile_path(user2)

    page.should have_no_content("Edit Your Profile")
    page.should have_no_content("Create a Nonprofit")
  end
    

end