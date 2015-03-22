module ApplicationHelper

 # Returns the full title on a per-page basis.
    def full_title(page_title = '')
    base_title = "LanguageApp"
        if page_title.empty?
          base_title
        else
          "#{base_title}|#{page_title}"
        end
    end

    def html_exists?(html)
	  html = "#{Rails.root}/app/assets/components/#{[params[:controller], params[:action]].join('/')}.html"
	  File.exists?(html) || File.exists?("#{html}.html") 
	end

    def broadcast(channel, &block)
    message = {:channel => channel, :data => capture(&block)}
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, :message => message.to_json)
    end    
end
