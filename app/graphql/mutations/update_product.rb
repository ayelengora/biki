module Mutations
    class UpdateProduct < BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :category, String, required: false
      argument :description, String, required: false
      argument :image_url, String, required: false
      argument :price, Float, required: false
  
      field :product, Types::ProductType, null: false
      field :errors, [String], null: false
  
      def resolve(id:, name: nil, category: nil, description: nil, image_url: nil, price: nil)
        product = Product.find_by(id: id)
        return { product: nil, errors: ["Producto no encontrado"] } unless product
  
        product.name = name if name
        product.category = category if category
        product.description = description if description
        product.image_url = image_url if image_url
        product.price = price if price
  
        if product.save
          { product: product, errors: [] }
        else
          { product: nil, errors: product.errors.full_messages }
        end
      end
    end
  end
  