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
  { name: 'Panda', definition: 'A large bearlike mammal with characteristic black and white markings, native to certain mountain forests in China. It feeds almost entirely on bamboo and has become increasingly rare.', category_name: 'Animals', level: 'Advanced' },

  # Clothing
  { name: 'Shirt', definition: 'A cloth garment for the upper body.', category_name: 'Clothing', level: 'Beginner' },
  { name: 'Pants', definition: 'A piece of clothing worn on the lower half of the body.', category_name: 'Clothing', level: 'Beginner' },
  { name: 'Dress', definition: 'A one-piece garment for a woman or girl.', category_name: 'Clothing', level: 'Intermediate' },
  { name: 'Blazer', definition: 'A lightweight jacket, typically in a solid color.', category_name: 'Clothing', level: 'Intermediate' },
  { name: 'Trench Coat', definition: 'A long, double-breasted coat.', category_name: 'Clothing', level: 'Advanced' },
  { name: 'Tuxedo', definition: 'A formal evening suit.', category_name: 'Clothing', level: 'Advanced' },

  # Fashion
  { name: 'Runway', definition: 'A narrow, usually flat surface where models walk to display clothing.', category_name: 'Fashion', level: 'Beginner' },
  { name: 'Model', definition: 'A person employed to display clothes by wearing them.', category_name: 'Fashion', level: 'Beginner' },
  { name: 'Couture', definition: 'The design and manufacture of fashionable clothes to a client\'s specific requirements.', category_name: 'Fashion', level: 'Intermediate' },
  { name: 'Trend', definition: 'A general direction in which something is developing or changing.', category_name: 'Fashion', level: 'Intermediate' },
  { name: 'Haute Couture', definition: 'High-end fashion that is constructed by hand from start to finish.', category_name: 'Fashion', level: 'Advanced' },
  { name: 'Avant-garde', definition: 'New and unusual or experimental ideas, especially in the arts.', category_name: 'Fashion', level: 'Advanced' },

  # Work
  { name: 'Office', definition: 'A room, set of rooms, or building used as a place for commercial, professional, or bureaucratic work.', category_name: 'Work', level: 'Beginner' },
  { name: 'Job', definition: 'A paid position of regular employment.', category_name: 'Work', level: 'Beginner' },
  { name: 'Manager', definition: 'A person responsible for controlling or administering an organization or group of staff.', category_name: 'Work', level: 'Intermediate' },
  { name: 'Team', definition: 'A group of people with a full set of complementary skills required to complete a task, job, or project.', category_name: 'Work', level: 'Intermediate' },
  { name: 'Strategy', definition: 'A plan of action designed to achieve a long-term or overall aim.', category_name: 'Work', level: 'Advanced' },
  { name: 'Innovation', definition: 'The act of introducing something new.', category_name: 'Work', level: 'Advanced' },

  # Education
  { name: 'School', definition: 'An institution for educating children.', category_name: 'Education', level: 'Beginner' },
  { name: 'Teacher', definition: 'A person who teaches, especially in a school.', category_name: 'Education', level: 'Beginner' },
  { name: 'Curriculum', definition: 'The subjects comprising a course of study in a school or college.', category_name: 'Education', level: 'Intermediate' },
  { name: 'Lecture', definition: 'An educational talk to an audience, especially to students in a university or college.', category_name: 'Education', level: 'Intermediate' },
  { name: 'Pedagogy', definition: 'The method and practice of teaching, especially as an academic subject or theoretical concept.', category_name: 'Education', level: 'Advanced' },
  { name: 'Thesis', definition: 'A statement or theory that is put forward as a premise to be maintained or proved.', category_name: 'Education', level: 'Advanced' },

  # Emotions
  { name: 'Happy', definition: 'Feeling or showing pleasure or contentment.', category_name: 'Emotions', level: 'Beginner' },
  { name: 'Sad', definition: 'Feeling or showing sorrow; unhappy.', category_name: 'Emotions', level: 'Beginner' },
  { name: 'Angry', definition: 'Feeling or showing strong annoyance, displeasure, or hostility.', category_name: 'Emotions', level: 'Intermediate' },
  { name: 'Fear', definition: 'An unpleasant emotion caused by the belief that someone or something is dangerous, likely to cause pain, or a threat.', category_name: 'Emotions', level: 'Intermediate' },
  { name: 'Ecstatic', definition: 'Feeling or expressing overwhelming happiness or joyful excitement.', category_name: 'Emotions', level: 'Advanced' },
  { name: 'Melancholy', definition: 'A feeling of pensive sadness, typically with no obvious cause.', category_name: 'Emotions', level: 'Advanced' },

  # Nature
  { name: 'Tree', definition: 'A woody perennial plant, typically having a single stem or trunk growing to a considerable height and bearing lateral branches at some distance from the ground.', category_name: 'Nature', level: 'Beginner' },
  { name: 'River', definition: 'A large natural stream of water flowing in a channel to the sea, a lake, or another such stream.', category_name: 'Nature', level: 'Beginner' },
  { name: 'Mountain', definition: 'A large natural elevation of the earth\'s surface rising abruptly from the surrounding level; a large steep hill.', category_name: 'Nature', level: 'Intermediate' },
  { name: 'Forest', definition: 'A large area covered chiefly with trees and undergrowth.', category_name: 'Nature', level: 'Intermediate' },
  { name: 'Ecosystem', definition: 'A biological community of interacting organisms and their physical environment.', category_name: 'Nature', level: 'Advanced' },
  { name: 'Biodiversity', definition: 'The variety of life in the world or in a particular habitat or ecosystem.', category_name: 'Nature', level: 'Advanced' },

  # Health
  { name: 'Doctor', definition: 'A person who is qualified to treat people who are ill.', category_name: 'Health', level: 'Beginner' },
  { name: 'Medicine', definition: 'The science or practice of the diagnosis, treatment, and prevention of disease (in technical use often taken to exclude surgery).', category_name: 'Health', level: 'Beginner' },
  { name: 'Nutrition', definition: 'The process of providing or obtaining the food necessary for health and growth.', category_name: 'Health', level: 'Intermediate' },
  { name: 'Vaccine', definition: 'A substance used to stimulate the production of antibodies and provide immunity against one or several diseases.', category_name: 'Health', level: 'Intermediate' },
  { name: 'Cardiology', definition: 'The branch of medicine that deals with diseases and abnormalities of the heart.', category_name: 'Health', level: 'Advanced' },
  { name: 'Neurology', definition: 'The branch of medicine or biology that deals with the anatomy, functions, and organic disorders of nerves and the nervous system.', category_name: 'Health', level: 'Advanced' },

  # Sports
  { name: 'Soccer', definition: 'A sport in which two teams of eleven players each try to score by kicking a ball into the other team\'s goal.', category_name: 'Sports', level: 'Beginner' },
  { name: 'Basketball', definition: 'A game played between two teams of five players each on a rectangular court, usually indoors. Each team tries to score by tossing the ball through the opponent\'s goal, an elevated horizontal hoop and net.', category_name: 'Sports', level: 'Beginner' },
  { name: 'Tennis', definition: 'A game in which two or four players strike a ball with rackets over a net stretched across a court.', category_name: 'Sports', level: 'Intermediate' },
  { name: 'Swimming', definition: 'The sport or activity of propelling oneself through water using the limbs.', category_name: 'Sports', level: 'Intermediate' },
  { name: 'Marathon', definition: 'A long-distance running race, strictly one of 26 miles 385 yards (42.195 km).', category_name: 'Sports', level: 'Advanced' },
  { name: 'Triathlon', definition: 'An athletic contest consisting of three different events, typically swimming, cycling, and long-distance running.', category_name: 'Sports', level: 'Advanced' },

  # Art
  { name: 'Painting', definition: 'The process or art of using paint, in a picture, as a protective coating, or as decoration.', category_name: 'Art', level: 'Beginner' },
  { name: 'Sculpture', definition: 'The art of making two- or three-dimensional representative or abstract forms, especially by carving stone or wood or by casting metal or plaster.', category_name: 'Art', level: 'Beginner' },
  { name: 'Photography', definition: 'The art or practice of taking and processing photographs.', category_name: 'Art', level: 'Intermediate' },
  { name: 'Ceramics', definition: 'The art of making objects out of clay and similar materials treated by firing.', category_name: 'Art', level: 'Intermediate' },
  { name: 'Impressionism', definition: 'A style or movement in painting originating in France in the 1860s, characterized by a concern with depicting the visual impression of the moment, especially in terms of the shifting effect of light and color.', category_name: 'Art', level: 'Advanced' },
  { name: 'Surrealism', definition: 'A 20th-century avant-garde movement in art and literature that sought to release the creative potential of the unconscious mind.', category_name: 'Art', level: 'Advanced' },

  # Literature
  { name: 'Novel', definition: 'A fictitious prose narrative of book length, typically representing character and action with some degree of realism.', category_name: 'Literature', level: 'Beginner' },
  { name: 'Poetry', definition: 'Literary work in which the expression of feelings and ideas is given intensity by the use of distinctive style and rhythm.', category_name: 'Literature', level: 'Beginner' },
  { name: 'Drama', definition: 'A play for theater, radio, or television.', category_name: 'Literature', level: 'Intermediate' },
  { name: 'Essay', definition: 'A short piece of writing on a particular subject.', category_name: 'Literature', level: 'Intermediate' },
  { name: 'Modernism', definition: 'A style or movement in the arts that aims to break with classical and traditional forms.', category_name: 'Literature', level: 'Advanced' },
  { name: 'Postmodernism', definition: 'A late 20th-century style and concept in the arts, architecture, and criticism that represents a departure from modernism and has at its heart a general distrust of grand theories and ideologies as well as a problematic relationship with any notion of “art.”', category_name: 'Literature', level: 'Advanced' },

  # Technology
  { name: 'Computer', definition: 'An electronic device for storing and processing data, typically in binary form, according to instructions given to it in a variable program.', category_name: 'Technology', level: 'Beginner' },
  { name: 'Internet', definition: 'A global computer network providing a variety of information and communication facilities, consisting of interconnected networks using standardized communication protocols.', category_name: 'Technology', level: 'Beginner' },
  { name: 'Software', definition: 'The programs and other operating information used by a computer.', category_name: 'Technology', level: 'Intermediate' },
  { name: 'Hardware', definition: 'The machines, wiring, and other physical components of a computer or other electronic system.', category_name: 'Technology', level: 'Intermediate' },
  { name: 'Artificial Intelligence', definition: 'The theory and development of computer systems able to perform tasks that normally require human intelligence, such as visual perception, speech recognition, decision-making, and translation between languages.', category_name: 'Technology', level: 'Advanced' },
  { name: 'Quantum Computing', definition: 'The use of quantum-mechanical phenomena such as superposition and entanglement to perform computation.', category_name: 'Technology', level: 'Advanced' }
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
    score: 9, date: current_time, start_time: current_time - 1.day + 1.hour, end_time: current_time - 1.day + 2.hours,
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
