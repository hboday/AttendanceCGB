class AddManagerIdToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :manager_id, :integer
  end
end
