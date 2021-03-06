class User < ActiveRecord::Base

  has_many :user_skills
  has_many :skills, through: :user_skills

  has_many :nonprofits, :dependent => :destroy, inverse_of: :user

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :city
  validates_presence_of :state

  validates_format_of :zipcode, 
    with: /\A\d{5}(-\d{4})?\z/i, :allow_blank => true 

  validates_inclusion_of :state, 
    in: State::STATES
    
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable

  def date_formatter(date)
    formatted_date = date.to_date
    formatted_date = formatted_date.to_formatted_s(:long)
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    if user
      return user
    else
      registered_user = User.where(:email => auth.info.email).first
      if registered_user
        return registered_user
      else
        location = self.location_cleaner(auth.info.location)
        user = User.create(first_name:auth.info.first_name,
                            last_name:auth.info.last_name,
                            city: location[0],
                            state: location[1],
                            provider:auth.provider,
                            uid:auth.uid,
                            email:auth.info.email,
                            password:Devise.friendly_token[0,20],
                          )
      end
    end
    user
  end

  def self.location_cleaner(fb_location)
    if fb_location.present?
      fb_location.split(/, /)
    else
      return ['Washington', 'District of Columbia']
    end
  end

  def self.search(query, state = nil)
    results = joins('left outer join user_skills us on users.id = us.user_id join skills s on s.id = us.skill_id').where("to_tsvector(coalesce(users.state, '') || ' ' || coalesce(users.about_me,'') || ' ' || coalesce(users.city, '') || ' ' || coalesce(s.name, '')) @@ plainto_tsquery(?)", query).select("distinct users.id, users.*")
  end

  def recommended_opportunities
    self.skills.reduce([]) {|opps, skill| opps + skill.opportunities }.uniq.take(5)
  end

end
