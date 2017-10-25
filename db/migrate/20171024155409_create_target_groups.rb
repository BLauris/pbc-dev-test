class CreateTargetGroups < ActiveRecord::Migration
  def change
    create_table :target_groups do |t|
      t.string :name, null: false, default: ""
      t.integer :external_id
      t.integer :parent_id
      t.string :secret_code
      t.integer :panel_provider_id
      t.timestamps null: false
    end
    
    add_index :target_groups, :external_id
    add_index :target_groups, :parent_id
    add_index :target_groups, :panel_provider_id
  end
end