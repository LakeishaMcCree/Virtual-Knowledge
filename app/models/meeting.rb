class Meeting < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :tasks through: :user 
end
