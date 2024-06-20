# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

Game.destroy_all
Word.destroy_all
Category.destroy_all


# Create users
User.create!(
  first_name: "Iona",
  last_name: "Helbig",
  email: "iona@gmail.com",
  password: "123456!",
  password_confirmation: "123456!"
)
# Create Categories
categories = %w[Animals Science Sports History Geography]
categories.each do |category|
  Category.create!(name: category)
end


# Create Words
Category.all.each do |category|
  10.times do
    Word.create!(
      name: Faker::Lorem.word,
      category: category,
      definition: Faker::Lorem.sentence(word_count: 10),
      level: %w[Beginner Intermediate Advanced].sample
    )
  end
end

# Create Games
User.all.each do |user|
  2.times do
    date =  Faker::Date.between(from: 2.years.ago, to: Date.today)
    game = Game.create!(
      category: Category.all.sample,
      difficulty_level: "Beginner",
      user: user,
      score: rand(0..100),
      date: date,
      start_time: Faker::Time.between(from: date - 1, to: date),
      end_time: Faker::Time.between(from: date + 1, to: date),
      word_id: Word.where(level: "Beginner").sample.id || 1
    )





    # Create Rounds for each Game
    # 2.times do
    #   Round.create!(
    #     game: game,
    #     word: Word.all.sample,
    #     attempts: rand(1..5)
    #   )
    # end
  end
end
