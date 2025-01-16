# app/serializers/user_v1_serializer.rb
class UserV1Serializer
  def initialize(user)
    @user = user
  end

  def serializable_hash
    {
      id: @user.id,
      name: @user.name,
      email: @user.email,
      created_at: @user.created_at.iso8601,
      updated_at: @user.updated_at.iso8601
    }
  end
end
