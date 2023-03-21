class AttendanceController < ApplicationController
  def clock
  end

  def proc
    # debugger
    puts "The card number is #{params}"
    e = Employee.with_card  params[:card_num]
    if e
      if e.has_pending_shift?
        flash[:notice] = "#{e} is clocking in."
        if e.pending_shift.update!(clockin_time:Time.now)
          flash[:notice] = "clocked in"

        else
          flash[:notice] = "issue clocking in"
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
    redirect_to "/clock"
  end
  def allocate
    authorize! :create, :shift_allocations
    if current_user.hr?
      @employees = Employee.all
    else
      @employees = Employee.for_manager(current_user.employee.id) # 1-1 relationship
    end
    #render "alloc_form"
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