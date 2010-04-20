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
      @browser.goto("https://www.chase.com/credit-cards.htm?card=member")
      @browser.text_field(:id, "uid").set(@credentials["username"])
      @browser.text_field(:name, "usr_password_tmp").set(@credentials["password"])
      @browser.button(:class, "loginButton").click
    end

    def balance
      @browser.goto("https://chaseonline.chase.com/MyAccounts.aspx")
      return "I have no idea"
    end
  end
end
