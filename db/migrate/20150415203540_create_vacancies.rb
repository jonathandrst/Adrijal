class CreateVacancies < ActiveRecord::Migration
  def change
    create_table :vacancies do |t|
      t.integer :occupation_id
      t.integer :project_id
      t.string :description
      t.float :hourly_wage
      t.float :hours_required
      t.integer :availability_status

      t.timestamps null: false
    end
  end
end
