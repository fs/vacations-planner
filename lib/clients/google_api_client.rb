class GoogleApiClient
  def spreadsheets
    session.spreadsheets
  end

  def create_spreadsheet(name)
    session.create_spreadsheet(name)
  end

  def human_url
    session.human_url
  end

  def share_access_with(email, spreadsheet)
    spreadsheet.acl.push({type: "user", email_address: email, role: "reader"})
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
