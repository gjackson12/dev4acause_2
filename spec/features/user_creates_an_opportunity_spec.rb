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
    nonprofit = FactoryGirl.create(:nonprofit, user: user)
    visit new_user_session_path
    fill_in "Email", with: user.email 
    fill_in "Password", with: user.password
    click_button 'Sign in'
    
    visit new_nonprofit_opportunity_path(nonprofit)

    fill_in 'Headline', with: 
      'Seeking Digital Designer Volunteers for Non-Profit Theater 
       that serves Homeless Children'
    fill_in 'Opportunity description', with: 'This role will be assisting in extending a campaign through numerous 
      digital channels as well as concepting in the process. Designers MUST be 
      trained conceptually, not just in design techniques. It will involve 
      considerable work with senior members to flesh out and bring to life 
      conceptual ideas across a variety of digitally-focused media 
      (sites, banners, mobile, video, guerrilla PR etc.)

      Must be versed in the social media landscape and understand all social 
      platforms (facebook, twitter, pinterest, instagram, etc.)

      Job Qualifications:

      - Creating and extending digital designs/layouts from an existing campaign 
        concept
      - Extensive work in Photoshop, Illustrator, InDesign and Powerpoint
      - All work is digitally focused, with emphasis on digital media, web site
        and social media. Experience in digital production and design is critical.
      - Effective and efficient skills; the ability to turn items well and fast
      - Learning the business and developing their skillset by working closely 
        with strategy and being able to apply those learnings when called upon 
        to work independently. Someone who has progressed beyond entry-level 
        responsibilities will find it easier to succeed in this role, but not 
        necessary.
      - Contributing new ideas and creative design solutions appropriate for 
        diverse media outlets, evolving technologies, and current trends
      - Being self-motivated, hard working, well organized, and resilient to 
        ever-changing timelines, requests, and deliverables'
    fill_in 'Current stack', with:  "Our current website is built using Rails, Ember, and PostgreSQL.
      Rails is providing data persistance, while Ember is serving as our
      front-end. Blah, blah, blah, blah, Amazon web services, blah blah"
    fill_in 'Street address', with: '1234 Constiution Avenue'
    fill_in 'Zipcode', with: '20009'
    select('District of Columbia', :from => 'State')
    fill_in 'Extra details', with: 'Remote help would be fine as well'
    fill_in 'Estimated project duration', with: 'Approximately 3 weeks'
    fill_in 'Time commitment', with: 'Approximately 10 hours a week'
    fill_in 'How to apply', with: 'Please send an e-mail to john@redcross.org.
      Also please submit an application with your portfolio by following this
      link: http://www.jobvite.com/fakeapplication'
    click_on 'Create Opportunity'

    expect(nonprofit.opportunities.count).to eql(1)
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

end