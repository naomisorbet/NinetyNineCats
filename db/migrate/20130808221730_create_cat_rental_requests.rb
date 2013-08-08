class CreateCatRentalRequests < ActiveRecord::Migration
  def change
    create_table :cat_rental_requests do |t|
      t.integer :cat_id, :not => :null
      t.date :begin_date, :not => :null
      t.date :end_date, :not => :null
      t.string :status, :not => :null, :default => "undecided"

      t.timestamps
    end
  end
end
