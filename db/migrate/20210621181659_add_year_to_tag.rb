class AddYearToTag < ActiveRecord::Migration[6.0]
  def change
    add_column :tags, :year, :integer
  end
end
