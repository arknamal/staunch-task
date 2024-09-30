class Blog < ApplicationRecord
  belongs_to :user
  has_many :api_responses
end
