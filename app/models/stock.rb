class Stock < ApplicationRecord
  belongs_to :product
  validates :size, :quantity, presence: true
end
