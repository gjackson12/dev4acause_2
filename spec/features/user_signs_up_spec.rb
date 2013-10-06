require 'spec_helper'

feature 'user signs up for the site', %Q{
  As an unauthenticated user
  I want to sign up for the site
  So that I can create opportunities
} do

  # Acceptance Criteria
# * I must specify a valid e-mail address
# * I must specify a password and confirm the password
# * I must provide a password that is 8 characters long
# * If I submit my information without a password that is 8 characters 
#   long I will be re-directed back to the sign-up page with a message 
#   displayed asking me to re-enter the password
# * I must specify a first name,last name, city, state, and zipcode
# * If I do not enter any of the above fields I will be re-directed to 
#   the sign-up page with a message displayed asking me to complete all 
#   fields

  scenario 'specifies valid information' do
    prev_user_count = User.count
    visit new_user_registration_path
    email = "john.smith@americanredcross.com"
    fill_in "Email", with: email
    fill_in "Password", with: "bondra12", :match => :prefer_exact
    fill_in "Verify password", with: "bondra12", :match => :prefer_exact
    fill_in "First name", with: "John"
    fill_in "Last name", with: "Smith"
    fill_in "City/town", with: "Washington"
    select('District of Columbia', :from => 'State')
    fill_in "Postal code", with: "20009"
    click_button 'Sign up'
    expect(page).to have_content(email)
    expect(User.count).to eql(prev_user_count + 1)
  end


  scenario 'does not specify required information' do
    prev_user_count = User.count
    visit new_user_registration_path
    click_button 'Sign up'
    expect(User.count).to eql(prev_user_count)
    
    within ".user_email" do
        expect(page).to have_content "can't be blank"
    end

    within ".user_password" do
        expect(page).to have_content "can't be blank"
    end

    within ".user_first_name" do
        expect(page).to have_content "can't be blank"
    end

    within ".user_last_name" do
        expect(page).to have_content "can't be blank"
    end

    within ".user_city" do
        expect(page).to have_content "can't be blank"
    end

    within ".user_state" do
        expect(page).to have_content "can't be blank"
    end

     within ".user_zipcode" do
        expect(page).to have_content "can't be blank"
    end

  end

  scenario 'does not specify an 8 character password, told to provide 8 character password' do
    prev_user_count = User.count
    visit new_user_registration_path
    fill_in "Email", with: "john.smith@americanredcross.com"
    fill_in "Password", with: "bondra", :match => :prefer_exact
    fill_in "Verify password", with: "bondra", :match => :prefer_exact
    fill_in "First name", with: "John"
    fill_in "Last name", with: "Smith"
    fill_in "City/town", with: "Washington"
    select('District of Columbia', :from => 'State')
    fill_in "Postal code", with: "20009"
    click_button 'Sign up'

    within ".user_password" do
        expect(page).to have_content 'is too short (minimum is 8 characters)'
    end
    expect(User.count).to eql(prev_user_count)
  end

end