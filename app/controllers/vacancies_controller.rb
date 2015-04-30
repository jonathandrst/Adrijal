class VacanciesController < ApplicationController
  before_action :set_vacancy, only: [:show, :edit, :update, :destroy, :apply]
  helper_method :apply
  before_action :verify_session
  before_action :verify_ownership, only: [:edit, :update, :destroy]

  # GET /vacancies
  # GET /vacancies.json
  def index

    @vacancies = Vacancy.where("projects.user_id = ?", current_user.id).joins(:project)
  end

  # GET /vacancies/1
  # GET /vacancies/1.json
  def show

  end

  def apply
    if UserVacancy.where("user_vacancies.user_id = ? AND user_vacancies.vacancy_id = ?", current_user.id, @vacancy.id).empty?
      @user_vacancy = UserVacancy.new()
      @user_vacancy.user_id = current_user.id
      @user_vacancy.vacancy_id = @vacancy.id
      @user_vacancy.acceptance_status = 0
      @user_vacancy.save
    end
  end
  
  # GET /vacancies/new
  def new
    @vacancy = Vacancy.new
  end

  # GET /vacancies/1/edit
  def edit
  end

  # POST /vacancies
  # POST /vacancies.json
  def create
    @vacancy = Vacancy.new(vacancy_params)

    respond_to do |format|
      if @vacancy.save
        format.html { redirect_to @vacancy, notice: 'Vacante creada correctamente.' }
        format.json { render :show, status: :created, location: @vacancy }
      else
        format.html { render :new }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vacancies/1
  # PATCH/PUT /vacancies/1.json
  def update
    respond_to do |format|
      if @vacancy.update(vacancy_params)
        format.html { redirect_to @vacancy, notice: 'Vacante actualizada correctamente.' }
        format.json { render :show, status: :ok, location: @vacancy }
      else
        format.html { render :edit }
        format.json { render json: @vacancy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vacancies/1
  # DELETE /vacancies/1.json
  def destroy
    @vacancy.destroy
    respond_to do |format|
      format.html { redirect_to vacancies_url, notice: 'Vacante eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  def verify_ownership
    if current_user.id != User.select("users.id").where("vacancies.id = ?", @vacancy.id).joins('INNER JOIN projects ON projects.user_id = users.id INNER JOIN vacancies ON vacancies.project_id = projects.id').pluck(:id)[0]
      redirect_to root_url, :notice => "No eres el creador de esta vacante."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vacancy
      @vacancy = Vacancy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vacancy_params
      params.require(:vacancy).permit(:occupation_id, :project_id, :description, :hourly_wage, :hours_required, :availability_status)
    end
end
