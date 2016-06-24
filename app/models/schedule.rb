class Schedule
  include ActiveModel::Validations

  attr_accessor :schedule

  validates :user_vacations_are_distanced, :at_least_one_vacation_is_long, :every_user_has_a_month_of_vacations
  delegate :[], :[]=, to: :schedule

  private

  def user_vacations_are_distanced
    true
  end

  def at_least_one_vacation_is_long
    true
  end

  def every_user_has_a_month_of_vacations
    true
  end
end
