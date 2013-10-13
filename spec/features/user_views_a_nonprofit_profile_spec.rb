require 'spec_helper'

feature 'user views a nonprofit profile', %Q{
  As an authenticated user or visitor
  I want to view a nonprofit profile
  So that I can find out more about their work
} do

  # Acceptance Criteria
# * I must be able to view the nonprofit's name, description, state,
#   city, and cause
# * If I leave first name, last name, city, state, or zipcode blank I will be prompted to re-
# * enter them 
# * If I enter all specified information in a valid format my profile should be updated

  scenario "authenticated nonprofit owner views their nonprofit's profile" do
    user = FactoryGirl.create(:user)
    nonprofit = FactoryGirl.create(:nonprofit, user: user)
    visit new_user_session_path
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password
    click_button 'Sign in'
    
    visit nonprofit_path(nonprofit)

    expect(page).to have_content(
      nonprofit.name,
      nonprofit.description_mission,
      nonprofit.state,
      nonprofit.city,
      nonprofit.cause
      )
    expect(page).to have_content("Edit Your Nonprofit")
  end

  scenario "user views a nonprofit profile they do not own" do
    user1 = FactoryGirl.create(:user)
    user2 = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user1.email 
    fill_in "Password", with: user1.password
    click_button 'Sign in'
    
    visit profile_path(user2)

    page.should have_no_content("Edit Your Nonprofit")
    page.should have_no_content("Create an Opportunity")
  end

  scenario "user views their nonprofit profile while not authenticated" do
    user = FactoryGirl.create(:user)
    nonprofit = FactoryGirl.create(:nonprofit, user: user)
    
    visit nonprofit_path(nonprofit)

    save_and_open_page

    page.should have_no_content("Edit Your Nonprofit")
    page.should have_no_content("Create an Opportunity")
  end
    

end