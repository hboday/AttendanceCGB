module CalendarHelper
  def last_sunday_of_prev_month(month, year)
    month -= 1
    if month == 0
      month = 12
      year -= 1
    end
    Date.new(year, month, -1).prev_day(Date.new(year, month, -1).wday)
  end

  def bootstrap_monthly_calendar(month, year)
    last_sunday = last_sunday_of_prev_month(month, year)
    first_day = Date.new(year, month, 1)
    last_day = Date.new(year, month, -1)
    weeks = (last_sunday..last_day).to_a.in_groups_of(7)

    content_tag(:div, class: 'd-flex flex-wrap justify-content-center') do
      weeks.map.with_index do |week, week_index|
        content_tag(:div, class: 'd-flex justify-content-center w-100') do
          week.map.with_index do |day, day_index|
            if week_index == 0 && day_index < last_sunday.wday
              content_tag(:div, '', class: 'w-100')
            else
              css_classes = ['text-center', day == Date.current ? 'bg-primary text-white' : '']
              css_classes << 'prev-month' if day && day < first_day
              content_tag(:div, class: 'p-2', style: 'width: calc(100% / 7)') do
                if day.present?
                  render partial: 'shared/calendar_icon', locals: { date: day, note: 'Some note' }
                end
              end
            end
          end.join.html_safe
        end
      end.join.html_safe
    end
  end
end
