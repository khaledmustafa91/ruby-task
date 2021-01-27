class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :image, presence: true
    has_many :posts
    has_many :comments
end
