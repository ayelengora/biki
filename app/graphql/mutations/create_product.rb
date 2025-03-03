Module Mutations
    class CreteProduct < BaseMutation
    argument :name, String,  required: true
    argument :category, Strig, required: true
    argument description, String, resuired: false
    argument image_url, String, required: false
    argument :price, Integer, required: true

    field :product, Types::ProductType, null: false
    field :errors, [String], null: false

        def resolve(name:, category:, description: nil, image_url: nil, price:)
        product = Product.new(
            name: name,
            category: category,
            description: description,
            image_url: image_url,
            price: price
        )

        if product.save
            { product: product, errors: [] }
        else
            { product: nil, errors: product.errors.full_messages }
        end

        end
    end
end