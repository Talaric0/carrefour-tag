class AddTagToOrders < ActiveRecord::Migration[6.0]
  def change
    add_reference :orders, :tag, null: false, foreign_key: true
  end
end
