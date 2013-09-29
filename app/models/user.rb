class User < ActiveRecord::Base

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zipcode

  validates_format_of :zipcode, 
    with: /\A\d{5}(-\d{4})?\z/i

  validates_inclusion_of :state, 
    in: State::STATES
    
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
