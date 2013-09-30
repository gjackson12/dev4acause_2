require 'spec_helper'

describe Nonprofit do

  it { should belong_to(:user) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:ein_num) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:description_mission) }
  it { should validate_presence_of(:cause) }

  it { should have_valid(:name).when("United Way","American Red Cross") }
  it { should_not have_valid(:name).when(nil,"") }

  it { should have_valid(:ein_num).when('1-2345678', '55-5555555') }
  it { should_not have_valid(:ein_num).when(nil,'','100000000000000000000', 'foo') }

  it { should ensure_inclusion_of(:state).in_array(State::STATES) }
  it {should_not have_valid(:state).when(nil,"") }

  it { should have_valid(:city).when("Washington","Boston","Seattle") }
  it {should_not have_valid(:city).when(nil,"") }

  it { should have_valid(:description_mission).when(
    "The American Red Cross prevents and alleviates human suffering 
     in the face of emergencies by mobilizing the power of volunteers 
     and the generosity of donors. Survivors of disaster, patients 
     needing lifesaving blood, members of the military and many more turn 
     to the Red Cross every second of every day."
    ) }
  it { should_not have_valid(:description_mission).when(nil,"") }

  it { should ensure_inclusion_of(:cause).in_array(Cause::CAUSES) }
  it { should_not have_valid(:cause).when(nil,"") }

  it { should have_valid(:zipcode).when('20009', '20009-8523') }
  it { should_not have_valid(:zipcode).when('10000000000000000', 'foo') }

  it { should have_valid(:date_founded).when("September 22nd 2009","1971") }

  it { should have_valid(:phone_number).when("7031111111","703-111-1111") }
  it { should_not have_valid(:phone_number).when("7037649220000","foo") }

  it { should have_valid(:fax_number).when("7031111111","703-111-1111") }
  it { should_not have_valid(:fax_number).when("7037649220000","foo") }

  it { should have_valid(:street_address).when("1234 Constitution Avenue","3455 Lincoln Avenue") }

  it { should have_valid(:street_address_2).when("Apt 4","P.O. Box 53") }

  it { should have_valid(:website_string).when("http://www.example.org","http://www.example.com") }

  it { should have_valid(:email_address).when("john.smith@example.com") }

end
