# routes/v1.rb
require_relative '../app/controllers/application_controller'
require 'sinatra/contrib'
require 'will_paginate'
require 'will_paginate/active_record'
require_relative '../app/serializers/paginated_users_serializer'
require_relative '../app/serializers/user_v1_serializer'



class V1Routes < Sinatra::Base
  register Sinatra::Namespace

  namespace '/api/v1' do
    before do
      content_type :json
    end

    get '/users' do
      page = params[:page] ? params[:page].to_i : 1
      per_page = params[:per_page] ? params[:per_page].to_i : 10
      users = User.paginate(page: page, per_page: per_page)
      json_response(PaginatedUsersSerializer.new(users).serializable_hash)
    end

    get '/users/:id' do
      user = User.find_by(id: params[:id])
      if user
        json_response(UserV1Serializer.new(user).serializable_hash)
      else
        error_response({ message: 'User not found' }, 404)
      end
    end

    post '/users' do
      user_params = JSON.parse(request.body.read)
      user = User.new(user_params)
      if user.save
        json_response(UserV1Serializer.new(user).serializable_hash, 201)
      else
        error_response(user.errors.full_messages, 400)
      end
    end

    put '/users/:id' do
      user_params = JSON.parse(request.body.read)
      user = User.find_by(id: params[:id])
      if user&.update(user_params)
        json_response(UserV1Serializer.new(user).serializable_hash, 200)
      else
        error_response(user&.errors.full_messages || 'User not found', 400)
      end
    end

    delete '/users/:id' do
      user = User.find_by(id: params[:id])
      if user&.destroy
        json_response({ message: 'User deleted successfully' }, 204)
      else
        error_response('User not found', 404)
      end
    end
  end

  helpers do
    def json_response(data, status = 200)
      content_type :json
      status status
      body data.to_json
    end

    def error_response(message, status)
      content_type :json
      status status
      { errors: message }.to_json
    end
  end
end
