require 'rails_helper'

RSpec.describe 'As a visitor', type: :feature do
  context 'when I visit the monsters show page' do
    it 'displays all monsters' do
      monster = Monster.create(name: 'Imp',
                               size: 'Tiny',
                               monster_type: 'Fiend',
                               alignment: 'LE',
                               ac: 13,
                               hp: 10,
                               speed: '20, 40 fly',
                               str: 6,
                               dex: 17,
                               con: 13,
                               int: 11,
                               wis: 12,
                               cha: 14,
                               saving_throws: nil,
                               skills: 'Deception, Insight, Persuasion, Stealth',
                               weaknesses_resistances_immunities: 'Coldres, nonmagicalres, nonsilveredres, fireimmu, poisonimmu, poisonedimmu',
                               senses: 'Darkvision 120',
                               languages: 'Infernal, Common',
                               challenge_rating: 1.0,
                               additional_abilities: 'Shapechanger, Devils Sight, Magic Resistance',
                               source: 'Monster Manual',
                               author: 'Wizards of the Coast')

      visit monster_path(monster)

      expect(page).to have_content(monster.name)
      expect(page).to have_content(monster.size)
      expect(page).to have_content(monster.monster_type)
      expect(page).to have_content(monster.alignment)
      expect(page).to have_content(monster.ac)
      expect(page).to have_content(monster.hp)
      expect(page).to have_content(monster.speed)
      expect(page).to have_content(monster.str)
      expect(page).to have_content(monster.dex)
      expect(page).to have_content(monster.con)
      expect(page).to have_content(monster.int)
      expect(page).to have_content(monster.wis)
      expect(page).to have_content(monster.cha)
      expect(page).to have_content(monster.languages)
      expect(page).to have_content(monster.challenge_rating)
      expect(page).to have_content(monster.additional_abilities)
      expect(page).to have_content(monster.source)
      expect(page).to have_content(monster.author)
    end
  end
end
