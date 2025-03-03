class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :size, quantity, :subtotal, presence: true
end
