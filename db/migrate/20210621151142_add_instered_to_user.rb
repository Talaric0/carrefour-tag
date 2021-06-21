class AddInsteredToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :interested, :boolean, default: false
  end
end
