class Post < ApplicationRecord
    scope :recent, lambda { where('created_at >= :thirty_days_ago', thiryty_days_ago: Time.now - 1.days) }
    validates :title, presence: true
    validates :body, presence: true
    validates :tags, presence: true
    serialize :tags, Array
    has_many :comments, dependent: :destroy
    belongs_to :user
end
