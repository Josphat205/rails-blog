class User < ApplicationRecord
    validates :name, :photo, :bio, presence:true
    has_many :posts
    has_many :comments
end
