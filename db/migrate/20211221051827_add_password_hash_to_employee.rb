class AddPasswordHashToEmployee < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :password_hash, :text
  end
end
