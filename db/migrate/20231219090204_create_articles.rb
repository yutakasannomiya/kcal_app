class CreateArticles < ActiveRecord::Migration[7.0]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.integer :about_time, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
