class RemovePasswordFromEmployees < ActiveRecord::Migration[6.1]
  def change
    remove_column :employees, :password, :text
  end
end
