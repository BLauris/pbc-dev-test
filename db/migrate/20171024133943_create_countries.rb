class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.string :country_code, null: false, default: ""
      t.integer :panel_provider_id, null: false
      t.timestamps null: false
    end
    
    add_index :countries, :panel_provider_id
    add_index :countries, :country_code, unique: true
  end
end
