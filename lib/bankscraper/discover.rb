require 'watir'

module BankScraper
  class DiscoverScraper
    attr_accessor :browser
    attr_accessor :credentials

    def initialize(credentials)
      @browser = Watir::Browser.new
      @credentials = credentials
    end

    def login
      @browser.goto("https://discovercard.com")
      @browser.text_field(:name, "userID").set(@credentials["username"])
      @browser.text_field(:name, "password").set(@credentials["password"])
      @browser.button(:name, "Log In").click
    end

    def balance
      @browser.goto("https://www.discovercard.com/cardmembersvcs/achome/homepage")
      @browser.span(:id, "current-balance").text.gsub(/[$,]/, '')
    end
  end
end
