class AttendanceController < ApplicationController
  def welcome
  end

  def allocate
    authorize! :create, :shift_allocations
    @employees = Employee.for_manager(current_user.employee.id) # 1-1 relationship
    render "alloc_form"
  end

  def shift_allocate
    shift_start_time = params[:start_time]
    shift_end_time = params[:end_time]
    from = params[:from]
    to = params[:to]
    puts "*************** #{params}"
    employee_ids = params[:employee_ids].map {|e| e.to_i}
    which_days = params[:day_ids].map{|d| d.to_i}

    shift_ids = Shift.create_shifts(from, to, shift_start_time, shift_end_time, which_days)
    ShiftAssignment.create_shift_assignments(shift_ids, employee_ids)
    flash[:notice] = "Created shifts!"
  end

  def show_shifts
    @employees = Employee.all
  end

end