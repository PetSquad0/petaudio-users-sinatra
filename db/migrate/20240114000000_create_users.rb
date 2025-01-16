# db/migrate/20240114000000_create_users.rb
class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    puts "Creating table users..."
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.timestamps
    end
    add_index :users, :email, unique: true
    puts "Table users created."
  end
end
