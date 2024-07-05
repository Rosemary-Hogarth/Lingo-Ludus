puts 'Cleaning up database...'
Game.destroy_all
Word.destroy_all
Category.destroy_all
Message.destroy_all
Chatroom.destroy_all
User.destroy_all
Language.destroy_all
puts 'Database cleaned'

current_time = DateTime.now - 7.days

# Create Users
users = [
  { email: 'alice@example.com', password: 'password123', first_name: 'Alice', last_name: 'Smith' },
  { email: 'bob@example.com', password: 'password123', first_name: 'Bob', last_name: 'Jones' },
  { email: 'carol@example.com', password: 'password123', first_name: 'Carol', last_name: 'White' }
]

users.each do |user_attributes|
  User.find_or_create_by!(email: user_attributes[:email]) do |user|
    user.password = user_attributes[:password]
    user.first_name = user_attributes[:first_name]
    user.last_name = user_attributes[:last_name]
    user.save!
  end
end

# Create Categories
category_names = [
  'Colors', 'Numbers', 'Time', 'Seasons & Weather', 'Food', 'Travel', 'Home', 'Clothing', 'Fashion', 'Work',
  'Animals', 'Education', 'Emotions', 'Nature', 'Health', 'Sports', 'Art', 'Literature', 'Technology'
]

categories = category_names.map do |name|
  Category.find_or_create_by!(name: name)
end

# Create Languages
languages = [
  { name: 'English', code: 'en' },
  { name: 'German', code: 'de' }
]

languages.each do |lang|
  Language.find_or_create_by!(name: lang[:name], code: lang[:code])
end

# Fetch language IDs
english = Language.find_by(code: 'en')
german = Language.find_by(code: 'de')

# Debug output to check if languages are created
puts "English Language ID: #{english&.id}"
puts "German Language ID: #{german&.id}"

raise 'Languages were not created correctly' if english.nil? || german.nil?

puts 'Languages created'

# Create Words with language assignments
words_attributes = [
  # Colors - Beginner (reference)
  { name: 'Red', definition: 'The color of blood.', category_name: 'Colors', level: 'Beginner',
    language_id: english.id },
  { name: 'Rot', definition: 'Die Farbe des Blutes.', category_name: 'Colors', level: 'Beginner',
    language_id: german.id },
  { name: 'Blue', definition: 'The color of the sky.', category_name: 'Colors', level: 'Beginner',
    language_id: english.id },
  { name: 'Blau', definition: 'Die Farbe des Himmels.', category_name: 'Colors', level: 'Beginner',
    language_id: german.id },
  { name: 'Green', definition: 'The color of grass.', category_name: 'Colors', level: 'Beginner',
    language_id: english.id },
  { name: 'Grün', definition: 'Die Farbe des Grases.', category_name: 'Colors', level: 'Beginner',
    language_id: german.id },
  { name: 'Yellow', definition: 'The color of the sun.', category_name: 'Colors', level: 'Beginner',
    language_id: english.id },
  { name: 'Gelb', definition: 'Die Farbe der Sonne.', category_name: 'Colors', level: 'Beginner',
    language_id: german.id },
  { name: 'Pink', definition: 'The color of a flamingo.', category_name: 'Colors', level: 'Beginner',
    language_id: english.id },
  { name: 'Rosa', definition: 'Die Farbe eines Flamingos.', category_name: 'Colors', level: 'Beginner',
    language_id: german.id },
  { name: 'Orange', definition: 'The color of a pumpkin.', category_name: 'Colors', level: 'Beginner',
    language_id: english.id },
  { name: 'Orange', definition: 'Die Farbe eines Kürbisses.', category_name: 'Colors', level: 'Beginner',
    language_id: german.id },
  { name: 'Purple', definition: 'The color of grapes or lavender.', category_name: 'Colors', level: 'Beginner',
    language_id: english.id },
  { name: 'Lila', definition: 'Die Farbe von Trauben oder Lavendel.', category_name: 'Colors', level: 'Beginner',
    language_id: german.id },
  { name: 'Brown', definition: 'A color produced by mixing red, yellow, and blue.', category_name: 'Colors',
    level: 'Beginner', language_id: english.id },
  { name: 'Braun', definition: 'Eine Farbe, die durch Mischen von Rot, Gelb und Blau entsteht.',
    category_name: 'Colors', level: 'Beginner', language_id: german.id },
  { name: 'Black', definition: 'The color of coal or night.', category_name: 'Colors', level: 'Beginner',
    language_id: english.id },
  { name: 'Schwarz', definition: 'Die Farbe von Kohle oder Nacht.', category_name: 'Colors', level: 'Beginner',
    language_id: german.id },
  { name: 'White', definition: 'The color of milk or fresh snow.', category_name: 'Colors', level: 'Beginner',
    language_id: english.id },
  { name: 'Weiß', definition: 'Die Farbe von Milch oder frischem Schnee.', category_name: 'Colors',
    level: 'Beginner', language_id: german.id },

  # Colors - Intermediate
  { name: 'Cyan', definition: 'A shade of blue.', category_name: 'Colors', level: 'Intermediate',
    language_id: english.id },
  { name: 'Zyan', definition: 'Ein Blauton.', category_name: 'Colors', level: 'Intermediate',
    language_id: german.id },
  { name: 'Magenta', definition: 'A shade of pink.', category_name: 'Colors', level: 'Intermediate',
    language_id: english.id },
  { name: 'Magenta', definition: 'Ein Rosaton.', category_name: 'Colors', level: 'Intermediate',
    language_id: german.id },
  { name: 'Lime', definition: 'A bright green color.', category_name: 'Colors', level: 'Intermediate',
    language_id: english.id },
  { name: 'Limonengrün', definition: 'Ein helles Grün.', category_name: 'Colors', level: 'Intermediate',
    language_id: german.id },
  { name: 'Teal', definition: 'A dark greenish-blue color.', category_name: 'Colors', level: 'Intermediate',
    language_id: english.id },
  { name: 'Petrol', definition: 'Ein dunkles Grünblau.', category_name: 'Colors', level: 'Intermediate',
    language_id: german.id },
  { name: 'Violet', definition: 'A bluish-purple color.', category_name: 'Colors', level: 'Intermediate',
    language_id: english.id },
  { name: 'Violett', definition: 'Ein bläuliches Lila.', category_name: 'Colors', level: 'Intermediate',
    language_id: german.id },
  { name: 'Lavender', definition: 'A pale purple color.', category_name: 'Colors', level: 'Intermediate',
    language_id: english.id },
  { name: 'Lavendel', definition: 'Ein blasses Lila.', category_name: 'Colors', level: 'Intermediate',
    language_id: german.id },
  { name: 'Maroon', definition: 'A dark brownish-red color.', category_name: 'Colors', level: 'Intermediate',
    language_id: english.id },
  { name: 'Kastanienbraun', definition: 'Ein dunkles Rotbraun.', category_name: 'Colors', level: 'Intermediate',
    language_id: german.id },
  { name: 'Olive', definition: 'A yellowish-green color.', category_name: 'Colors', level: 'Intermediate',
    language_id: english.id },
  { name: 'Oliv', definition: 'Ein gelbliches Grün.', category_name: 'Colors', level: 'Intermediate',
    language_id: german.id },
  { name: 'Peach', definition: 'A pale yellowish-pink color.', category_name: 'Colors', level: 'Intermediate',
    language_id: english.id },
  { name: 'Pfirsich', definition: 'Ein blasses Gelbrosa.', category_name: 'Colors', level: 'Intermediate',
    language_id: german.id },
  { name: 'Navy', definition: 'A dark blue color.', category_name: 'Colors', level: 'Intermediate',
    language_id: english.id },
  { name: 'Marineblau', definition: 'Ein dunkles Blau.', category_name: 'Colors', level: 'Intermediate',
    language_id: german.id },

  # Colors - Advanced
  { name: 'Crimson', definition: 'A deep red color.', category_name: 'Colors', level: 'Advanced',
    language_id: english.id },
  { name: 'Karmesinrot', definition: 'Ein tiefes Rot.', category_name: 'Colors', level: 'Advanced',
    language_id: german.id },
  { name: 'Indigo', definition: 'A deep blue color.', category_name: 'Colors', level: 'Advanced',
    language_id: english.id },
  { name: 'Indigo', definition: 'Ein tiefes Blau.', category_name: 'Colors', level: 'Advanced',
    language_id: german.id },
  { name: 'Turquoise', definition: 'A blue-green color.', category_name: 'Colors', level: 'Advanced',
    language_id: english.id },
  { name: 'Türkis', definition: 'Ein blaugrüne Farbe.', category_name: 'Colors', level: 'Advanced',
    language_id: german.id },
  { name: 'Chartreuse', definition: 'A color halfway between yellow and green.', category_name: 'Colors',
    level: 'Advanced', language_id: english.id },
  { name: 'Chartreuse', definition: 'Eine Farbe zwischen Gelb und Grün.', category_name: 'Colors', level: 'Advanced',
    language_id: german.id },
  { name: 'Amber', definition: 'A honey-yellow color.', category_name: 'Colors', level: 'Advanced',
    language_id: english.id },
  { name: 'Bernstein', definition: 'Eine honiggelbe Farbe.', category_name: 'Colors', level: 'Advanced',
    language_id: german.id },
  { name: 'Coral', definition: 'A pinkish-orange color.', category_name: 'Colors', level: 'Advanced',
    language_id: english.id },
  { name: 'Koralle', definition: 'Eine rosa-orange Farbe.', category_name: 'Colors', level: 'Advanced',
    language_id: german.id },
  { name: 'Saffron', definition: 'A golden-yellow color.', category_name: 'Colors', level: 'Advanced',
    language_id: english.id },
  { name: 'Safran', definition: 'Eine goldgelbe Farbe.', category_name: 'Colors', level: 'Advanced',
    language_id: german.id },
  { name: 'Cerulean', definition: 'A deep sky blue color.', category_name: 'Colors', level: 'Advanced',
    language_id: english.id },
  { name: 'Himmelblau', definition: 'Ein tiefes Himmelblau.', category_name: 'Colors', level: 'Advanced',
    language_id: german.id },
  { name: 'Ochre', definition: 'An earthy yellow or red color.', category_name: 'Colors', level: 'Advanced',
    language_id: english.id },
  { name: 'Ocker', definition: 'Eine erdige Gelb- oder Rotfarbe.', category_name: 'Colors', level: 'Advanced',
    language_id: german.id },
  { name: 'Aubergine', definition: 'A dark purple color.', category_name: 'Colors', level: 'Advanced',
    language_id: english.id },
  { name: 'Aubergine', definition: 'Eine dunkle Lila Farbe.', category_name: 'Colors', level: 'Advanced',
    language_id: german.id }
]

# Seed Words
words_attributes.each do |word_attr|
  category = Category.find_by(name: word_attr[:category_name])
  if category
    Word.create!(
      name: word_attr[:name],
      definition: word_attr[:definition],
      category: category,
      level: word_attr[:level],
      language_id: word_attr[:language_id]
    )
  else
    puts "Category not found for #{word_attr[:name]}"
  end
end

puts 'Words created'

# Create Games
games_attributes = [
  {
    category_name: 'Colors', difficulty_level: 'Beginner', user_email: 'alice@example.com',
    score: 3, date: current_time, start_time: current_time - 5.seconds, end_time: current_time,
    word_name: 'Red', attempts: 1, language_id: english.id
  },

  # German games
  {
    category_name: 'Colors', difficulty_level: 'Beginner', user_email: 'alice@example.com',
    score: 3, date: current_time, start_time: current_time - 5.seconds, end_time: current_time,
    word_name: 'Rot', attempts: 1, language_id: german.id
  },
  {
    category_name: 'Colors', difficulty_level: 'Beginner', user_email: 'alice@example.com',
    score: 3, date: current_time, start_time: current_time - 5.seconds, end_time: current_time,
    word_name: 'Gelb', attempts: 1, language_id: german.id
  }
]

# Update German game entries to use `language_id: german.id`
games_attributes.each do |attrs|
  attrs[:language_id] = german.id if attrs.key?(:language_code) && attrs[:language_code] == 'de'
  attrs.delete(:language_code) # Clean up if you no longer need the language_code attribute
end

# Seed Games
games_attributes.each do |attrs|
  category = Category.find_by(name: attrs[:category_name])
  user = User.find_by(email: attrs[:user_email])
  word = Word.find_by(name: attrs[:word_name])
  language = Language.find_by(id: attrs[:language_id])

  if category && user && word && language
    Game.find_or_create_by!(
      category: category, difficulty_level: attrs[:difficulty_level], user: user, word: word,
      start_time: attrs[:start_time], end_time: attrs[:end_time]
    ) do |game|
      game.score = attrs[:score]
      game.date = attrs[:date]
      game.attempts = attrs[:attempts]
      game.language = language
    end
  else
    puts "Missing data for game creation: category: #{category}, user: #{user}, word: #{word}, language: #{language}"
  end
end

puts 'Games created'

chatroom_names = ['Language tips', 'Hardest words', 'Random chat', 'Career & Language']

chatroom_names.each do |name|
  Chatroom.create(name: name)
end

puts "Seeded #{chatroom_names.count} chatrooms."
