class ExportScheduleToSpreadsheet
  include Interactor
  VIEWERS = ["daniil.sunyaev@flatstack.com"].freeze
  SPREADSHEET_NAME = "VACATIONS AUTO".freeze

  delegate :table, to: :context

  def call
    VIEWERS.each do |viewer|
      google_client.share_access_with(viewer, spreadsheet)
    end
    context.url = spreadsheet.human_url
    worksheet = spreadsheet.worksheets[0]

    table.each_with_index do |row, row_index|
      row.each_with_index do |element, column_index|
        worksheet[row_index + 1, column_index + 1] = element if element.present?
      end
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
