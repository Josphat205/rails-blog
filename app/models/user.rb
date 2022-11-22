class User < ApplicationRecord
    validates :name, :photo, :bio, presence:true
end
