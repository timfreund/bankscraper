require 'watir'

module BankScraper
  class CapitolFederalScraper
    attr_accessor :browser
    attr_accessor :credentials

    def initialize(credentials)
      @browser = Watir::Browser.new
      @credentials = credentials
    end

    def login
      @browser.goto("https://tbonline.capfed.com/capfed/")
      @browser.text_field(:id, "ctlSignon_txtUserID").set(@credentials["username"].to_s)
      @browser.text_field(:id, "ctlSignon_txtPassword").set(@credentials["password"])
      @browser.button(:id, "ctlSignon_btnLogin").click
    end

    def balance
      # TODO (hardcoded)
      @browser.select_list(:id, "ddlAccounts").select_value(2)
      @browser.button(:id, "btnSubmitHistoryRequest").click
      table = @browser.table(:id, "ctlAccountActivityChecking")
      cell = table.rows[1].cells[6]
      return cell.text.gsub(/[$,]/, '')
    end
  end
end
