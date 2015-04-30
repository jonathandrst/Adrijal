class Project < ActiveRecord::Base
	#associations
	belongs_to :user
	has_many :vacancies

	#validations
	validates :name, :description, :user_id, :address, :availability_status, presence: true
	validates :name, length: { in: 2..120 }, uniqueness: true
	validates :description, length: { in: 2..200 }
	validates :address, length: { in: 2..400 }

end