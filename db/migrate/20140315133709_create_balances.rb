class CreateBalances < ActiveRecord::Migration
  def change
    create_table :balances do |t|
      t.float :exchanged
      t.float :unexchanged

      t.references :address, index: true

      t.timestamps
    end
  end
end
