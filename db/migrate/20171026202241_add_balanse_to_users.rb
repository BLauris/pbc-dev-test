class AddBalanseToUsers < ActiveRecord::Migration
  def change
    add_column :users, :balance_in_cents, :integer, null: false, default: 0
  end
end
