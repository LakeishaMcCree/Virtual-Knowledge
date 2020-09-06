class Comment < ApplicationRecord
    belongs_to :meeting
    belongs_to :user
    belongs_to :task 
end
