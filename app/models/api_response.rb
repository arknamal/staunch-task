class ApiResponse < ApplicationRecord
  belongs_to :blog
  enum api_status: [:success, :failure]
end
