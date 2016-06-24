class BuildFullSchedule
  include Interactor

  def call
    context.full_schedule = full_schedule
  end

  def full_schedule
    full_schedule = []
    UserGroup.find_each do |group|
      full_schedule << BuildGroupSchedule.call(group_id: group.id).requests
    end
    full_schedule
  end
end
