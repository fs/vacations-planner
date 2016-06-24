class Schedule
  MIN_WEEKS_BETWEEN_VACATIONS = 8
  MIN_WEEKS_DURATION_FOR_LONGEST_VACATION = 2
  WEEKS_OF_VACATION_PER_YEAR = 4
  WEEKS_IN_YEAR = 51

  include ActiveModel::Validations

  attr_accessor :schedule

  validate :elements_are_vacation_requests, :user_vacations_are_distanced,
    :at_least_one_vacation_is_long, :every_user_has_a_month_of_vacations

  delegate :[], :[]=, :<<, to: :schedule

  def initialize
    @schedule = Array.new(WEEKS_IN_YEAR)
  end

  private

  def elements_are_vacation_requests
    schedule.compact.each do |el|
      errors.add(:schedule, "Contains non-request elements") unless el.is_a? VacationRequest
    end
  end

  def user_vacations_are_distanced
    schedule.compact.group_by(&:user_id).each do |user_id, vacation_requests|
      vacation_requests.combination(2).each do |vacation_pair|
        next if (vacation_pair[0].ends_at_week - vacation_pair[1].starts_at_week).abs > MIN_WEEKS_BETWEEN_VACATIONS ||
                (vacation_pair[1].ends_at_week - vacation_pair[0].starts_at_week).abs > MIN_WEEKS_BETWEEN_VACATIONS
        errors.add(
          :schedule,
          "Vacations with ids #{vacation_pair.map(&:id)} of user #{User.find(user_id).full_name} are planned to close"
        )
      end
    end
  end

  def at_least_one_vacation_is_long
    schedule.compact.group_by(&:user_id).each do |user_id, vacation_requests|
      next if vacation_requests.max_by(&:length_in_weeks).length_in_weeks >= MIN_WEEKS_DURATION_FOR_LONGEST_VACATION
      errors.add(:schedule, "User #{User.find(user_id).full_name} has many small vacations (< 14 days)")
    end
  end

  def every_user_has_a_month_of_vacations
    schedule.compact.group_by(&:user_id).each do |user_id, vacation_requests|
      next if vacation_requests.sum(&:length_in_weeks) == WEEKS_OF_VACATION_PER_YEAR
      errors.add(
        :schedule,
        "User #{User.find(user_id).full_name} have planned vacation other than for a 28 days in a year"
      )
    end
  end
end
