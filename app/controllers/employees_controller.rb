class EmployeesController < ApplicationController
  load_and_authorize_resource
  
  def show # show the current employee page
    @employee = current_user.employee
    if @employee.hr?
      @notifications = ['Noor AlTamimi clocked-in late today.', 'Mashael AlEmadi clocked-in from unassigned location.', 'Hessa Boday clocked-out early today.', 'Fatima Alsafar has worked overtime today.']
    elsif @employee.manager?
      @notifications = ['Noor AlTamimi clocked-in late today.', 'Mashael AlEmadi clocked-in from unassigned location.']
    else
      @notifications = ['You clocked-in late today', 'You left early today']
    end
    render 'employees/show', locals: { notifications: @notifications }
  end

  def index; end
  
  def edit # not used - but it is to edit employees details 
    @employee = Employee.find(params[:id])
    @shift_assignment = ShiftAssignment.find(params[:shift_assignment_id])
end

def update # update clock-in and clock-out time (manual updates)
  debugger
  @employee = Employee.find(params[:id])
  @shift_assignment = ShiftAssignment.find(params[:shift_assignment_id])

  if @shift_assignment.update(clockin_time: params[:clockin_time], clockout_time: params[:clockout_time])
    # Handle successful update
  else
    # Handle unsuccessful update
  end
end


end
