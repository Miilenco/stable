class CreateHorses < ActiveRecord::Migration[7.1]
  def change
    create_table :horses do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :breed
      t.integer :age
      t.string :location
      t.float :stud_fee
      t.string :pedigry
      t.string :progeny_success
      t.text :race_record

      t.timestamps
    end
  end
end
