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
    user = FactoryGirl.create(:user)
    first_name = 'Graham'
    visit new_user_session_path
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password
    click_button 'Sign in'
    
    visit edit_profile_path(user.id)

    fill_in 'First name', with: first_name
    fill_in 'Last name', with: 'Jackson'
    fill_in 'City/town', with: 'Miami'
    select('Florida', :from => 'State')
    fill_in 'Zipcode', with: '22032'
    fill_in 'About me', with: "
      Lorem ipsum dolor sit amet, consectetur adipisicing elit, 
      sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
      Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi 
      ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in 
      voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint 
      occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit 
      anim id est laborum."
    fill_in 'Current company', with: 'LivingSocial'
    click_on 'Update Profile'

    # expect(user.first_name).to eql(first_name) <---- need to figure out what the issue is
  end

    # scenario 'does not specify required information' do
    #    user = FactoryGirl.create(:user)
    #    visit new_user_session_path
    #    fill_in "Email", with: user.email 
    #    fill_in "Password", with: user.password
    #    click_button 'Sign in'
    #    click_link 'Edit Your Profile'

    #    within ".user_first_name" do
    #        expect(page).to have_content "can't be blank"
    #    end

    #    within ".user_last_name" do
    #        expect(page).to have_content "can't be blank"
    #    end

    #    within ".user_city" do
    #        expect(page).to have_content "can't be blank"
    #    end

    #    within ".user_state" do
    #        expect(page).to have_content "can't be blank"
    #    end

    #    within ".user_zipcode" do
    #        expect(page).to have_content "can't be blank"
    #    end

    # end

end