class VacationRequestsController < ApplicationController
  expose(:user) { current_user }
  expose(:vacation_requests, ancestor: :user)
  expose(:vacation_request, attributes: :vacation_request_params)

  def index
  end

  def new
  end

  def edit
  end

  def create
    vacation_request.save

    respond_with vacation_request, location: vacation_requests_path
  end

  def update
  end

  def destroy
    vacation_request.destroy

    redirect_to vacation_requests_path
  end

  private

  def vacation_request_params
    params.require(:vacation_request).permit(:starts_at_week, :ends_at_week)
  end
end
