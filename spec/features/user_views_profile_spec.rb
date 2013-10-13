require 'spec_helper'

feature 'user views their profile', %Q{
  As an authenticated user or visitor
  I can view a profile
  So that I can find users to connect with
} do

  # Acceptance Criteria
# * I must be able to view the user's first name, last name, city, state, and zipcode
# * If provided I am able to see their about me section, current company,
#   birthday, education, and the reason they joined Dev4aCause 
# * I must be able to view a user's profile even if I am not signed in
# * I must not be able to see the option to edit my profile if I am 
#   not signed in
# * I must not be able to see the option to edit if I am viewing
#   a profile for another user

  scenario 'user views their own profile' do
    user = FactoryGirl.create(:user)
    visit new_user_session_path
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password
    click_button 'Sign in'
    
    visit profile_path(user)

    expect(page).to have_content(
      user.email, 
      user.first_name, 
      user.last_name,
      user.city,
      user.state,
      user.zipcode
      )
    expect(page).to have_content("Edit Your Profile")
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

   scenario "user views their profile while not authenticated" do
    user = FactoryGirl.create(:user)
    
    visit profile_path(user)

    page.should have_no_content("Edit Your Profile")
    page.should have_no_content("Create a Nonprofit")
  end
    

end