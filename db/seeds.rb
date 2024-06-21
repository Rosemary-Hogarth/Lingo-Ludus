current_time = DateTime.now

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
  'Colors', 'Numbers', 'Time', 'Seasons', 'Food', 'Travel', 'Home', 'Clothing', 'Fashion', 'Work',
  'Animals', 'Education', 'Emotions', 'Nature', 'Health', 'Sports', 'Art', 'Literature', 'Technology'
]

categories = category_names.map do |name|
  Category.find_or_create_by!(name: name)
end

# Create Words
words_attributes = [
  # Colors
  { name: 'Red', definition: 'The color of blood.', category_name: 'Colors', level: 'Beginner' },
  { name: 'Blue', definition: 'The color of the sky.', category_name: 'Colors', level: 'Beginner' },
  { name: 'Green', definition: 'The color of grass.', category_name: 'Colors', level: 'Beginner' },
  { name: 'Cyan', definition: 'A shade of blue.', category_name: 'Colors', level: 'Intermediate' },
  { name: 'Magenta', definition: 'A shade of pink.', category_name: 'Colors', level: 'Intermediate' },
  { name: 'Yellow', definition: 'The color of the sun.', category_name: 'Colors', level: 'Intermediate' },
  { name: 'Crimson', definition: 'A deep red color.', category_name: 'Colors', level: 'Advanced' },
  { name: 'Indigo', definition: 'A deep blue color.', category_name: 'Colors', level: 'Advanced' },
  { name: 'Turquoise', definition: 'A blue-green color.', category_name: 'Colors', level: 'Advanced' },

  # Numbers
  { name: 'One', definition: 'The number after zero.', category_name: 'Numbers', level: 'Beginner' },
  { name: 'Two', definition: 'The number after one.', category_name: 'Numbers', level: 'Beginner' },
  { name: 'Three', definition: 'The number after two.', category_name: 'Numbers', level: 'Beginner' },
  { name: 'Four', definition: 'The number after three.', category_name: 'Numbers', level: 'Intermediate' },
  { name: 'Five', definition: 'The number after four.', category_name: 'Numbers', level: 'Intermediate' },
  { name: 'Six', definition: 'The number after five.', category_name: 'Numbers', level: 'Intermediate' },
  { name: 'Seven', definition: 'The number after six.', category_name: 'Numbers', level: 'Advanced' },
  { name: 'Eight', definition: 'The number after seven.', category_name: 'Numbers', level: 'Advanced' },
  { name: 'Nine', definition: 'The number after eight.', category_name: 'Numbers', level: 'Advanced' },

  # Time
  { name: 'Clock', definition: 'A device used to measure time.', category_name: 'Time', level: 'Beginner' },
  { name: 'Watch', definition: 'A small timepiece worn typically on a strap on one\'s wrist.', category_name: 'Time', level: 'Beginner' },
  { name: 'Hour', definition: 'A period of time equal to a twenty-fourth part of a day and night.', category_name: 'Time', level: 'Beginner' },
  { name: 'Minute', definition: 'A period of time equal to sixty seconds or a sixtieth of an hour.', category_name: 'Time', level: 'Intermediate' },
  { name: 'Second', definition: 'A sixtieth of a minute of time.', category_name: 'Time', level: 'Intermediate' },
  { name: 'Day', definition: 'A period of twenty-four hours as a unit of time.', category_name: 'Time', level: 'Intermediate' },
  { name: 'Week', definition: 'A period of seven days.', category_name: 'Time', level: 'Advanced' },
  { name: 'Month', definition: 'Each of the twelve named periods into which a year is divided.', category_name: 'Time', level: 'Advanced' },
  { name: 'Year', definition: 'The time taken by the earth to make one revolution around the sun.', category_name: 'Time', level: 'Advanced' },

  # Seasons
  { name: 'Spring', definition: 'The season after winter and before summer.', category_name: 'Seasons', level: 'Beginner' },
  { name: 'Summer', definition: 'The warmest season of the year.', category_name: 'Seasons', level: 'Beginner' },
  { name: 'Autumn', definition: 'The season after summer and before winter.', category_name: 'Seasons', level: 'Beginner' },
  { name: 'Winter', definition: 'The coldest season of the year.', category_name: 'Seasons', level: 'Intermediate' },
  { name: 'Equinox', definition: 'The time or date at which the sun crosses the celestial equator.', category_name: 'Seasons', level: 'Intermediate' },
  { name: 'Solstice', definition: 'Either of the two times in the year when the sun is at its greatest distance from the celestial equator.', category_name: 'Seasons', level: 'Intermediate' },
  { name: 'Blossom', definition: 'The flower of a plant, especially of one producing an edible fruit.', category_name: 'Seasons', level: 'Advanced' },
  { name: 'Heatwave', definition: 'A prolonged period of abnormally hot weather.', category_name: 'Seasons', level: 'Advanced' },
  { name: 'Harvest', definition: 'The process or period of gathering in crops.', category_name: 'Seasons', level: 'Advanced' },

  # Food
  { name: 'Apple', definition: 'A round fruit with red or yellow skin and a firm white flesh.', category_name: 'Food', level: 'Beginner' },
  { name: 'Bread', definition: 'A food made of flour, water, and yeast mixed together and baked.', category_name: 'Food', level: 'Beginner' },
  { name: 'Cheese', definition: 'A food made from the pressed curds of milk.', category_name: 'Food', level: 'Beginner' },
  { name: 'Pasta', definition: 'A dish originally from Italy consisting of dough made from durum wheat and water, extruded or stamped into various shapes and typically cooked in boiling water.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Pizza', definition: 'A dish of Italian origin consisting of a flat, round base of dough baked with a topping of tomatoes and cheese, typically with added meat or vegetables.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Salad', definition: 'A cold dish of various mixtures of raw or cooked vegetables, usually seasoned with oil, vinegar, or other dressing.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Sushi', definition: 'A Japanese dish consisting of small balls or rolls of vinegar-flavored cold rice served with a garnish of vegetables, egg, or raw seafood.', category_name: 'Food', level: 'Advanced' },
  { name: 'Steak', definition: 'High-quality beef taken from the hindquarters of the animal, typically cut into thick slices that are cooked by grilling or frying.', category_name: 'Food', level: 'Advanced' },
  { name: 'Taco', definition: 'A Mexican dish consisting of a folded or rolled tortilla filled with various mixtures, such as seasoned meat, beans, lettuce, and tomatoes.', category_name: 'Food', level: 'Advanced' },

  # Travel
  { name: 'Airport', definition: 'A complex of runways and buildings for the takeoff, landing, and maintenance of civil aircraft, with facilities for passengers.', category_name: 'Travel', level: 'Beginner' },
  { name: 'Hotel', definition: 'An establishment providing accommodation, meals, and other services for travelers and tourists.', category_name: 'Travel', level: 'Beginner' },
  { name: 'Passport', definition: 'An official document issued by a government, certifying the holder\'s identity and citizenship and entitling them to travel under its protection to and from foreign countries.', category_name: 'Travel', level: 'Beginner' },
  { name: 'Tour', definition: 'A journey for pleasure in which several different places are visited.', category_name: 'Travel', level: 'Intermediate' },
  { name: 'Journey', definition: 'An act of traveling from one place to another.', category_name: 'Travel', level: 'Intermediate' },
  { name: 'Adventure', definition: 'An unusual and exciting, typically hazardous, experience or activity.', category_name: 'Travel', level: 'Intermediate' },
  { name: 'Excursion', definition: 'A short journey or trip, especially one engaged in as a leisure activity.', category_name: 'Travel', level: 'Advanced' },
  { name: 'Expedition', definition: 'A journey undertaken by a group of people with a particular purpose, especially that of exploration, research, or war.', category_name: 'Travel', level: 'Advanced' },
  { name: 'Voyage', definition: 'A long journey involving travel by sea or in space.', category_name: 'Travel', level: 'Advanced' },

  # Home
  { name: 'House', definition: 'A building for human habitation, especially one that is lived in by a family or small group of people.', category_name: 'Home', level: 'Beginner' },
  { name: 'Kitchen', definition: 'A room or area where food is prepared and cooked.', category_name: 'Home', level: 'Beginner' },
  { name: 'Bedroom', definition: 'A room for sleeping in.', category_name: 'Home', level: 'Beginner' },
  { name: 'Bathroom', definition: 'A room containing a bathtub or shower and usually also a washbasin and a toilet.', category_name: 'Home', level: 'Intermediate' },
  { name: 'Living Room', definition: 'A room in a house for general and informal everyday use.', category_name: 'Home', level: 'Intermediate' },
  { name: 'Garden', definition: 'A piece of ground, often near a house, used for growing flowers, fruit, or vegetables.', category_name: 'Home', level: 'Intermediate' },
  { name: 'Garage', definition: 'A building for housing a motor vehicle or vehicles.', category_name: 'Home', level: 'Advanced' },
  { name: 'Basement', definition: 'The floor of a building which is partly or entirely below ground level.', category_name: 'Home', level: 'Advanced' },
  { name: 'Attic', definition: 'A space or room just below the roof of a building.', category_name: 'Home', level: 'Advanced' },

  # Animals
  { name: 'Dog', definition: 'A domesticated carnivorous mammal that typically has a long snout, an acute sense of smell, non-retractable claws, and a barking, howling, or whining voice.', category_name: 'Animals', level: 'Beginner' },
  { name: 'Cat', definition: 'A small domesticated carnivorous mammal with soft fur, a short snout, and retractile claws.', category_name: 'Animals', level: 'Beginner' },
  { name: 'Bird', definition: 'A warm-blooded egg-laying vertebrate distinguished by the possession of feathers, wings, and a beak and (typically) by being able to fly.', category_name: 'Animals', level: 'Beginner' },
  { name: 'Elephant', definition: 'A large mammal with a trunk, native to Africa and southern Asia.', category_name: 'Animals', level: 'Intermediate' },
  { name: 'Giraffe', definition: 'An African mammal with a very long neck and forelegs, having a coat patterned with brown patches separated by lighter lines. It is the tallest living animal.', category_name: 'Animals', level: 'Intermediate' },
  { name: 'Dolphin', definition: 'A small gregarious toothed whale that typically has a beaklike snout and a curved fin on the back.', category_name: 'Animals', level: 'Intermediate' },
  { name: 'Penguin', definition: 'A large flightless seabird of the southern hemisphere, with black upper parts and white underparts and wings developed into flippers for swimming underwater.', category_name: 'Animals', level: 'Advanced' },
  { name: 'Kangaroo', definition: 'A large plant-eating marsupial with a long powerful tail and strongly developed hind limbs that enable it to travel by leaping, found only in Australia and New Guinea.', category_name: 'Animals', level: 'Advanced' },
  { name: 'Panda', definition: 'A large bearlike mammal with characteristic black and white markings, native to certain mountain forests in China. It feeds almost entirely on bamboo and has become increasingly rare.', category_name: 'Animals', level: 'Advanced' }
]

words_attributes.each do |word_attr|
  category = Category.find_by(name: word_attr[:category_name])
  if category
    Word.create!(
      name: word_attr[:name],
      definition: word_attr[:definition],
      category: category,
      level: word_attr[:level]
    )
  else
    puts "Category not found for #{word_attr[:name]}"
  end
end

# Create Games
games_attributes = [
  {
    category_name: 'Animals', difficulty_level: 'Beginner', user_email: 'alice@example.com',
    score: 10, date: current_time, start_time: current_time - 1.hour, end_time: current_time,
    word_name: 'Dog', attempts: 1
  },
  {
    category_name: 'Numbers', difficulty_level: 'Beginner', user_email: 'bob@example.com',
    score: 8, date: current_time, start_time: current_time - 2.hours, end_time: current_time - 1.hour,
    word_name: 'Two', attempts: 2
  },
  {
    category_name: 'Time', difficulty_level: 'Beginner', user_email: 'carol@example.com',
    score: 9, date: current_time, start_time: current_time - 1.5.hours, end_time: current_time - 0.5.hour,
    word_name: 'Clock', attempts: 1
  }
]

games_attributes.each do |attrs|
  category = Category.find_by(name: attrs[:category_name])
  user = User.find_by(email: attrs[:user_email])
  word = Word.find_by(name: attrs[:word_name])

  if category && user && word
    Game.find_or_create_by!(
      category: category, difficulty_level: attrs[:difficulty_level], user: user, word: word,
      start_time: attrs[:start_time], end_time: attrs[:end_time]
    ) do |game|
      game.score = attrs[:score]
      game.date = attrs[:date]
      game.attempts = attrs[:attempts]
    end
  else
    puts "Missing data for game creation: category: #{category}, user: #{user}, word: #{word}"
  end
end
