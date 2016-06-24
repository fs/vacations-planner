class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :confirmable,
    :recoverable, :rememberable, :trackable, :validatable

  validates :full_name, :user_group_id, presence: true

  has_many :vacation_requests
  belongs_to :user_group

  # GROUPS = [TEAM_LEAD, MANAGER, MOBILE_DEV, FE_DEV, DESINER, ADMINISTRATION]
  # TEAM_LEAD = "team_lead"
  # MANAGER = "manager"
  # MOBILE_DEV = "mobile_dev"
  # FE_DEV = "fe_dev"
  # DESINER = "designer"
  # ADMINISTRATION = "administration"
end
