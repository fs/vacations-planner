require "rails_helper"

describe VacationRequestsContainer do
  describe "validations" do
    let(:user) { create :user }

    subject do
      vacation_requests = described_class.new
      vacation_requests[0] = vacation_request_1
      vacation_requests[20] = vacation_request_2
      vacation_requests
    end

    context "with vacations planeed too close" do
      let!(:vacation_request_1) { create :vacation_request, user: user, starts_at_week: 1, ends_at_week: 2 }
      let!(:vacation_request_2) { create :vacation_request, user: user, starts_at_week: 4, ends_at_week: 7 }

      it { is_expected.not_to be_valid }
    end

    context "with vacations planeed too short" do
      let!(:vacation_request_1) { create :vacation_request, user: user, starts_at_week: 1, ends_at_week: 2 }
      let!(:vacation_request_2) { create :vacation_request, user: user, starts_at_week: 20, ends_at_week: 21 }
      let!(:vacation_request_3) { create :vacation_request, user: user, starts_at_week: 40, ends_at_week: 41 }
      let!(:vacation_request_4) { create :vacation_request, user: user, starts_at_week: 10, ends_at_week: 11 }

      subject do
        vacation_requests = described_class.new
        vacation_requests[0] = vacation_request_1
        vacation_requests[10] = vacation_request_2
        vacation_requests[20] = vacation_request_3
        vacation_requests[30] = vacation_request_3
        vacation_requests
      end

      it { is_expected.not_to be_valid }
    end

    context "with vacations planned for a 5 weeks in a year" do
      let!(:vacation_request_1) { create :vacation_request, user: user, starts_at_week: 1, ends_at_week: 3 }
      let!(:vacation_request_2) { create :vacation_request, user: user, starts_at_week: 20, ends_at_week: 23 }

      it { is_expected.not_to be_valid }
    end

    context "with vacations planned for a 3 weeks in a year" do
      let!(:vacation_request_1) { create :vacation_request, user: user, starts_at_week: 1, ends_at_week: 3 }
      let!(:vacation_request_2) { create :vacation_request, user: user, starts_at_week: 20, ends_at_week: 21 }

      it { is_expected.not_to be_valid }
    end
  end
end
