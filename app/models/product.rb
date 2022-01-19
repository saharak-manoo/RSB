class Product < ApplicationRecord
  has_many :branch_products, dependent: :destroy
  validates :name, presence: true
end