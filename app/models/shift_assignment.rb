class ShiftAssignment < ApplicationRecord
  belongs_to :employee
  belongs_to :shift

  # validate :shift_cannot_be_in_the_past # shift cannot being assigned to cannot be in the past
  validate :employee_is_not_already_working_on_date, on: create 
  # cannot create another shift for an employee who already has a shift on that day


  scope :upcoming, -> {where(clockout_time:nil)}
  scope :completed, -> {where.not(clockout_time:nil)} # shows all completed shift assigned
  scope :for_month, -> {}
  #scope  :chronological, -> {order('clockin_time desc')} # shows the shifts by decending clock-in time
  scope :chronological, ->  {joins(:shift).order('start_time desc')}
  def self.create_shift_assignments(shift_ids, employee_ids) 
    # helper used to create shift assignments that allows shift creation for multiple dates and employees
    shift_ids.each do |s_id|
      employee_ids.each do |e_id|
        ShiftAssignment.create(shift_id: s_id, employee_id: e_id)
      end
    end
  end

  def was_edited?
    edited_clockin_time.present? || edited_clockout_time.present?
  end

  def completed? # checks if a shift has been completed
    clockout_time.present?
  end

  def grace_time_used # in seconds
    return 0 unless completed?

    clockin = edited_clockin_time || clockin_time
    clockout = edited_clockout_time || clockout_time

    shift_duration_in_seconds = (shift.end_time - shift.start_time).to_i
    duration_in_seconds = (clockout - clockin).to_i

    duration_in_seconds < shift_duration_in_seconds ? shift_duration_in_seconds - duration_in_seconds : 0
  end
  

  def duration 
    # calculates the duration of the shift that an employee worked (based on clock-in and clock-out time)
    return nil unless completed?

    # use edited times if present, otherwise use original times
    clockin = edited_clockin_time || clockin_time
    clockout = edited_clockout_time || clockout_time

    # displays the duration in hours and remaining minutes
    duration_in_seconds = (clockout - clockin).to_i
    duration_in_hours = duration_in_seconds / 3600
    duration_in_minutes = (duration_in_seconds % 3600) / 60
    format('%02d:%02d', duration_in_hours, duration_in_minutes)
  end


  

  def date_of_shift
    shift.start_time.strftime("%Y-%m-%d")
  end

  def timings_for_calendar
    s = shift.start_time.strftime('%H:%M')
    e = shift.end_time.strftime('%H:%M')
    "#{s} - #{e}"
  end

  def timings_and_location_for_calendar
    timings_for_calendar + " #{shift.location.name}"
  end

  private

  # doesn't work for overnight shift! will assign on the same day as ending
  def employee_is_not_already_working_on_date # method for validation
    # get all dates being worked
    dates_working = employee.shifts.chronological.map { |s| s.start_time.to_date }
    return unless (dates_working.include? shift.start_time.to_date) || (dates_working.include? shift.end_time.to_date)

    errors.add(:employee, "can't already be assigned a shift on the day")
  end
end
