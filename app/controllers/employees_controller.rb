class EmployeesController < ApplicationController
  load_and_authorize_resource
  def show
    @employee = current_user.employee
  end

  def index; end
  
  def edit
    @employee = Employee.find(params[:id])
    @shift_assignment = ShiftAssignment.find(params[:shift_assignment_id])
end

def update
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
