class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :plate
      t.string :maker
      t.string :model
      t.string :nickname
      t.boolean :locked, default: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
