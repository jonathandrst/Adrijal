class Vacancy < ActiveRecord::Base
	#associations
	has_many :user_vacancies
	belongs_to :project
	belongs_to :occupation

	#validations
	validates :occupation_id, :project_id, :description, :hourly_wage, :hours_required, :availability_status, presence: true
	validates :description, length: { in: 2..200 }
	validates :hourly_wage, numericality: { greater_than_or_equal_to: 0 }
	validates :hours_required, numericality: { greater_than_or_equal_to: 0 }

end
