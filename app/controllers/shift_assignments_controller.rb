class ShiftAssignmentsController < ApplicationController
  def edit # processes the manual changes form made to employee's clock-in and clock-out 
    # time and updates their attendance logs accordingly

    shift_assignment = ShiftAssignment.find(params[:shift_assignment_id])

    if params[:clockin_time].present? # if the clock-in time was given, update it (uses the same date)
      #debugger
      clockin_time = Time.zone.parse("#{shift_assignment.clockin_time.to_date} #{params[:clockin_time]}")
      shift_assignment.clockin_time = clockin_time
    end

    if params[:clockout_time].present? # if the clock-out time was given, update it (uses the same date)
       clockout_time = Time.zone.parse("#{shift_assignment.clockout_time.to_date} #{params[:clockout_time]}")
      shift_assignment.clockout_time = clockout_time
    end

    if shift_assignment.save # save the updated information and reflect it to the database
      respond_to do |format|
        format.html { redirect_to employee_path(current_user.employee), notice: "Attendance log updated successfully." }
        format.js { render :update_row, locals: {shift_assignment: shift_assignment} }
      end
    else
      respond_to do |format|
        format.html { redirect_to employee_path(current_user.employee), alert: "Failed to update attendance log." }
        format.js { render :update_row_error }
      end
    end
  


end

end