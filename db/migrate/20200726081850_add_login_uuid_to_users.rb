class AddLoginUuidToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :login_uuid, :string, default: nil
    add_index :users, :login_uuid
    add_column :users, :login_timestamp, :timestamp
  end
end
