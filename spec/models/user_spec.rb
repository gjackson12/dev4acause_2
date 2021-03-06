require 'spec_helper'

describe User do

  it { should have_many(:skills).through(:user_skills) }

  it { should have_many(:nonprofits) }

  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }

  it {should have_valid(:first_name).when("John","Edward","Matt") }
  it {should_not have_valid(:first_name).when(nil,"") }

  it {should have_valid(:last_name).when("Smith","Jones","Simpson") }
  it {should_not have_valid(:last_name).when(nil,"") }

  it {should have_valid(:city).when("Washington","Boston","Seattle") }
  it {should_not have_valid(:city).when(nil,"") }

  it {should have_valid(:zipcode).when("20009","22032","20009-8523") }

  it { should ensure_inclusion_of(:state).in_array(State::STATES) }
  it {should_not have_valid(:state).when(nil,"") }

end
