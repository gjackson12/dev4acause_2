require 'spec_helper'

feature 'user creates non-profit', %Q{
  As an authenticated user
  I can create a non-profit
  So that I can begin to post opportunities
} do

  # Acceptance Criteria
# * I must specify a name, ein_number, state, city, description mission, and
#   cause area
# * I am able to specify a date founded, phone number,fax number, street address,
#   street 2 address, zipcode, e-mail address, and website url 
# * If I do not enter any of the above required fields I will be prompted 
#   to do so
# * If I enter all specified information in a valid format my non-profit
#   will be created and I can begin to post opportunities

  scenario 'specifies valid information' do
    user = FactoryGirl.create(:user)
    prev_nonprofit_count = Nonprofit.count
    visit new_user_session_path
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password
    click_button 'Sign in'
    click_link 'Create a Nonprofit'

    fill_in 'Name', with: 'American Red Cross'
    fill_in 'EIN number', with: '1-1111111'
    fill_in 'City/town', with: 'Washington'
    select('District of Columbia', :from => 'State')
    fill_in 'Description', with: "
      The American Red Cross prevents and alleviates human suffering 
      in the face of emergencies."
    fill_in 'Mission', with: "
      The American Red Cross prevents and alleviates human suffering 
      in the face of emergencies."
    fill_in 'Vision', with: "
      The American Red Cross prevents and alleviates human suffering 
      in the face of emergencies."
    select('Disaster Relief', :from => 'Cause area')
    fill_in 'Date founded', with: 'May 21st 1881'
    fill_in 'Phone number', with: '202-111-1111'
    fill_in 'Fax number', with: '202-111-1111'
    fill_in 'Street address', with: '1234 Constiution Avenue'
    fill_in 'Street address 2', with: '4th floor'
    fill_in 'Zipcode', with: '20009'
    fill_in 'Email address', with: 'john@americanredcross.com'
    fill_in 'Website', with: 'http://www.redcross.org'
    click_button 'Create Nonprofit'

    expect(Nonprofit.count).to eql(prev_nonprofit_count + 1)
    expect(user.nonprofits.first).to eql(Nonprofit.last)
  end

  scenario 'does not specify required information' do
    user = FactoryGirl.create(:user)
    prev_nonprofit_count = Nonprofit.count
    visit new_user_session_path
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password
    click_button 'Sign in'
    click_link 'Create a Nonprofit'
    click_button 'Create Nonprofit'

    within ".nonprofit_name" do
        expect(page).to have_content "can't be blank"
    end

    within ".nonprofit_ein_num" do
        expect(page).to have_content "can't be blank"
    end

    within ".nonprofit_city" do
        expect(page).to have_content "can't be blank"
    end

    within ".nonprofit_state" do
        expect(page).to have_content "can't be blank"
    end

    within ".nonprofit_description_mission" do
        expect(page).to have_content "can't be blank"
    end

    within ".nonprofit_cause" do
        expect(page).to have_content "can't be blank"
    end
    
    expect(Nonprofit.count).to eql(prev_nonprofit_count)
  end

  scenario 'specifies invalid formats for fields with format validations' do
    user = FactoryGirl.create(:user)
    prev_nonprofit_count = Nonprofit.count
    visit new_user_session_path
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password
    click_button 'Sign in'
    click_link 'Create a Nonprofit'

    fill_in 'Name', with: 'American Red Cross'
    fill_in 'EIN number', with: '1-21111111'
    fill_in 'City/town', with: 'Washington'
    select('District of Columbia', :from => 'State')
    fill_in 'Description', with: "
      The American Red Cross prevents and alleviates human suffering 
      in the face of emergencies by mobilizing the power of volunteers 
      and the generosity of donors."
    select('Disaster Relief', :from => 'Cause area')
    fill_in 'Date founded', with: 'May 21st 1881'
    fill_in 'Phone number', with: '202-111-11111'
    fill_in 'Fax number', with: '202-111-11111'
    fill_in 'Street address', with: '1234 Constiution Avenue'
    fill_in 'Street address 2', with: '4th floor'
    fill_in 'Zipcode', with: '200090000'
    fill_in 'Email address', with: 'johnamericanredcross.com'
    fill_in 'Website', with: 'http://www.redcross.org'
    click_button 'Create Nonprofit'

     within ".nonprofit_ein_num" do
        expect(page).to have_content "is invalid"
     end

     within ".nonprofit_phone_number" do
        expect(page).to have_content "is invalid"
     end

     within ".nonprofit_fax_number" do
        expect(page).to have_content "is invalid"
     end

     within ".nonprofit_zipcode" do
        expect(page).to have_content "is invalid"
     end

     within ".nonprofit_email_address" do
        expect(page).to have_content "is invalid"
     end

    expect(Nonprofit.count).to eql(prev_nonprofit_count)
  end

end