class JobsController < ApplicationController

  before_action :verify_session

  def index
  	@vacancies = Vacancy.where("vacancies.occupation_id = ? AND vacancies.availability_status = ? AND projects.user_id != ?", current_user.occupation_id, 1, current_user.id).joins(:project)
  end
end