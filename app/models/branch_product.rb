class BranchProduct < ApplicationRecord
  belongs_to :branch
  belongs_to :product
  has_many   :stocks, dependent: :destroy
  accepts_nested_attributes_for :stocks, allow_destroy: true
end