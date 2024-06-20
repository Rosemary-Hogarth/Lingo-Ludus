# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


category = Category.find_or_create_by(name: 'Test')


words_data = [
  { name: 'Wordone', definition: 'Definition of Word 1', level: "Beginner", category_id: category.id },
  { name: 'Wordtwo', definition: 'Definition of Word 2', level: "Intermediate", category_id: category.id },
  { name: 'Wordthree', definition: 'Definition of Word 3', level: "Advanced", category_id: category.id }
]

words_data.each do |word_params|
  Word.find_or_create_by(name: word_params[:name]) do |word|
    word.definition = word_params[:definition]
    word.level = word_params[:level]
    word.category_id = word_params[:category_id]
  end
end
