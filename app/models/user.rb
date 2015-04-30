class User < ActiveRecord::Base
	#associations
	has_many :projects
	belongs_to :occupation
	has_many :user_vacancies

	#callbacks
	before_save :asign_priority

	#methods
  	devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

 	#validations
	validates :rfc, :fullname, :mobile_phone_number, :home_phone_number, :linkedin_url, presence: true

  def asign_priority 
    if self.role_identity.nil?
      self.role_identity = 0
    end
  end

end