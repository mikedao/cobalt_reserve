class CreateAdventureLog < ActiveRecord::Migration[6.0]
  def change
    create_table :adventure_logs do |t|
      t.text :content

      t.timestamps
    end
  end
end
