class Product < ApplicationRecord
  has_many :stocks, dependent: :destroy
  validates :name, :price, presence: true
  validates :price, numericality: { greater_than: 0 }
end