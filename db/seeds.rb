require 'csv'
Campaign.create(name: 'Turing West Marches', status: 'active')
array = CSV.read('./data/monsters.csv', headers: true)

array.each do |row|
  Monster.create(name: row["Name"],
                 size: row["Size"],
                 monster_type: row["Type"],
                 alignment: row["Align."],
                 ac: row["AC"].to_i,
                 hp: row["HP"].to_i,
                 speed: row["Speeds"],
                 str: row["STR"].to_i,
                 dex: row["DEX"].to_i,
                 con: row["CON"].to_i,
                 int: row["INT"].to_i,
                 wis: row["WIS"].to_i,
                 cha: row["CHA"].to_i,
                 saving_throws: row["Sav. Throws"],
                 skills: row["Skills"],
                 weaknesses_resistances_immunities: row["WRI"],
                 senses: row["Senses"],
                 languages: row["Languages"],
                 challenge_rating: row["CR"].to_f,
                 additional_abilities: row["Additional"],
                 source: row["Font"],
                 author: row["Author"])
end
