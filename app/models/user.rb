class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true
    validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :image, presence: true
    validates :password, presence:true, length:{ minimum: 8 }
    has_many :posts, dependent: :destroy
    has_many :comments, dependent: :destroy

end
