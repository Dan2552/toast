require 'toast/active_record_extensions.rb'
require 'toast/resource.rb'
require 'toast/collection'
require 'toast/association'
require 'toast/record'
require 'toast/single'

require 'action_dispatch/http/request'
require 'rack/accept_media_types'

module Toast
  class Engine < Rails::Engine

    # configure our plugin on boot. other extension points such
    # as configuration, rake tasks, etc, are also available
    initializer "toast.initialize" do |app|
      # Add 'acts_as_resource' declaration to ActiveRecord::Base
      ActiveRecord::Base.extend Toast::ActiveRecordExtensions

      # Load all models in app/models early to setup routing
      begin
        Dir["#{Rails.root}/app/models/**/*.rb"].each{|m| require m }

      rescue
        # raised when DB is not setup yet. (rake db:schema:load)
      end

      # Monkey patch the request class for Rails 3.0, Rack 1.2
      # Backport from Rack 1.3
      if Rack.release == "1.2"
        class Rack::Request
          def base_url
            url = scheme + "://"
            url << host

            if scheme == "https" && port != 443 ||
                scheme == "http" && port != 80
              url << ":#{port}"
            end

            url
          end
        end
      end
    end
  end
end
