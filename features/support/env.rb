require_relative '../../myapp.rb'
require 'rubygems'
require 'selenium-cucumber'

BeforeAll do
  puts "Starting App..."
  $pid = fork do
    MyApp.run!
  end
  sleep 1
  puts "Started App..."
end

AfterAll do
  unless $pid.nil?
    Process.kill "TERM", $pid
    Process.wait $pid
  end
  $driver.quit
end

Before do
  $driver.manage.delete_all_cookies
end

# Store command line arguments
$browser_type = ENV['BROWSER'] || 'ff'
$platform = ENV['PLATFORM'] || 'desktop'
$app_path = ENV['APP_PATH']

# check for valid parameters
validate_parameters $platform, $browser_type, $app_path

# If platform is android or ios create driver instance for mobile browser
begin
  $driver = Selenium::WebDriver.for(:"#{$browser_type}")
  $driver.manage().window().maximize()
rescue Exception => e
  $driver.quit
  puts e.message
  Process.exit(0)
end

at_exit do
  unless $pid.nil?
    Process.kill "TERM", $pid
    Process.wait $pid
  end
end
