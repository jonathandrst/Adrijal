class AddReferences < ActiveRecord::Migration
  def change
    add_foreign_key :users, :occupations, column: :occupation_id
    add_foreign_key :projects, :users, column: :user_id
    add_foreign_key :vacancies, :projects, column: :project_id
    add_foreign_key :vacancies, :occupations, column: :occupation_id
    add_foreign_key :user_vacancies, :vacancies, column: :vacancy_id
    add_foreign_key :user_vacancies, :users, column: :user_id
  end
end
