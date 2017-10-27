class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name, null: false, default: ""
      t.integer :external_id
      t.string :secret_code
      t.integer :country_id
      t.timestamps null: false
    end
    
    add_index :locations, :external_id
    add_index :locations, :country_id
  end
end
