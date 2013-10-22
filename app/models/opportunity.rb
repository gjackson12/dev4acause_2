class Opportunity < ActiveRecord::Base
  belongs_to :nonprofit, inverse_of: :opportunities

  has_many :opportunity_skills
  has_many :skills, through: :opportunity_skills

  accepts_nested_attributes_for :opportunity_skills

  validates_presence_of :description
  validates_presence_of :current_stack
  validates_presence_of :headline
  validates_presence_of :application_info
  validates_presence_of :nonprofit_id

  validates_format_of :zipcode, 
    with: /\A\d{5}(-\d{4})?\z/i, allow_blank:true

  validates_inclusion_of :state, 
    in: State::STATES, allow_blank:true

  def self.search(query, state = nil)
    results = joins('left outer join opportunity_skills os on opportunities.id = os.opportunity_id join skills s on s.id = os.skill_id').where("to_tsvector(coalesce(opportunities.description, '') || ' ' || coalesce(opportunities.headline,'') || ' ' || coalesce(opportunities.state, '') || ' ' || coalesce(s.name, '')) @@ plainto_tsquery(?)", query).select("distinct opportunities.id, opportunities.*")
  end

  def self.createable_by(user,nonprofit)
    user.id == nonprofit.user_id
  end

end
