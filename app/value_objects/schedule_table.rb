class ScheduleTable
  def initialize(full_requests_array)
    @full_requests_array = full_requests_array
  end

  def table
    table = [[nil]]
    for week in 1..VacationRequestsContainer::WEEKS_IN_YEAR
      table[0] << weekly_dates(week)
    end
    @full_requests_array.each_with_index do |row, group_index|
      table[group_index + 1] = [row.first.user.user_group.name]
      table[group_index + 1].concat(Array.new(51))

      row.each do |request|
        table[group_index + 1][request.starts_at_week + 1] = request.user.full_name
        table[group_index + 1][request.starts_at_week + 2] = request.user.full_name if request.length_in_weeks > 1
        table[group_index + 1][request.starts_at_week + 3] = request.user.full_name if request.length_in_weeks > 2
      end
    end
    table
  end

  def weekly_dates(week_num)
    "#{formated_date(first_vacationable_day + (week_num - 1).weeks)} "\
      "- #{formated_date(first_vacationable_day + week_num.weeks)}"
  end

  def first_vacationable_day
    Time.current.at_beginning_of_year.end_of_week + 1.second
  end

  def formated_date(date)
    date.strftime("%d %b")
  end
end
