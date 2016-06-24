class VacationRequest < ActiveRecord::Base
  belongs_to :user

  def length_in_weeks
    ends_at_week - starts_at_week
  end
end
