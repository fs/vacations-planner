class ScheduleTable
  def initialize(full_requests_array)
    @full_requests_array = full_requests_array
  end

  def table
    table = []
    @full_requests_array.each_with_index do |row, group_index|
      table[group_index] = [row.first.user.user_group.name]
      table[group_index].concat(Array.new(51))

      row.each do |request|
        table[group_index][request.starts_at_week + 1] = request.user.full_name
        table[group_index][request.starts_at_week + 2] = request.user.full_name if request.length_in_weeks > 1
        table[group_index][request.starts_at_week + 3] = request.user.full_name if request.length_in_weeks > 2
      end
    end
    table
  end
end
