class OptimizedSchedulesController < ApplicationController
  def show
    @url = ExportScheduleToSpreadsheet.call(table: table).url
  end

  private

  def table
    @table ||= ScheduleTable.new(full_optimized_schedule).table
  end
  
  def full_optimized_schedule
    @full_optimized_schedule ||= BuildFullSchedule.call.full_schedule
  end
end
