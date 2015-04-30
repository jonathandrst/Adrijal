require 'test_helper'

class UserVacanciesControllerTest < ActionController::TestCase
  setup do
    @user_vacancy = user_vacancies(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_vacancies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_vacancy" do
    assert_difference('UserVacancy.count') do
      post :create, user_vacancy: { acceptance_status: @user_vacancy.acceptance_status, user_id: @user_vacancy.user_id, vacancy_id: @user_vacancy.vacancy_id }
    end

    assert_redirected_to user_vacancy_path(assigns(:user_vacancy))
  end

  test "should show user_vacancy" do
    get :show, id: @user_vacancy
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_vacancy
    assert_response :success
  end

  test "should update user_vacancy" do
    patch :update, id: @user_vacancy, user_vacancy: { acceptance_status: @user_vacancy.acceptance_status, user_id: @user_vacancy.user_id, vacancy_id: @user_vacancy.vacancy_id }
    assert_redirected_to user_vacancy_path(assigns(:user_vacancy))
  end

  test "should destroy user_vacancy" do
    assert_difference('UserVacancy.count', -1) do
      delete :destroy, id: @user_vacancy
    end

    assert_redirected_to user_vacancies_path
  end
end
