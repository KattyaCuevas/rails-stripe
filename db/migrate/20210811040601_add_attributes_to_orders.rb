class AddAttributesToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :order_type, :string
    add_column :orders, :stripe_checkout_id, :string
  end
end
