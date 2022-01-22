class Stock < ApplicationRecord
  extend SimplestStatus
  statuses :import, :export, :change_branch
  belongs_to :branch_product
  attr_accessor :branch_id, :qty, :date, :price
end