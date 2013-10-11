require 'spec_helper'

describe Opportunity do
  it { should belong_to :nonprofit }
  it { should have_many(:skills).through(:opportunity_skills) }

  it { validate_presence_of(:description) }
  it { validate_presence_of(:current_stack) }
  it { validate_presence_of(:headline) }
  it { validate_presence_of(:nonprofit_id) }

  it { should have_valid(:description).when(
    "The Actors Theatre Workshop is an award-winning non-profit theatre 
    company that also provides classes in acting and leadership for actors 
    and business professionals as well as com."
    )}
  it { should_not have_valid(:description).when(nil,"") }

  it { should have_valid(:current_stack).when(
      "Our current website is built using Rails, Ember, and PostgreSQL.
      Rails is providing data persistance, while Ember is serving as our
      front-end. Blah, blah, blah, blah, Amazon web services, blah blah"
    )}
  it { should_not have_valid(:current_stack).when(nil,"") }

  it { should have_valid(:headline).when(
    "Seeking Digital Designer Volunteers for Non-Profit Theater 
     that serves Homeless Children"
    ) }
  it { should_not have_valid(:headline).when(nil,"") }

  it { should have_valid(:city).when("Washington","Boston","Seattle") }

  it { should have_valid(:street_address).when("1234 Constitution Avenue","3455 Lincoln Avenue") }

  it { should have_valid(:extra_details).when("Remote help would be fine as well") }
  
  it { should have_valid(:duration).when("Approximately 3 weeks") }

  it { should have_valid(:time_commitment).when("Maybe 10 hours per week") }

  it { should have_valid(:start_date).when("2001-10-05") }

  it { should have_valid(:end_date).when("2001-10-05") }  

  it { should have_valid(:zipcode).when('20009', '20009-8523') }
  it { should_not have_valid(:zipcode).when('10000000000000000', 'foo') }

  it { should ensure_inclusion_of(:state).in_array(State::STATES) }

  it { should have_valid(:application_info).when(
      'Please send an e-mail to john@redcross.org.
      Also please submit an application with your portfolio 
      by following this link: http://www.jobvite.com/fakeapplication') }
  it { should_not have_valid(:application_info).when(nil, "") }

  describe '.search' do
    describe 'by description' do
      before :each do
        @target = FactoryGirl.create(:opportunity, 
          description: 'foo bar baz')
        @other = FactoryGirl.create(:opportunity,
          description: 'something else')
      end

      it 'matches exactly' do
        results = Opportunity.search('foo bar baz')
        expect(results).to include(@target)
        expect(results).to_not include(@other)
      end

      it 'matches partially' do
        results = Opportunity.search('bar')
        expect(results).to include(@target)
        expect(results).to_not include(@other)
      end

      it 'is case insensitive' do
        results = Opportunity.search('FoO bAr BAZ')
        expect(results).to include(@target)
        expect(results).to_not include(@other)
      end

      it 'ignores order of words' do
        results = Opportunity.search('bar baz foo')
        expect(results).to include(@target)
        expect(results).to_not include(@other)
      end
    end

    it 'matches multiple fields' do
      target = FactoryGirl.create(:opportunity,
        description: 'foodler', headline: 'batmitzvah')
      other = FactoryGirl.create(:opportunity,
        description: 'bananas', headline: 'oranges')

      results = Opportunity.search('foodler batmitzvah')
      expect(results).to include(target)
      expect(results).to_not include(other)
    end

    it 'matches fields on other models'
    it 'matches pluralized words'
    
    it 'handles null values' do
      target = FactoryGirl.create(:opportunity,
        description: 'gfkjgfsdgf', extra_details: 'foodler')
      other = FactoryGirl.create(:opportunity,
        description: 'blah blah', extra_details: nil)

      results = Opportunity.search('foodler')
      expect(results).to include(target)
    end
  end

  

end
