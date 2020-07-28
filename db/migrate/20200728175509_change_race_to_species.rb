class ChangeRaceToSpecies < ActiveRecord::Migration[6.0]
  def change
    rename_column :characters, :race, :species
  end
end
