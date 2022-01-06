class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable, :confirmable, :rememberable, :validatable, :trackable, :recoverable
end
