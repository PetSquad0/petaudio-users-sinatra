# models/user_serializer.rb
class UserV1Serializer < ActiveModel::Serializer
  attributes :id, :name, :email, :created_at, :updated_at
end
