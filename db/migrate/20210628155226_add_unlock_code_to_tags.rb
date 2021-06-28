class AddUnlockCodeToTags < ActiveRecord::Migration[6.0]
  def change
    add_column :tags, :unlock_code, :string, default: ""
  end
end
