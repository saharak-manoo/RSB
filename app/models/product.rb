class Product < ApplicationRecord
  has_many :stocks, dependent: :destroy
  validates :name, :price, presence: true
end