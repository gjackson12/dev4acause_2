class Nonprofit < ActiveRecord::Base

  belongs_to :user
  has_many :opportunities, :dependent => :destroy, inverse_of: :nonprofit 

  validates_presence_of :name
  validates_presence_of :ein_num
  validates_presence_of :state
  validates_presence_of :city
  validates_presence_of :description_mission
  validates_presence_of :cause

  validates_format_of :ein_num,
    with: /\A[1-9]\d?-\d{7}\z/i

  validates_format_of :phone_number,
    with: /\A\d{3}?[-. ]?\d{3}?[-. ]?\d{4}\z/, allow_blank:true

  validates_format_of :fax_number,
    with: /\A\d{3}?[-. ]?\d{3}?[-. ]?\d{4}\z/, allow_blank:true

  validates_format_of :email_address, 
    with: /.+@.+\..+/i, allow_blank:true

  validates_inclusion_of :cause, 
    in: Cause::CAUSES

  validates_inclusion_of :state, 
    in: State::STATES

  validates_format_of :zipcode, 
    with: /\A\d{5}(-\d{4})?\z/i, allow_blank:true

  mount_uploader :image, ImageUploader
end
