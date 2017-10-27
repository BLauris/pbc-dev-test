class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, default: ""
      t.string :token
      t.datetime :token_expires_at
      t.timestamps null: false
    end
    
    add_index :users, :email, unique: true
    add_index :users, :token, unique: true
  end
end
