require 'watir'

module BankScraper
  class ChaseCreditScraper
    attr_accessor :browser
    attr_accessor :credentials

    def initialize(credentials)
      @browser = Watir::Browser.new
      @credentials = credentials
    end

    def login
      @browser.goto("https://chaseonline.chase.com/Logon.aspx")
      @browser.text_field(:name, "Password").set(@credentials["password"])
      @browser.text_field(:id, "UserID").set(@credentials["username"])
      @browser.button(:id, "logon").click
    end

    def balance
      @browser.goto("https://chaseonline.chase.com/MyAccounts.aspx")
      return @browser.tables[15].rows[0].cells[2].text
    end
  end
end
