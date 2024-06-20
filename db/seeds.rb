# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# require 'faker'

# # Create Categories
# categories = %w[Animals Science Sports History Geography]
# categories.each do |category|
#   Category.create!(name: category)
# end


# # Create Words
# Category.all.each do |category|
#   10.times do
#     Word.create!(
#       name: Faker::Lorem.word,
#       category: category,
#       definition: Faker::Lorem.sentence(word_count: 10),
#       level: rand(1..3) # Adjusted level range to 1-3
#     )
#   end
# end

# # Create Games
# User.all.each do |user|
#   2.times do
#     game = Game.create!(
#       category: Category.all.sample,
#       difficulty_level: %w[Beginner Intermediate Advanced].sample,
#       user: user,
#       score: rand(0..100),
#       date: Faker::Date.between(from: 2.years.ago, to: Date.today)
#     )

#     # Create Rounds for each Game
#     2.times do
#       Round.create!(
#         game: game,
#         word: Word.all.sample,
#         attempts: rand(1..5)
#       )
#     end
#   end
# end
words = [
  { name: 'Gravity', definition: 'The force that attracts a body toward the center of the earth.', level: 1, category_name: 'Science' },
  { name: 'Photosynthesis', definition: 'The process by which green plants use sunlight to synthesize foods.', level: 2, category_name: 'Science' },
  { name: 'Metamorphosis', definition: 'The process of transformation from an immature form to an adult form.', level: 3, category_name: 'Science' },
  { name: 'Hamlet', definition: 'A tragedy written by William Shakespeare.', level: 1, category_name: 'Literature' },
  # Add more words as needed
]
