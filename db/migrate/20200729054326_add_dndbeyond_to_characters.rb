class AddDndbeyondToCharacters < ActiveRecord::Migration[6.0]
  def change
    add_column :characters, :dndbeyond_url, :string
  end
end
