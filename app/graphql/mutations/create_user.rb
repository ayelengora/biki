module Mutations
    class CreateUser < BaseMutation
      argument :name, String, required: true
      argument :email, String, required: true
      argument :password, String, required: true
      argument :role, String, required: false, default_value: "customer"
  
      field :user, Types::UserType, null: false
      field :errors, [String], null: false
  
      def resolve(name:, email:, password:, role:)
        user = User.new(name: name, email: email, password: password, role: role)
        if user.save
          { user: user, errors: [] }
        else
          { user: nil, errors: user.errors.full_messages }
        end
      end
    end
  end
  