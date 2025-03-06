class AddCoordinatesToHorses < ActiveRecord::Migration[7.1]
  def change
    add_column :horses, :latitude, :float
    add_column :horses, :longitude, :float
  end
end
