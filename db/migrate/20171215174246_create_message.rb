class CreateMessage < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :from, null: false
      t.integer :to, null: false
      t.datetime :visualized
      t.integer :status, null: false , default: 0
      t.datetime :archived
      t.integer :response

      t.timestamps null: false
    end
  end
end
