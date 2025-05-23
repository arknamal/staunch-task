class MemoryLeakJob < ApplicationJob
  queue_as :default

  # The purpose of this job now is to take blog records in batches,
  # delegate the batches to another job which hits the API and saves API responses.
  # This will help in reducing memory usage and avoid loading all records at once.
  # The batch size is set to 1000 (arvitrarily), but can be adjusted based on the system's memory capacity.
  # The concurrent jobs will be independent of each other and will not share memory.
  def perform
    Blog.find_in_batches(batch_size: 1000) do |batch|
      BlogBatchJob.perform_later(batch.map(&:id))
    end
  end
end
