class CreateMonsters < ActiveRecord::Migration[6.0]
  def change
    create_table :monsters do |t|
      t.string :name
      t.string :size
      t.string :monster_type
      t.string :alignment
      t.integer :ac
      t.integer :hp
      t.string :speed
      t.integer :str
      t.integer :dex
      t.integer :con
      t.integer :int
      t.integer :wis
      t.integer :cha
      t.string :saving_throws
      t.string :skills
      t.string :weaknesses_resistances_immunities
      t.string :senses
      t.string :languages
      t.float :challenge_rating
      t.string :additional_abilities
      t.string :source
      t.string :author

      t.timestamps
    end
  end
end
