# config/environment.rb
require 'sinatra'
require 'sinatra/activerecord'

# Конфигурация базы данных
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.sqlite3'
)
set :database_file, 'database.yml'
