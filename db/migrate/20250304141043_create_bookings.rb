class CreateBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :bookings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :horse, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :status
      t.decimal :price_at_booking

      t.timestamps
    end
  end
end
