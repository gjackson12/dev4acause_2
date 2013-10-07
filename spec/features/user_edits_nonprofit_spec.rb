require 'spec_helper'

feature 'user edits their nonprofit', %Q{
  As an authenticated user
  I can edit my nonprofit
  So that I can provide the latest informaton about my nonprofit
} do

  # Acceptance Criteria
# * I have the ability to enter a new value for my name, EIN number, city, state,
#   description/mission, cause, date founded, phone number, fax number,
#   street address, street address 2, zipcode, email address, and website
#   about me, and current company 
# * If I leave name, EIN number, city, state, description/mission, or cause I will be prompted to re-
#   enter them 
# * If all required information is present than my profile should be updated

  scenario 'specifies valid information' do
    user = FactoryGirl.create(:user)
    nonprofit = FactoryGirl.create(:nonprofit, user: user)
    new_nonprofit_name = "Kramerica Foundation"
    visit new_user_session_path
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password
    click_button 'Sign in'
    
    visit edit_nonprofit_path(nonprofit)

    click_link "Edit Nonprofit"

    fill_in "Name", with: ""
    fill_in 'Name', with: new_nonprofit_name
    click_on 'Update Nonprofit'

    expect(nonprofit.reload.name).to eql(new_nonprofit_name)
  end

    # scenario 'does not specify required information' do
    #    user = FactoryGirl.create(:user)
    #    nonprofit = FactoryGirl.create(:nonprofit, user: user)
    #    visit new_user_session_path
    #    fill_in "Email", with: user.email 
    #    fill_in "Password", with: user.password
    #    click_button 'Sign in'
       
    #    visit edit_nonprofit_path(nonprofit)

    #    fill_in 'Name', with: "Edit Nonprofit"

    #    within ".nonprofit_name" do
    #        expect(page).to have_content "can't be blank"
    #    end

    # end

end