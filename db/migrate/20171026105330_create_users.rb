class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false, default: "", unique: true
      t.string :token, unique: true
      t.datetime :token_expires_at
      t.timestamps null: false
    end
    
    add_index :users, :token
  end
end
