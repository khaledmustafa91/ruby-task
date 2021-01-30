class Post < ApplicationRecord
    scope :recent, lambda { where('created_at <= :one_day_ago', one_day_ago: Time.now - 1.days) }
    validates :title, presence: true
    validates :body, presence: true
    validates :tags, presence: true
    serialize :tags, Array
    has_many :comments, dependent: :destroy
    belongs_to :user
end
