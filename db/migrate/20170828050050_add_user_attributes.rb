class AddUserAttributes < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string, null: true, after: :email
    add_column :users, :last_name, :string, null: true, after: :first_name
  end
end
