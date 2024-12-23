class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :patronymic
      t.string :surname
      t.string :email
      t.integer :age
      t.string :nationality
      t.string :country
      t.string :gender
      t.references :interest, null: true, foreign_key: true
      t.references :skill, null: true, foreign_key: true
      t.timestamps
    end
  end
end
