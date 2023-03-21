class ShiftAssignment < ApplicationRecord
  belongs_to :employee
  belongs_to :shift

  # validate :shift_cannot_be_in_the_past # shift cannot being assigned to cannot be in the past
  validate :employee_is_not_already_working_on_date, on: create

  def edit
    # puts "Hi!!!"
  end

  scope :completed, -> {where.not(clockout_time:nil)}
  scope  :chronological, -> {order('clockin_time desc')}
  def self.create_shift_assignments(shift_ids, employee_ids)
    shift_ids.each do |s_id|
      employee_ids.each do |e_id|
        ShiftAssignment.create(shift_id: s_id, employee_id: e_id)
      end
    end
  end

  def completed?
    clockout_time.present?
  end

  def duration
    return nil unless completed?

    duration_in_seconds = (clockout_time - clockin_time).to_i
    duration_in_hours = duration_in_seconds / 3600
    duration_in_minutes = (duration_in_seconds % 3600) / 60
    format('%02d:%02d', duration_in_hours, duration_in_minutes)
  end

  private

  # doesn't work for overnight shift! will assign on the same day as ending
  def employee_is_not_already_working_on_date
    # get all dates being worked
    dates_working = employee.shifts.chronological.map { |s| s.start_time.to_date }
    return unless (dates_working.include? shift.start_time.to_date) || (dates_working.include? shift.end_time.to_date)

    errors.add(:employee, "can't already be assigned a shift on the day")
  end
end
