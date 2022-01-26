class User < ApplicationRecord
  rolify
  devise :database_authenticatable, :registerable, :confirmable, :rememberable, :validatable, :trackable, :recoverable
  has_many :stock_histories

  def full_name
    "#{first_name} #{last_name}"
  end
end
