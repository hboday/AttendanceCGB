class Shift < ApplicationRecord
  belongs_to :location
  has_many :shift_assignments
  has_many :employees, through: :shifts

  def self.create_shifts(start_date, end_date, shift_start_time, shift_end_time, location_id, which_days = (0...7)) # sunday is 0
    start_time = Time.parse(shift_start_time)
    end_time = Time.parse(shift_end_time)

    (Date.parse(start_date)..Date.parse(end_date)).map do |date|
      start_datetime = Time.zone.local(date.year, date.month, date.day, start_time.hour, start_time.min, 0)
      end_datetime = Time.zone.local(date.year, date.month, date.day, end_time.hour, end_time.min, 0)
      end_datetime += 1.day if start_time > end_time
      Shift.create(start_time: start_datetime, end_time: end_datetime, location_id:).id if which_days.include? date.wday
    end
  end

  scope :about_to_start, ->(before = 30.minutes) { where(start_time: Time.current..(Time.current + before)) }
  scope :chronological, -> { order('start_time') } # CHECK!!!!
  scope :ongoing, lambda {
                    where('(start_time <= ?) and (? < end_time)', Time.now, Time.now)
                  }

  scope :future, -> { where('start_time > ?', Time.now) } # warning, includes about_to_start!
end
