require 'spec_helper'

feature 'user searches for opportunities', %q{
  As a user
  I want to search for opportunities
  So that I can specify my criteria
} do

  scenario 'search for existing opportunities' do
    opportunity = FactoryGirl.create(:opportunity, headline: 'banana farmer')

    visit root_path
    fill_in 'Search', with: 'bananas'
    click_button 'Search Opportunities'

    expect(page).to have_content('banana farmer')
  end

end