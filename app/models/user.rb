class User < ApplicationRecord
    has_many :meetings, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :tasks

end
