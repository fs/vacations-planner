class VacationsScheduleDraft < VacationRequestsContainer
  def initialize
    @schedule = Array.new(WEEKS_IN_YEAR)
  end
end
