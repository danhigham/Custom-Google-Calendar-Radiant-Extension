# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application_controller'

class CustomGoogleCalendarExtension < Radiant::Extension
  version "1.0"
  description "Acts a proxy between your site and Google calendars"
  url "http://yourwebsite.com/custom_google_calendar"
  
  extension_config do |config|
    config.gem 'mechanize'
  #   config.after_initialize do
  #     run_something
  #   end
   end

  # See your config/routes.rb file in this extension to define custom routes
  
  def activate
    # tab 'Content' do
    #   add_item "Custom Google Calendar", "/admin/custom_google_calendar", :after => "Pages"
    # end
  end
  
  Page.send :include, CustomGoogleCalendar
end
