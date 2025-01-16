# controllers/application_controller.rb
class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'

  helpers do
    def json_response(object, status = 200)
      content_type :json
      status status
      object.to_json
    end

    def error_response(message, status)
      content_type :json
      status status
      { error: message }.to_json
    end
  end
end
