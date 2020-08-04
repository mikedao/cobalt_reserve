class ChangeUserStatus < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :status, :string
    add_column :users, :active, :boolean, default: true
  end
end
