class CreateOccupations < ActiveRecord::Migration
  def change
    create_table :occupations do |t|
      t.string :name
      t.string :description

      t.timestamps null: false
    end
  end
end
