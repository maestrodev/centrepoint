require 'selenium-client'
require 'selenium-webdriver'
require 'json'

# SELENIUM 1

def selenium_start(name)

  browser = {
    "username"        => ENV['SELENIUM_USERNAME'],
    "access-key"      => ENV['SELENIUM_ACCESS_KEY'],
    "os"              => ENV['SELENIUM_OS'],
    "browser"         => ENV['SELENIUM_BROWSER'],
    "browser-version" => ENV['SELENIUM_BROWSER_VERSION'],
    "name"            => name
  }

  params = {
    :host => ENV['SELENIUM_HOST'],
    :port => ENV['SELENIUM_PORT'],
    :browser => browser.to_json,
    :url => ENV['SELENIUM_URL'],
    :timeout_in_second => 60
  }
  puts "Connecting to Selenium: #{params.inspect}"
  @driver = Selenium::Client::Driver.new(params)

  @driver.start
end

def selenium_stop
  @driver.stop
end

# SELENIUM 2 - WEBDRIVER

def webdriver_start(name)
  caps = Selenium::WebDriver::Remote::Capabilities.send(ENV['SELENIUM_BROWSER'])
  caps.version = ENV['SELENIUM_BROWSER_VERSION']
  caps.platform = ENV['SELENIUM_OS'],
  caps[:name] = name

  @driver = Selenium::WebDriver.for(
    :remote,
    :url => "http://#{ENV['SELENIUM_USERNAME']}:#{ENV['SELENIUM_ACCESS_KEY']}@#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}/wd/hub",
    :desired_capabilities => caps)
end

def webdriver_quit
  @driver.quit
end
