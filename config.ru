# config.ru
require './config/environment'

map('/users') { run UsersController }
