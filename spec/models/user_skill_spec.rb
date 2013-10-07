require 'spec_helper'

describe UserSkill do
  it { should belong_to(:user) }
  it { should belong_to(:skill) }
end
