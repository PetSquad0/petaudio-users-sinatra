# app/models/user.rb
class User < ActiveRecord::Base
  has_secure_password
  
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
