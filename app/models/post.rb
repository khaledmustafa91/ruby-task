class Post < ApplicationRecord
    validates :title, presence: true
    validates :body, presence: true
    validates :tags, presence: true
    serialize :tags, Array
    has_many :comments
    belongs_to :user
end
