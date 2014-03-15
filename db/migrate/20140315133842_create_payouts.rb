class CreatePayouts < ActiveRecord::Migration
  def change
    create_table :payouts do |t|
      t.datetime :timestamp
      t.float :value
      t.string :tx

      t.references :address, index: true

      t.timestamps
    end
  end
end
