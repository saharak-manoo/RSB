class Order < ApplicationRecord
  validates :sold_at, :price, presence: true
end