class AddCanceledToTags < ActiveRecord::Migration[6.0]
  def change
    add_column :tags, :canceled, :boolean
  end
end
