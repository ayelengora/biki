module Types
    class OrderType < Types::BaseObject
      field :id, ID, null: false
      field :status, String, null: false
      field :total_price, Float, null: false
      field :user, Types::UserType, null: false
      field :order_items, [Types::OrderItemType], null: true
    end
  end
  