require "rails_helper"

describe VacationRequestsContainer do
  describe "validations" do
    let(:group) { create :user_group, name: "FE devs" }
    let(:user) { create :user, user_group: group }

    subject do
      vacation_requests = described_class.new
      vacation_requests << vacation_request_1
      vacation_requests << vacation_request_2
      vacation_requests
    end

    context "with vacations planned too close" do
      let!(:vacation_request_1) { create :vacation_request, user: user, starts_at_week: 1, ends_at_week: 2 }
      let!(:vacation_request_2) { create :vacation_request, user: user, starts_at_week: 4, ends_at_week: 7 }

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

    context "with 4 vacations" do
      subject do
        vacation_requests = described_class.new
        vacation_requests << vacation_request_1
        vacation_requests << vacation_request_2
        vacation_requests << vacation_request_3
        vacation_requests << vacation_request_4
        vacation_requests
      end

      context "with vacations planned too short" do
        let!(:vacation_request_1) { create :vacation_request, user: user, starts_at_week: 1, ends_at_week: 2 }
        let!(:vacation_request_2) { create :vacation_request, user: user, starts_at_week: 20, ends_at_week: 21 }
        let!(:vacation_request_3) { create :vacation_request, user: user, starts_at_week: 40, ends_at_week: 41 }
        let!(:vacation_request_4) { create :vacation_request, user: user, starts_at_week: 10, ends_at_week: 11 }

        it { is_expected.not_to be_valid }
      end

      context "with additional user in group" do
        let(:user2) { create :user, user_group: group }

        context "whith overlapping vacations" do
          let!(:vacation_request_1) { create :vacation_request, user: user, starts_at_week: 1, ends_at_week: 3 }
          let!(:vacation_request_2) { create :vacation_request, user: user, starts_at_week: 20, ends_at_week: 22 }
          let!(:vacation_request_3) { create :vacation_request, user: user2, starts_at_week: 2, ends_at_week: 4 }
          let!(:vacation_request_4) { create :vacation_request, user: user2, starts_at_week: 30, ends_at_week: 32 }

          it { is_expected.not_to be_valid }
        end

        context "whith correcly planned vacations" do
          let!(:vacation_request_1) { create :vacation_request, user: user, starts_at_week: 1, ends_at_week: 3 }
          let!(:vacation_request_2) { create :vacation_request, user: user, starts_at_week: 20, ends_at_week: 22 }
          let!(:vacation_request_3) { create :vacation_request, user: user2, starts_at_week: 5, ends_at_week: 7 }
          let!(:vacation_request_4) { create :vacation_request, user: user2, starts_at_week: 30, ends_at_week: 32 }

          it { is_expected.to be_valid }
        end
      end
    end
  end
end
