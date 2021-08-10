class CreateSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :subscriptions do |t|
      t.string :name
      t.string :stripe_pricing_id
      t.integer :price
      t.integer :number

      t.timestamps
    end
  end
end
