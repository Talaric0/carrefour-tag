class AddAddressToLocation < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :address, :string
  end
end
