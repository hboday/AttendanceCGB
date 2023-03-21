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

    content_tag(:table, class: 'table table-bordered') do
      content_tag(:thead) do
        content_tag(:tr) do
          %w[Su Mo Tu We Th Fr Sa].map { |d| content_tag(:th, d) }.join.html_safe
        end
      end +
        content_tag(:tbody) do
          weeks.map.with_index do |week, week_index|
            content_tag(:tr) do
              week.map.with_index do |day, day_index|
                if week_index == 0 && day_index < last_sunday.wday
                  content_tag(:td)
                else
                  day_num = (day.nil? ? '' : day.day)
                  css_classes = ['text-center', day == Date.current ? 'table-primary' : '']
                  css_classes << 'prev-month' if day && day < first_day
                  content_tag(:td, class: css_classes.join(' '),
                                   style: 'width: calc(100% / 7); padding: 5px; border-radius: 10px; margin: 5px;') do
                    concat content_tag(:span, day_num, class: 'fw-bold')
                    concat tag(:br)
                    concat content_tag(:span, day&.strftime('%a'), class: 'text-muted small')
                  end
                end
              end.join.html_safe
            end
          end.join.html_safe
        end
    end
  end
end
