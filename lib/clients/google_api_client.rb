class GoogleApiClient
  delegate :spreadsheets, to: :session

  delegate :create_spreadsheet, to: :session

  delegate :human_url, to: :session

  def share_access_with(email, spreadsheet)
    spreadsheet.acl.push(type: "user", email_address: email, role: "reader")
  end

  private

  def session
    @session ||= GoogleDrive.login_with_oauth(authorization)
  end

  def scopes
    ["https://www.googleapis.com/auth/drive", "https://spreadsheets.google.com/feeds/"]
  end

  def authorization
    Google::Auth.get_application_default(scopes)
  end
end
