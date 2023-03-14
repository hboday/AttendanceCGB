class CreateShiftAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :shift_assignments do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :shift, null: false, foreign_key: true
      t.datetime :clockin_time
      t.datetime :clockout_time

      t.timestamps
    end
  end
end
