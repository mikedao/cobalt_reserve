class CreateWorldMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :world_maps do |t|
      t.string :low_res
      t.string :high_res

      t.timestamps
    end
  end
end
