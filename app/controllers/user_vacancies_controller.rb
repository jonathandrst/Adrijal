class UserVacanciesController < ApplicationController
  before_action :set_user_vacancy, only: [:show, :update, :destroy, :approve, :disapprove]
  before_action :verify_session
  before_action :verify_ownership, only: [:update, :destroy, :approve, :disapprove]
  before_action :approve, only: [ :update]

  # GET /user_vacancies
  # GET /user_vacancies.json
  def index
    @user_vacancies = UserVacancy.where(user_id:current_user.id)
    @applicants = UserVacancy.where("projects.user_id = ?", current_user.id).joins('INNER JOIN vacancies ON user_vacancies.vacancy_id = vacancies.id INNER JOIN projects ON vacancies.project_id = projects.id')


  end

  # GET /user_vacancies/1
  # GET /user_vacancies/1.json
  def show
  end


  def approve
    if UserVacancy.where("user_vacancies.acceptance_status = ? AND user_vacancies.vacancy_id = ?", 1, @user_vacancy.vacancy_id).count >= 1
      redirect_to user_vacancies_url, :notice => "Alguien ya fue aceptado para esta posición previamente."
    else 
      @user_vacancy.acceptance_status = 1
      @user_vacancy.save
      @vacancy =  Vacancy.find_by_id(@user_vacancy.vacancy_id)
      @vacancy.availability_status = 0
      @vacancy.save
    end
  end

  def disapprove
    @user_vacancy.acceptance_status = 0
    @user_vacancy.save
    @vacancy =  Vacancy.find_by_id(@user_vacancy.vacancy_id)
    @vacancy.availability_status = 1
    @vacancy.save
  end

  # GET /user_vacancies/new
  def new
    @user_vacancy = UserVacancy.new
  end

  # GET /user_vacancies/1/edit

  # POST /user_vacancies
  # POST /user_vacancies.json
  def create
    @user_vacancy = UserVacancy.new(user_vacancy_params)

    respond_to do |format|
      if @user_vacancy.save
        format.html { redirect_to @user_vacancy, notice: 'Aplicación exitosa' }
        format.json { render :show, status: :created, location: @user_vacancy }
      else
        format.html { render :new }
        format.json { render json: @user_vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_vacancies/1
  # PATCH/PUT /user_vacancies/1.json
  def update
    respond_to do |format|
      if @user_vacancy.update(user_vacancy_params)
        format.html { redirect_to @user_vacancy, notice: 'Aplicación actualizada correctamente' }
        format.json { render :show, status: :ok, location: @user_vacancy }
      else
        format.html { render :edit }
        format.json { render json: @user_vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_vacancies/1
  # DELETE /user_vacancies/1.json
  def destroy
    @user_vacancy.destroy
    respond_to do |format|
      format.html { redirect_to user_vacancies_url, notice: 'Aplicación eliminada correctamente' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_vacancy
      @user_vacancy = UserVacancy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_vacancy_params
      params.require(:user_vacancy).permit(:acceptance_status)
    end

    def verify_ownership
      if current_user.id != User.select("users.id").where("vacancies.id = ?", @user_vacancy.vacancy_id).joins('INNER JOIN projects ON users.id = projects.user_id INNER JOIN vacancies ON vacancies.project_id = projects.id INNER JOIN user_vacancies ON user_vacancies.vacancy_id = vacancies.id').pluck(:id)[0]
        redirect_to user_vacancies_url, :notice => "No eres el creador de esta vacante."
      end
    end
end
