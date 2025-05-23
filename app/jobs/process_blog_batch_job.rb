# app/jobs/process_blog_batch_job.rb
class ProcessBlogBatchJob < ApplicationJob
  queue_as :default

  def perform(blog_ids)
    Blog.where(id: blog_ids).find_each do |blog|
      next unless blog_valid?(blog)
      blog_to_api(blog)
    end
  end

  private

  def blog_valid?(blog)
    blog.title.present? && blog.body.present?
  end

  def blog_to_api(blog)
    # Mock API call - can be replaced with real HTTP call
    sleep(0.1) # Simulate some network latency
    api_response_id = "blog-#{SecureRandom.hex}-#{blog.id}"
    blog.api_responses.create!(
      api_response_id: api_response_id,
      api_status: ApiResponse.api_statuses.keys.sample
    )
  end
end
