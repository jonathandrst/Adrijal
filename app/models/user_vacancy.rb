class UserVacancy < ActiveRecord::Base

	#associations
	belongs_to :user
	belongs_to :vacancy

	#validations
	validates :vacancy_id, :user_id, :acceptance_status, presence: true

	
end
