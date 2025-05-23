class Blog < ApplicationRecord
  belongs_to :user
  has_many :api_responses

  validates :title, presence: true
  validates :body, presence: true
  # We can add more validations (like a min limit for length etc. if needed - these are basic) e.g.
  # validates :title, length: { minimum: 5 }
  # validates :body, length: { minimum: 10 }
end
