# app/serializers/paginated_users_serializer.rb
class PaginatedUsersSerializer
  def initialize(users)
    @users = users
  end

  def serializable_hash
    {
      users: @users.map { |user| UserV1Serializer.new(user).serializable_hash },
      meta: {
        total_count: @users.total_entries,
        current_page: @users.current_page,
        total_pages: @users.total_pages
      }
    }
  end
end
