class AddAncestryCultureTables < ActiveRecord::Migration[6.0]
  def change
    create_table :species do |t|
      t.string :name
      t.boolean :active, default: false

      t.timestamps
    end
  end
end
