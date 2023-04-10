class AttendanceController < ApplicationController
  def clock
  end

  def proc # clock-in clock-out process
    # checks if the user has a pending shift and allows them in if they do
    # sets the clock-in time for employees
    # if an employee started working their shift then it allows them to clock-out
    # stores clock-in and clock-out time in the database
    # debugger
    
    loc_id = params[:location_id]
    e = Employee.with_card  params[:card_num]
    if e
      if e.has_pending_shift?
        if e.pending_shift.shift.location.id == loc_id.to_i
          flash[:notice] = "#{e} is clocking in."
          if e.pending_shift.update!(clockin_time:Time.now)
            flash[:notice] = "clocked in"

          else
            flash[:notice] = "issue clocking in"
          end
        else
          flash[:notice] = "You do not have a shift at the current location!"
        end

      elsif e.is_working_shift?
        flash[:notice] = "#{e} is clocking out!"
        if e.working_shift.update!(clockout_time:Time.now)
         flash[:notice] = "clocked out"
        else
          flash[:notice] = "issue clocking out"
        end
      else
        flash[:notice] = "No pending shift!"
      end
    else
      flash[:notice] = "Employee doesn't exist!"
    end
    redirect_to "/clock/#{loc_id}"
  end

  def allocate # only allows allocations based on authorization
    # HR admins can create shifts for all employees 
    # managers are restricted to their own employees
    authorize! :create, :shift_allocations
    if current_user.hr?
      @employees = Employee.all
    else
      @employees = Employee.for_manager(current_user.employee.id) # 1-1 relationship
    end
    @locations = Location.all
    render "alloc_form"
  end

  def shift_allocate # takes the data from the form and processes it (allocates shift assignment to the database)
    shift_start_time = params[:start_time]
    shift_end_time = params[:end_time]
    from = params[:from]
    to = params[:to]
    employee_ids = params[:employee_ids].map {|e| e.to_i}
    which_days = params[:day_ids].map{|d| d.to_i}
    location_id = params[:location_id]
    shift_ids = Shift.create_shifts(from, to, shift_start_time, shift_end_time, location_id, which_days)
    ShiftAssignment.create_shift_assignments(shift_ids, employee_ids)
    flash[:notice] = "Created shifts!"
    redirect_to employee_path(current_user.employee)
  end

  def show_shifts # show all the shifts for all employees
    @employees = Employee.all
  end

end