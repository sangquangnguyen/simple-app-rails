class CreateEmployees < ActiveRecord::Migration[6.1]
  def change
    create_table :employees do |t|
      t.text :avatar
      t.string :fname
      t.string :lname
      t.datetime :birthday
      t.string :role
      t.string :email
      t.text :password
      t.references :organisation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
