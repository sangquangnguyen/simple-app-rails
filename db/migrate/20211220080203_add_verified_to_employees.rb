class AddVerifiedToEmployees < ActiveRecord::Migration[6.1]
  def change
    add_column :employees, :verified, :boolean, default: false
  end
end
