class BuildGroupSchedule
  include Interactor

  delegate :group_id, to: :context

  def call
    context.requests = if requests.valid?
      requests
    else
      FindOptimalSchedule.call(requests: requests, group_id: group_id).optimized_schedule
    end
  end

  private

  def requests
    draft = VacationRequestsContainer.new
    VacationRequest.joins(:user).where(users: { user_group_id: group_id }).each do |request|
      draft << request
    end
    draft
  end
end
