class Occupation < ActiveRecord::Base
	#associations
	has_many :users
	has_many :vacancies

	#validations
	validates :name, :description, presence: true
	validates :name, length: { in: 2..120 }, uniqueness: true
	validates :description, length: { in: 2..200 }

end
