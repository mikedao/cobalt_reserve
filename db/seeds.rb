require 'csv'

AdventureLog.delete_all
GameSessionCharacter.delete_all
GameSession.delete_all
Character.delete_all
WorldMap.delete_all
Campaign.delete_all
Monster.delete_all
User.delete_all

campaign = Campaign.create(name: 'Turing West Marches', status: 'active')
campaign.world_maps.create(low_res: "https://i.imgur.com/rBxkv0D.jpg",
                           high_res: "https://i.imgur.com/zPIS6Ig.jpg")
array = CSV.read('./data/monsters.csv', headers: true)

array.each do |row|
  Monster.create(name: row['Name'],
                 size: row['Size'],
                 monster_type: row['Type'],
                 alignment: row['Align.'],
                 ac: row['AC'].to_i,
                 hp: row['HP'].to_i,
                 speed: row['Speeds'],
                 str: row['STR'].to_i,
                 dex: row['DEX'].to_i,
                 con: row['CON'].to_i,
                 int: row['INT'].to_i,
                 wis: row['WIS'].to_i,
                 cha: row['CHA'].to_i,
                 saving_throws: row['Sav. Throws'],
                 skills: row['Skills'],
                 weaknesses_resistances_immunities: row['WRI'],
                 senses: row['Senses'],
                 languages: row['Languages'],
                 challenge_rating: row['CR'].to_f,
                 additional_abilities: row['Additional'],
                 source: row['Font'],
                 author: row['Author'])
end

# Species list from https://www.dndbeyond.com/races including Eberron and some other books, approved by Mike
Ancestryone.delete_all
['Aarakocra', 'Aasimar', 'Bugbear', 'Centaur', 'Changeling', 'Dragonborn', 'Dwarf', 'Elf', 'Feral Tiefling',
 'Firbolg', 'Genasi', 'Gith', 'Gnome', 'Goblin', 'Goliath', 'Grung', 'Half-Elf', 'Half-Orc', 'Halfling',
 'Hobgoblin', 'Human', 'Kalashatar', 'Kenku', 'Kobold', 'Leonin', 'Lizardfolk', 'Locathah', 'Loxodon',
 'Minotaur', 'Orc', 'Orc of Eberron', 'Orc of Exandria', 'Satyr', 'Shifter', 'Simic Hybrid', 'Tabaxi',
 'Tiefling', 'Tortle', 'Triton', 'Vedalken', 'Verdan', 'Warforged', 'Yuan-ti Pureblood'].each do |species|
   Ancestryone.create(name: species, active: true)
 end
