require 'spec_helper'

describe OpportunitySkill do
  it { should belong_to(:skill) }
  it { should belong_to(:opportunity) }
end
