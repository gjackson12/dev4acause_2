class Opportunity < ActiveRecord::Base
  belongs_to :nonprofit, inverse_of: :opportunities

  validates_presence_of :description
  validates_presence_of :current_stack
  validates_presence_of :headline
  validates_presence_of :application_info
  validates_presence_of :nonprofit_id

  validates_format_of :zipcode, 
    with: /\A\d{5}(-\d{4})?\z/i, allow_blank:true
end
