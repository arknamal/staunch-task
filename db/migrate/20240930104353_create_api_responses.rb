class CreateApiResponses < ActiveRecord::Migration[7.0]
  def change
    create_table :api_responses do |t|
      t.references :blog, null: false, foreign_key: true
      t.integer :api_status
      t.string :api_response_id

      t.timestamps
    end
  end
end
