class Employee < ApplicationRecord
  has_gravatar :email
  belongs_to :user
  has_many :shift_assignments
  has_many :shifts, through: :shift_assignments

  validates_presence_of :role
  enum role: %i[employee manager hr]

  def self.with_card(c) # given the card number it returns a reference to an employee if they exist
    find_by(card_num: c)
  end

  def managed_employees # all employees who are managed by a specific manager
    Employee.where(manager_id:self.id)
  end

  def managed_employees_completed_shifts 
    # returns the completed shifts by the employees under a specific manager or all employees if its an HR admin
    if role == "manager"
      ShiftAssignment.completed.joins(:employee).where("manager_id = ?", self.id).chronological
    elsif role == "hr"
      ShiftAssignment.completed.joins(:employee).chronological
    else
      nil
    end
  end

  def completed_shifts # returns all the shifts that have been completed
    shift_assignments.where.not(clockout_time:nil)
  end
  # FIX!!
  def pending_shift # nil if no pending shift
    s = shifts.ongoing # ongoing shifts ()
    return nil if s.empty?

    s.first.shift_assignments.where(employee_id: id).where(clockin_time: nil).first
  end

  def has_pending_shift? # returns true if employee has a pending shift, and false otherwise
    pending_shift.present?
  end

  def working_shift # returns all the shifts that are currently ongoing
    s = shift_assignments.where.not(clockin_time: nil).where(clockout_time: nil)
    return nil if s.empty?

    s
  end

  def is_working_shift? # returns true if the employee is currently active at work (ongoing shift)
    working_shift.present?
  end
  
  def name # returns the full name of employees
    "#{first_name} #{last_name}"
  end

  def humanized_role
    if role == 'employee'
      "Employee"
    elsif role == 'manager'
      "Manager"
    else
      "Human Resources"
    end
  end

  scope :for_manager, ->(id){where(manager_id:id)} # returns all employees and their specific manager

    #   def working_on(date)
  #     assigned_dates = shifts.map { |s| s.start_time.to_date } | [shifts.last.end_time.to_date]
  #     assigned_dates.include? date.to_date
  #   end

end
