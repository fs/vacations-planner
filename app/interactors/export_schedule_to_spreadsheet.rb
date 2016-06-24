class ExportScheduleToSpreadsheet
  include Interactor
  VIEWERS = ["daniil.sunyaev@flatstack.com"].freeze
  SPREADSHEET_NAME = "VACATIONS AUTO".freeze

  delegate :draft, to: :context

  def call
    VIEWERS.each do |viewer|
      google_client.share_access_with(viewer, spreadsheet)
    end
    context.url = spreadsheet.human_url
    worksheet = spreadsheet.worksheets[0]

    draft.each_with_index do |vacation_week, index|
      next if vacation_week.blank?
      worksheet[2, index + 1] = vacation_week.user.full_name
    end
    worksheet.save
  end

  private

  def spreadsheet
    @spreadsheet ||= google_client.create_spreadsheet(SPREADSHEET_NAME)
  end

  def google_client
    @google_client ||= GoogleApiClient.new
  end
end
