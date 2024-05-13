class CreateNotes < ActiveRecord::Migration[7.1]
  def change
    create_table :na_notes do |t|
      t.string :title
      t.string :body
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
