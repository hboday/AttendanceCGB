class AddGravatarEmailToEmployees < ActiveRecord::Migration[7.0]
  def change
    add_column :employees, :gravatar_email, :string
  end
end
