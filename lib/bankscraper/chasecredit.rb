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
      for table in @browser.tables
        if table.rows.length > 0 and table.rows[0].cells.length > 2
          if table.rows[0].cells[1].text.starts_with? "Outstanding balance"
            return table.rows[0].cells[2].text.gsub(/[$,]/, '')
          end
        end
      end
    end
  end
end
