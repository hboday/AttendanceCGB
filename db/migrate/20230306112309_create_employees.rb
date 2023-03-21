class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :card_num
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.integer :role
      t.integer :user_id

      t.timestamps
    end
  end
end
