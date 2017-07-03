class CreateCapturedImages < ActiveRecord::Migration[5.0]
  def change
    create_table :captured_images do |t|
      t.string :content, null: false
      t.references :prototype, foreign_key: true
      t.integer :status, null: false
      t.timestamps
    end
  end
end
