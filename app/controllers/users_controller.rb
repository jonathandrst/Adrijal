class UsersController < ApplicationController
	before_action :verify_session
  def show
  	@user = User.find(params[:id])
  end
end