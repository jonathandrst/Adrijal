class CreateUserVacancies < ActiveRecord::Migration
  def change
    create_table :user_vacancies do |t|
      t.integer :vacancy_id
      t.integer :user_id
      t.integer :acceptance_status

      t.timestamps null: false
    end
  end
end
