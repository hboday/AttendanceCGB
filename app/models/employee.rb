class Employee < ApplicationRecord
  has_gravatar :email
  belongs_to :user
  has_many :shift_assignments
  has_many :shifts, through: :shift_assignments

  validates_presence_of :role
  enum role: %i[employee manager hr]

  def self.with_card(c)
    find_by(card_num: c)
  end

  def managed_employees
    Employee.where(manager_id:self.id)
  end

  def managed_employees_completed_shifts
    if role == "manager"
      ShiftAssignment.completed.joins(:employee).where("manager_id = ?", self.id).chronological
    elsif role == "hr"
      ShiftAssignment.completed.joins(:employee).chronological
    else
      nil
    end
  end

  def completed_shifts
    shift_assignments.where.not(clockout_time:nil)
  end
  # FIX!!
  def pending_shift # nil if no pending shift
    s = shifts.ongoing # ongoing shifts ()
    return nil if s.empty?

    s.first.shift_assignments.where(employee_id: id).where(clockin_time: nil).first
  end

  def has_pending_shift?
    pending_shift.present?
  end

  def working_shift
    s = shift_assignments.where.not(clockin_time: nil).where(clockout_time: nil)
    return nil if s.empty?

    s
  end

  def is_working_shift?
    working_shift.present?
  end
  
  def name
    "#{first_name} #{last_name}"
  end

  scope :for_manager, ->(id){where(manager_id:id)}

    #   def working_on(date)
  #     assigned_dates = shifts.map { |s| s.start_time.to_date } | [shifts.last.end_time.to_date]
  #     assigned_dates.include? date.to_date
  #   end

end
