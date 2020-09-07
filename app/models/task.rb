class Task < ApplicationRecord
    belongs_to :meeting
    has_many :comments, through: :user
end
