class CreateUserPanelProviders < ActiveRecord::Migration
  def change
    create_table :user_panel_providers do |t|
      t.integer :user_id, null: false
      t.integer :panel_provider_id, null: false
      t.integer :active, default: false
      t.timestamps null: false
    end
  end
end
