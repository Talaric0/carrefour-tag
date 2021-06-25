class AddIconToLocations < ActiveRecord::Migration[6.0]
  def change
    add_column :locations, :icon, :string
  end
end
