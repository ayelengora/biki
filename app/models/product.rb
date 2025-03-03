class Product < ApplicationRecord
has_many :stocks, dependant: :destroy
validates :name, :category, :price, presence: true
end
