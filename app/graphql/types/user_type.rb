module Types
    class UserType < Types::BaseObject
      field :id, ID, null: false
      field :name, String, null: false
      field :email, String, null: false
      field :role, String, null: false
      field :orders, [Types::OrderType], null: true
    end
  end
  