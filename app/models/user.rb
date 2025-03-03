class User < ApplicationRecord
    has_secure_password
    has_many :orders

    validates :name, :email, :role, presence: true
    validates :email, uniqueness: true
    validates :password, length: { minimum: 6 }, allow_nil: true
    
end
