# app.rb
require 'sinatra'
require 'sinatra/activerecord'
require 'json'
require 'sinatra/contrib'
require 'will_paginate'
require 'will_paginate/active_record'
require_relative './app/models/user'
require_relative './app/controllers/application_controller'
require_relative './routes/v1'


# Настройка базы данных
set :database_file, 'config/database.yml'

# Обработчики ошибок
error ActiveRecord::RecordNotFound do
  error_response('Resource not found', 404)
end

error ActiveRecord::RecordInvalid do
  error_response(env['sinatra.error'].record.errors.full_messages, 400)
end

error do
  error_response('Internal Server Error', 500)
end

# Подключение маршрутов
use V1Routes

# Глобальные хелперы (если необходимо)
helpers do
  def error_response(message, status)
    content_type :json
    status status
    { errors: message }.to_json
  end
end
