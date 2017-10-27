class CreateTargetGroups < ActiveRecord::Migration
  def change
    create_table :target_groups do |t|
      t.string :name, null: false, default: ""
      t.integer :external_id
      t.string :secret_code
      t.integer :panel_provider_id
      
      t.integer :parent_id, null: true, index: true
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true
      
      t.timestamps null: false
    end
    
    add_index :target_groups, :panel_provider_id
  end
end