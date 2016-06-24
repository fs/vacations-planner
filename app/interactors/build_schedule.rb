class BuildSchedule
  include Interactor

  def call
    context.schedule = schedule
  end

  private

  def schedule
    draft = VacationRequestsContainer.new
    draft.vacation_requests = Array.new(51)
    VacationRequest.find_each do |request|
      draft[request.starts_at_week] = request
      draft[request.starts_at_week + 1] = request if request.length_in_weeks > 1
      draft[request.starts_at_week + 2] = request if request.length_in_weeks > 2
    end
    draft
  end
end
