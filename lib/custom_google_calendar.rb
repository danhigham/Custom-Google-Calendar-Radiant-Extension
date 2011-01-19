require 'open-uri'

module CustomGoogleCalendar

  include Radiant::Taggable
  
  desc "Renders a google calendar and injects a style tag"
  tag "Calendar" do |tag|

    page = tag.locals.page
    user = UserActionObserver.current_user
    
    if !tag.attr['url'].nil?
      google_markup = open(tag.attr['url']) { |x| x.read }
      
      #correct relative URLs
      src_matches = google_markup.match(/src=\"[^http].*\"/)
      href_matches = google_markup.match(/href=\"[^http].*\"/)
      
      if src_matches.length > 0
        google_markup.gsub!(src_matches[0], src_matches[0].gsub('src="', 'src="http://www.google.com/calendar/'))
      end

      if href_matches.length > 0
        google_markup.gsub!(href_matches[0], href_matches[0].gsub('href="', 'href="http://www.google.com/calendar/'))
      end

      #inject stylesheets
      if !tag.attr['stylesheets'].nil?
        css_list = tag.attr['stylesheets'].split(',')
        
        css_list.each do |css|
          google_markup.gsub!(/\<\/head\>/, "<link type=\"text/css\" rel=\"stylesheet\" href=\"#{css}\" />\n</head>")
        end
      end

      %{        
        #{google_markup}
      }
    end
  end
  
end
