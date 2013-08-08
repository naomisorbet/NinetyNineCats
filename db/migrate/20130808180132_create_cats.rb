class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name
      t.integer :age
      t.datetime :birth_date
      t.string :color
      t.string :sex

      t.timestamps
    end
  end
end
