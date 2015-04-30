class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.string :name
      t.string :description
      t.string :address
      t.integer :availability_status

      t.timestamps null: false
    end
  end
end
