class AddEditedClockinAndClockoutToShiftAssignments < ActiveRecord::Migration[7.0]
  def change
    add_column :shift_assignments, :edited_clockin_time, :datetime
    add_column :shift_assignments, :edited_clockout_time, :datetime
  end
end
