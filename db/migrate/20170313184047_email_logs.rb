class EmailLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :email_logs do |t|
      t.column :category, :string, null: false
      t.column :sent_at, :datetime, null: false
    end

    add_index :email_logs, :category
  end
end
