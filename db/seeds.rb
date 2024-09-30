# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
ActiveRecord::Base.transaction do
  user = User.create!(email: "blogger@test.com", password: 'admin123')
  100_000.times do
    Blog.create!(title: Faker::Lorem.sentence , body: Faker::Lorem.paragraph, user_id: user.id)
  end
end