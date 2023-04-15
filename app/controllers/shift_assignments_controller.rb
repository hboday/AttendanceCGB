class ShiftAssignmentsController < ApplicationController


  def edit
    #debugger
    shift_assignment = ShiftAssignment.find(params[:shift_assignment_id])

    if params[:edited_clockin_time].present?
      clockin_time = Time.zone.parse("#{shift_assignment.clockin_time.to_date} #{params[:edited_clockin_time]}")
      shift_assignment.edited_clockin_time = clockin_time
    end

    if params[:edited_clockout_time].present?
      clockout_time = Time.zone.parse("#{shift_assignment.clockout_time.to_date} #{params[:edited_clockout_time]}")
      shift_assignment.edited_clockout_time = clockout_time
    end

    if shift_assignment.save
      respond_to do |format|
        # format.html { redirect_to employee_path(current_user.employee), notice: "Attendance log updated successfully." }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("shift-assignment-#{shift_assignment.id}", partial: "shared/shift_assignment_row", locals: { shift_assignment: shift_assignment }) }
      end
    else
      respond_to do |format|
        format.html { redirect_to employee_path(current_user.employee), alert: "Failed to update attendance log." }
        format.js { render :update_row_error }
      end
    end
  end



end
