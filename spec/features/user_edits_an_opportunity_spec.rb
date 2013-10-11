require 'spec_helper'

feature ' owner edits non-profi', %Q{
  As an authenticated user
  I can edit a non-profit I own
  So that I can update the opportunitiy with the latest information
} do

# Acceptance Criteria
# * I must specify a headline, description, current stack, and 
#   application information
# * I must have the ability to specify a street address, city, state,
#   extra details, duration, time commitment, start date, end date,
#   and zipcode
# * If I do not enter any of the above required fields I will be prompted 
#   to do so
# * If I enter all specified information in a valid format my opportunity
#   will be updated

  scenario 'specifies valid information' do
    user = FactoryGirl.create(:user)
    nonprofit = FactoryGirl.create(:nonprofit, user: user)
    opportunity = FactoryGirl.create(:opportunity, description: "new stuff", nonprofit: nonprofit)
    new_description = 'Seeking Digital Designer Volunteers for Non-Profit Theater 
       that serves Homeless Children'
    visit new_user_session_path
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password
    click_button 'Sign in'
    
    visit new_nonprofit_opportunity_path(nonprofit,opportunity)

    fill_in 'Headline', with: new_description
    click_on 'Update Opportunity'

    expect(opportunity.reload.description).to eql(new_description)
  end

  # scenario 'does not specify required information' do
  #   user = FactoryGirl.create(:user)
  #   prev_nonprofit_count = Nonprofit.count
  #   visit new_user_session_path
  #   fill_in "Email", with: user.email 
  #   fill_in "Password", with: user.password
  #   click_button 'Sign in'
  #   click_link 'Create a Nonprofit'
  #   click_button 'Create Nonprofit'

  #   within ".nonprofit_name" do
  #       expect(page).to have_content "can't be blank"
  #   end

  #   within ".nonprofit_ein_num" do
  #       expect(page).to have_content "can't be blank"
  #   end

  #   within ".nonprofit_city" do
  #       expect(page).to have_content "can't be blank"
  #   end

  #   within ".nonprofit_state" do
  #       expect(page).to have_content "can't be blank"
  #   end

  #   within ".nonprofit_description_mission" do
  #       expect(page).to have_content "can't be blank"
  #   end

  #   within ".nonprofit_cause" do
  #       expect(page).to have_content "can't be blank"
  #   end
    
  #   expect(Nonprofit.count).to eql(prev_nonprofit_count)
  # end

end