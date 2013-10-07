require 'spec_helper'

feature 'user edits profile', %Q{
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

  scenario 'specifies valid information' do
    user = FactoryGirl.create(:user, first_name: "Todd")
    first_name = 'Graham'
    visit new_user_session_path
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password
    click_button 'Sign in'
    
    visit edit_profile_path(user.id)

    fill_in 'First name', with: first_name
  
    click_on 'Update Profile'

    expect(user.reload.first_name).to eql(first_name)
  end

  scenario 'does not specify required information' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password
    click_button 'Sign in'
    click_link 'Edit Your Profile'

    fill_in 'First name', with: ""

    click_on 'Update Profile'

    user = user.reload

    within ".user_first_name" do
      expect(page).to have_content "can't be blank"
    end

  end

end