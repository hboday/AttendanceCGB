class CalendarController < ApplicationController
  def show
    upcoming_assignments =  current_user.employee.shift_assignments.upcoming.chronological.reverse
    if upcoming_assignments.present?
      #debugger
      @start_month = upcoming_assignments.first.shift.start_time.month
      @end_month = upcoming_assignments.last.shift.start_time.month
      @start_year =  upcoming_assignments.first.shift.start_time.year
      @end_year = upcoming_assignments.last.shift.start_time.year
      @timings_and_location = upcoming_assignments.map{ |a|  [a.date_of_shift, a.timings_and_location_for_calendar]}.to_h
    else
      render 'calendar/no_shifts'
    end
  end
end