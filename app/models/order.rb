class Order < ApplicationRecord
  belongs_to :user
  has_many order_items, dependent: :destroy
  validates :status, :total_price, presence: true
end
