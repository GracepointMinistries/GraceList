class AddProfileImage < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :avatar_url, :string, null: true, after: :encrypted_password
  end
end
