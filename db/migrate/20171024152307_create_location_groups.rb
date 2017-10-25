class CreateLocationGroups < ActiveRecord::Migration
  def change
    create_table :location_groups do |t|
      t.string :name, null: false, default: ""
      t.integer :country_id
      t.integer :panel_provider_id
      t.timestamps null: false
    end
    
    add_index :location_groups, :country_id
    add_index :location_groups, :panel_provider_id
  end
end
