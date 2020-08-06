class CreateWorldNews < ActiveRecord::Migration[6.0]
  def change
    create_table :world_news do |t|
      t.string :date
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
