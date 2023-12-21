class CreateCalcs < ActiveRecord::Migration[7.0]
  def change
    create_table :calcs do |t|
      t.references :user,        null: false,foreign_key: true
      t.date       :record,      null: false
      t.integer    :plus,        null: false
      t.integer    :minus,       null: false
      t.integer    :total,       null: false

      t.timestamps
    end
  end
end
