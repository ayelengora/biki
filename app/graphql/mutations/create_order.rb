module Mutations
    class CreateOrder < BaseMutation
      argument :user_id, ID, required: true
      argument :items, [Types::OrderItemInputType], required: true
  
      field :order, Types::OrderType, null: false
      field :errors, [String], null: false
  
      def resolve(user_id:, items:)
        user = User.find(user_id)
        total_price = 0
  
        order = Order.new(user: user, status: "pending")
  
        items.each do |item|
          product = Product.find(item[:product_id])
          subtotal = product.price * item[:quantity]
          total_price += subtotal
  
          order.order_items.build(
            product: product,
            size: item[:size],
            quantity: item[:quantity],
            subtotal: subtotal
          )
        end
  
        order.total_price = total_price
  
        if order.save
          { order: order, errors: [] }
        else
          { order: nil, errors: order.errors.full_messages }
        end
      end
    end
  end
  