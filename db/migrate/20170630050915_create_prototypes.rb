class CreatePrototypes < ActiveRecord::Migration[5.0]
  def change
    create_table :prototypes do |t|
      t.string :title, null: false
      t.text :catch_copy
      t.text :concept
      t.references :user, foreign_key: true
      t.integer :likes_count
      t.timestamps
    end
  end
end
