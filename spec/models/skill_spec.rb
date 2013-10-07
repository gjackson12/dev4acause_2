require 'spec_helper'

describe Skill do
  it { should have_many(:opportunities).through(:opportunity_skills) }
  it { should have_many(:users).through(:user_skills) }

  it { should validate_presence_of(:name) }

  it { should have_valid(:name).when('Java','Ruby','Python') }
  it { should_not have_valid(:name).when(nil, '') }
end
