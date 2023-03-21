class EmployeesController < ApplicationController
  load_and_authorize_resource
  def show
    @employee = current_user.employee
  end

  def index; end
end
