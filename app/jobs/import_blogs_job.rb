# app/jobs/import_blogs_job.rb

require 'csv'

class ImportBlogsJob < ApplicationJob
  queue_as :default

  def perform(csv_file, user_id)
    # Set the user based on the provided user_id (no checks (for now) as it came from current_user)
    user = User.find(user_id)

    # This array will keep failed rows and their errors logs to be displayed at the end (after import)
    failed_rows = []

    # Read and import the CSV file in chunks of 1000 rows (GPT says foreach is faster than parse although
    # a stackoverflow post benchmarking both says that their is negligible difference - our use case
    # is row-by-row so I preferred foreach as it goes row by row)
    CSV.foreach(csv_file, headers: true).each_slice(1000) do |rows|
      # Convert each row to a hash readying it for validation and import
      blog_attrs = rows.map(&:to_h)

      # Create the blog objects in memory with the user association and the attributes
      blogs = blog_attrs.map { |attrs| user.blogs.new(attrs) }

      # Validate and import the blogs in a block
      begin
        # This will validate and import the records in a single SQL query
        # The `on_duplicate_key_ignore` option will skip any duplicates
        # The invalide records will be silently skipped. Using result to capture `failed_instances`
        result = Blog.import blogs, validate: true, on_duplicate_key_ignore: true

        # If any records failed to import, we log them here
        # The way we are currently doing it is that we simply take the instance (not CSV format)
        # this can be improved by adding the row data to the instance but will slow down the import
        result.failed_instances.each do |failed_blog|
          failed_rows << {
            blog: failed_blog,
            errors: failed_blog.errors.full_messages
          }
        end

      # This is for unexpected failures (outside of validations)
      rescue => e
        blog_attrs.each do |row|
          failed_rows << { row_data: row, errors: [e.message] }
        end
      end
    end

    # After the import of complete CSV, we turn towards error reporting
    log_failures(failed_rows)
    # We can also send a notification to the user about the import status
    # UserMailer.import_status(user, failed_rows).deliver_now or something on those lines
    # We can also remove the temporary file at this stage
  end

  private

  def log_failures(failed_rows)
    return if failed_rows.empty?

    Rails.logger.info "Blog Import: #{failed_rows.size} records failed"

    # This will display the errors for each failed row and the row data for reference
    # One further improvement can be to delegate this to another job which retries
    # for a set number of times but I think it is redundant because validation failure is not accidental
    # The user should fix and upload the CSV again - optimal
    failed_rows.each_with_index do |fail, index|
      Rails.logger.info "##{index + 1} — Errors: #{fail[:errors].join(', ')} | Data: #{fail[:row_data]}"
    end
  end
end
