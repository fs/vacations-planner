class FindOptimalSchedule
  include Interactor
  delegate :requests, to: :context
  def call
    @schedule = VacationRequestsContainer.new
    context.optimized_schedule = optimized_schedule
  end

  def optimized_schedule
    requests_stack = requests
    until requests_stack.empty?
      request = requests_stack.pop

      next if place_vacation(request)

      find_a_place_for(request)
    end
    @schedule
  end

  def place_vacation(request)
    @schedule << request
    if @schedule.no_overlapping_vacations && @schedule.user_vacations_are_distanced && @schedule.errors.blank?
      return true
    else
      @schedule.pop
      @schedule.errors.clear
      return false
    end
  end

  def find_a_place_for(request)
    for i in 1..VacationRequestsContainer::WEEKS_IN_YEAR
      if i % 2 > 0
        request.starts_at_week += i
        request.ends_at_week += i
      else
        request.starts_at_week -= i
        request.ends_at_week -= i
      end
      next if request.starts_at_week < 1 || request.ends_at_week > VacationRequestsContainer::WEEKS_IN_YEAR
      break if place_vacation(request)
    end
  end
end
