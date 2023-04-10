class EmployeesController < ApplicationController
  load_and_authorize_resource
  
  def show # show the current employee page (defaults to attendance log table)
    @shift_assignments = []
    pp = 12
    if current_user.employee?
      @shift_assignments = ShiftAssignment.completed.where(employee: @employee).chronological.paginate(page: params[:page], per_page: pp)
    elsif current_user.manager?
      @shift_assignments = ShiftAssignment.completed.where(employee: Employee.where(manager_id:  @employee.id)).chronological.paginate(page: params[:page], per_page: pp)
    else
      @shift_assignments = ShiftAssignment.completed.where(employee: Employee.where(manager_id: Employee.all)).chronological.paginate(page: params[:page], per_page: pp)
    end
    render 'employees/table'
  end

  def index; end
  
  def edit # not used - but it is to edit employees details 
    @employee = Employee.find(params[:id])
    @shift_assignment = ShiftAssignment.find(params[:shift_assignment_id])
  end

def update # update clock-in and clock-out time (manual updates)
  @employee = Employee.find(params[:id])
  @shift_assignment = ShiftAssignment.find(params[:shift_assignment_id])

  if @shift_assignment.update(clockin_time: params[:clockin_time], clockout_time: params[:clockout_time])
    # Handle successful update
  else
    # Handle unsuccessful update
  end
end


end
