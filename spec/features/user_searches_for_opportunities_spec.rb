require 'spec_helper'

feature 'user searches for opportunities', %q{
  As a user
  I want to search for opportunities
  So that I can specify my criteria
} do

  scenario 'search for existing opportunities' do
    target = FactoryGirl.create(:opportunity, headline: 'banana farmer')
    other = FactoryGirl.create(:opportunity, headline: 'yak shaver')

    visit opportunities_path

    expect(page).to have_content('yak shaver')
    expect(page).to have_content('banana farmer') 

    fill_in 'Search Opportunities', with: 'bananas'
    click_button 'Search Opportunities'

    expect(page).to have_content('banana farmer')
    expect(page).to_not have_content('yak shaver')
  end

end