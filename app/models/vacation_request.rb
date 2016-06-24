class VacationRequest < ActiveRecord::Base
  belongs_to :user
  validates :starts_at_week, :ends_at_week, presence: true

  def length_in_weeks
    ends_at_week - starts_at_week
  end
end
