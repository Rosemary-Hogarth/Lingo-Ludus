puts "Cleaning up database..."
Game.destroy_all
Word.destroy_all
Category.destroy_all
User.destroy_all
puts "Database cleaned"


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

# Iterate over each category name and create or find a category with that name
categories = category_names.map do |name|
  Category.find_or_create_by!(name: name)
end

# Create Words
words_attributes = [
  # Colors
  # Colors - Beginner
  { name: 'Red', definition: 'The color of blood.', category_name: 'Colors', level: 'Beginner' },
  { name: 'Blue', definition: 'The color of the sky.', category_name: 'Colors', level: 'Beginner' },
  { name: 'Green', definition: 'The color of grass.', category_name: 'Colors', level: 'Beginner' },
  { name: 'Yellow', definition: 'The color of the sun.', category_name: 'Colors', level: 'Beginner' },
  { name: 'Pink', definition: 'The color of a flamingo.', category_name: 'Colors', level: 'Beginner' },
  { name: 'Orange', definition: 'The color of a pumpkin.', category_name: 'Colors', level: 'Beginner' },
  { name: 'Purple', definition: 'The color of grapes or lavender.', category_name: 'Colors', level: 'Beginner' },
  { name: 'Brown', definition: 'A color produced by mixing red, yellow, and blue.', category_name: 'Colors', level: 'Beginner' },
  { name: 'Black', definition: 'The color of coal or night.', category_name: 'Colors', level: 'Beginner' },
  { name: 'White', definition: 'The color of milk or fresh snow.', category_name: 'Colors', level: 'Beginner' },

  # Colors - Intermediate
  { name: 'Cyan', definition: 'A shade of blue.', category_name: 'Colors', level: 'Intermediate' },
  { name: 'Magenta', definition: 'A shade of pink.', category_name: 'Colors', level: 'Intermediate' },
  { name: 'Lime', definition: 'A bright green color.', category_name: 'Colors', level: 'Intermediate' },
  { name: 'Teal', definition: 'A dark greenish-blue color.', category_name: 'Colors', level: 'Intermediate' },
  { name: 'Violet', definition: 'A bluish-purple color.', category_name: 'Colors', level: 'Intermediate' },
  { name: 'Lavender', definition: 'A pale purple color.', category_name: 'Colors', level: 'Intermediate' },
  { name: 'Maroon', definition: 'A dark brownish-red color.', category_name: 'Colors', level: 'Intermediate' },
  { name: 'Olive', definition: 'A yellowish-green color.', category_name: 'Colors', level: 'Intermediate' },
  { name: 'Peach', definition: 'A pale yellowish-pink color.', category_name: 'Colors', level: 'Intermediate' },
  { name: 'Navy', definition: 'A dark blue color.', category_name: 'Colors', level: 'Intermediate' },

  # Colors - Advanced
  { name: 'Crimson', definition: 'A deep red color.', category_name: 'Colors', level: 'Advanced' },
  { name: 'Indigo', definition: 'A deep blue color.', category_name: 'Colors', level: 'Advanced' },
  { name: 'Turquoise', definition: 'A blue-green color.', category_name: 'Colors', level: 'Advanced' },
  { name: 'Chartreuse', definition: 'A color halfway between yellow and green.', category_name: 'Colors', level: 'Advanced' },
  { name: 'Amber', definition: 'A honey-yellow color.', category_name: 'Colors', level: 'Advanced' },
  { name: 'Coral', definition: 'A pinkish-orange color.', category_name: 'Colors', level: 'Advanced' },
  { name: 'Saffron', definition: 'A golden-yellow color.', category_name: 'Colors', level: 'Advanced' },
  { name: 'Cerulean', definition: 'A deep sky blue color.', category_name: 'Colors', level: 'Advanced' },
  { name: 'Ochre', definition: 'An earthy yellow or red color.', category_name: 'Colors', level: 'Advanced' },
  { name: 'Aubergine', definition: 'A dark purple color.', category_name: 'Colors', level: 'Advanced' },

  # Numbers
  # Numbers - Beginner
  { name: 'One', definition: 'The number after zero.', category_name: 'Numbers', level: 'Beginner' },
  { name: 'Two', definition: 'The number after one.', category_name: 'Numbers', level: 'Beginner' },
  { name: 'Three', definition: 'The number after two.', category_name: 'Numbers', level: 'Beginner' },
  { name: 'Four', definition: 'The number after three.', category_name: 'Numbers', level: 'Beginner' },
  { name: 'Five', definition: 'The number after four.', category_name: 'Numbers', level: 'Beginner' },
  { name: 'Six', definition: 'The number after five.', category_name: 'Numbers', level: 'Beginner' },
  { name: 'Seven', definition: 'The number after six.', category_name: 'Numbers', level: 'Beginner' },
  { name: 'Eight', definition: 'The number after seven.', category_name: 'Numbers', level: 'Beginner' },
  { name: 'Nine', definition: 'The number after eight.', category_name: 'Numbers', level: 'Beginner' },
  { name: 'Ten', definition: 'The number after nine.', category_name: 'Numbers', level: 'Beginner' },

  # Numbers - Intermediate
  { name: 'Eleven', definition: 'The product of five times two plus one.', category_name: 'Numbers', level: 'Intermediate' },
  { name: 'Twelve', definition: 'The number of months in a year.', category_name: 'Numbers', level: 'Intermediate' },
  { name: 'Thirteen', definition: 'The atomic number of aluminum.', category_name: 'Numbers', level: 'Intermediate' },
  { name: 'Fourteen', definition: 'The number of days in two weeks.', category_name: 'Numbers', level: 'Intermediate' },
  { name: 'Fifteen', definition: 'The number representing a quarter-hour.', category_name: 'Numbers', level: 'Intermediate' },
  { name: 'Sixteen', definition: 'A square number, 4 squared.', category_name: 'Numbers', level: 'Intermediate' },
  { name: 'Seventeen', definition: 'A prime number following sixteen.', category_name: 'Numbers', level: 'Intermediate' },
  { name: 'Eighteen', definition: 'The product of three times six.', category_name: 'Numbers', level: 'Intermediate' },
  { name: 'Nineteen', definition: 'A prime number following eighteen.', category_name: 'Numbers', level: 'Intermediate' },
  { name: 'Twenty', definition: 'The product of five times four.', category_name: 'Numbers', level: 'Intermediate' },

  # Numbers - Advanced
  { name: 'Twenty-One', definition: 'The number of spots on a standard six-sided die.', category_name: 'Numbers', level: 'Advanced' },
  { name: 'Twenty-Two', definition: 'The number of players on a soccer field during a match.', category_name: 'Numbers', level: 'Advanced' },
  { name: 'Thirty', definition: 'The number of degrees in each angle of an equilateral triangle.', category_name: 'Numbers', level: 'Advanced' },
  { name: 'Forty', definition: 'The number of weeks in a typical human pregnancy.', category_name: 'Numbers', level: 'Advanced' },
  { name: 'Fifty', definition: 'Half of one hundred.', category_name: 'Numbers', level: 'Advanced' },
  { name: 'Sixty', definition: 'The number of seconds in a minute.', category_name: 'Numbers', level: 'Advanced' },
  { name: 'Seventy', definition: 'The number of years in seven decades.', category_name: 'Numbers', level: 'Advanced' },
  { name: 'Eighty', definition: 'The number of minutes in one hour and twenty minutes.', category_name: 'Numbers', level: 'Advanced' },
  { name: 'Ninety', definition: 'The number of degrees in a right angle.', category_name: 'Numbers', level: 'Advanced' },
  { name: 'One Hundred', definition: 'A number representing a century.', category_name: 'Numbers', level: 'Advanced' },

  # Time
  # Time - Beginner
  { name: 'Clock', definition: 'A device used to measure time.', category_name: 'Time', level: 'Beginner' },
  { name: 'Watch', definition: 'A small timepiece worn typically on a strap on one\'s wrist.', category_name: 'Time', level: 'Beginner' },
  { name: 'Hour', definition: 'A period of time equal to a twenty-fourth part of a day and night.', category_name: 'Time', level: 'Beginner' },
  { name: 'Morning', definition: 'The early part of the day, from sunrise until noon.', category_name: 'Time', level: 'Beginner' },
  { name: 'Evening', definition: 'The later part of the day, from the end of the afternoon until night.', category_name: 'Time', level: 'Beginner' },
  { name: 'Night', definition: 'The period of time when it is dark outside, typically from sunset to sunrise.', category_name: 'Time', level: 'Beginner' },
  { name: 'Midnight', definition: 'Twelve o\'clock at night.', category_name: 'Time', level: 'Beginner' },
  

  # Time - Intermediate
  { name: 'Minute', definition: 'A period of time equal to sixty seconds or a sixtieth of an hour.', category_name: 'Time', level: 'Intermediate' },
  { name: 'Second', definition: 'A sixtieth of a minute of time.', category_name: 'Time', level: 'Intermediate' },
  { name: 'Day', definition: 'A period of twenty-four hours as a unit of time.', category_name: 'Time', level: 'Intermediate' },
  { name: 'Afternoon', definition: 'The period of time from noon until evening.', category_name: 'Time', level: 'Intermediate' },
  { name: 'Dawn', definition: 'The time of day when the sun begins to rise.', category_name: 'Time', level: 'Intermediate' },
  { name: 'Dusk', definition: 'The time of day when the sky is getting dark.', category_name: 'Time', level: 'Intermediate' },
  { name: 'Weekday', definition: 'Any day of the week except Saturday and Sunday.', category_name: 'Time', level: 'Intermediate' },
  { name: 'Weekend', definition: 'The period from Friday evening through Sunday evening, especially regarded as a time for leisure.', category_name: 'Time', level: 'Intermediate' },


  # Time - Advanced
  { name: 'Week', definition: 'A period of seven days.', category_name: 'Time', level: 'Advanced' },
  { name: 'Month', definition: 'Each of the twelve named periods into which a year is divided.', category_name: 'Time', level: 'Advanced' },
  { name: 'Year', definition: 'The time taken by the earth to make one revolution around the sun.', category_name: 'Time', level: 'Advanced' },
  { name: 'Century', definition: 'A period of one hundred years.', category_name: 'Time', level: 'Advanced' },
  { name: 'Millennium', definition: 'A period of one thousand years.', category_name: 'Time', level: 'Advanced' },
  { name: 'Era', definition: 'A long and distinct period of history with a particular feature or characteristic.', category_name: 'Time', level: 'Advanced' },
  { name: 'Decade', definition: 'A period of ten years.', category_name: 'Time', level: 'Advanced' },
  { name: 'Quarter', definition: 'Each of four equal or corresponding parts into which something is or can be divided.', category_name: 'Time', level: 'Advanced' },

  # Seasons & Weather
  # Seasons & Weather - Beginner
  { name: 'Spring', definition: 'The season after winter and before summer.', category_name: 'Seasons & Weather', level: 'Beginner' },
  { name: 'Summer', definition: 'The warmest season of the year.', category_name: 'Seasons & Weather', level: 'Beginner' },
  { name: 'Autumn', definition: 'The season after summer and before winter.', category_name: 'Seasons & Weather', level: 'Beginner' },
  { name: 'Fall', definition: 'The season after summer and before winter.', category_name: 'Seasons & Weather', level: 'Beginner' },
  { name: 'Snow', definition: 'Frozen water vapor falling in light white flakes.', category_name: 'Seasons & Weather', level: 'Beginner' },
  { name: 'Sunshine', definition: 'The light and warmth that come from the sun.', category_name: 'Seasons & Weather', level: 'Beginner' },
  { name: 'Rain', definition: 'Water that falls from clouds in drops.', category_name: 'Seasons & Weather', level: 'Beginner' },
  { name: 'Cloud', definition: 'A visible mass of condensed water vapor floating in the atmosphere.', category_name: 'Seasons & Weather', level: 'Beginner' },

  # Seasons & Weather - Intermediate
  { name: 'Winter', definition: 'The coldest season of the year.', category_name: 'Seasons & Weather', level: 'Intermediate' },
  { name: 'Equinox', definition: 'The time or date at which the sun crosses the celestial equator.', category_name: 'Seasons & Weather', level: 'Intermediate' },
  { name: 'Solstice', definition: 'Either of the two times in the year when the sun is at its greatest distance from the celestial equator.', category_name: 'Seasons & Weather', level: 'Intermediate' },
  { name: 'Humidity', definition: 'The amount of water vapor in the air.', category_name: 'Seasons & Weather', level: 'Intermediate' },
  { name: 'Temperature', definition: 'The degree of heat or cold in the air.', category_name: 'Seasons & Weather', level: 'Intermediate' },
  { name: 'Frost', definition: 'A thin layer of ice that forms on surfaces when it is very cold.', category_name: 'Seasons & Weather', level: 'Intermediate' },
  { name: 'Monsoon', definition: 'A seasonal wind that brings heavy rain.', category_name: 'Seasons & Weather', level: 'Intermediate' },
  { name: 'Breeze', definition: 'A gentle wind.', category_name: 'Seasons & Weather', level: 'Intermediate' },


  # Seasons & Weather - Advanced
  { name: 'Heatwave', definition: 'A prolonged period of abnormally hot weather.', category_name: 'Seasons & Weather', level: 'Advanced' },
  { name: 'Harvest', definition: 'The process or period of gathering in crops.', category_name: 'Seasons & Weather', level: 'Advanced' },
  { name: 'Precipitation', definition: 'Any form of water that falls from clouds, such as rain or snow.', category_name: 'Seasons & Weather', level: 'Advanced' },
  { name: 'Solstice', definition: 'The time when the sun is at its greatest distance from the equator, happening twice a year.', category_name: 'Seasons & Weather', level: 'Advanced' },


  # Food
  # Food - Beginner
  { name: 'Apple', definition: 'A round fruit with red or yellow skin and a firm white flesh.', category_name: 'Food', level: 'Beginner' },
  { name: 'Bread', definition: 'A food made of flour, water, and yeast mixed together and baked.', category_name: 'Food', level: 'Beginner' },
  { name: 'Cheese', definition: 'A food made from the pressed curds of milk.', category_name: 'Food', level: 'Beginner' },
  { name: 'Banana', definition: 'A long, curved fruit with a yellow skin.', category_name: 'Food', level: 'Beginner' },
  { name: 'Milk', definition: 'A white liquid produced by mammals, used as a drink or in cooking.', category_name: 'Food', level: 'Beginner' },
  { name: 'Egg', definition: 'A round or oval object laid by a female bird, reptile, fish, or invertebrate, usually containing a developing embryo.', category_name: 'Food', level: 'Beginner' },
  { name: 'Carrot', definition: 'A long, thin orange vegetable that grows underground.', category_name: 'Food', level: 'Beginner' },
  { name: 'Rice', definition: 'A small white or brown grain that is a staple food in many countries.', category_name: 'Food', level: 'Beginner' },
  { name: 'Tomato', definition: 'A glossy red or yellow edible fruit that is typically eaten as a vegetable or in salad.', category_name: 'Food', level: 'Beginner' },
  { name: 'Potato', definition: 'A starchy plant tuber that is one of the most important food crops, cooked and eaten as a vegetable.', category_name: 'Food', level: 'Beginner' },
  { name: 'Fish', definition: 'A cold-blooded vertebrate animal that lives in water and has gills, fins, and scales.', category_name: 'Food', level: 'Beginner' },
  { name: 'Bell Pepper', definition: 'A large, mild pepper that can be green, red, yellow, or orange.', category_name: 'Food', level: 'Beginner' },
  { name: 'Berries', definition: 'Small, juicy fruits with seeds, such as strawberries, blueberries, and raspberries.', category_name: 'Food', level: 'Beginner' },
  { name: 'Celery', definition: 'A crunchy, green vegetable with long, fibrous stalks.', category_name: 'Food', level: 'Beginner' },
  { name: 'Cucumber', definition: 'A long, green vegetable with a crisp, watery flesh.', category_name: 'Food', level: 'Beginner' },
  { name: 'Garlic', definition: 'A strong-smelling bulb used as a flavoring in cooking.', category_name: 'Food', level: 'Beginner' },
  { name: 'Ginger', definition: 'A spicy root used in cooking and baking.', category_name: 'Food', level: 'Beginner' },
  { name: 'Lemon', definition: 'A yellow citrus fruit with a sour taste.', category_name: 'Food', level: 'Beginner' },
  { name: 'Lime', definition: 'A small, green citrus fruit with a sour taste.', category_name: 'Food', level: 'Beginner' },
  { name: 'Onion', definition: 'A vegetable with a strong smell and taste, made up of several layers.', category_name: 'Food', level: 'Beginner' },
  { name: 'Pear', definition: 'A sweet fruit with a round bottom and a narrow top.', category_name: 'Food', level: 'Beginner' },
  { name: 'Zucchini', definition: 'A green summer squash with a mild flavor.', category_name: 'Food', level: 'Beginner' },
  { name: 'Coffee', definition: 'A beverage made from roasted coffee beans.', category_name: 'Food', level: 'Beginner' },
  { name: 'Tea', definition: 'A beverage made by steeping herbal leaves in hot water.', category_name: 'Food', level: 'Beginner' },
  { name: 'Butter', definition: 'A solid dairy product made by churning cream.', category_name: 'Food', level: 'Beginner' },
  
  
  
  # Food - Intermediate
  { name: 'Beets', definition: 'A round root vegetable with dark red skin and sweet flesh.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Blueberry', definition: 'A small, round, dark blue fruit that grows on bushes.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Asparagus', definition: 'A green vegetable with long, thin stems and a pointed tip.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Strawberry', definition: 'A sweet, red fruit with tiny seeds on its surface.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Sweet Potato', definition: 'A root vegetable with a sweet, orange flesh.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Pasta', definition: 'A dish originally from Italy consisting of dough made from durum wheat and water, extruded or stamped into various shapes and typically cooked in boiling water.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Pizza', definition: 'A dish of Italian origin consisting of a flat, round base of dough baked with a topping of tomatoes and cheese, typically with added meat or vegetables.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Salad', definition: 'A cold dish of various mixtures of raw or cooked vegetables, usually seasoned with oil, vinegar, or other dressing.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Avocado', definition: 'A green, pear-shaped fruit with a large pit and creamy flesh.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Mushroom', definition: 'A type of fungus with a cap on a stem, some of which are edible.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Broccoli', definition: 'A green vegetable with a thick stem and a dense cluster of flower buds.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Chicken', definition: 'Meat from a domesticated bird often raised for eggs and meat.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Yogurt', definition: 'A thick, creamy food made from milk soured by the addition of bacteria.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Ketchup', definition: 'A sweet and tangy sauce made from tomatoes, vinegar, sugar, and spices.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Mustard', definition: 'A condiment made from the seeds of a mustard plant, typically yellow or brown.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Olive Oil', definition: 'A liquid fat obtained from olives, used in cooking and dressings.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Peanut Butter', definition: 'A spread made from ground, dry-roasted peanuts.', category_name: 'Food', level: 'Intermediate' },
  { name: 'Rice', definition: 'A small white or brown grain that is a staple food in many countries.', category_name: 'Food', level: 'Intermediate' },


  # Food - Advanced
  { name: 'Sushi', definition: 'A Japanese dish consisting of small balls or rolls of vinegar-flavored cold rice served with a garnish of vegetables, egg, or raw seafood.', category_name: 'Food', level: 'Advanced' },
  { name: 'Steak', definition: 'High-quality beef taken from the hindquarters of the animal, typically cut into thick slices that are cooked by grilling or frying.', category_name: 'Food', level: 'Advanced' },
  { name: 'Taco', definition: 'A Mexican dish consisting of a folded or rolled tortilla filled with various mixtures, such as seasoned meat, beans, lettuce, and tomatoes.', category_name: 'Food', level: 'Advanced' },
  { name: 'Prosciutto', definition: 'An Italian dry-cured ham that is thinly sliced and served uncooked.', category_name: 'Food', level: 'Advanced' },
  { name: 'Chutney', definition: 'A spicy condiment made of fruits or vegetables with vinegar, spices, and sugar.', category_name: 'Food', level: 'Advanced' },
  { name: 'Tiramisu', definition: 'An Italian dessert made with layers of sponge cake soaked in coffee and brandy or liqueur, with powdered chocolate and mascarpone cheese.', category_name: 'Food', level: 'Advanced' },
  { name: 'Fennel Bulb', definition: 'A vegetable with a crunchy texture and a flavor similar to licorice.', category_name: 'Food', level: 'Advanced' },
  { name: 'Parsley', definition: 'A green herb often used as a garnish or seasoning.', category_name: 'Food', level: 'Advanced' },
  { name: 'Rosemary', definition: 'A fragrant herb with needle-like leaves, used in cooking.', category_name: 'Food', level: 'Advanced' },
  { name: 'Olives', definition: 'Small, oval fruits that are usually pickled or used to make olive oil.', category_name: 'Food', level: 'Advanced' },
  { name: 'Soy Sauce', definition: 'A dark, salty sauce made from fermented soybeans.', category_name: 'Food', level: 'Advanced' },
  { name: 'Vinegar', definition: 'A sour liquid made by fermenting ethanol, used in cooking and pickling.', category_name: 'Food', level: 'Advanced' },
  { name: 'Tahini', definition: 'A paste made from ground sesame seeds, used in Middle Eastern cuisine.', category_name: 'Food', level: 'Advanced' },
  { name: 'Quinoa', definition: 'A high-protein grain from the Andean region, used as a food staple.', category_name: 'Food', level: 'Advanced' },


  # Travel
  # Travel - Beginner
  { name: 'Airport', definition: 'A complex of runways and buildings for the takeoff, landing, and maintenance of civil aircraft, with facilities for passengers.', category_name: 'Travel', level: 'Beginner' },
  { name: 'Hotel', definition: 'An establishment providing accommodation, meals, and other services for travelers and tourists.', category_name: 'Travel', level: 'Beginner' },
  { name: 'Passport', definition: 'An official document issued by a government, certifying the holder\'s identity and citizenship and entitling them to travel under its protection to and from foreign countries.', category_name: 'Travel', level: 'Beginner' },
  { name: 'Bus', definition: 'A large motor vehicle carrying passengers by road.', category_name: 'Travel', level: 'Beginner' },
  { name: 'Car', definition: 'A road vehicle, typically with four wheels, powered by an internal combustion engine.', category_name: 'Travel', level: 'Beginner' },
  { name: 'Train', definition: 'A series of connected vehicles that run on tracks and are used as a form of transportation.', category_name: 'Travel', level: 'Beginner' },
  { name: 'Plane', definition: 'An aircraft that has a fixed wing and is powered by propellers or jets.', category_name: 'Travel', level: 'Beginner' },
  { name: 'Map', definition: 'A diagrammatic representation of an area of land or sea showing physical features.', category_name: 'Travel', level: 'Beginner' },
  { name: 'Luggage', definition: 'Suitcases or other bags in which to pack personal belongings for traveling.', category_name: 'Travel', level: 'Beginner' },
  { name: 'Taxi', definition: 'A car licensed to transport passengers in return for payment of a fare.', category_name: 'Travel', level: 'Beginner' },
  { name: 'Subway', definition: 'An underground electric railway system in a city.', category_name: 'Travel', level: 'Beginner' },
  { name: 'Bicycle', definition: 'A vehicle composed of two wheels held in a frame one behind the other, propelled by pedals and steered with handlebars attached to the front wheel.', category_name: 'Travel', level: 'Beginner' },
  { name: 'Motorcycle', definition: 'A two-wheeled vehicle that is powered by a motor and has no pedals.', category_name: 'Travel', level: 'Beginner' },
  { name: 'Cruise', definition: 'A vacation spent on a ship or boat.', category_name: 'Travel', level: 'Beginner' },

  # Travel - Intermediate
  { name: 'Tour', definition: 'A journey for pleasure in which several different places are visited.', category_name: 'Travel', level: 'Intermediate' },
  { name: 'Journey', definition: 'An act of traveling from one place to another.', category_name: 'Travel', level: 'Intermediate' },
  { name: 'Adventure', definition: 'An unusual and exciting, typically hazardous, experience or activity.', category_name: 'Travel', level: 'Intermediate' },
  { name: 'Backpack', definition: 'A bag carried on one\'s back, typically with two shoulder straps.', category_name: 'Travel', level: 'Intermediate' },
  { name: 'Reservation', definition: 'The action of reserving something, such as a seat on a plane or a room in a hotel.', category_name: 'Travel', level: 'Intermediate' },
  { name: 'Itinerary', definition: 'A planned route or journey.', category_name: 'Travel', level: 'Intermediate' },
  { name: 'Tourist', definition: 'A person who is traveling or visiting a place for pleasure.', category_name: 'Travel', level: 'Intermediate' },
  { name: 'Souvenir', definition: 'A thing that is kept as a reminder of a person, place, or event.', category_name: 'Travel', level: 'Intermediate' },


  # Travel - Advanced
  { name: 'Excursion', definition: 'A short journey or trip, especially one engaged in as a leisure activity.', category_name: 'Travel', level: 'Advanced' },
  { name: 'Expedition', definition: 'A journey undertaken by a group of people with a particular purpose, especially that of exploration, research, or war.', category_name: 'Travel', level: 'Advanced' },
  { name: 'Voyage', definition: 'A long journey involving travel by sea or in space.', category_name: 'Travel', level: 'Advanced' },
  { name: 'Customs', definition: 'The place at an airport, border, etc., where government officials check people and goods entering a country.', category_name: 'Travel', level: 'Advanced' },
  { name: 'Embassy', definition: 'The official residence or offices of an ambassador.', category_name: 'Travel', level: 'Advanced' },
  { name: 'Transit', definition: 'The carrying of people, goods, or materials from one place to another.', category_name: 'Travel', level: 'Advanced' },


  # Home
  # Home - Beginner
  { name: 'House', definition: 'A building for human habitation, especially one that is lived in by a family or small group of people.', category_name: 'Home', level: 'Beginner' },
  { name: 'Kitchen', definition: 'A room or area where food is prepared and cooked.', category_name: 'Home', level: 'Beginner' },
  { name: 'Bedroom', definition: 'A room for sleeping in.', category_name: 'Home', level: 'Beginner' },
  { name: 'Chair', definition: 'A piece of furniture for one person to sit on.', category_name: 'Home', level: 'Beginner' },
  { name: 'Table', definition: 'A piece of furniture with a flat top and one or more legs.', category_name: 'Home', level: 'Beginner' },
  { name: 'Bed', definition: 'A piece of furniture for sleeping on.', category_name: 'Home', level: 'Beginner' },
  { name: 'Lamp', definition: 'A device for giving light.', category_name: 'Home', level: 'Beginner' },
  { name: 'Window', definition: 'An opening in a wall or door that usually contains a sheet of glass.', category_name: 'Home', level: 'Beginner' },


  # Home - Intermediate
  { name: 'Bathroom', definition: 'A room containing a bathtub or shower and usually also a washbasin and a toilet.', category_name: 'Home', level: 'Intermediate' },
  { name: 'Living Room', definition: 'A room in a house for general and informal everyday use.', category_name: 'Home', level: 'Intermediate' },
  { name: 'Garden', definition: 'A piece of ground, often near a house, used for growing flowers, fruit, or vegetables.', category_name: 'Home', level: 'Intermediate' },
  { name: 'Couch', definition: 'A long upholstered piece of furniture for several people to sit on.', category_name: 'Home', level: 'Intermediate' },
  { name: 'Bookshelf', definition: 'A piece of furniture with shelves for storing books.', category_name: 'Home', level: 'Intermediate' },
  { name: 'Closet', definition: 'A small room or space for storing clothes.', category_name: 'Home', level: 'Intermediate' },
  { name: 'Curtains', definition: 'Pieces of cloth that hang down from above a window and can be pulled together to cover the window.', category_name: 'Home', level: 'Intermediate' },
  { name: 'Microwave', definition: 'A kitchen appliance used for heating food quickly.', category_name: 'Home', level: 'Intermediate' },


  # Home - Advanced
  { name: 'Garage', definition: 'A building for housing a motor vehicle or vehicles.', category_name: 'Home', level: 'Advanced' },
  { name: 'Basement', definition: 'The floor of a building which is partly or entirely below ground level.', category_name: 'Home', level: 'Advanced' },
  { name: 'Attic', definition: 'A space or room just below the roof of a building.', category_name: 'Home', level: 'Advanced' },
  { name: 'Chandelier', definition: 'A decorative hanging light with branches for several light bulbs or candles.', category_name: 'Home', level: 'Advanced' },
  { name: 'Dishwasher', definition: 'A machine for washing dishes automatically.', category_name: 'Home', level: 'Advanced' },
  { name: 'Air Conditioner', definition: 'A system for controlling the humidity, ventilation, and temperature in a building.', category_name: 'Home', level: 'Advanced' },
  { name: 'Refrigerator', definition: 'An appliance for keeping food and drinks cold.', category_name: 'Home', level: 'Advanced' },
  { name: 'Fireplace', definition: 'A structure made of brick, stone, or metal designed to contain a fire.', category_name: 'Home', level: 'Advanced' },


  # Animals
  { name: 'Dog', definition: 'A domesticated carnivorous mammal that typically has a long snout, an acute sense of smell, non-retractable claws, and a barking, howling, or whining voice.', category_name: 'Animals', level: 'Beginner' },
  { name: 'Cat', definition: 'A small domesticated carnivorous mammal with soft fur, a short snout, and retractile claws.', category_name: 'Animals', level: 'Beginner' },
  { name: 'Bird', definition: 'A warm-blooded egg-laying vertebrate distinguished by the possession of feathers, wings, and a beak and (typically) by being able to fly.', category_name: 'Animals', level: 'Beginner' },
  { name: 'Fish', definition: 'A limbless cold-blooded vertebrate animal with gills and fins and living wholly in water.', category_name: 'Animals', level: 'Beginner' },
  { name: 'Rabbit', definition: 'A burrowing, gregarious, plant-eating mammal with long ears, long hind legs, and a short tail.', category_name: 'Animals', level: 'Beginner' },
  { name: 'Horse', definition: 'A large plant-eating domesticated mammal with solid hoofs and a flowing mane and tail, used for riding, racing, and to carry and pull loads.', category_name: 'Animals', level: 'Beginner' },
  
  # Animals - Intermediate
  { name: 'Elephant', definition: 'A large mammal with a trunk, native to Africa and southern Asia.', category_name: 'Animals', level: 'Intermediate' },
  { name: 'Giraffe', definition: 'An African mammal with a very long neck and forelegs, having a coat patterned with brown patches separated by lighter lines. It is the tallest living animal.', category_name: 'Animals', level: 'Intermediate' },
  { name: 'Dolphin', definition: 'A small gregarious toothed whale that typically has a beaklike snout and a curved fin on the back.', category_name: 'Animals', level: 'Intermediate' },

  # Animals - Advanced
  { name: 'Penguin', definition: 'A large flightless seabird of the southern hemisphere, with black upper parts and white underparts and wings developed into flippers for swimming underwater.', category_name: 'Animals', level: 'Advanced' },
  { name: 'Kangaroo', definition: 'A large plant-eating marsupial with a long powerful tail and strongly developed hind limbs that enable it to travel by leaping, found only in Australia and New Guinea.', category_name: 'Animals', level: 'Advanced' },
  { name: 'Panda', definition: 'A large bearlike mammal with characteristic black and white markings, native to certain mountain forests in China. It feeds almost entirely on bamboo and has become increasingly rare.', category_name: 'Animals', level: 'Advanced' },

  # Clothing
  # Clothing - Beginner
  { name: 'Shirt', definition: 'A cloth garment for the upper body.', category_name: 'Clothing', level: 'Beginner' },
  { name: 'Pants', definition: 'A piece of clothing worn on the lower half of the body.', category_name: 'Clothing', level: 'Beginner' },
  { name: 'T-shirt', definition: 'A short-sleeved casual top.', category_name: 'Clothing', level: 'Beginner' },
  { name: 'Shoes', definition: 'A covering for the foot, typically made of leather, having a sturdy sole and not reaching above the ankle.', category_name: 'Clothing', level: 'Beginner' },
  { name: 'Hat', definition: 'A head covering that can be made of various materials and worn for warmth, fashion, or protection.', category_name: 'Clothing', level: 'Beginner' },
  { name: 'Skirt', definition: 'A woman’s outer garment fastened around the waist and hanging down around the legs.', category_name: 'Clothing', level: 'Beginner' },
  { name: 'Jacket', definition: 'A garment for the upper body, typically having a front opening, collar, lapels, sleeves, and pockets.', category_name: 'Clothing', level: 'Beginner' },
  { name: 'Socks', definition: 'A soft covering for the foot, usually made of wool, cotton, or nylon.', category_name: 'Clothing', level: 'Beginner' },
  { name: 'Shorts', definition: 'Short trousers that reach only to the knees or thighs.', category_name: 'Clothing', level: 'Beginner' },
  { name: 'Dress', definition: 'A one-piece garment for a woman or girl that covers the body and extends down over the legs.', category_name: 'Clothing', level: 'Beginner' },
  { name: 'Belt', definition: 'A strip of leather or other material worn around the waist to support or hold in clothes.', category_name: 'Clothing', level: 'Beginner' },
  { name: 'Cap', definition: 'A soft, flat hat without a brim and typically with a peak.', category_name: 'Clothing', level: 'Beginner' },


  # Clothing - Intermediate
  { name: 'Dress', definition: 'A one-piece garment for a woman or girl.', category_name: 'Clothing', level: 'Intermediate' },
  { name: 'Blazer', definition: 'A lightweight jacket, typically in a solid color.', category_name: 'Clothing', level: 'Intermediate' },
  { name: 'Blouse', definition: 'A woman’s loose upper garment resembling a shirt, typically with a collar, buttons, and sleeves.', category_name: 'Clothing', level: 'Intermediate' },
  { name: 'Sweater', definition: 'A knitted garment typically with long sleeves, worn over the upper body.', category_name: 'Clothing', level: 'Intermediate' },
  { name: 'Jeans', definition: 'Denim pants that are typically blue in color.', category_name: 'Clothing', level: 'Intermediate' },
  { name: 'Scarf', definition: 'A length or square of fabric worn around the neck or head.', category_name: 'Clothing', level: 'Intermediate' },
  { name: 'Gloves', definition: 'Hand coverings with separate sections for each finger and the thumb.', category_name: 'Clothing', level: 'Intermediate' },
  { name: 'Vest', definition: 'A sleeveless garment worn on the upper body, often under a jacket.', category_name: 'Clothing', level: 'Intermediate' },
  { name: 'Sandals', definition: 'A light shoe with straps that go over the top of the foot and around the ankle.', category_name: 'Clothing', level: 'Intermediate' },
  { name: 'Tie', definition: 'A piece of cloth worn around the neck, usually under the collar of a shirt, and tied in a knot at the front.', category_name: 'Clothing', level: 'Intermediate' },
  { name: 'Overcoat', definition: 'A long warm coat worn over other clothing.', category_name: 'Clothing', level: 'Intermediate' },
  { name: 'Hoodie', definition: 'A sweatshirt with a hood.', category_name: 'Clothing', level: 'Intermediate' },


  # Clothing - Advanced
  { name: 'Tuxedo', definition: 'A formal evening suit.', category_name: 'Clothing', level: 'Advanced' },
  { name: 'Blazer', definition: 'A lightweight jacket, typically in a solid color, worn as part of a uniform or as smart casual wear.', category_name: 'Clothing', level: 'Advanced' },
  { name: 'Cardigan', definition: 'A knitted sweater that opens at the front.', category_name: 'Clothing', level: 'Advanced' },
  { name: 'Trench Coat', definition: 'A long coat typically made of waterproof heavy-duty cotton gabardine drill, leather, or poplin.', category_name: 'Clothing', level: 'Advanced' },
  { name: 'Loafers', definition: 'A type of shoe that is easy to slip on and off, often worn for informal occasions.', category_name: 'Clothing', level: 'Advanced' },
  { name: 'Cummerbund', definition: 'A broad waist sash, usually pleated, worn with a tuxedo or dinner jacket.', category_name: 'Clothing', level: 'Advanced' },


  # Fashion
  # Fashion - Beginner
  { name: 'Runway', definition: 'A narrow, usually flat surface where models walk to display clothing.', category_name: 'Fashion', level: 'Beginner' },
  { name: 'Model', definition: 'A person employed to display clothes by wearing them.', category_name: 'Fashion', level: 'Beginner' },

  # Fashion - Intermediate
  { name: 'Couture', definition: 'The design and manufacture of fashionable clothes to a client\'s specific requirements.', category_name: 'Fashion', level: 'Intermediate' },
  { name: 'Trend', definition: 'A general direction in which something is developing or changing.', category_name: 'Fashion', level: 'Intermediate' },

  # Fashion - Advanced
  { name: 'Haute Couture', definition: 'High-end fashion that is constructed by hand from start to finish.', category_name: 'Fashion', level: 'Advanced' },
  { name: 'Avant-garde', definition: 'New and unusual or experimental ideas, especially in the arts.', category_name: 'Fashion', level: 'Advanced' },

  # Work
  # Work - Beginner
  { name: 'Office', definition: 'A room, set of rooms, or building used as a place for commercial, professional, or bureaucratic work.', category_name: 'Work', level: 'Beginner' },
  { name: 'Desk', definition: 'A piece of furniture with a flat top for writing or working.', category_name: 'Work', level: 'Beginner' },
  { name: 'Computer', definition: 'An electronic device for storing and processing data.', category_name: 'Work', level: 'Beginner' },
  { name: 'Pen', definition: 'A writing instrument using ink.', category_name: 'Work', level: 'Beginner' },
  { name: 'Paper', definition: 'Material for writing or printing on.', category_name: 'Work', level: 'Beginner' },
  { name: 'Chair', definition: 'A piece of furniture for sitting.', category_name: 'Work', level: 'Beginner' },
  { name: 'Email', definition: 'A system for sending messages electronically, especially from one computer to another.', category_name: 'Work', level: 'Beginner' },
  { name: 'Boss', definition: 'A person in charge of a worker or organization.', category_name: 'Work', level: 'Beginner' },
  { name: 'Job', definition: 'A paid position of regular employment.', category_name: 'Work', level: 'Beginner' },
  { name: 'Task', definition: 'A piece of work to be done.', category_name: 'Work', level: 'Beginner' },

  # Work - Intermediate
  { name: 'Manager', definition: 'A person responsible for controlling or administering an organization or group of staff.', category_name: 'Work', level: 'Intermediate' },
  { name: 'Team', definition: 'A group of people with a full set of complementary skills required to complete a task, job, or project.', category_name: 'Work', level: 'Intermediate' },
  { name: 'Meeting', definition: 'An assembly of people for discussion.', category_name: 'Work', level: 'Intermediate' },
  { name: 'Deadline', definition: 'The latest time or date by which something should be completed.', category_name: 'Work', level: 'Intermediate' },
  { name: 'Report', definition: 'A detailed account of something.', category_name: 'Work', level: 'Intermediate' },
  { name: 'Schedule', definition: 'A plan that lists the times and dates when tasks will be done.', category_name: 'Work', level: 'Intermediate' },
  { name: 'Team', definition: 'A group of people working together.', category_name: 'Work', level: 'Intermediate' },
  { name: 'Client', definition: 'A person or organization using the services of a professional person or company.', category_name: 'Work', level: 'Intermediate' },
  { name: 'Document', definition: 'A piece of written, printed, or electronic matter that provides information.', category_name: 'Work', level: 'Intermediate' },
  
  # Work - Advanced
  { name: 'Presentation', definition: 'A talk or display to explain something.', category_name: 'Work', level: 'Advanced' },
  { name: 'Conference', definition: 'A formal meeting for discussion.', category_name: 'Work', level: 'Advanced' },
  { name: 'Strategy', definition: 'A plan of action designed to achieve a long-term or overall aim.', category_name: 'Work', level: 'Advanced' },
  { name: 'Innovation', definition: 'The act of introducing something new.', category_name: 'Work', level: 'Advanced' },
  { name: 'Strategy', definition: 'A plan of action to achieve a long-term goal.', category_name: 'Work', level: 'Advanced' },
  { name: 'Negotiation', definition: 'Discussion aimed at reaching an agreement.', category_name: 'Work', level: 'Advanced' },
  { name: 'Entrepreneur', definition: 'A person who starts and runs a business.', category_name: 'Work', level: 'Advanced' },
  { name: 'Consultant', definition: 'A person who provides expert advice professionally.', category_name: 'Work', level: 'Advanced' },
  { name: 'Leadership', definition: 'The action of leading a group of people or an organization.', category_name: 'Work', level: 'Advanced' },

  # Education
  # Education - Beginner
  { name: 'School', definition: 'A place where children go to learn.', category_name: 'Education', level: 'Beginner' },
  { name: 'Teacher', definition: 'A person who helps students to learn.', category_name: 'Education', level: 'Beginner' },
  { name: 'Student', definition: 'A person who is studying at a school or college.', category_name: 'Education', level: 'Beginner' },
  { name: 'Classroom', definition: 'A room where teaching and learning take place.', category_name: 'Education', level: 'Beginner' },
  { name: 'Homework', definition: 'Work that a student is given to do at home.', category_name: 'Education', level: 'Beginner' },
  { name: 'Book', definition: 'A set of written or printed pages, usually bound with a protective cover.', category_name: 'Education', level: 'Beginner' },
  { name: 'Pen', definition: 'A writing instrument using ink.', category_name: 'Education', level: 'Beginner' },
  { name: 'Desk', definition: 'A piece of furniture with a flat top for writing or working.', category_name: 'Education', level: 'Beginner' },
  { name: 'Notebook', definition: 'A small book with blank or ruled pages for writing notes.', category_name: 'Education', level: 'Beginner' },
  { name: 'Pencil', definition: 'A writing instrument made of wood with a graphite center.', category_name: 'Education', level: 'Beginner' },
  { name: 'Eraser', definition: 'A piece of rubber used to remove pencil marks from paper.', category_name: 'Education', level: 'Beginner' },
  { name: 'Ruler', definition: 'A tool used to measure length and draw straight lines.', category_name: 'Education', level: 'Beginner' },
  { name: 'Backpack', definition: 'A bag carried on one’s back, typically with two shoulder straps.', category_name: 'Education', level: 'Beginner' },
  { name: 'Library', definition: 'A place where books, magazines, and other materials are available for people to use or borrow.', category_name: 'Education', level: 'Beginner' },
  { name: 'Blackboard', definition: 'A large board with a smooth, dark surface used for writing on with chalk.', category_name: 'Education', level: 'Beginner' },

  # Education - Intermediate
  { name: 'Curriculum', definition: 'The subjects comprising a course of study in a school or college.', category_name: 'Education', level: 'Intermediate' },
  { name: 'Lecture', definition: 'An educational talk to an audience, especially to students in a university or college.', category_name: 'Education', level: 'Intermediate' },
  { name: 'Exam', definition: 'A formal test of a person’s knowledge or proficiency in a subject or skill.', category_name: 'Education', level: 'Intermediate' },
  { name: 'Semester', definition: 'Half of a school year.', category_name: 'Education', level: 'Intermediate' },
  { name: 'Textbook', definition: 'A book used as a standard work for the study of a particular subject.', category_name: 'Education', level: 'Intermediate' },

  # Education - Advanced
  { name: 'Pedagogy', definition: 'The method and practice of teaching, especially as an academic subject or theoretical concept.', category_name: 'Education', level: 'Advanced' },
  { name: 'Thesis', definition: 'A statement or theory that is put forward as a premise to be maintained or proved.', category_name: 'Education', level: 'Advanced' },
  { name: 'Dissertation', definition: 'A long essay on a particular subject, especially one written for a university degree or diploma.', category_name: 'Education', level: 'Advanced' },
  { name: 'Syllabus', definition: 'An outline of the subjects in a course of study or teaching.', category_name: 'Education', level: 'Advanced' },
  { name: 'Research', definition: 'The systematic investigation into and study of materials and sources in order to establish facts and reach new conclusions.', category_name: 'Education', level: 'Advanced' },

  # Emotions
  # Emotions - Beginner
  { name: 'Happy', definition: 'Feeling or showing pleasure or contentment.', category_name: 'Emotions', level: 'Beginner' },
  { name: 'Sad', definition: 'Feeling or showing sorrow; unhappy.', category_name: 'Emotions', level: 'Beginner' },
  { name: 'Angry', definition: 'Feeling or showing strong annoyance, displeasure, or hostility.', category_name: 'Emotions', level: 'Beginner' },
  { name: 'Afraid', definition: 'Feeling fear or anxiety; frightened.', category_name: 'Emotions', level: 'Beginner' },
  { name: 'Surprised', definition: 'Feeling or showing surprise because something unexpected happened.', category_name: 'Emotions', level: 'Beginner' },

  # Emotions - Intermediate
  { name: 'Fear', definition: 'An unpleasant emotion caused by the belief that someone or something is dangerous, likely to cause pain, or a threat.', category_name: 'Emotions', level: 'Intermediate' },
  { name: 'Excited', definition: 'Very enthusiastic and eager.', category_name: 'Emotions', level: 'Intermediate' },
  { name: 'Nervous', definition: 'Easily agitated or alarmed; tending to be anxious.', category_name: 'Emotions', level: 'Intermediate' },
  { name: 'Confused', definition: 'Unable to think clearly or to understand what is happening or what somebody is saying.', category_name: 'Emotions', level: 'Intermediate' },
  { name: 'Jealous', definition: 'Feeling or showing an envious resentment of someone or their achievements, possessions, or perceived advantages.', category_name: 'Emotions', level: 'Intermediate' },
  { name: 'Proud', definition: 'Feeling deep pleasure or satisfaction as a result of one\'s own achievements, qualities, or possessions.', category_name: 'Emotions', level: 'Intermediate' },

  # Emotions - Advanced
  { name: 'Ecstatic', definition: 'Feeling or expressing overwhelming happiness or joyful excitement.', category_name: 'Emotions', level: 'Advanced' },
  { name: 'Melancholy', definition: 'A feeling of pensive sadness, typically with no obvious cause.', category_name: 'Emotions', level: 'Advanced' },
  { name: 'Frustrated', definition: 'Feeling or expressing distress and annoyance resulting from an inability to change or achieve something.', category_name: 'Emotions', level: 'Advanced' },
  { name: 'Content', definition: 'In a state of peaceful happiness.', category_name: 'Emotions', level: 'Advanced' },
  { name: 'Anxious', definition: 'Experiencing worry, unease, or nervousness, typically about an imminent event or something with an uncertain outcome.', category_name: 'Emotions', level: 'Advanced' },

  # Nature
  # Nature - Beginner
  { name: 'Tree', definition: 'A woody perennial plant, typically having a single stem or trunk growing to a considerable height and bearing lateral branches at some distance from the ground.', category_name: 'Nature', level: 'Beginner' },
  { name: 'River', definition: 'A large natural stream of water flowing in a channel to the sea, a lake, or another such stream.', category_name: 'Nature', level: 'Beginner' },
  { name: 'Flower', definition: 'The seed-bearing part of a plant, typically surrounded by brightly colored petals.', category_name: 'Nature', level: 'Beginner' },
  { name: 'Leaf', definition: 'A flattened structure of a higher plant, typically green and blade-like, that is attached to a stem.', category_name: 'Nature', level: 'Beginner' },
  { name: 'Grass', definition: 'Plants with narrow green leaves, commonly found on lawns and in fields.', category_name: 'Nature', level: 'Beginner' },
  { name: 'Rock', definition: 'A solid mineral material forming part of the surface of the earth and other similar planets.', category_name: 'Nature', level: 'Beginner' },
  { name: 'Sky', definition: 'The region of the atmosphere and outer space seen from the earth.', category_name: 'Nature', level: 'Beginner' },

  # Nature - Intermediate
  { name: 'Mountain', definition: 'A large natural elevation of the earth\'s surface rising abruptly from the surrounding level; a large steep hill.', category_name: 'Nature', level: 'Intermediate' },
  { name: 'Forest', definition: 'A large area covered chiefly with trees and undergrowth.', category_name: 'Nature', level: 'Intermediate' },
  { name: 'River', definition: 'A large natural stream of water flowing in a channel to the sea, a lake, or another river.', category_name: 'Nature', level: 'Intermediate' },
  { name: 'Hill', definition: 'A naturally raised area of land, not as high or craggy as a mountain.', category_name: 'Nature', level: 'Intermediate' },
  { name: 'Ocean', definition: 'A very large expanse of sea.', category_name: 'Nature', level: 'Intermediate' },
  { name: 'Desert', definition: 'A barren area of landscape where little precipitation occurs and consequently living conditions are hostile for plant and animal life.', category_name: 'Nature', level: 'Intermediate' },

  # Nature - Advanced
  { name: 'Ecosystem', definition: 'A biological community of interacting organisms and their physical environment.', category_name: 'Nature', level: 'Advanced' },
  { name: 'Biodiversity', definition: 'The variety of life in the world or in a particular habitat or ecosystem.', category_name: 'Nature', level: 'Advanced' },
  { name: 'Glacier', definition: 'A slowly moving mass or river of ice formed by the accumulation and compaction of snow on mountains or near the poles.', category_name: 'Nature', level: 'Advanced' },
  { name: 'Savannah', definition: 'A grassy plain in tropical and subtropical regions, with few trees.', category_name: 'Nature', level: 'Advanced' },
  { name: 'Tundra', definition: 'A vast, flat, treeless Arctic region in which the subsoil is permanently frozen.', category_name: 'Nature', level: 'Advanced' },


  # Health
  # Health - Beginner
  { name: 'Doctor', definition: 'A person who is qualified to treat people who are ill.', category_name: 'Health', level: 'Beginner' },
  { name: 'Hospital', definition: 'A place where people who are ill or injured are treated and taken care of.', category_name: 'Health', level: 'Beginner' },
  { name: 'Medicine', definition: 'A substance used to treat illness or injury.', category_name: 'Health', level: 'Beginner' },
  { name: 'Bandage', definition: 'A strip of material used to bind a wound or to protect an injured part of the body.', category_name: 'Health', level: 'Beginner' },
  { name: 'Exercise', definition: 'Physical activity that is done to become stronger and healthier.', category_name: 'Health', level: 'Beginner' },
  
  # Health - Intermediate
  { name: 'Vaccine', definition: 'A substance used to stimulate the production of antibodies and provide immunity against diseases.', category_name: 'Health', level: 'Intermediate' },
  { name: 'Therapy', definition: 'Treatment intended to relieve or heal a disorder.', category_name: 'Health', level: 'Intermediate' },
  { name: 'Nutrition', definition: 'The process of providing or obtaining the food necessary for health and growth.', category_name: 'Health', level: 'Intermediate' },
  { name: 'Allergy', definition: 'A damaging immune response by the body to a substance, especially pollen, fur, a particular food, or dust.', category_name: 'Health', level: 'Intermediate' },
  { name: 'Symptom', definition: 'A physical or mental feature that is regarded as indicating a condition of disease.', category_name: 'Health', level: 'Intermediate' },

  # Health - Advanced
  { name: 'Cardiology', definition: 'The branch of medicine that deals with diseases and abnormalities of the heart.', category_name: 'Health', level: 'Advanced' },
  { name: 'Oncology', definition: 'The study and treatment of tumors.', category_name: 'Health', level: 'Advanced' },
  { name: 'Neurology', definition: 'The branch of medicine or biology that deals with the anatomy, functions, and organic disorders of nerves and the nervous system.', category_name: 'Health', level: 'Advanced' },
  { name: 'Psychiatry', definition: 'The study and treatment of mental illness, emotional disturbance, and abnormal behavior.', category_name: 'Health', level: 'Advanced' },
  { name: 'Epidemiology', definition: 'The branch of medicine which deals with the incidence, distribution, and possible control of diseases.', category_name: 'Health', level: 'Advanced' },

  # Sports
  # Sports - Beginner
  { name: 'Ball', definition: 'A round object used in many sports.', category_name: 'Sports', level: 'Beginner' },
  { name: 'Goal', definition: 'A point scored in some sports such as soccer, hockey, and basketball.', category_name: 'Sports', level: 'Beginner' },
  { name: 'Coach', definition: 'A person who trains and teaches athletes or sports teams.', category_name: 'Sports', level: 'Beginner' },
  { name: 'Team', definition: 'A group of players forming one side in a competitive game or sport.', category_name: 'Sports', level: 'Beginner' },
  { name: 'Referee', definition: 'An official who watches a game or match closely to ensure that the rules are adhered to.', category_name: 'Sports', level: 'Beginner' },
  { name: 'Player', definition: 'A person who takes part in a game or sport.', category_name: 'Sports', level: 'Beginner' },
  { name: 'Score', definition: 'The number of points achieved in a game or test.', category_name: 'Sports', level: 'Beginner' },
  
  
  # Sports - Intermediate
  { name: 'Soccer', definition: 'A sport in which two teams of eleven players each try to score by kicking a ball into the other team\'s goal.', category_name: 'Sports', level: 'Intermediate' },
  { name: 'Basketball', definition: 'A game played between two teams of five players each on a rectangular court, usually indoors. Each team tries to score by tossing the ball through the opponent\'s goal, an elevated horizontal hoop and net.', category_name: 'Sports', level: 'Intermediate' },
  { name: 'Tennis', definition: 'A game in which two or four players strike a ball with rackets over a net stretched across a court.', category_name: 'Sports', level: 'Intermediate' },
  { name: 'Swimming', definition: 'The sport or activity of propelling oneself through water using the limbs.', category_name: 'Sports', level: 'Intermediate' },

  # Sports - Advanced
  { name: 'Marathon', definition: 'A long-distance running race, strictly one of 26 miles 385 yards (42.195 km).', category_name: 'Sports', level: 'Advanced' },
  { name: 'Triathlon', definition: 'An athletic contest consisting of three different events, typically swimming, cycling, and long-distance running.', category_name: 'Sports', level: 'Advanced' },
  { name: 'Decathlon', definition: 'An athletic event taking place over two days, in which each competitor takes part in the same prescribed ten events.', category_name: 'Sports', level: 'Advanced' },
  { name: 'Endurance', definition: 'The ability to endure an unpleasant or difficult process or situation without giving way.', category_name: 'Sports', level: 'Advanced' },
  { name: 'Rehabilitation', definition: 'The action of restoring someone to health or normal life through training and therapy after imprisonment, addiction, or illness.', category_name: 'Sports', level: 'Advanced' },
  { name: 'Biomechanics', definition: 'The study of the mechanical laws relating to the movement or structure of living organisms.', category_name: 'Sports', level: 'Advanced' },
  { name: 'Sportsmanship', definition: 'Fair and generous behavior or treatment of others, especially in a sports contest.', category_name: 'Sports', level: 'Advanced' },
  { name: 'Kinesiology', definition: 'The study of the mechanics of body movements.', category_name: 'Sports', level: 'Advanced' },


  # Art
  # Art - Beginner
  { name: 'Painting', definition: 'The process or art of using paint, in a picture, as a protective coating, or as decoration.', category_name: 'Art', level: 'Beginner' },
  { name: 'Sculpture', definition: 'The art of making two- or three-dimensional representative or abstract forms, especially by carving stone or wood or by casting metal or plaster.', category_name: 'Art', level: 'Beginner' },
  { name: 'Paint', definition: 'A colored substance spread over a surface to dry and leave a thin decorative or protective coating.', category_name: 'Art', level: 'Beginner' },
  { name: 'Brush', definition: 'An implement with a handle and bristles used for painting.', category_name: 'Art', level: 'Beginner' },
  { name: 'Drawing', definition: 'A picture or diagram made with a pencil, pen, or crayon rather than paint.', category_name: 'Art', level: 'Beginner' },
  { name: 'Color', definition: 'The property possessed by an object of producing different sensations on the eye as a result of the way it reflects or emits light.', category_name: 'Art', level: 'Beginner' },
  { name: 'Canvas', definition: 'A strong, unbleached cloth used as a surface for painting.', category_name: 'Art', level: 'Beginner' },
  { name: 'Gallery', definition: 'A room or building for the display or sale of works of art.', category_name: 'Art', level: 'Beginner' },

  # Art - Intermediate
  { name: 'Photography', definition: 'The art or practice of taking and processing photographs.', category_name: 'Art', level: 'Intermediate' },
  { name: 'Ceramics', definition: 'The art of making objects out of clay and similar materials treated by firing.', category_name: 'Art', level: 'Intermediate' },
  { name: 'Palette', definition: 'A thin board or slab on which an artist lays and mixes colors.', category_name: 'Art', level: 'Intermediate' },
  { name: 'Exhibit', definition: 'A public display of works of art or other items of interest.', category_name: 'Art', level: 'Intermediate' },
  { name: 'Abstract', definition: 'Art that does not attempt to represent external reality, but seeks to achieve its effect using shapes, colors, and textures.', category_name: 'Art', level: 'Intermediate' },
  { name: 'Portrait', definition: 'A painting, drawing, photograph, or engraving of a person, especially one depicting only the face or head and shoulders.', category_name: 'Art', level: 'Intermediate' },
  { name: 'Sketch', definition: 'A rough or unfinished drawing or painting, often made to assist in making a more finished picture.', category_name: 'Art', level: 'Intermediate' },
  { name: 'Medium', definition: 'The material or technique an artist uses to create their work.', category_name: 'Art', level: 'Intermediate' },
  { name: 'Mosaic', definition: 'A picture or pattern produced by arranging together small colored pieces of hard material, such as stone, tile, or glass.', category_name: 'Art', level: 'Intermediate' },


  # Art - Advanced
  { name: 'Impressionism', definition: 'A style or movement in painting originating in France in the 1860s, characterized by a concern with depicting the visual impression of the moment, especially in terms of the shifting effect of light and color.', category_name: 'Art', level: 'Advanced' },
  { name: 'Cubism', definition: 'An early 20th-century style and movement in art, especially painting, in which perspective with a single viewpoint was abandoned and use was made of simple geometric shapes, interlocking planes, and later, collage.', category_name: 'Art', level: 'Advanced' },
  { name: 'Surrealism', definition: 'A 20th-century avant-garde movement in art and literature that sought to release the creative potential of the unconscious mind.', category_name: 'Art', level: 'Advanced' },
  { name: 'Fresco', definition: 'A technique of mural painting executed upon freshly laid lime plaster.', category_name: 'Art', level: 'Advanced' },
  { name: 'Installation', definition: 'A genre of three-dimensional works that are often site-specific and designed to transform the perception of a space.', category_name: 'Art', level: 'Advanced' },
  { name: 'Renaissance', definition: 'The revival of art and literature under the influence of classical models in the 14th–16th centuries.', category_name: 'Art', level: 'Advanced' },
  { name: 'Avant-garde', definition: 'New and unusual or experimental ideas, especially in the arts, or the people introducing them.', category_name: 'Art', level: 'Advanced' },

  # Literature
  # Literature - Beginner
  { name: 'Novel', definition: 'A fictitious prose narrative of book length, typically representing character and action with some degree of realism.', category_name: 'Literature', level: 'Beginner' },
  { name: 'Poetry', definition: 'Literary work in which the expression of feelings and ideas is given intensity by the use of distinctive style and rhythm.', category_name: 'Literature', level: 'Beginner' },
  { name: 'Book', definition: 'A written or printed work consisting of pages glued or sewn together along one side and bound in covers.', category_name: 'Literature', level: 'Beginner' },
  { name: 'Story', definition: 'A narrative, either true or fictitious, in prose or verse, designed to interest, amuse, or instruct the hearer or reader.', category_name: 'Literature', level: 'Beginner' },
  { name: 'Author', definition: 'A writer of a book, article, or report.', category_name: 'Literature', level: 'Beginner' },
  { name: 'Title', definition: 'The name of a book, composition, or other artistic work.', category_name: 'Literature', level: 'Beginner' },
  { name: 'Chapter', definition: 'A main division of a book, typically with a number or title.', category_name: 'Literature', level: 'Beginner' },
  { name: 'Library', definition: 'A building or room containing collections of books, periodicals, and sometimes films and recorded music for people to read, borrow, or refer to.', category_name: 'Literature', level: 'Beginner' },

  # Literature - Intermediate
  { name: 'Drama', definition: 'A play for theater, radio, or television.', category_name: 'Literature', level: 'Intermediate' },
  { name: 'Essay', definition: 'A short piece of writing on a particular subject.', category_name: 'Literature', level: 'Intermediate' },
  { name: 'Novel', definition: 'A fictitious prose narrative of book length, typically representing character and action with some degree of realism.', category_name: 'Literature', level: 'Intermediate' },
  { name: 'Poem', definition: 'A piece of writing that partakes of the nature of both speech and song, that is nearly always rhythmical, usually metaphorical, and often exhibits such formal elements as meter, rhyme, and stanzaic structure.', category_name: 'Literature', level: 'Intermediate' },
  { name: 'Genre', definition: 'A category of artistic composition, as in music or literature, characterized by similarities in form, style, or subject matter.', category_name: 'Literature', level: 'Intermediate' },
  { name: 'Plot', definition: 'The main events of a play, novel, movie, or similar work, devised and presented by the writer as an interrelated sequence.', category_name: 'Literature', level: 'Intermediate' },
  { name: 'Character', definition: 'A person in a novel, play, or movie.', category_name: 'Literature', level: 'Intermediate' },
  { name: 'Narrator', definition: 'A person who narrates something, especially a character who recounts the events of a novel or narrative poem.', category_name: 'Literature', level: 'Intermediate' },
  { name: 'Setting', definition: 'The place or type of surroundings where something is positioned or where an event takes place.', category_name: 'Literature', level: 'Intermediate' },

  # Literature - Advanced
  { name: 'Modernism', definition: 'A style or movement in the arts that aims to break with classical and traditional forms.', category_name: 'Literature', level: 'Advanced' },
  { name: 'Postmodernism', definition: 'A late 20th-century style and concept in the arts, architecture, and criticism that represents a departure from modernism and has at its heart a general distrust of grand theories and ideologies as well as a problematic relationship with any notion of “art.”', category_name: 'Literature', level: 'Advanced' },
  { name: 'Metaphor', definition: 'A figure of speech in which a word or phrase is applied to an object or action to which it is not literally applicable.', category_name: 'Literature', level: 'Advanced' },
  { name: 'Allegory', definition: 'A story, poem, or picture that can be interpreted to reveal a hidden meaning, typically a moral or political one.', category_name: 'Literature', level: 'Advanced' },
  { name: 'Protagonist', definition: 'The leading character or one of the major characters in a drama, movie, novel, or other fictional text.', category_name: 'Literature', level: 'Advanced' },
  { name: 'Foreshadowing', definition: 'A literary device in which a writer gives an advance hint of what is to come later in the story.', category_name: 'Literature', level: 'Advanced' },
  { name: 'Epiphany', definition: 'A moment of sudden revelation or insight.', category_name: 'Literature', level: 'Advanced' },
  { name: 'Irony', definition: 'The expression of one\'s meaning by using language that normally signifies the opposite, typically for humorous or emphatic effect.', category_name: 'Literature', level: 'Advanced' },
  { name: 'Satire', definition: 'The use of humor, irony, exaggeration, or ridicule to expose and criticize people\'s stupidity or vices, particularly in the context of contemporary politics and other topical issues.', category_name: 'Literature', level: 'Advanced' },


  # Technology
  # Technology - Beginner
  { name: 'Computer', definition: 'An electronic device for storing and processing data.', category_name: 'Technology', level: 'Beginner' },
  { name: 'Internet', definition: 'A global network connecting millions of computers, allowing them to communicate.', category_name: 'Technology', level: 'Beginner' },
  { name: 'Mouse', definition: 'A small handheld device that is moved across a mat or flat surface to move the cursor on a computer screen.', category_name: 'Technology', level: 'Beginner' },
  { name: 'Keyboard', definition: 'A panel of keys that operate a computer or typewriter.', category_name: 'Technology', level: 'Beginner' },
  { name: 'Screen', definition: 'The flat surface on a computer, TV, or other electronic devices where images and data are displayed.', category_name: 'Technology', level: 'Beginner' },
  { name: 'Phone', definition: 'A device that allows people to talk to each other over long distances.', category_name: 'Technology', level: 'Beginner' },
  { name: 'Email', definition: 'Messages distributed by electronic means from one computer user to one or more recipients via a network.', category_name: 'Technology', level: 'Beginner' },

  # Technology - Intermediate
  { name: 'Software', definition: 'The programs and other operating information used by a computer.', category_name: 'Technology', level: 'Intermediate' },
  { name: 'Hardware', definition: 'The physical parts of a computer system.', category_name: 'Technology', level: 'Intermediate' },
  { name: 'Database', definition: 'A structured set of data held in a computer, especially one that is accessible in various ways.', category_name: 'Technology', level: 'Intermediate' },
  { name: 'Network', definition: 'A group of interconnected computers.', category_name: 'Technology', level: 'Intermediate' },
  { name: 'Browser', definition: 'A software application used to access and view websites.', category_name: 'Technology', level: 'Intermediate' },
  { name: 'Algorithm', definition: 'A process or set of rules to be followed in calculations or other problem-solving operations, especially by a computer.', category_name: 'Technology', level: 'Intermediate' },
  { name: 'Cybersecurity', definition: 'The practice of protecting systems, networks, and programs from digital attacks.', category_name: 'Technology', level: 'Intermediate' },

  # Technology - Advanced
  { name: 'Artificial Intelligence', definition: 'The theory and development of computer systems able to perform tasks that normally require human intelligence, such as visual perception, speech recognition, decision-making, and translation between languages.', category_name: 'Technology', level: 'Advanced' },
  { name: 'Quantum Computing', definition: 'The use of quantum-mechanical phenomena such as superposition and entanglement to perform computation.', category_name: 'Technology', level: 'Advanced' }, 
  { name: 'Blockchain', definition: 'A system in which a record of transactions made in bitcoin or another cryptocurrency is maintained across several computers that are linked in a peer-to-peer network.', category_name: 'Technology', level: 'Advanced' },
  { name: 'Big Data', definition: 'Extremely large data sets that may be analyzed computationally to reveal patterns, trends, and associations.', category_name: 'Technology', level: 'Advanced' },
  { name: 'Virtual Reality', definition: 'The computer-generated simulation of a three-dimensional image or environment.', category_name: 'Technology', level: 'Advanced' },
  { name: 'Augmented Reality', definition: 'An enhanced version of reality created by the use of technology to overlay digital information on an image of something being viewed through a device.', category_name: 'Technology', level: 'Advanced' },
  { name: 'Machine Learning', definition: 'A type of artificial intelligence that allows software applications to become more accurate at predicting outcomes without being explicitly programmed to do so.', category_name: 'Technology', level: 'Advanced' },
  { name: 'Internet of Things', definition: 'The interconnection via the Internet of computing devices embedded in everyday objects, enabling them to send and receive data.', category_name: 'Technology', level: 'Advanced' },
  { name: 'Cloud Computing', definition: 'The practice of using a network of remote servers hosted on the Internet to store, manage, and process data, rather than a local server or a personal computer.', category_name: 'Technology', level: 'Advanced' },
  { name: '3D Printing', definition: 'The action or process of making a physical object from a three-dimensional digital model, typically by laying down many thin layers of a material in succession.', category_name: 'Technology', level: 'Advanced' },
  { name: 'Biotechnology', definition: 'The exploitation of biological processes for industrial and other purposes, especially the genetic manipulation of microorganisms for the production of antibiotics, hormones, etc.', category_name: 'Technology', level: 'Advanced' },
  { name: 'Nanotechnology', definition: 'The branch of technology that deals with dimensions and tolerances of less than 100 nanometers, especially the manipulation of individual atoms and molecules.', category_name: 'Technology', level: 'Advanced' },
  { name: 'Robotics', definition: 'The branch of technology that deals with the design, construction, operation, and application of robots.', category_name: 'Technology', level: 'Advanced' },
  { name: 'Telecommunications', definition: 'The transmission of information over significant distances to communicate.', category_name: 'Technology', level: 'Advanced' },
  { name: 'Wireless', definition: 'A term used to describe telecommunications in which electromagnetic waves carry the signal over part or all of the communication path.', category_name: 'Technology', level: 'Advanced'}
]

# Seed Words
words_attributes.each do |word_attr|
  # Find the category by name
  category = Category.find_by(name: word_attr[:category_name])
  if category
    # Create a new word with the provided attributes if the category exists
    Word.create!(
      name: word_attr[:name],
      definition: word_attr[:definition],
      category: category,
      level: word_attr[:level]
    )
  else
    # Log a message if the category does not exist
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
  },
  # Additional Beginner game
  {
    category_name: 'Colors', difficulty_level: 'Beginner', user_email: 'alice@example.com',
    score: 12, date: current_time, start_time: current_time - 1.hour, end_time: current_time,
    word_name: 'Red', attempts: 1
  },
  # Intermediate game
  {
    category_name: 'Seasons & Weather', difficulty_level: 'Intermediate', user_email: 'bob@example.com',
    score: 15, date: current_time, start_time: current_time - 3.hours, end_time: current_time - 2.hours,
    word_name: 'Winter', attempts: 2
  },
  # Additional Intermediate game
  {
    category_name: 'Food', difficulty_level: 'Intermediate', user_email: 'carol@example.com',
    score: 17, date: current_time, start_time: current_time - 5.hours, end_time: current_time - 4.hours,
    word_name: 'Pasta', attempts: 1
  },
  # Advanced game
  {
    category_name: 'Health', difficulty_level: 'Advanced', user_email: 'alice@example.com',
    score: 20, date: current_time, start_time: current_time - 1.day, end_time: current_time - 1.day + 1.hour,
    word_name: 'Cardiology', attempts: 3
  },
  # Additional Advanced game
  {
    category_name: 'Technology', difficulty_level: 'Advanced', user_email: 'bob@example.com',
    score: 22, date: current_time, start_time: current_time - 2.days, end_time: current_time - 2.days + 1.hour,
    word_name: 'Quantum Computing', attempts: 2
  }
]



# Seed Games (with the defined games_attributes array)
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

chatroom_names = ["Language tips", "Hardest words", "Random chat", "Career & Language"]

chatroom_names.each do |name|
  Chatroom.create(name: name)
end

puts "Seeded #{chatroom_names.count} chatrooms."
