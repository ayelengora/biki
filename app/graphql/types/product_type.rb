module Types
    class ProductType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :category, String, null: false
      field :description, String, null: true
      field :image_url, String, null: true
      field :price, Float, null: false
      field :stocks, [Types::StockType], null: true
    end
  end
  