require 'spec_helper'

describe "Test google", :selenium => 2 do
  before(:all) do
    webdriver_start "Test google webdriver"
  end

  it "should search" do
    @driver.navigate.to ENV['SELENIUM_URL']
    element = @driver.find_element(:name, 'q')
    element.send_keys "Hello WebDriver!"
    element.submit
    @driver.title.should eq("Google")
  end

  after(:all) do
    webdriver_quit
  end
end
