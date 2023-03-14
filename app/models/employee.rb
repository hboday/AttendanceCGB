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

  def completed_shifts
    shift_assignments.where.not(clockout_time:nil)
  end
  # FIX!!
  def pending_shift # nil if no pending shift
    s = shifts.ongoing # ongoing shifts ()
    return nil if s.empty?

    s.first.shift_assignments.where(employee_id: id).where(clockin_time: nil).first
  end

  def name
    "#{first_name} #{last_name}"
  end
  #   def working_on(date)
  #     assigned_dates = shifts.map { |s| s.start_time.to_date } | [shifts.last.end_time.to_date]
  #     assigned_dates.include? date.to_date
  #   end

  scope :for_manager, ->(id){where(manager_id:id)}
end
