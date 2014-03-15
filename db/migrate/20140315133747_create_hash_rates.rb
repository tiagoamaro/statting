class CreateHashRates < ActiveRecord::Migration
  def change
    create_table :hash_rates do |t|
      t.float :hash_rate
      t.float :reject_rate

      t.references :address, index: true

      t.timestamps
    end
  end
end
