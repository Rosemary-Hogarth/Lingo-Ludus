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
    language_id: german.id },
  
    # Numbers - Beginner
    { name: 'One', definition: 'The number after zero.', category_name: 'Numbers', level: 'Beginner', language_id: english.id },
    { name: 'Eins', definition: 'Die Zahl nach null.', category_name: 'Numbers', level: 'Beginner', language_id: german.id },
    { name: 'Two', definition: 'The number after one.', category_name: 'Numbers', level: 'Beginner', language_id: english.id },
    { name: 'Zwei', definition: 'Die Zahl nach eins.', category_name: 'Numbers', level: 'Beginner', language_id: german.id },
    { name: 'Three', definition: 'The number after two.', category_name: 'Numbers', level: 'Beginner', language_id: english.id },
    { name: 'Drei', definition: 'Die Zahl nach zwei.', category_name: 'Numbers', level: 'Beginner', language_id: german.id },
    { name: 'Four', definition: 'The number after three.', category_name: 'Numbers', level: 'Beginner', language_id: english.id },
    { name: 'Vier', definition: 'Die Zahl nach drei.', category_name: 'Numbers', level: 'Beginner', language_id: german.id },
    { name: 'Five', definition: 'The number after four.', category_name: 'Numbers', level: 'Beginner', language_id: english.id },
    { name: 'Fünf', definition: 'Die Zahl nach vier.', category_name: 'Numbers', level: 'Beginner', language_id: german.id },
    { name: 'Six', definition: 'The number after five.', category_name: 'Numbers', level: 'Beginner', language_id: english.id },
    { name: 'Sechs', definition: 'Die Zahl nach fünf.', category_name: 'Numbers', level: 'Beginner', language_id: german.id },
    { name: 'Seven', definition: 'The number after six.', category_name: 'Numbers', level: 'Beginner', language_id: english.id },
    { name: 'Sieben', definition: 'Die Zahl nach sechs.', category_name: 'Numbers', level: 'Beginner', language_id: german.id },
    { name: 'Eight', definition: 'The number after seven.', category_name: 'Numbers', level: 'Beginner', language_id: english.id },
    { name: 'Acht', definition: 'Die Zahl nach sieben.', category_name: 'Numbers', level: 'Beginner', language_id: german.id },
    { name: 'Nine', definition: 'The number after eight.', category_name: 'Numbers', level: 'Beginner', language_id: english.id },
    { name: 'Neun', definition: 'Die Zahl nach acht.', category_name: 'Numbers', level: 'Beginner', language_id: german.id },
    { name: 'Ten', definition: 'The number after nine.', category_name: 'Numbers', level: 'Beginner', language_id: english.id },
    { name: 'Zehn', definition: 'Die Zahl nach neun.', category_name: 'Numbers', level: 'Beginner', language_id: german.id },

    # Numbers - Intermediate
    { name: 'Eleven', definition: 'The product of five times two plus one.', category_name: 'Numbers', level: 'Intermediate', language_id: english.id },
    { name: 'Elf', definition: 'Das Produkt von fünf mal zwei plus eins.', category_name: 'Numbers', level: 'Intermediate', language_id: german.id },
    { name: 'Twelve', definition: 'The number of months in a year.', category_name: 'Numbers', level: 'Intermediate', language_id: english.id },
    { name: 'Zwölf', definition: 'Die Anzahl der Monate in einem Jahr.', category_name: 'Numbers', level: 'Intermediate', language_id: german.id },
    { name: 'Thirteen', definition: 'The atomic number of aluminum.', category_name: 'Numbers', level: 'Intermediate', language_id: english.id },
    { name: 'Dreizehn', definition: 'Die Ordnungszahl von Aluminium.', category_name: 'Numbers', level: 'Intermediate', language_id: german.id },
    { name: 'Fourteen', definition: 'The number of days in two weeks.', category_name: 'Numbers', level: 'Intermediate', language_id: english.id },
    { name: 'Vierzehn', definition: 'Die Anzahl der Tage in zwei Wochen.', category_name: 'Numbers', level: 'Intermediate', language_id: german.id },
    { name: 'Fifteen', definition: 'The number representing a quarter-hour.', category_name: 'Numbers', level: 'Intermediate', language_id: english.id },
    { name: 'Fünfzehn', definition: 'Die Zahl, die eine Viertelstunde darstellt.', category_name: 'Numbers', level: 'Intermediate', language_id: german.id },
    { name: 'Sixteen', definition: 'A square number, 4 squared.', category_name: 'Numbers', level: 'Intermediate', language_id: english.id },
    { name: 'Sechzehn', definition: 'Eine Quadratzahl, 4 hoch 2.', category_name: 'Numbers', level: 'Intermediate', language_id: german.id },
    { name: 'Seventeen', definition: 'A prime number following sixteen.', category_name: 'Numbers', level: 'Intermediate', language_id: english.id },
    { name: 'Siebzehn', definition: 'Eine Primzahl nach sechzehn.', category_name: 'Numbers', level: 'Intermediate', language_id: german.id },
    { name: 'Eighteen', definition: 'The product of three times six.', category_name: 'Numbers', level: 'Intermediate', language_id: english.id },
    { name: 'Achtzehn', definition: 'Das Produkt von drei mal sechs.', category_name: 'Numbers', level: 'Intermediate', language_id: german.id },
    { name: 'Nineteen', definition: 'A prime number following eighteen.', category_name: 'Numbers', level: 'Intermediate', language_id: english.id },
    { name: 'Neunzehn', definition: 'Eine Primzahl nach achtzehn.', category_name: 'Numbers', level: 'Intermediate', language_id: german.id },
    { name: 'Twenty', definition: 'The product of five times four.', category_name: 'Numbers', level: 'Intermediate', language_id: english.id },
    { name: 'Zwanzig', definition: 'Das Produkt von fünf mal vier.', category_name: 'Numbers', level: 'Intermediate', language_id: german.id },

    # Numbers - Advanced
    { name: 'Twenty-One', definition: 'The number of spots on a standard six-sided die.', category_name: 'Numbers', level: 'Advanced', language_id: english.id },
    { name: 'Einundzwanzig', definition: 'Die Anzahl der Punkte auf einem Standard-Sechs-Seiten-Würfel.', category_name: 'Numbers', level: 'Advanced', language_id: german.id },
    { name: 'Twenty-Two', definition: 'The number of players on a soccer field during a match.', category_name: 'Numbers', level: 'Advanced', language_id: english.id },
    { name: 'Zweiundzwanzig', definition: 'Die Anzahl der Spieler auf einem Fußballfeld während eines Spiels.', category_name: 'Numbers', level: 'Advanced', language_id: german.id },
    { name: 'Thirty', definition: 'The number of degrees in each angle of an equilateral triangle.', category_name: 'Numbers', level: 'Advanced', language_id: english.id },
    { name: 'Dreißig', definition: 'Die Anzahl der Grade in jedem Winkel eines gleichseitigen Dreiecks.', category_name: 'Numbers', level: 'Advanced', language_id: german.id },
    { name: 'Forty', definition: 'The number of weeks in a typical human pregnancy.', category_name: 'Numbers', level: 'Advanced', language_id: english.id },
    { name: 'Vierzig', definition: 'Die Anzahl der Wochen in einer typischen menschlichen Schwangerschaft.', category_name: 'Numbers', level: 'Advanced', language_id: german.id },
    { name: 'Fifty', definition: 'Half of one hundred.', category_name: 'Numbers', level: 'Advanced', language_id: english.id },
    { name: 'Fünfzig', definition: 'Die Hälfte von einhundert.', category_name: 'Numbers', level: 'Advanced', language_id: german.id },
    { name: 'Sixty', definition: 'The number of seconds in a minute.', category_name: 'Numbers', level: 'Advanced', language_id: english.id },
    { name: 'Sechzig', definition: 'Die Anzahl der Sekunden in einer Minute.', category_name: 'Numbers', level: 'Advanced', language_id: german.id },
    { name: 'Seventy', definition: 'The number of years in seven decades.', category_name: 'Numbers', level: 'Advanced', language_id: english.id },
    { name: 'Siebzig', definition: 'Die Anzahl der Jahre in sieben Jahrzehnten.', category_name: 'Numbers', level: 'Advanced', language_id: german.id },
    { name: 'Eighty', definition: 'The number of minutes in one hour and twenty minutes.', category_name: 'Numbers', level: 'Advanced', language_id: english.id },
    { name: 'Achtzig', definition: 'Die Anzahl der Minuten in einer Stunde und zwanzig Minuten.', category_name: 'Numbers', level: 'Advanced', language_id: german.id },
    { name: 'Ninety', definition: 'The number of degrees in a right angle.', category_name: 'Numbers', level: 'Advanced', language_id: english.id },
    { name: 'Neunzig', definition: 'Die Anzahl der Grade in einem rechten Winkel.', category_name: 'Numbers', level: 'Advanced', language_id: german.id },
    { name: 'One Hundred', definition: 'A number representing a century.', category_name: 'Numbers', level: 'Advanced', language_id: english.id },
    { name: 'Einhundert', definition: 'Eine Zahl, die ein Jahrhundert repräsentiert.', category_name: 'Numbers', level: 'Advanced', language_id: german.id },

    # Time - Beginner
    { name: 'Clock', definition: 'A device used to measure time.', category_name: 'Time', level: 'Beginner', language_id: english.id },
    { name: 'Uhr', definition: 'Ein Gerät zur Messung der Zeit.', category_name: 'Time', level: 'Beginner', language_id: german.id },
    { name: 'Watch', definition: 'A small timepiece worn typically on a strap on one\'s wrist.', category_name: 'Time', level: 'Beginner', language_id: english.id },
    { name: 'Armbanduhr', definition: 'Ein kleines Zeitmessgerät, das typischerweise an einem Armband am Handgelenk getragen wird.', category_name: 'Time', level: 'Beginner', language_id: german.id },
    { name: 'Hour', definition: 'A period of timevequal to a twenty-fourth part of a day and night.', category_name: 'Time', level: 'Beginner', language_id: english.id },
    { name: 'Stunde', definition: 'Eine Zeiteinheit, die dem vierundzwanzigsten Teil eines Tages und einer Nacht entspricht.', category_name: 'Time', level: 'Beginner', language_id: german.id },
    { name: 'Morning', definition: 'The early part of the day, from sunrise until noon.', category_name: 'Time', level: 'Beginner', language_id: english.id },
    { name: 'Morgen', definition: 'Der frühe Teil des Tages, von Sonnenaufgang bis Mittag.', category_name: 'Time', level: 'Beginner', language_id: german.id },
    { name: 'Evening', definition: 'The later part of the day, from the end of the afternoon until night.', category_name: 'Time', level: 'Beginner', language_id: english.id },
    { name: 'Abend', definition: 'Der spätere Teil des Tages, vom Ende des Nachmittags bis zur Nacht.', category_name: 'Time', level: 'Beginner', language_id: german.id },
    { name: 'Night', definition: 'The period of time when it is dark outside, typically from sunset to sunrise.', category_name: 'Time', level: 'Beginner', language_id: english.id },
    { name: 'Nacht', definition: 'Die Zeit, in der es draußen dunkel ist, typischerweise von Sonnenuntergang bis Sonnenaufgang.', category_name: 'Time', level: 'Beginner', language_id: german.id },
    { name: 'Midnight', definition: 'Twelve o\'clock at night.', category_name: 'Time', level: 'Beginner', language_id: english.id },
    { name: 'Mitternacht', definition: 'Zwölf Uhr nachts.', category_name: 'Time', level: 'Beginner', language_id: german.id },

    # Time - Intermediate
    { name: 'Minute', definition: 'A period of time equal to sixty seconds or a sixtieth of an hour.', category_name: 'Time', level: 'Intermediate', language_id: english.id },
    { name: 'Minute', definition: 'Ein Zeitraum, der sechzig Sekunden oder ein Sechzigstel einer Stunde entspricht.', category_name: 'Time', level: 'Intermediate', language_id: german.id },
    { name: 'Second', definition: 'A sixtieth of a minute of time.', category_name: 'Time', level: 'Intermediate', language_id: english.id },
    { name: 'Sekunde', definition: 'Ein Sechzigstel einer Minute Zeit.', category_name: 'Time', level: 'Intermediate', language_id: german.id },
    { name: 'Day', definition: 'A period of twenty-four hours as a unit of time.', category_name: 'Time', level: 'Intermediate', language_id: english.id },
    { name: 'Tag', definition: 'Ein Zeitraum von vierundzwanzig Stunden als Zeiteinheit.', category_name: 'Time', level: 'Intermediate', language_id: german.id },
    { name: 'Afternoon', definition: 'The period of time from noon until evening.', category_name: 'Time', level: 'Intermediate', language_id: english.id },
    { name: 'Nachmittag', definition: 'Der Zeitraum von Mittag bis Abend.', category_name: 'Time', level: 'Intermediate', language_id: german.id },
    { name: 'Dawn', definition: 'The time of day when the sun begins to rise.', category_name: 'Time', level: 'Intermediate', language_id: english.id },
    { name: 'Morgendämmerung', definition: 'Die Tageszeit, wenn die Sonne zu steigen beginnt.', category_name: 'Time', level: 'Intermediate', language_id: german.id },
    { name: 'Dusk', definition: 'The time of day when the sky is getting dark.', category_name: 'Time', level: 'Intermediate', language_id: english.id },
    { name: 'Abenddämmerung', definition: 'Die Tageszeit, wenn der Himmel dunkel wird.', category_name: 'Time', level: 'Intermediate', language_id: german.id },
    { name: 'Weekday', definition: 'Any day of the week except Saturday and Sunday.', category_name: 'Time', level: 'Intermediate', language_id: english.id },
    { name: 'Wochentag', definition: 'Jeder Tag der Woche außer Samstag und Sonntag.', category_name: 'Time', level: 'Intermediate', language_id: german.id },
    { name: 'Weekend', definition: 'The period from Friday evening through Sunday evening, especially regarded as a time for leisure.', category_name: 'Time', level: 'Intermediate', language_id: english.id },
    { name: 'Wochenende', definition: 'Der Zeitraum von Freitagabend bis Sonntagabend, insbesondere als Zeit für Freizeit betrachtet.', category_name: 'Time', level: 'Intermediate', language_id: german.id },


    # Time - Advanced
    { name: 'Week', definition: 'A period of seven days.', category_name: 'Time', level: 'Advanced', language_id: english.id },
    { name: 'Woche', definition: 'Ein Zeitraum von sieben Tagen.', category_name: 'Time', level: 'Advanced', language_id: german.id },
    { name: 'Month', definition: 'Each of the twelve named periods into which a year is divided.', category_name: 'Time', level: 'Advanced', language_id: english.id },
    { name: 'Monat', definition: 'Jeder der zwölf benannten Zeiträume, in die ein Jahr eingeteilt ist.', category_name: 'Time', level: 'Advanced', language_id: german.id },
    { name: 'Year', definition: 'The time taken by the earth to make one revolution around the sun.', category_name: 'Time', level: 'Advanced', language_id: english.id },
    { name: 'Jahr', definition: 'Die Zeit, die die Erde für eine Umdrehung um die Sonne benötigt.', category_name: 'Time', level: 'Advanced', language_id: german.id },
    { name: 'Century', definition: 'A period of one hundred years.', category_name: 'Time', level: 'Advanced', language_id: english.id },
    { name: 'Jahrhundert', definition: 'Ein Zeitraum von hundert Jahren.', category_name: 'Time', level: 'Advanced', language_id: german.id },
    { name: 'Millennium', definition: 'A period of one thousand years.', category_name: 'Time', level: 'Advanced', language_id: english.id },
    { name: 'Jahrtausend', definition: 'Ein Zeitraum von tausend Jahren.', category_name: 'Time', level: 'Advanced', language_id: german.id },
    { name: 'Era', definition: 'A long and distinct period of history with a particular feature or characteristic.', category_name: 'Time', level: 'Advanced', language_id: english.id },
    { name: 'Epoche', definition: 'Ein langer und deutlicher Zeitraum der Geschichte mit einem besonderen Merkmal oder Charakteristikum.', category_name: 'Time', level: 'Advanced', language_id: german.id },
    { name: 'Decade', definition: 'A period of ten years.', category_name: 'Time', level: 'Advanced', language_id: english.id },
    { name: 'Jahrzehnt', definition: 'Ein Zeitraum von zehn Jahren.', category_name: 'Time', level: 'Advanced', language_id: german.id },
    { name: 'Quarter', definition: 'Each of four equal or corresponding parts into which something is or can be divided.', category_name: 'Time', level: 'Advanced', language_id: english.id },
    { name: 'Quartal', definition: 'Jeder der vier gleichen oder entsprechenden Teile, in die etwas geteilt ist oder werden kann.', category_name: 'Time', level: 'Advanced', language_id: german.id },

    # Seasons & Weather - Beginner
    { name: 'Spring', definition: 'The season after winter and before summer.', category_name: 'Seasons & Weather', level: 'Beginner', language_id: english.id },
    { name: 'Frühling', definition: 'Die Jahreszeit nach dem Winter und vor dem Sommer.', category_name: 'Seasons & Weather', level: 'Beginner', language_id: german.id },
    { name: 'Summer', definition: 'The warmest season of the year.', category_name: 'Seasons & Weather', level: 'Beginner', language_id: english.id },
    { name: 'Sommer', definition: 'Die wärmste Jahreszeit des Jahres.', category_name: 'Seasons & Weather', level: 'Beginner', language_id: german.id },
    { name: 'Autumn', definition: 'The season after summer and before winter.', category_name: 'Seasons & Weather', level: 'Beginner', language_id: english.id },
    { name: 'Herbst', definition: 'Die Jahreszeit nach dem Sommer und vor dem Winter.', category_name: 'Seasons & Weather', level: 'Beginner', language_id: german.id },
    { name: 'Winter', definition: 'The coldest season of the year.', category_name: 'Seasons & Weather', level: 'Beginner', language_id: english.id },
    { name: 'Winter', definition: 'Die kälteste Jahreszeit des Jahres.', category_name: 'Seasons & Weather', level: 'Beginner', language_id: german.id },
    { name: 'Snow', definition: 'Frozen water vapor falling in light white flakes.', category_name: 'Seasons & Weather', level: 'Beginner', language_id: english.id },
    { name: 'Schnee', definition: 'Gefrorener Wasserdampf, der in leichten weißen Flocken fällt.', category_name: 'Seasons & Weather', level: 'Beginner', language_id: german.id },
    { name: 'Rain', definition: 'Water that falls from clouds in drops.', category_name: 'Seasons & Weather', level: 'Beginner', language_id: english.id },
    { name: 'Regen', definition: 'Wasser, das in Tropfen von den Wolken fällt.', category_name: 'Seasons & Weather', level: 'Beginner', language_id: german.id },
    { name: 'Sunshine', definition: 'The light and warmth that come from the sun.', category_name: 'Seasons & Weather', level: 'Beginner', language_id: english.id },
    { name: 'Sonnenschein', definition: 'Das Licht und die Wärme, die von der Sonne kommen.', category_name: 'Seasons & Weather', level: 'Beginner', language_id: german.id },
    { name: 'Cloud', definition: 'A visible mass of condensed water vapor floating in the atmosphere.', category_name: 'Seasons & Weather', level: 'Beginner', language_id: english.id },
    { name: 'Wolke', definition: 'Eine sichtbare Masse von kondensiertem Wasserdampf, die in der Atmosphäre schwebt.', category_name: 'Seasons & Weather', level: 'Beginner', language_id: german.id },

    # Seasons & Weather - Intermediate
    { name: 'Winter', definition: 'The coldest season of the year.', category_name: 'Seasons & Weather', level: 'Intermediate', language_id: english.id },
    { name: 'Winter', definition: 'Die kälteste Jahreszeit des Jahres.', category_name: 'Seasons & Weather', level: 'Intermediate', language_id: german.id },
    { name: 'Equinox', definition: 'The time or date at which the sun crosses the celestial equator.', category_name: 'Seasons & Weather', level: 'Intermediate', language_id: english.id },
    { name: 'Äquinoktium', definition: 'Die Zeit oder das Datum, an dem die Sonne den Himmelsäquator überquert.', category_name: 'Seasons & Weather', level: 'Intermediate', language_id: german.id },
    { name: 'Solstice', definition: 'Either of the two times in the year when the sun is at its greatest distance from the celestial equator.', category_name: 'Seasons & Weather', level: 'Intermediate', language_id: english.id },
    { name: 'Sonnenwende', definition: 'Einer der beiden Zeitpunkte im Jahr, an dem die Sonne am weitesten vom Himmelsäquator entfernt ist.', category_name: 'Seasons & Weather', level: 'Intermediate', language_id: german.id },
    { name: 'Humidity', definition: 'The amount of water vapor in the air.', category_name: 'Seasons & Weather', level: 'Intermediate', language_id: english.id },
    { name: 'Luftfeuchtigkeit', definition: 'Die Menge an Wasserdampf in der Luft.', category_name: 'Seasons & Weather', level: 'Intermediate', language_id: german.id },
    { name: 'Temperature', definition: 'The degree of heat or cold in the air.', category_name: 'Seasons & Weather', level: 'Intermediate', language_id: english.id },
    { name: 'Temperatur', definition: 'Der Grad der Wärme oder Kälte in der Luft.', category_name: 'Seasons & Weather', level: 'Intermediate', language_id: german.id },
    { name: 'Frost', definition: 'A thin layer of ice that forms on surfaces when it is very cold.', category_name: 'Seasons & Weather', level: 'Intermediate', language_id: english.id },
    { name: 'Frost', definition: 'Eine dünne Eisschicht, die sich auf Oberflächen bildet, wenn es sehr kalt ist.', category_name: 'Seasons & Weather', level: 'Intermediate', language_id: german.id },
    { name: 'Monsoon', definition: 'A seasonal wind that brings heavy rain.', category_name: 'Seasons & Weather', level: 'Intermediate', language_id: english.id },
    { name: 'Monsun', definition: 'Ein saisonaler Wind, der starken Regen bringt.', category_name: 'Seasons & Weather', level: 'Intermediate', language_id: german.id },
    { name: 'Breeze', definition: 'A gentle wind.', category_name: 'Seasons & Weather', level: 'Intermediate', language_id: english.id },
    { name: 'Brise', definition: 'Ein sanfter Wind.', category_name: 'Seasons & Weather', level: 'Intermediate', language_id: german.id },


    # Seasons & Weather - Advanced
    { name: 'Heatwave', definition: 'A prolonged period of abnormally hot weather.', category_name: 'Seasons & Weather', level: 'Advanced', language_id: english.id },
    { name: 'Hitzewelle', definition: 'Eine längere Periode ungewöhnlich heißer Wetterbedingungen.', category_name: 'Seasons & Weather', level: 'Advanced', language_id: german.id },
    { name: 'Harvest', definition: 'The process or period of gathering in crops.', category_name: 'Seasons & Weather', level: 'Advanced', language_id: english.id },
    { name: 'Ernte', definition: 'Der Prozess oder die Periode der Ernte von Feldfrüchten.', category_name: 'Seasons & Weather', level: 'Advanced', language_id: german.id },
    { name: 'Precipitation', definition: 'Any form of water that falls from clouds, such as rain or snow.', category_name: 'Seasons & Weather', level: 'Advanced', language_id: english.id },
    { name: 'Niederschlag', definition: 'Jede Form von Wasser, die aus Wolken fällt, wie Regen oder Schnee.', category_name: 'Seasons & Weather', level: 'Advanced', language_id: german.id },
    { name: 'Solstice', definition: 'The time when the sun is at its greatest distance from the equator, happening twice a year.', category_name: 'Seasons & Weather', level: 'Advanced', language_id: english.id },
    { name: 'Sonnenwende', definition: 'Die Zeit, in der die Sonne am weitesten vom Äquator entfernt ist, was zweimal im Jahr passiert.', category_name: 'Seasons & Weather', level: 'Advanced', language_id: german.id },

    # Food - Beginner
    { name: 'Apple', definition: 'A round fruit with red or yellow skin and a firm white flesh.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Apfel', definition: 'Eine runde Frucht mit roter oder gelber Haut und festem weißem Fleisch.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Bread', definition: 'A food made of flour, water, and yeast mixed together and baked.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Brot', definition: 'Ein Nahrungsmittel aus Mehl, Wasser und Hefe, das zusammen gemischt und gebacken wird.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Cheese', definition: 'A food made from the pressed curds of milk.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Käse', definition: 'Ein Nahrungsmittel, das aus gepressten Käsebruchstücken hergestellt wird.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Banana', definition: 'A long, curved fruit with a yellow skin.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Banane', definition: 'Eine lange, gekrümmte Frucht mit gelber Haut.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Milk', definition: 'A white liquid produced by mammals, used as a drink or in cooking.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Milch', definition: 'Eine weiße Flüssigkeit, die von Säugetieren produziert wird und als Getränk oder zum Kochen verwendet wird.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Egg', definition: 'A round or oval object laid by a female bird, reptile, fish, or invertebrate, usually containing a developing embryo.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Ei', definition: 'Ein rundes oder ovales Objekt, das von einem weiblichen Vogel, Reptil, Fisch oder Wirbellosen gelegt wird und normalerweise ein sich entwickelndes Embryo enthält.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Carrot', definition: 'A long, thin orange vegetable that grows underground.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Karotte', definition: 'Ein langes, dünnes, oranges Gemüse, das unter der Erde wächst.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Rice', definition: 'A small white or brown grain that is a staple food in many countries.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Reis', definition: 'Ein kleines weißes oder braunes Korn, das in vielen Ländern ein Grundnahrungsmittel ist.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Tomato', definition: 'A glossy red or yellow edible fruit that is typically eaten as a vegetable or in salad.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Tomate', definition: 'Eine glänzende rote oder gelbe essbare Frucht, die typischerweise als Gemüse oder im Salat gegessen wird.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Potato', definition: 'A starchy plant tuber that is one of the most important food crops, cooked and eaten as a vegetable.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Kartoffel', definition: 'Ein stärkehaltiger Pflanzentuberkel, der eine der wichtigsten Nahrungspflanzen ist, gekocht und als Gemüse gegessen wird.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Fish', definition: 'A cold-blooded vertebrate animal that lives in water and has gills, fins, and scales.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Fisch', definition: 'Ein kaltblütiges Wirbeltier, das im Wasser lebt und Kiemen, Flossen und Schuppen hat.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Bell Pepper', definition: 'A large, mild pepper that can be green, red, yellow, or orange.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Paprika', definition: 'Ein großer, milder Pfeffer, der grün, rot, gelb oder orange sein kann.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Berries', definition: 'Small, juicy fruits with seeds, such as strawberries, blueberries, and raspberries.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Beeren', definition: 'Kleine, saftige Früchte mit Samen, wie Erdbeeren, Blaubeeren und Himbeeren.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Celery', definition: 'A crunchy, green vegetable with long, fibrous stalks.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Sellerie', definition: 'Ein knuspriges, grünes Gemüse mit langen, faserigen Stängeln.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Cucumber', definition: 'A long, green vegetable with a crisp, watery flesh.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Gurke', definition: 'Ein langes, grünes Gemüse mit knackigem, wässrigem Fruchtfleisch.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Garlic', definition: 'A strong-smelling bulb used as a flavoring in cooking.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Knoblauch', definition: 'Eine stark riechende Knolle, die als Gewürz beim Kochen verwendet wird.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Ginger', definition: 'A spicy root used in cooking and baking.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Ingwer', definition: 'Eine scharfe Wurzel, die beim Kochen und Backen verwendet wird.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Lemon', definition: 'A yellow citrus fruit with a sour taste.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Zitrone', definition: 'Eine gelbe Zitrusfrucht mit saurem Geschmack.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Lime', definition: 'A small, green citrus fruit with a sour taste.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Limette', definition: 'Eine kleine, grüne Zitrusfrucht mit saurem Geschmack.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Onion', definition: 'A vegetable with a strong smell and taste, made up of several layers.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Zwiebel', definition: 'Ein Gemüse mit starkem Geruch und Geschmack, bestehend aus mehreren Schichten.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Pear', definition: 'A sweet fruit with a round bottom and a narrow top.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Birne', definition: 'Eine süße Frucht mit rundem Boden und schmalem oberen Teil.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Zucchini', definition: 'A green summer squash with a mild flavor.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Zucchini', definition: 'Ein grüner Sommerkürbis mit mildem Geschmack.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Coffee', definition: 'A beverage made from roasted coffee beans.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Kaffee', definition: 'Ein Getränk aus gerösteten Kaffeebohnen.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Tea', definition: 'A beverage made by steeping herbal leaves in hot water.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Tee', definition: 'Ein Getränk, das durch Einweichen von Kräuterblättern in heißem Wasser hergestellt wird.', category_name: 'Food', level: 'Beginner', language_id: german.id },
    { name: 'Butter', definition: 'A solid dairy product made by churning cream.', category_name: 'Food', level: 'Beginner', language_id: english.id },
    { name: 'Butter', definition: 'Ein festes Milchprodukt, das durch Schlagen von Sahne hergestellt wird.', category_name: 'Food', level: 'Beginner', language_id: german.id },

    # Food - Intermediate
    { name: 'Beets', definition: 'A round root vegetable with dark red skin and sweet flesh.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Rote Beete', definition: 'Ein rundes Wurzelgemüse mit dunkelroter Haut und süßem Fleisch.', category_name: 'Food', level: 'Intermediate', language_id: german.id },
    { name: 'Blueberry', definition: 'A small, round, dark blue fruit that grows on bushes.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Blaubeere', definition: 'Eine kleine, runde, dunkelblaue Frucht, die an Büschen wächst.', category_name: 'Food', level: 'Intermediate', language_id: german.id },
    { name: 'Asparagus', definition: 'A green vegetable with long, thin stems and a pointed tip.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Spargel', definition: 'Ein grünes Gemüse mit langen, dünnen Stielen und einer spitzen Spitze.', category_name: 'Food', level: 'Intermediate', language_id: german.id },
    { name: 'Strawberry', definition: 'A sweet, red fruit with tiny seeds on its surface.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Erdbeere', definition: 'Eine süße, rote Frucht mit winzigen Samen auf ihrer Oberfläche.', category_name: 'Food', level: 'Intermediate', language_id: german.id },
    { name: 'Sweet Potato', definition: 'A root vegetable with a sweet, orange flesh.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Süßkartoffel', definition: 'Ein Wurzelgemüse mit süßem, orangefarbenem Fleisch.', category_name: 'Food', level: 'Intermediate', language_id: german.id },
    { name: 'Pasta', definition: 'A dish originally from Italy consisting of dough made from durum wheat and water, extruded or stamped into various shapes and typically cooked in boiling water.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Nudeln', definition: 'Ein Gericht ursprünglich aus Italien, bestehend aus Teig aus Hartweizen und Wasser, der zu verschiedenen Formen extrudiert oder gestanzt und typischerweise in kochendem Wasser gekocht wird.', category_name: 'Food', level: 'Intermediate', language_id: german.id },
    { name: 'Pizza', definition: 'A dish of Italian origin consisting of a flat, round base of dough baked with a topping of tomatoes and cheese, typically with added meat or vegetables.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Pizza', definition: 'Ein Gericht italienischer Herkunft, bestehend aus einer flachen, runden Teigbasis, gebacken mit einem Belag aus Tomaten und Käse, typischerweise mit zusätzlichem Fleisch oder Gemüse.', category_name: 'Food', level: 'Intermediate', language_id: german.id },
    { name: 'Salad', definition: 'A cold dish of various mixtures of raw or cooked vegetables, usually seasoned with oil, vinegar, or other dressing.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Salat', definition: 'Ein kaltes Gericht aus verschiedenen Mischungen von rohem oder gekochtem Gemüse, üblicherweise gewürzt mit Öl, Essig oder einem anderen Dressing.', category_name: 'Food', level: 'Intermediate', language_id: german.id },
    { name: 'Avocado', definition: 'A green, pear-shaped fruit with a large pit and creamy flesh.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Avocado', definition: 'Eine grüne, birnenförmige Frucht mit einem großen Kern und cremigem Fleisch.', category_name: 'Food', level: 'Intermediate', language_id: german.id },
    { name: 'Mushroom', definition: 'A type of fungus with a cap on a stem, some of which are edible.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Pilz', definition: 'Eine Art Pilz mit einer Kappe auf einem Stiel, von denen einige essbar sind.', category_name: 'Food', level: 'Intermediate', language_id: german.id },
    { name: 'Broccoli', definition: 'A green vegetable with a thick stem and a dense cluster of flower buds.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Brokkoli', definition: 'Ein grünes Gemüse mit einem dicken Stiel und einem dichten Büschel von Blütenknospen.', category_name: 'Food', level: 'Intermediate', language_id: german.id },
    { name: 'Chicken', definition: 'Meat from a domesticated bird often raised for eggs and meat.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Hähnchen', definition: 'Fleisch von einem domestizierten Vogel, der oft für Eier und Fleisch gezüchtet wird.', category_name: 'Food', level: 'Intermediate', language_id: german.id },
    { name: 'Yogurt', definition: 'A thick, creamy food made from milk soured by the addition of bacteria.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Joghurt', definition: 'Ein dickes, cremiges Lebensmittel, das aus durch den Zusatz von Bakterien gesäuerter Milch hergestellt wird.', category_name: 'Food', level: 'Intermediate', language_id: german.id },
    { name: 'Ketchup', definition: 'A sweet and tangy sauce made from tomatoes, vinegar, sugar, and spices.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Ketchup', definition: 'Eine süße und würzige Sauce aus Tomaten, Essig, Zucker und Gewürzen.', category_name: 'Food', level: 'Intermediate', language_id: german.id },
    { name: 'Mustard', definition: 'A condiment made from the seeds of a mustard plant, typically yellow or brown.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Senf', definition: 'Ein Gewürz, das aus den Samen einer Senfpflanze hergestellt wird, typischerweise gelb oder braun.', category_name: 'Food', level: 'Intermediate', language_id: german.id },
    { name: 'Olive Oil', definition: 'A liquid fat obtained from olives, used in cooking and dressings.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Olivenöl', definition: 'Ein flüssiges Fett, das aus Oliven gewonnen wird, verwendet in der Küche und für Dressings.', category_name: 'Food', level: 'Intermediate', language_id: german.id },
    { name: 'Peanut Butter', definition: 'A spread made from ground, dry-roasted peanuts.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Erdnussbutter', definition: 'Ein Aufstrich aus gemahlenen, trocken gerösteten Erdnüssen.', category_name: 'Food', level: 'Intermediate', language_id: german.id },
    { name: 'Rice', definition: 'A small white or brown grain that is a staple food in many countries.', category_name: 'Food', level: 'Intermediate', language_id: english.id },
    { name: 'Reis', definition: 'Ein kleines weißes oder braunes Korn, das in vielen Ländern ein Grundnahrungsmittel ist.', category_name: 'Food', level: 'Intermediate', language_id: german.id },

        # Food - Advanced
    { name: 'Sushi', definition: 'A Japanese dish consisting of small balls or rolls of vinegar-flavored cold rice served with a garnish of vegetables, egg, or raw seafood.', category_name: 'Food', level: 'Advanced', language_id: english.id },
    { name: 'Sushi', definition: 'Ein japanisches Gericht aus kleinen Bällen oder Rollen von essiggeschmacktem kaltem Reis, serviert mit einer Garnitur aus Gemüse, Ei oder rohem Meeresfrüchten.', category_name: 'Food', level: 'Advanced', language_id: german.id },
    { name: 'Steak', definition: 'High-quality beef taken from the hindquarters of the animal, typically cut into thick slices that are cooked by grilling or frying.', category_name: 'Food', level: 'Advanced', language_id: english.id },
    { name: 'Steak', definition: 'Hochwertiges Rindfleisch aus den Hinterläufen des Tieres, typischerweise in dicke Scheiben geschnitten, die durch Grillen oder Braten gekocht werden.', category_name: 'Food', level: 'Advanced', language_id: german.id },
    { name: 'Taco', definition: 'A Mexican dish consisting of a folded or rolled tortilla filled with various mixtures, such as seasoned meat, beans, lettuce, and tomatoes.', category_name: 'Food', level: 'Advanced', language_id: english.id },
    { name: 'Taco', definition: 'Ein mexikanisches Gericht, bestehend aus einer gefalteten oder gerollten Tortilla, gefüllt mit verschiedenen Mischungen, wie gewürztem Fleisch, Bohnen, Salat und Tomaten.', category_name: 'Food', level: 'Advanced', language_id: german.id },
    { name: 'Prosciutto', definition: 'An Italian dry-cured ham that is thinly sliced and served uncooked.', category_name: 'Food', level: 'Advanced', language_id: english.id },
    { name: 'Prosciutto', definition: 'Ein italienischer luftgetrockneter Schinken, der dünn geschnitten und roh serviert wird.', category_name: 'Food', level: 'Advanced', language_id: german.id },
    { name: 'Chutney', definition: 'A spicy condiment made of fruits or vegetables with vinegar, spices, and sugar.', category_name: 'Food', level: 'Advanced', language_id: english.id },
    { name: 'Chutney', definition: 'Ein würziges Kondiment aus Früchten oder Gemüse mit Essig, Gewürzen und Zucker.', category_name: 'Food', level: 'Advanced', language_id: german.id },
    { name: 'Tiramisu', definition: 'An Italian dessert made with layers of sponge cake soaked in coffee and brandy or liqueur, with powdered chocolate and mascarpone cheese.', category_name: 'Food', level: 'Advanced', language_id: english.id },
    { name: 'Tiramisu', definition: 'Ein italienisches Dessert aus Schichten von Biskuitkuchen, getränkt in Kaffee und Brandy oder Likör, mit Puderzucker und Mascarpone.', category_name: 'Food', level: 'Advanced', language_id: german.id },
    { name: 'Fennel Bulb', definition: 'A vegetable with a crunchy texture and a flavor similar to licorice.', category_name: 'Food', level: 'Advanced', language_id: english.id },
    { name: 'Fenchelknolle', definition: 'Ein Gemüse mit einer knackigen Textur und einem Geschmack ähnlich wie Lakritz.', category_name: 'Food', level: 'Advanced', language_id: german.id },
    { name: 'Parsley', definition: 'A green herb often used as a garnish or seasoning.', category_name: 'Food', level: 'Advanced', language_id: english.id },
    { name: 'Petersilie', definition: 'Ein grünes Kraut, das oft als Garnierung oder Gewürz verwendet wird.', category_name: 'Food', level: 'Advanced', language_id: german.id },
    { name: 'Rosemary', definition: 'A fragrant herb with needle-like leaves, used in cooking.', category_name: 'Food', level: 'Advanced', language_id: english.id },
    { name: 'Rosmarin', definition: 'Ein duftendes Kraut mit nadelähnlichen Blättern, verwendet beim Kochen.', category_name: 'Food', level: 'Advanced', language_id: german.id },
    { name: 'Olives', definition: 'Small, oval fruits that are usually pickled or used to make olive oil.', category_name: 'Food', level: 'Advanced', language_id: english.id },
    { name: 'Oliven', definition: 'Kleine, ovale Früchte, die üblicherweise eingelegt oder zur Herstellung von Olivenöl verwendet werden.', category_name: 'Food', level: 'Advanced', language_id: german.id },
    { name: 'Soy Sauce', definition: 'A dark, salty sauce made from fermented soybeans.', category_name: 'Food', level: 'Advanced', language_id: english.id },
    { name: 'Sojasauce', definition: 'Eine dunkle, salzige Sauce aus fermentierten Sojabohnen.', category_name: 'Food', level: 'Advanced', language_id: german.id },
    { name: 'Vinegar', definition: 'A sour liquid made by fermenting ethanol, used in cooking and pickling.', category_name: 'Food', level: 'Advanced', language_id: english.id },
    { name: 'Essig', definition: 'Eine saure Flüssigkeit, hergestellt durch die Fermentation von Ethanol, verwendet beim Kochen und Einlegen.', category_name: 'Food', level: 'Advanced', language_id: german.id },
    { name: 'Tahini', definition: 'A paste made from ground sesame seeds, used in Middle Eastern cuisine.', category_name: 'Food', level: 'Advanced', language_id: english.id },
    { name: 'Tahini', definition: 'Eine Paste aus gemahlenen Sesamsamen, verwendet in der nahöstlichen Küche.', category_name: 'Food', level: 'Advanced', language_id: german.id },
    { name: 'Quinoa', definition: 'A high-protein grain from the Andean region, used as a food staple.', category_name: 'Food', level: 'Advanced', language_id: english.id },
    { name: 'Quinoa', definition: 'Ein eiweißreiches Korn aus der Andenregion, verwendet als Grundnahrungsmittel.', category_name: 'Food', level: 'Advanced', language_id: german.id },


    # Travel
    # Travel - Beginner
    { name: 'Airport', definition: 'A complex of runways and buildings for the takeoff, landing, and maintenance of civil aircraft, with facilities for passengers.', category_name: 'Travel', level: 'Beginner', language_id: english.id },
    { name: 'Flughafen', definition: 'Ein Komplex von Start- und Landebahnen und Gebäuden für den Start, die Landung und die Wartung von Zivilflugzeugen, mit Einrichtungen für Passagiere.', category_name: 'Travel', level: 'Beginner', language_id: german.id },
    { name: 'Hotel', definition: 'An establishment providing accommodation, meals, and other services for travelers and tourists.', category_name: 'Travel', level: 'Beginner', language_id: english.id },
    { name: 'Hotel', definition: 'Ein Etablissement, das Unterkunft, Mahlzeiten und andere Dienstleistungen für Reisende und Touristen bietet.', category_name: 'Travel', level: 'Beginner', language_id: german.id },
    { name: 'Passport', definition: 'An official document issued by a government, certifying the holder\'s identity and citizenship and entitling them to travel under its protection to and from foreign countries.', category_name: 'Travel', level: 'Beginner', language_id: english.id },
    { name: 'Reisepass', definition: 'Ein offizielles Dokument, das von einer Regierung ausgestellt wird und die Identität und Staatsbürgerschaft des Inhabers bestätigt und ihm das Reisen unter ihrem Schutz von und zu fremden Ländern ermöglicht.', category_name: 'Travel', level: 'Beginner', language_id: german.id },
    { name: 'Bus', definition: 'A large motor vehicle carrying passengers by road.', category_name: 'Travel', level: 'Beginner', language_id: english.id },
    { name: 'Bus', definition: 'Ein großes Kraftfahrzeug, das Passagiere auf der Straße befördert.', category_name: 'Travel', level: 'Beginner', language_id: german.id },
    { name: 'Car', definition: 'A road vehicle, typically with four wheels, powered by an internal combustion engine.', category_name: 'Travel', level: 'Beginner', language_id: english.id },
    { name: 'Auto', definition: 'Ein Straßenfahrzeug, typischerweise mit vier Rädern, das von einem Verbrennungsmotor angetrieben wird.', category_name: 'Travel', level: 'Beginner', language_id: german.id },
    { name: 'Train', definition: 'A series of connected vehicles that run on tracks and are used as a form of transportation.', category_name: 'Travel', level: 'Beginner', language_id: english.id },
    { name: 'Zug', definition: 'Eine Serie verbundener Fahrzeuge, die auf Gleisen fahren und als Transportmittel verwendet werden.', category_name: 'Travel', level: 'Beginner', language_id: german.id },
    { name: 'Plane', definition: 'An aircraft that has a fixed wing and is powered by propellers or jets.', category_name: 'Travel', level: 'Beginner', language_id: english.id },
    { name: 'Flugzeug', definition: 'Ein Luftfahrzeug, das feste Flügel hat und von Propellern oder Düsen angetrieben wird.', category_name: 'Travel', level: 'Beginner', language_id: german.id },
    { name: 'Map', definition: 'A diagrammatic representation of an area of land or sea showing physical features.', category_name: 'Travel', level: 'Beginner', language_id: english.id },
    { name: 'Karte', definition: 'Eine diagrammatische Darstellung eines Gebiets von Land oder Meer, die physische Merkmale zeigt.', category_name: 'Travel', level: 'Beginner', language_id: german.id },
    { name: 'Luggage', definition: 'Suitcases or other bags in which to pack personal belongings for traveling.', category_name: 'Travel', level: 'Beginner', language_id: english.id },
    { name: 'Gepäck', definition: 'Koffer oder andere Taschen, in die man persönliche Dinge zum Reisen packen kann.', category_name: 'Travel', level: 'Beginner', language_id: german.id },
    { name: 'Taxi', definition: 'A car licensed to transport passengers in return for payment of a fare.', category_name: 'Travel', level: 'Beginner', language_id: english.id },
    { name: 'Taxi', definition: 'Ein Auto, das lizenziert ist, um Passagiere gegen Bezahlung eines Fahrpreises zu befördern.', category_name: 'Travel', level: 'Beginner', language_id: german.id },
    { name: 'Subway', definition: 'An underground electric railway system in a city.', category_name: 'Travel', level: 'Beginner', language_id: english.id },
    { name: 'U-Bahn', definition: 'Ein unterirdisches elektrisches Bahnsystem in einer Stadt.', category_name: 'Travel', level: 'Beginner', language_id: german.id },
    { name: 'Bicycle', definition: 'A vehicle composed of two wheels held in a frame one behind the other, propelled by pedals and steered with handlebars attached to the front wheel.', category_name: 'Travel', level: 'Beginner', language_id: english.id },
    { name: 'Fahrrad', definition: 'Ein Fahrzeug, das aus zwei Rädern besteht, die in einem Rahmen hintereinander gehalten werden, durch Pedale angetrieben und mit einem Lenker am Vorderrad gesteuert werden.', category_name: 'Travel', level: 'Beginner', language_id: german.id },
    { name: 'Motorcycle', definition: 'A two-wheeled vehicle that is powered by a motor and has no pedals.', category_name: 'Travel', level: 'Beginner', language_id: english.id },
    { name: 'Motorrad', definition: 'Ein zweirädriges Fahrzeug, das von einem Motor angetrieben wird und keine Pedale hat.', category_name: 'Travel', level: 'Beginner', language_id: german.id },
    { name: 'Cruise', definition: 'A vacation spent on a ship or boat.', category_name: 'Travel', level: 'Beginner', language_id: english.id },
    { name: 'Kreuzfahrt', definition: 'Ein Urlaub auf einem Schiff oder Boot.', category_name: 'Travel', level: 'Beginner', language_id: german.id },

 # Travel - Intermediate
    { name: 'Tour', definition: 'A journey for pleasure in which several different places are visited.', category_name: 'Travel', level: 'Intermediate', language_id: english.id },
    { name: 'Tour', definition: 'Eine Reise zum Vergnügen, bei der mehrere verschiedene Orte besucht werden.', category_name: 'Travel', level: 'Intermediate', language_id: german.id },
    { name: 'Journey', definition: 'An act of traveling from one place to another.', category_name: 'Travel', level: 'Intermediate', language_id: english.id },
    { name: 'Reise', definition: 'Eine Handlung des Reisens von einem Ort zum anderen.', category_name: 'Travel', level: 'Intermediate', language_id: german.id },
    { name: 'Adventure', definition: 'An unusual and exciting, typically hazardous, experience or activity.', category_name: 'Travel', level: 'Intermediate', language_id: english.id },
    { name: 'Abenteuer', definition: 'Eine ungewöhnliche und aufregende, typischerweise gefährliche Erfahrung oder Aktivität.', category_name: 'Travel', level: 'Intermediate', language_id: german.id },
    { name: 'Backpack', definition: 'A bag carried on one\'s back, typically with two shoulder straps.', category_name: 'Travel', level: 'Intermediate', language_id: english.id },
    { name: 'Rucksack', definition: 'Eine Tasche, die auf dem Rücken getragen wird, typischerweise mit zwei Schultergurten.', category_name: 'Travel', level: 'Intermediate', language_id: german.id },
    { name: 'Reservation', definition: 'The action of reserving something, such as a seat on a plane or a room in a hotel.', category_name: 'Travel', level: 'Intermediate', language_id: english.id },
    { name: 'Reservierung', definition: 'Die Handlung, etwas zu reservieren, wie einen Sitzplatz in einem Flugzeug oder ein Zimmer in einem Hotel.', category_name: 'Travel', level: 'Intermediate', language_id: german.id },
    { name: 'Itinerary', definition: 'A planned route or journey.', category_name: 'Travel', level: 'Intermediate', language_id: english.id },
    { name: 'Reiseroute', definition: 'Eine geplante Route oder Reise.', category_name: 'Travel', level: 'Intermediate', language_id: german.id },
    { name: 'Tourist', definition: 'A person who is traveling or visiting a place for pleasure.', category_name: 'Travel', level: 'Intermediate', language_id: english.id },
    { name: 'Tourist', definition: 'Eine Person, die reist oder einen Ort zum Vergnügen besucht.', category_name: 'Travel', level: 'Intermediate', language_id: german.id },
    { name: 'Souvenir', definition: 'A thing that is kept as a reminder of a person, place, or event.', category_name: 'Travel', level: 'Intermediate', language_id: english.id },
    { name: 'Souvenir', definition: 'Ein Gegenstand, der als Erinnerung an eine Person, einen Ort oder ein Ereignis aufbewahrt wird.', category_name: 'Travel',level: 'Intermediate', language_id: german.id },


    # Travel - Advanced
    { name: 'Excursion', definition: 'A short journey or trip, especially one engaged in as a leisure activity.', category_name: 'Travel', level: 'Advanced', language_id: english.id },
    { name: 'Ausflug', definition: 'Eine kurze Reise oder Fahrt, insbesondere eine als Freizeitaktivität unternommene.', category_name: 'Travel', level: 'Advanced', language_id: german.id },
    { name: 'Expedition', definition: 'A journey undertaken by a group of people with a particular purpose, especially that of exploration, research, or war.', category_name: 'Travel', level: 'Advanced', language_id: english.id },
    { name: 'Expedition', definition: 'Eine Reise, die von einer Gruppe von Personen mit einem bestimmten Zweck unternommen wird, insbesondere zur Erkundung, Forschung oder im Krieg.', category_name: 'Travel', level: 'Advanced', language_id: german.id },
    { name: 'Voyage', definition: 'A long journey involving travel by sea or in space.', category_name: 'Travel', level: 'Advanced', language_id: english.id },
    { name: 'Reise', definition: 'Eine lange Reise, die Reisen auf See oder im Weltraum beinhaltet.', category_name: 'Travel', level: 'Advanced', language_id: german.id },
    { name: 'Customs', definition: 'The place at an airport, border, etc., where government officials check people and goods entering a country.', category_name: 'Travel', level: 'Advanced', language_id: english.id },
    { name: 'Zoll', definition: 'Der Ort an einem Flughafen, einer Grenze usw., an dem Regierungsbeamte Personen und Waren überprüfen, die in ein Land einreisen.', category_name: 'Travel', level: 'Advanced', language_id: german.id },
    { name: 'Embassy', definition: 'The official residence or offices of an ambassador.', category_name: 'Travel', level: 'Advanced', language_id: english.id },
    { name: 'Botschaft', definition: 'Der offizielle Wohnsitz oder die Büros eines Botschafters.', category_name: 'Travel', level: 'Advanced', language_id: german.id },
    { name: 'Transit', definition: 'The carrying of people, goods, or materials from one place to another.', category_name: 'Travel', level: 'Advanced', language_id: english.id },
    { name: 'Transit', definition: 'Der Transport von Personen, Gütern oder Materialien von einem Ort zum anderen.', category_name: 'Travel', level: 'Advanced', language_id: german.id },

    # Home - Beginner
    { name: 'House', definition: 'A building for human habitation, especially one that is lived in by a family or small group of people.', category_name: 'Home', level: 'Beginner', language_id: english.id },
    { name: 'Haus', definition: 'Ein Gebäude zum menschlichen Wohnen, insbesondere eines, in dem eine Familie oder eine kleine Gruppe von Menschen lebt.', category_name: 'Home', level: 'Beginner', language_id: german.id },
    { name: 'Kitchen', definition: 'A room or area where food is prepared and cooked.', category_name: 'Home', level: 'Beginner', language_id: english.id },
    { name: 'Küche', definition: 'Ein Raum oder Bereich, in dem Essen zubereitet und gekocht wird.', category_name: 'Home', level: 'Beginner', language_id: german.id },
    { name: 'Bedroom', definition: 'A room for sleeping in.', category_name: 'Home', level: 'Beginner', language_id: english.id },
    { name: 'Schlafzimmer', definition: 'Ein Raum zum Schlafen.', category_name: 'Home', level: 'Beginner', language_id: german.id },
    { name: 'Chair', definition: 'A piece of furniture for one person to sit on.', category_name: 'Home', level: 'Beginner', language_id: english.id },
    { name: 'Stuhl', definition: 'Ein Möbelstück, auf dem eine Person sitzen kann.', category_name: 'Home', level: 'Beginner', language_id: german.id },
    { name: 'Table', definition: 'A piece of furniture with a flat top and one or more legs.', category_name: 'Home', level: 'Beginner', language_id: english.id },
    { name: 'Tisch', definition: 'Ein Möbelstück mit einer flachen Oberseite und einem oder mehreren Beinen.', category_name: 'Home', level: 'Beginner', language_id: german.id },
    { name: 'Bed', definition: 'A piece of furniture for sleeping on.', category_name: 'Home', level: 'Beginner', language_id: english.id },
    { name: 'Bett', definition: 'Ein Möbelstück zum Schlafen.', category_name: 'Home', level: 'Beginner', language_id: german.id },
    { name: 'Lamp', definition: 'A device for giving light.', category_name: 'Home', level: 'Beginner', language_id: english.id },
    { name: 'Lampe', definition: 'Ein Gerät zum Leuchten.', category_name: 'Home', level: 'Beginner', language_id: german.id },
    { name: 'Window', definition: 'An opening in a wall or door that usually contains a sheet of glass.', category_name: 'Home', level: 'Beginner', language_id: english.id },
    { name: 'Fenster', definition: 'Eine Öffnung in einer Wand oder Tür, die normalerweise eine Glasscheibe enthält.', category_name: 'Home', level: 'Beginner', language_id: german.id },

    # Home - Intermediate
    { name: 'Bathroom', definition: 'A room containing a bathtub or shower and usually also a washbasin and a toilet.', category_name: 'Home', level: 'Intermediate', language_id: english.id },
    { name: 'Badezimmer', definition: 'Ein Raum mit einer Badewanne oder Dusche und normalerweise auch einem Waschbecken und einer Toilette.', category_name: 'Home', level: 'Intermediate', language_id: german.id },
    { name: 'Living Room', definition: 'A room in a house for general and informal everyday use.', category_name: 'Home', level: 'Intermediate', language_id: english.id },
    { name: 'Wohnzimmer', definition: 'Ein Raum in einem Haus für allgemeinen und informellen täglichen Gebrauch.', category_name: 'Home', level: 'Intermediate', language_id: german.id },
    { name: 'Garden', definition: 'A piece of ground, often near a house, used for growing flowers, fruit, or vegetables.', category_name: 'Home', level: 'Intermediate', language_id: english.id },
    { name: 'Garten', definition: 'Ein Stück Land, oft in der Nähe eines Hauses, zum Anbau von Blumen, Obst oder Gemüse.', category_name: 'Home', level: 'Intermediate', language_id: german.id },
    { name: 'Couch', definition: 'A long upholstered piece of furniture for several people to sit on.', category_name: 'Home', level: 'Intermediate', language_id: english.id },
    { name: 'Couch', definition: 'Ein langes gepolstertes Möbelstück, auf dem mehrere Personen sitzen können.', category_name: 'Home', level: 'Intermediate', language_id: german.id },
    { name: 'Bookshelf', definition: 'A piece of furniture with shelves for storing books.', category_name: 'Home', level: 'Intermediate', language_id: english.id },
    { name: 'Bücherregal', definition: 'Ein Möbelstück mit Regalen zur Aufbewahrung von Büchern.', category_name: 'Home', level: 'Intermediate', language_id: german.id },
    { name: 'Closet', definition: 'A small room or space for storing clothes.', category_name: 'Home', level: 'Intermediate', language_id: english.id },
    { name: 'Schrank', definition: 'Ein kleiner Raum oder Platz zur Aufbewahrung von Kleidung.', category_name: 'Home', level: 'Intermediate', language_id: german.id },
    { name: 'Curtains', definition: 'Pieces of cloth that hang down from above a window and can be pulled together to cover the window.', category_name: 'Home', level: 'Intermediate', language_id: english.id },
    { name: 'Vorhänge', definition: 'Stoffstücke, die von oben vor einem Fenster herabhängen und zusammengezogen werden können, um das Fenster zu bedecken.', category_name: 'Home', level: 'Intermediate', language_id: german.id },
    { name: 'Microwave', definition: 'A kitchen appliance used for heating food quickly.', category_name: 'Home', level: 'Intermediate', language_id: english.id },
    { name: 'Mikrowelle', definition: 'Ein Küchengerät zum schnellen Erwärmen von Essen.', category_name: 'Home', level: 'Intermediate', language_id: german.id },

    # Home - Advanced
    { name: 'Garage', definition: 'A building for housing a motor vehicle or vehicles.', category_name: 'Home', level: 'Advanced', language_id: english.id },
    { name: 'Garage', definition: 'Ein Gebäude zum Unterstellen eines oder mehrerer Kraftfahrzeuge.', category_name: 'Home', level: 'Advanced', language_id: german.id },
    { name: 'Basement', definition: 'The floor of a building which is partly or entirely below ground level.', category_name: 'Home', level: 'Advanced', language_id: english.id },
    { name: 'Keller', definition: 'Das Geschoss eines Gebäudes, das teilweise oder ganz unter der Erdoberfläche liegt.', category_name: 'Home', level: 'Advanced', language_id: german.id },
    { name: 'Attic', definition: 'A space or room just below the roof of a building.', category_name: 'Home', level: 'Advanced', language_id: english.id },
    { name: 'Dachboden', definition: 'Ein Raum oder Bereich direkt unter dem Dach eines Gebäudes.', category_name: 'Home', level: 'Advanced', language_id: german.id },
    { name: 'Chandelier', definition: 'A decorative hanging light with branches for several light bulbs or candles.', category_name: 'Home', level: 'Advanced', language_id: english.id },
    { name: 'Kronleuchter', definition: 'Ein dekoratives Hängeleuchte mit Armen für mehrere Glühbirnen oder Kerzen.', category_name: 'Home', level: 'Advanced', language_id: german.id },
    { name: 'Dishwasher', definition: 'A machine for washing dishes automatically.', category_name: 'Home', level: 'Advanced', language_id: english.id },
    { name: 'Geschirrspüler', definition: 'Eine Maschine zum automatischen Waschen von Geschirr.', category_name: 'Home', level: 'Advanced', language_id: german.id },
    { name: 'Air Conditioner', definition: 'A system for controlling the humidity, ventilation, and temperature in a building.', category_name: 'Home', level: 'Advanced', language_id: english.id },
    { name: 'Klimaanlage', definition: 'Ein System zur Kontrolle der Luftfeuchtigkeit, Belüftung und Temperatur in einem Gebäude.', category_name: 'Home', level: 'Advanced', language_id: german.id },
    { name: 'Refrigerator', definition: 'An appliance for keeping food and drinks cold.', category_name: 'Home', level: 'Advanced', language_id: english.id },
    { name: 'Kühlschrank', definition: 'Ein Gerät zum Kühlen von Lebensmitteln und Getränken.', category_name: 'Home', level: 'Advanced', language_id: german.id },
    { name: 'Fireplace', definition: 'A structure made of brick, stone, or metal designed to contain a fire.', category_name: 'Home', level: 'Advanced', language_id: english.id },
    { name: 'Kamin', definition: 'Eine aus Ziegeln, Steinen oder Metall gefertigte Struktur, die dazu dient, ein Feuer zu beherbergen.', category_name: 'Home', level: 'Advanced', language_id: german.id },

    # Animals
    # Animals - Beginner
    { name: 'Dog', definition: 'A domesticated carnivorous mammal that typically has a long snout, an acute sense of smell, non-retractable claws, and a barking, howling, or whining voice.', category_name: 'Animals', level: 'Beginner', language_id: english.id },
    { name: 'Hund', definition: 'Ein domestiziertes fleischfressendes Säugetier, das typischerweise eine lange Schnauze, einen scharfen Geruchssinn, nicht einziehbare Krallen und eine bellende, heulende oder winselnde Stimme hat.', category_name: 'Animals', level: 'Beginner', language_id: german.id },
    { name: 'Cat', definition: 'A small domesticated carnivorous mammal with soft fur, a short snout, and retractile claws.', category_name: 'Animals', level: 'Beginner', language_id: english.id },
    { name: 'Katze', definition: 'Ein kleines domestiziertes fleischfressendes Säugetier mit weichem Fell, einer kurzen Schnauze und einziehbaren Krallen.', category_name: 'Animals', level: 'Beginner', language_id: german.id },
    { name: 'Bird', definition: 'A warm-blooded egg-laying vertebrate distinguished by the possession of feathers, wings, and a beak and (typically) by being able to fly.', category_name: 'Animals', level: 'Beginner', language_id: english.id },
    { name: 'Vogel', definition: 'Ein warmblütiges, eierlegendes Wirbeltier, das sich durch den Besitz von Federn, Flügeln und einem Schnabel auszeichnet und (typischerweise) fliegen kann.', category_name: 'Animals', level: 'Beginner', language_id: german.id },
    { name: 'Fish', definition: 'A limbless cold-blooded vertebrate animal with gills and fins and living wholly in water.', category_name: 'Animals', level: 'Beginner', language_id: english.id },
    { name: 'Fisch', definition: 'Ein gliedmaßenloses, kaltblütiges Wirbeltier mit Kiemen und Flossen, das ganz im Wasser lebt.', category_name: 'Animals', level: 'Beginner', language_id: german.id },
    { name: 'Rabbit', definition: 'A burrowing, gregarious, plant-eating mammal with long ears, long hind legs, and a short tail.', category_name: 'Animals', level: 'Beginner', language_id: english.id },
    { name: 'Kaninchen', definition: 'Ein grabendes, geselliges, pflanzenfressendes Säugetier mit langen Ohren, langen Hinterbeinen und einem kurzen Schwanz.', category_name: 'Animals', level: 'Beginner', language_id: german.id },
    { name: 'Horse', definition: 'A large plant-eating domesticated mammal with solid hoofs and a flowing mane and tail, used for riding, racing, and to carry and pull loads.', category_name: 'Animals', level: 'Beginner', language_id: english.id },
    { name: 'Pferd', definition: 'Ein großes pflanzenfressendes domestiziertes Säugetier mit festen Hufen und einer fließenden Mähne und Schwanz, das zum Reiten, Rennen und zum Tragen und Ziehen von Lasten verwendet wird.', category_name: 'Animals', level: 'Beginner', language_id: german.id },

    # Animals - Intermediate
    { name: 'Elephant', definition: 'A large mammal with a trunk, native to Africa and southern Asia.', category_name: 'Animals', level: 'Intermediate', language_id: english.id },
    { name: 'Elefant', definition: 'Ein großes Säugetier mit einem Rüssel, heimisch in Afrika und Südasien.', category_name: 'Animals', level: 'Intermediate', language_id: german.id },
    { name: 'Giraffe', definition: 'An African mammal with a very long neck and forelegs, having a coat patterned with brown patches separated by lighter lines. It is the tallest living animal.', category_name: 'Animals', level: 'Intermediate', language_id: english.id },
    { name: 'Giraffe', definition: 'Ein afrikanisches Säugetier mit einem sehr langen Hals und Vorderbeinen, das ein Fellmuster mit braunen Flecken hat, die durch hellere Linien getrennt sind. Es ist das höchste lebende Tier.', category_name: 'Animals', level: 'Intermediate', language_id: german.id },
    { name: 'Dolphin', definition: 'A small gregarious toothed whale that typically has a beaklike snout and a curved fin on the back.', category_name: 'Animals', level: 'Intermediate', language_id: english.id },
    { name: 'Delfin', definition: 'Ein kleiner geselliger Zahnwal, der typischerweise eine schnabelartige Schnauze und eine gebogene Flosse auf dem Rücken hat.', category_name: 'Animals', level: 'Intermediate', language_id: german.id },

    # Animals - Advanced
    { name: 'Penguin', definition: 'A large flightless seabird of the southern hemisphere, with black upper parts and white underparts and wings developed into flippers for swimming underwater.', category_name: 'Animals', level: 'Advanced', language_id: english.id },
    { name: 'Pinguin', definition: 'Ein großer flugunfähiger Seevogel der südlichen Hemisphäre, mit schwarzen Oberseiten und weißen Unterseiten und zu Flossen entwickelten Flügeln zum Schwimmen unter Wasser.', category_name: 'Animals', level: 'Advanced', language_id: german.id },
    { name: 'Kangaroo', definition: 'A large plant-eating marsupial with a long powerful tail and strongly developed hind limbs that enable it to travel by leaping, found only in Australia and New Guinea.', category_name: 'Animals', level: 'Advanced', language_id: english.id },
    { name: 'Känguru', definition: 'Ein großes pflanzenfressendes Beuteltier mit einem langen kräftigen Schwanz und stark entwickelten Hintergliedmaßen, das es ihm ermöglichen, durch Springen zu reisen, findet sich nur in Australien und Neuguinea.', category_name: 'Animals', level: 'Advanced', language_id: german.id },
    { name: 'Panda', definition: 'A large bearlike mammal with characteristic black and white markings, native to certain mountain forests in China. It feeds almost entirely on bamboo and has become increasingly rare.', category_name: 'Animals', level: 'Advanced', language_id: english.id },
    { name: 'Panda', definition: 'Ein großes bärähnliches Säugetier mit charakteristischen schwarz-weißen Markierungen, heimisch in bestimmten Bergwäldern Chinas. Es ernährt sich fast ausschließlich von Bambus und ist zunehmend seltener geworden.', category_name: 'Animals', level: 'Advanced', language_id: german.id },

    # Clothing
    # Clothing - Beginner
    { name: 'Shirt', definition: 'A cloth garment for the upper body.', category_name: 'Clothing', level: 'Beginner', language_id: english.id },
    { name: 'Hemd', definition: 'Ein Kleidungsstück aus Stoff für den Oberkörper.', category_name: 'Clothing', level: 'Beginner', language_id: german.id },
    { name: 'Pants', definition: 'A piece of clothing worn on the lower half of the body.', category_name: 'Clothing', level: 'Beginner', language_id: english.id },
    { name: 'Hose', definition: 'Ein Kleidungsstück, das an der unteren Körperhälfte getragen wird.', category_name: 'Clothing', level: 'Beginner', language_id: german.id },
    { name: 'T-shirt', definition: 'A short-sleeved casual top.', category_name: 'Clothing', level: 'Beginner', language_id: english.id },
    { name: 'T-Shirt', definition: 'Ein kurzärmeliges Freizeitoberteil.', category_name: 'Clothing', level: 'Beginner', language_id: german.id },
    { name: 'Shoes', definition: 'A covering for the foot, typically made of leather, having a sturdy sole and not reaching above the ankle.', category_name: 'Clothing', level: 'Beginner', language_id: english.id },
    { name: 'Schuhe', definition: 'Eine Bedeckung für den Fuß, typischerweise aus Leder, mit einer robusten Sohle und nicht über den Knöchel reichend.', category_name: 'Clothing', level: 'Beginner', language_id: german.id },
    { name: 'Hat', definition: 'A head covering that can be made of various materials and worn for warmth, fashion, or protection.', category_name: 'Clothing', level: 'Beginner', language_id: english.id },
    { name: 'Hut', definition: 'Eine Kopfbedeckung, die aus verschiedenen Materialien hergestellt und zur Wärme, Mode oder zum Schutz getragen werden kann.', category_name: 'Clothing', level: 'Beginner', language_id: german.id },
    { name: 'Skirt', definition: 'A woman\'s outer garment fastened around the waist and hanging down around the legs.', category_name: 'Clothing', level: 'Beginner', language_id: english.id },
    { name: 'Rock', definition: 'Ein äußeres Kleidungsstück für Frauen, das um die Taille befestigt und um die Beine herabhängt.', category_name: 'Clothing', level: 'Beginner', language_id: german.id },
    { name: 'Jacket', definition: 'A garment for the upper body, typically having a front opening, collar, lapels, sleeves, and pockets.', category_name: 'Clothing', level: 'Beginner', language_id: english.id },
    { name: 'Jacke', definition: 'Ein Kleidungsstück für den Oberkörper, typischerweise mit einer vorderen Öffnung, Kragen, Revers, Ärmeln und Taschen.', category_name: 'Clothing', level: 'Beginner', language_id: german.id },
    { name: 'Socks', definition: 'A soft covering for the foot, usually made of wool, cotton, or nylon.', category_name: 'Clothing', level: 'Beginner', language_id: english.id },
    { name: 'Socken', definition: 'Eine weiche Bedeckung für den Fuß, üblicherweise aus Wolle, Baumwolle oder Nylon.', category_name: 'Clothing', level: 'Beginner', language_id: german.id },
    { name: 'Shorts', definition: 'Short trousers that reach only to the knees or thighs.', category_name: 'Clothing', level: 'Beginner', language_id: english.id },
    { name: 'Shorts', definition: 'Kurze Hosen, die nur bis zu den Knien oder Oberschenkeln reichen.', category_name: 'Clothing', level: 'Beginner', language_id: german.id },
    { name: 'Dress', definition: 'A one-piece garment for a woman or girl that covers the body and extends down over the legs.', category_name: 'Clothing', level: 'Beginner', language_id: english.id },
    { name: 'Kleid', definition: 'Ein einteiliges Kleidungsstück für eine Frau oder ein Mädchen, das den Körper bedeckt und über die Beine reicht.', category_name: 'Clothing', level: 'Beginner', language_id: german.id },
    { name: 'Belt', definition: 'A strip of leather or other material worn around the waist to support or hold in clothes.', category_name: 'Clothing', level: 'Beginner', language_id: english.id },
    { name: 'Gürtel', definition: 'Ein Streifen aus Leder oder einem anderen Material, der um die Taille getragen wird, um Kleidung zu stützen oder zu halten.', category_name: 'Clothing', level: 'Beginner', language_id: german.id },
    { name: 'Cap', definition: 'A soft, flat hat without a brim and typically with a peak.', category_name: 'Clothing', level: 'Beginner', language_id: english.id },
    { name: 'Mütze', definition: 'Eine weiche, flache Kopfbedeckung ohne Krempe und typischerweise mit einem Schirm.', category_name: 'Clothing', level: 'Beginner', language_id: german.id },

    # Clothing - Intermediate
    { name: 'Dress', definition: 'A one-piece garment for a woman or girl.', category_name: 'Clothing', level: 'Intermediate', language_id: english.id },
    { name: 'Kleid', definition: 'Ein einteiliges Kleidungsstück für eine Frau oder ein Mädchen.', category_name: 'Clothing', level: 'Intermediate', language_id: german.id },
    { name: 'Blazer', definition: 'A lightweight jacket, typically in a solid color.', category_name: 'Clothing', level: 'Intermediate', language_id: english.id },
    { name: 'Blazer', definition: 'Eine leichte Jacke, üblicherweise in einer einfarbigen Farbe.', category_name: 'Clothing', level: 'Intermediate', language_id: german.id },
    { name: 'Blouse', definition: 'A woman\'s loose upper garment resembling a shirt, typically with a collar, buttons, and sleeves.', category_name: 'Clothing', level: 'Intermediate', language_id: english.id },
    { name: 'Bluse', definition: 'Ein lockeres Oberkleidungsstück für Frauen, ähnlich einem Hemd, typischerweise mit Kragen, Knöpfen und Ärmeln.', category_name: 'Clothing', level: 'Intermediate', language_id: german.id },
    { name: 'Sweater', definition: 'A knitted garment typically with long sleeves, worn over the upper body.', category_name: 'Clothing', level: 'Intermediate', language_id: english.id },
    { name: 'Pullover', definition: 'Ein gestricktes Kleidungsstück, üblicherweise mit langen Ärmeln, das über dem Oberkörper getragen wird.', category_name: 'Clothing', level: 'Intermediate', language_id: german.id },
    { name: 'Jeans', definition: 'Denim pants that are typically blue in color.', category_name: 'Clothing', level: 'Intermediate', language_id: english.id },
    { name: 'Jeans', definition: 'Denimhosen, die üblicherweise blau sind.', category_name: 'Clothing', level: 'Intermediate', language_id: german.id },
    { name: 'Scarf', definition: 'A length or square of fabric worn around the neck or head.', category_name: 'Clothing', level: 'Intermediate', language_id: english.id },
    { name: 'Schal', definition: 'Ein langes oder quadratisches Stück Stoff, das um den Hals oder Kopf getragen wird.', category_name: 'Clothing', level: 'Intermediate', language_id: german.id },
    { name: 'Gloves', definition: 'Hand coverings with separate sections for each finger and the thumb.', category_name: 'Clothing', level: 'Intermediate', language_id: english.id },
    { name: 'Handschuhe', definition: 'Handbekleidung mit separaten Abschnitten für jeden Finger und den Daumen.', category_name: 'Clothing', level: 'Intermediate', language_id: german.id },
    { name: 'Vest', definition: 'A sleeveless garment worn on the upper body, often under a jacket.', category_name: 'Clothing', level: 'Intermediate', language_id: english.id },
    { name: 'Weste', definition: 'Ein ärmelloses Kleidungsstück, das am Oberkörper getragen wird, oft unter einer Jacke.', category_name: 'Clothing', level: 'Intermediate', language_id: german.id },
    { name: 'Sandals', definition: 'A light shoe with straps that go over the top of the foot and around the ankle.', category_name: 'Clothing', level: 'Intermediate', language_id: english.id },
    { name: 'Sandalen', definition: 'Ein leichter Schuh mit Riemen, die über den Fußrücken und um die Knöchel gehen.', category_name: 'Clothing', level: 'Intermediate', language_id: german.id },
    { name: 'Tie', definition: 'A piece of cloth worn around the neck, usually under the collar of a shirt, and tied in a knot at the front.', category_name: 'Clothing', level: 'Intermediate', language_id: english.id },
    { name: 'Krawatte', definition: 'Ein Stück Stoff, das um den Hals getragen wird, üblicherweise unter dem Kragen eines Hemdes, und vorne zu einem Knoten gebunden ist.', category_name: 'Clothing', level: 'Intermediate', language_id: german.id },
    { name: 'Overcoat', definition: 'A long warm coat worn over other clothing.', category_name: 'Clothing', level: 'Intermediate', language_id: english.id },
    { name: 'Mantel', definition: 'Ein langer, warmer Mantel, der über anderer Kleidung getragen wird.', category_name: 'Clothing', level: 'Intermediate', language_id: german.id },
    { name: 'Hoodie', definition: 'A sweatshirt with a hood.', category_name: 'Clothing', level: 'Intermediate', language_id: english.id },
    { name: 'Kapuzenpullover', definition: 'Ein Sweatshirt mit Kapuze.', category_name: 'Clothing', level: 'Intermediate', language_id: german.id },


    # Clothing - Advanced
    { name: 'Tuxedo', definition: 'A formal evening suit.', category_name: 'Clothing', level: 'Advanced', language_id: english.id },
    { name: 'Smoking', definition: 'Ein formeller Abendanzug.', category_name: 'Clothing', level: 'Advanced', language_id: german.id },
    { name: 'Blazer', definition: 'A lightweight jacket, typically in a solid color, worn as part of a uniform or as smart casual wear.', category_name: 'Clothing', level: 'Advanced', language_id: english.id },
    { name: 'Blazer', definition: 'Eine leichte Jacke, typischerweise in einer einfarbigen Farbe, als Teil einer Uniform oder als elegante Freizeitkleidung getragen.', category_name: 'Clothing', level: 'Advanced', language_id: german.id },
    { name: 'Cardigan', definition: 'A knitted sweater that opens at the front.', category_name: 'Clothing', level: 'Advanced', language_id: english.id },
    { name: 'Strickjacke', definition: 'Ein gestrickter Pullover, der vorne geöffnet wird.', category_name: 'Clothing', level: 'Advanced', language_id: german.id },
    { name: 'Trench Coat', definition: 'A long coat typically made of waterproof heavy-duty cotton gabardine drill, leather, or poplin.', category_name: 'Clothing', level: 'Advanced', language_id: english.id },
    { name: 'Trenchcoat', definition: 'Ein langer Mantel, typischerweise aus wasserdichtem schwerem Baumwollgabardine, Leder oder Popeline.', category_name: 'Clothing', level: 'Advanced', language_id: german.id },
    { name: 'Loafers', definition: 'A type of shoe that is easy to slip on and off, often worn for informal occasions.', category_name: 'Clothing', level: 'Advanced', language_id: english.id },
    { name: 'Slipper', definition: 'Eine Art Schuh, der leicht an- und ausgezogen werden kann, oft für informelle Anlässe getragen.', category_name: 'Clothing', level: 'Advanced', language_id: german.id },
    { name: 'Cummerbund', definition: 'A broad waist sash, usually pleated, worn with a tuxedo or dinner jacket.', category_name: 'Clothing', level: 'Advanced', language_id: english.id },
    { name: 'Kummerbund', definition: 'Eine breite Taillenschärpe, üblicherweise gefaltet, getragen mit einem Smoking oder Dinnerjacket.', category_name: 'Clothing', level: 'Advanced', language_id: german.id },

    # Fashion - Beginner
    { name: 'Runway', definition: 'A narrow, usually flat surface where models walk to display clothing.', category_name: 'Fashion', level: 'Beginner', language_id: english.id },
    { name: 'Laufsteg', definition: 'Eine schmale, üblicherweise flache Oberfläche, auf der Models laufen, um Kleidung zu präsentieren.', category_name: 'Fashion', level: 'Beginner', language_id: german.id },
    { name: 'Model', definition: 'A person employed to display clothes by wearing them.', category_name: 'Fashion', level: 'Beginner', language_id: english.id },
    { name: 'Modell', definition: 'Eine Person, die beschäftigt ist, um Kleidung zu präsentieren, indem sie diese trägt.', category_name: 'Fashion', level: 'Beginner', language_id: german.id },


    # Fashion - Intermediate
    { name: 'Couture', definition: 'The design and manufacture of fashionable clothes to a client\'s specific requirements.', category_name: 'Fashion', level: 'Intermediate', language_id: english.id },
    { name: 'Maßschneiderei', definition: 'Das Design und die Herstellung modischer Kleidung nach spezifischen Anforderungen eines Kunden.', category_name: 'Fashion', level: 'Intermediate', language_id: german.id },
    { name: 'Trend', definition: 'A general direction in which something is developing or changing.', category_name: 'Fashion', level: 'Intermediate', language_id: english.id },
    { name: 'Trend', definition: 'Eine allgemeine Richtung, in die sich etwas entwickelt oder verändert.', category_name: 'Fashion', level: 'Intermediate', language_id: german.id },

    # Fashion - Advanced
    { name: 'Haute Couture', definition: 'High-end fashion that is constructed by hand from start to finish.', category_name: 'Fashion', level: 'Advanced', language_id: english.id },
    { name: 'Haute Couture', definition: 'Hochwertige Mode, die von Anfang bis Ende von Hand gefertigt wird.', category_name: 'Fashion', level: 'Advanced', language_id: german.id },
    { name: 'Avant-garde', definition: 'New and unusual or experimental ideas, especially in the arts.', category_name: 'Fashion', level: 'Advanced', language_id: english.id },
    { name: 'Avantgarde', definition: 'Neue und ungewöhnliche oder experimentelle Ideen, insbesondere in den Künsten.', category_name: 'Fashion', level: 'Advanced', language_id: german.id },

  
    # Work - Beginner
    { name: 'Office', definition: 'A room, set of rooms, or building used as a place for commercial, professional, or bureaucratic work.', category_name: 'Work', level: 'Beginner', language_id: english.id },
    { name: 'Büro', definition: 'Ein Raum, eine Reihe von Räumen oder ein Gebäude, das als Ort für kommerzielle, professionelle oder bürokratische Arbeit genutzt wird.', category_name: 'Work', level: 'Beginner', language_id: german.id },
    { name: 'Desk', definition: 'A piece of furniture with a flat top for writing or working.', category_name: 'Work', level: 'Beginner', language_id: english.id },
    { name: 'Schreibtisch', definition: 'Ein Möbelstück mit einer flachen Oberfläche zum Schreiben oder Arbeiten.', category_name: 'Work', level: 'Beginner', language_id: german.id },
    { name: 'Computer', definition: 'An electronic device for storing and processing data.', category_name: 'Work', level: 'Beginner', language_id: english.id },
    { name: 'Computer', definition: 'Ein elektronisches Gerät zum Speichern und Verarbeiten von Daten.', category_name: 'Work', level: 'Beginner', language_id: german.id },
    { name: 'Pen', definition: 'A writing instrument using ink.', category_name: 'Work', level: 'Beginner', language_id: english.id },
    { name: 'Stift', definition: 'Ein Schreibgerät, das Tinte verwendet.', category_name: 'Work', level: 'Beginner', language_id: german.id },
    { name: 'Paper', definition: 'Material for writing or printing on.', category_name: 'Work', level: 'Beginner', language_id: english.id },
    { name: 'Papier', definition: 'Material zum Schreiben oder Drucken.', category_name: 'Work', level: 'Beginner', language_id: german.id },
    { name: 'Chair', definition: 'A piece of furniture for sitting.', category_name: 'Work', level: 'Beginner', language_id: english.id },
    { name: 'Stuhl', definition: 'Ein Möbelstück zum Sitzen.', category_name: 'Work', level: 'Beginner', language_id: german.id },
    { name: 'Email', definition: 'A system for sending messages electronically, especially from one computer to another.', category_name: 'Work', level: 'Beginner', language_id: english.id },
    { name: 'E-Mail', definition: 'Ein System zum elektronischen Versenden von Nachrichten, insbesondere von einem Computer zum anderen.', category_name: 'Work', level: 'Beginner', language_id: german.id },
    { name: 'Boss', definition: 'A person in charge of a worker or organization.', category_name: 'Work', level: 'Beginner', language_id: english.id },
    { name: 'Chef', definition: 'Eine Person, die für einen Arbeiter oder eine Organisation verantwortlich ist.', category_name: 'Work', level: 'Beginner', language_id: german.id },
    { name: 'Job', definition: 'A paid position of regular employment.', category_name: 'Work', level: 'Beginner', language_id: english.id },
    { name: 'Arbeitsstelle', definition: 'Eine bezahlte Position der regelmäßigen Beschäftigung.', category_name: 'Work', level: 'Beginner', language_id: german.id },
    { name: 'Task', definition: 'A piece of work to be done.', category_name: 'Work', level: 'Beginner', language_id: english.id },
    { name: 'Aufgabe', definition: 'Ein Stück Arbeit, das erledigt werden muss.', category_name: 'Work', level: 'Beginner', language_id: german.id },


    # Work - Intermediate
    { name: 'Manager', definition: 'A person responsible for controlling or administering an organization or group of staff.', category_name: 'Work', level: 'Intermediate', language_id: english.id },
    { name: 'Manager', definition: 'Eine Person, die für die Kontrolle oder Verwaltung einer Organisation oder Gruppe von Mitarbeitern verantwortlich ist.', category_name: 'Work', level: 'Intermediate', language_id: german.id },
    { name: 'Team', definition: 'A group of people with a full set of complementary skills required to complete a task, job, or project.', category_name: 'Work', level: 'Intermediate', language_id: english.id },
    { name: 'Team', definition: 'Eine Gruppe von Personen mit einem vollständigen Satz ergänzender Fähigkeiten, die erforderlich sind, um eine Aufgabe, einen Job oder ein Projekt abzuschließen.', category_name: 'Work', level: 'Intermediate', language_id: german.id },
    { name: 'Meeting', definition: 'An assembly of people for discussion.', category_name: 'Work', level: 'Intermediate', language_id: english.id },
    { name: 'Besprechung', definition: 'Eine Versammlung von Personen zur Diskussion.', category_name: 'Work', level: 'Intermediate', language_id: german.id },
    { name: 'Deadline', definition: 'The latest time or date by which something should be completed.', category_name: 'Work', level: 'Intermediate', language_id: english.id },
    { name: 'Frist', definition: 'Der späteste Zeitpunkt oder Datum, bis zu dem etwas fertiggestellt sein sollte.', category_name: 'Work', level: 'Intermediate', language_id: german.id },
    { name: 'Report', definition: 'A detailed account of something.', category_name: 'Work', level: 'Intermediate', language_id: english.id },
    { name: 'Bericht', definition: 'Ein detaillierter Bericht über etwas.', category_name: 'Work', level: 'Intermediate', language_id: german.id },
    { name: 'Schedule', definition: 'A plan that lists the times and dates when tasks will be done.', category_name: 'Work', level: 'Intermediate', language_id: english.id },
    { name: 'Zeitplan', definition: 'Ein Plan, der die Zeiten und Daten auflistet, wann Aufgaben erledigt werden.', category_name: 'Work', level: 'Intermediate', language_id: german.id },
    { name: 'Client', definition: 'A person or organization using the services of a professional person or company.', category_name: 'Work', level: 'Intermediate', language_id: english.id },
    { name: 'Klient', definition: 'Eine Person oder Organisation, die die Dienste einer professionellen Person oder Firma nutzt.', category_name: 'Work', level: 'Intermediate', language_id: german.id },
    { name: 'Document', definition: 'A piece of written, printed, or electronic matter that provides information.', category_name: 'Work', level: 'Intermediate', language_id: english.id },
    { name: 'Dokument', definition: 'Ein Stück geschriebenes, gedrucktes oder elektronisches Material, das Informationen liefert.', category_name: 'Work', level: 'Intermediate', language_id: german.id },

    # Work - Advanced
    { name: 'Presentation', definition: 'A talk or display to explain something.', category_name: 'Work', level: 'Advanced', language_id: english.id },
    { name: 'Präsentation', definition: 'Ein Vortrag oder eine Darstellung, um etwas zu erklären.', category_name: 'Work', level: 'Advanced', language_id: german.id },
    { name: 'Conference', definition: 'A formal meeting for discussion.', category_name: 'Work', level: 'Advanced', language_id: english.id },
    { name: 'Konferenz', definition: 'Ein formelles Treffen zur Diskussion.', category_name: 'Work', level: 'Advanced', language_id: german.id },
    { name: 'Strategy', definition: 'A plan of action designed to achieve a long-term or overall aim.', category_name: 'Work', level: 'Advanced', language_id: english.id },
    { name: 'Strategie', definition: 'Ein Aktionsplan, der darauf ausgelegt ist, ein langfristiges oder allgemeines Ziel zu erreichen.', category_name: 'Work', level: 'Advanced', language_id: german.id },
    { name: 'Innovation', definition: 'The act of introducing something new.', category_name: 'Work', level: 'Advanced', language_id: english.id },
    { name: 'Innovation', definition: 'Die Einführung von etwas Neuem.', category_name: 'Work', level: 'Advanced', language_id: german.id },
    { name: 'Negotiation', definition: 'Discussion aimed at reaching an agreement.', category_name: 'Work', level: 'Advanced', language_id: english.id },
    { name: 'Verhandlung', definition: 'Diskussion mit dem Ziel, eine Vereinbarung zu erreichen.', category_name: 'Work', level: 'Advanced', language_id: german.id },
    { name: 'Entrepreneur', definition: 'A person who starts and runs a business.', category_name: 'Work', level: 'Advanced', language_id: english.id },
    { name: 'Unternehmer', definition: 'Eine Person, die ein Geschäft gründet und führt.', category_name: 'Work', level: 'Advanced', language_id: german.id },
    { name: 'Consultant', definition: 'A person who provides expert advice professionally.', category_name: 'Work', level: 'Advanced', language_id: english.id },
    { name: 'Berater', definition: 'Eine Person, die professionell Expertenrat bietet.', category_name: 'Work', level: 'Advanced', language_id: german.id },
    { name: 'Leadership', definition: 'The action of leading a group of people or an organization.', category_name: 'Work', level: 'Advanced', language_id: english.id },
    { name: 'Führung', definition: 'Die Handlung, eine Gruppe von Menschen oder eine Organisation zu leiten.', category_name: 'Work', level: 'Advanced', language_id: german.id },


    # Education
    # Education - Beginner
    { name: 'School', definition: 'A place where children go to learn.', category_name: 'Education', level: 'Beginner', language_id: english.id },
    { name: 'Schule', definition: 'Ein Ort, an dem Kinder lernen.', category_name: 'Education', level: 'Beginner', language_id: german.id },
    { name: 'Teacher', definition: 'A person who helps students to learn.', category_name: 'Education', level: 'Beginner', language_id: english.id },
    { name: 'Lehrer', definition: 'Eine Person, die Schülern hilft zu lernen.', category_name: 'Education', level: 'Beginner', language_id: german.id },
    { name: 'Student', definition: 'A person who is studying at a school or college.', category_name: 'Education', level: 'Beginner', language_id: english.id },
    { name: 'Schüler', definition: 'Eine Person, die in einer Schule oder Universität studiert.', category_name: 'Education', level: 'Beginner', language_id: german.id },
    { name: 'Classroom', definition: 'A room where teaching and learning take place.', category_name: 'Education', level: 'Beginner', language_id: english.id },
    { name: 'Klassenzimmer', definition: 'Ein Raum, in dem Unterricht und Lernen stattfinden.', category_name: 'Education', level: 'Beginner', language_id: german.id },
    { name: 'Homework', definition: 'Work that a student is given to do at home.', category_name: 'Education', level: 'Beginner', language_id: english.id },
    { name: 'Hausaufgaben', definition: 'Arbeit, die einem Schüler gegeben wird, um zu Hause zu erledigen.', category_name: 'Education', level: 'Beginner', language_id: german.id },
    { name: 'Book', definition: 'A set of written or printed pages, usually bound with a protective cover.', category_name: 'Education', level: 'Beginner', language_id: english.id },
    { name: 'Buch', definition: 'Eine Reihe von geschriebenen oder gedruckten Seiten, normalerweise mit einem Schutzumschlag gebunden.', category_name: 'Education', level: 'Beginner', language_id: german.id },
    { name: 'Pen', definition: 'A writing instrument using ink.', category_name: 'Education', level: 'Beginner', language_id: english.id },
    { name: 'Stift', definition: 'Ein Schreibgerät, das Tinte verwendet.', category_name: 'Education', level: 'Beginner', language_id: german.id },
    { name: 'Desk', definition: 'A piece of furniture with a flat top for writing or working.', category_name: 'Education', level: 'Beginner', language_id: english.id },
    { name: 'Schreibtisch', definition: 'Ein Möbelstück mit einer flachen Oberfläche zum Schreiben oder Arbeiten.', category_name: 'Education', level: 'Beginner', language_id: german.id },
    { name: 'Notebook', definition: 'A small book with blank or ruled pages for writing notes.', category_name: 'Education', level: 'Beginner', language_id: english.id },
    { name: 'Notizbuch', definition: 'Ein kleines Buch mit leeren oder linierten Seiten zum Notieren.', category_name: 'Education', level: 'Beginner', language_id: german.id },
    { name: 'Pencil', definition: 'A writing instrument made of wood with a graphite center.', category_name: 'Education', level: 'Beginner', language_id: english.id },
    { name: 'Bleistift', definition: 'Ein Schreibgerät aus Holz mit einem Graphitkern.', category_name: 'Education', level: 'Beginner', language_id: german.id },
    { name: 'Eraser', definition: 'A piece of rubber used to remove pencil marks from paper.', category_name: 'Education', level: 'Beginner', language_id: english.id },
    { name: 'Radiergummi', definition: 'Ein Stück Gummi, das verwendet wird, um Bleistiftmarkierungen von Papier zu entfernen.', category_name: 'Education', level: 'Beginner', language_id: german.id },
    { name: 'Ruler', definition: 'A tool used to measure length and draw straight lines.', category_name: 'Education', level: 'Beginner', language_id: english.id },
    { name: 'Lineal', definition: 'Ein Werkzeug, das verwendet wird, um Längen zu messen und gerade Linien zu zeichnen.', category_name: 'Education', level: 'Beginner', language_id: german.id },
    { name: 'Backpack', definition: 'A bag carried on one\'s back, typically with two shoulder straps.', category_name: 'Education', level: 'Beginner', language_id: english.id },
    { name: 'Rucksack', definition: 'Eine Tasche, die auf dem Rücken getragen wird, typischerweise mit zwei Schultergurten.', category_name: 'Education', level: 'Beginner', language_id: german.id },
    { name: 'Library', definition: 'A place where books, magazines, and other materials are available for people to use or borrow.', category_name: 'Education', level: 'Beginner', language_id: english.id },
    { name: 'Bibliothek', definition: 'Ein Ort, an dem Bücher, Zeitschriften und andere Materialien zur Nutzung oder Ausleihe zur Verfügung stehen.', category_name: 'Education', level: 'Beginner', language_id: german.id },
    { name: 'Blackboard', definition: 'A large board with a smooth, dark surface used for writing on with chalk.', category_name: 'Education', level: 'Beginner', language_id: english.id },
    { name: 'Tafel', definition: 'Eine große Tafel mit einer glatten, dunklen Oberfläche, auf der mit Kreide geschrieben wird.', category_name: 'Education', level: 'Beginner', language_id: german.id },


  # Education - Intermediate
  { name: 'Curriculum', definition: 'The subjects comprising a course of study in a school or college.', category_name: 'Education', level: 'Intermediate', language_id: english.id },
  { name: 'Lehrplan', definition: 'Die Fächer, die einen Studiengang in einer Schule oder Hochschule umfassen.', category_name: 'Education', level: 'Intermediate', language_id: german.id },
  { name: 'Lecture', definition: 'An educational talk to an audience, especially to students in a university or college.', category_name: 'Education', level: 'Intermediate', language_id: english.id },
  { name: 'Vorlesung', definition: 'Ein Bildungsvortrag für ein Publikum, insbesondere für Studenten an einer Universität oder Hochschule.', category_name: 'Education', level: 'Intermediate', language_id: german.id },
  { name: 'Exam', definition: 'A formal test of a person\'s knowledge or proficiency in a subject or skill.', category_name: 'Education', level: 'Intermediate', language_id: english.id },
  { name: 'Prüfung', definition: 'Eine formelle Überprüfung des Wissens oder der Fähigkeiten einer Person in einem Fach oder einer Fertigkeit.', category_name: 'Education', level: 'Intermediate', language_id: german.id },
  { name: 'Semester', definition: 'Half of a school year.', category_name: 'Education', level: 'Intermediate', language_id: english.id },
  { name: 'Semester', definition: 'Die Hälfte eines Schuljahres.', category_name: 'Education', level: 'Intermediate', language_id: german.id },
  { name: 'Textbook', definition: 'A book used as a standard work for the study of a particular subject.', category_name: 'Education', level: 'Intermediate', language_id: english.id },
  { name: 'Lehrbuch', definition: 'Ein Buch, das als Standardwerk für das Studium eines bestimmten Fachs verwendet wird.', category_name: 'Education', level: 'Intermediate', language_id: german.id },

  # Education - Advanced
  { name: 'Pedagogy', definition: 'The method and practice of teaching, especially as an academic subject or theoretical concept.', category_name: 'Education', level: 'Advanced', language_id: english.id },
  { name: 'Pädagogik', definition: 'Die Methode und Praxis des Lehrens, insbesondere als akademisches Fach oder theoretisches Konzept.', category_name: 'Education', level: 'Advanced', language_id: german.id },
  { name: 'Thesis', definition: 'A statement or theory that is put forward as a premise to be maintained or proved.', category_name: 'Education', level: 'Advanced', language_id: english.id },
  { name: 'These', definition: 'Eine Aussage oder Theorie, die als Prämisse vorgebracht wird, um aufrechterhalten oder bewiesen zu werden.', category_name: 'Education', level: 'Advanced', language_id: german.id },
  { name: 'Dissertation', definition: 'A long essay on a particular subject, especially one written for a university degree or diploma.', category_name: 'Education', level: 'Advanced', language_id: english.id },
  { name: 'Dissertation', definition: 'Ein langer Aufsatz über ein bestimmtes Thema, insbesondere einer, der für einen Universitätsabschluss oder ein Diplom geschrieben wurde.', category_name: 'Education', level: 'Advanced', language_id: german.id },
  { name: 'Syllabus', definition: 'An outline of the subjects in a course of study or teaching.', category_name: 'Education', level: 'Advanced', language_id: english.id },
  { name: 'Lehrplan', definition: 'Eine Übersicht der Fächer in einem Studien- oder Lehrplan.', category_name: 'Education', level: 'Advanced', language_id: german.id },
  { name: 'Research', definition: 'The systematic investigation into and study of materials and sources in order to establish facts and reach new conclusions.', category_name: 'Education', level: 'Advanced', language_id: english.id },
  { name: 'Forschung', definition: 'Die systematische Untersuchung und Studie von Materialien und Quellen, um Fakten festzustellen und neue Schlussfolgerungen zu ziehen.', category_name: 'Education', level: 'Advanced', language_id: german.id },


  # Emotions
  # Emotions - Beginner
{ name: 'Happy', definition: 'Feeling or showing pleasure or contentment.', category_name: 'Emotions', level: 'Beginner', language_id: english.id },
{ name: 'Glücklich', definition: 'Das Gefühl oder die Darstellung von Freude oder Zufriedenheit.', category_name: 'Emotions', level: 'Beginner', language_id: german.id },
{ name: 'Sad', definition: 'Feeling or showing sorrow; unhappy.', category_name: 'Emotions', level: 'Beginner', language_id: english.id },
{ name: 'Traurig', definition: 'Das Gefühl oder die Darstellung von Kummer; unglücklich.', category_name: 'Emotions', level: 'Beginner', language_id: german.id },
{ name: 'Angry', definition: 'Feeling or showing strong annoyance, displeasure, or hostility.', category_name: 'Emotions', level: 'Beginner', language_id: english.id },
{ name: 'Wütend', definition: 'Das Gefühl oder die Darstellung starker Verärgerung, Missfallen oder Feindseligkeit.', category_name: 'Emotions', level: 'Beginner', language_id: german.id },
{ name: 'Afraid', definition: 'Feeling fear or anxiety; frightened.', category_name: 'Emotions', level: 'Beginner', language_id: english.id },
{ name: 'Ängstlich', definition: 'Das Gefühl von Angst oder Sorge; verängstigt.', category_name: 'Emotions', level: 'Beginner', language_id: german.id },
{ name: 'Surprised', definition: 'Feeling or showing surprise because something unexpected happened.', category_name: 'Emotions', level: 'Beginner', language_id: english.id },
{ name: 'Überrascht', definition: 'Das Gefühl oder die Darstellung von Überraschung, weil etwas Unerwartetes passiert ist.', category_name: 'Emotions', level: 'Beginner', language_id: german.id },


  # Emotions - Intermediate
  { name: 'Fear', definition: 'An unpleasant emotion caused by the belief that someone or something is dangerous, likely to cause pain, or a threat.', category_name: 'Emotions', level: 'Intermediate', language_id: english.id },
  { name: 'Angst', definition: 'Ein unangenehmes Gefühl, das durch den Glauben verursacht wird, dass jemand oder etwas gefährlich ist, wahrscheinlich Schmerz verursacht oder eine Bedrohung darstellt.', category_name: 'Emotions', level: 'Intermediate', language_id: german.id },
  { name: 'Excited', definition: 'Very enthusiastic and eager.', category_name: 'Emotions', level: 'Intermediate', language_id: english.id },
  { name: 'Aufgeregt', definition: 'Sehr enthusiastisch und eifrig.', category_name: 'Emotions', level: 'Intermediate', language_id: german.id },
  { name: 'Nervous', definition: 'Easily agitated or alarmed; tending to be anxious.', category_name: 'Emotions', level: 'Intermediate', language_id: english.id },
  { name: 'Nervös', definition: 'Leicht aufgeregt oder alarmiert; dazu neigen, ängstlich zu sein.', category_name: 'Emotions', level: 'Intermediate', language_id: german.id },
  { name: 'Confused', definition: 'Unable to think clearly or to understand what is happening or what somebody is saying.', category_name: 'Emotions', level: 'Intermediate', language_id: english.id },
  { name: 'Verwirrt', definition: 'Nicht klar denken können oder nicht verstehen können, was passiert oder was jemand sagt.', category_name: 'Emotions', level: 'Intermediate', language_id: german.id },
  { name: 'Jealous', definition: 'Feeling or showing an envious resentment of someone or their achievements, possessions, or perceived advantages.', category_name: 'Emotions', level: 'Intermediate', language_id: english.id },
  { name: 'Eifersüchtig', definition: 'Ein neidischer Groll auf jemanden oder seine Errungenschaften, Besitztümer oder wahrgenommenen Vorteile fühlen oder zeigen.', category_name: 'Emotions', level: 'Intermediate', language_id: german.id },
  { name: 'Proud', definition: 'Feeling deep pleasure or satisfaction as a result of one\'s own achievements, qualities, or possessions.', category_name: 'Emotions', level: 'Intermediate', language_id: english.id },
  { name: 'Stolz', definition: 'Ein tiefes Vergnügen oder Zufriedenheit als Ergebnis der eigenen Errungenschaften, Qualitäten oder Besitztümer fühlen.', category_name: 'Emotions', level: 'Intermediate', language_id: german.id },


  # Emotions - Advanced
  { name: 'Ecstatic', definition: 'Feeling or expressing overwhelming happiness or joyful excitement.', category_name: 'Emotions', level: 'Advanced', language_id: english.id },
  { name: 'Ekstatisch', definition: 'Das Gefühl oder die Darstellung überwältigender Freude oder glücklicher Aufregung.', category_name: 'Emotions', level: 'Advanced', language_id: german.id },
  { name: 'Melancholy', definition: 'A feeling of pensive sadness, typically with no obvious cause.', category_name: 'Emotions', level: 'Advanced', language_id: english.id },
  { name: 'Melancholie', definition: 'Ein Gefühl der nachdenklichen Traurigkeit, typischerweise ohne offensichtlichen Grund.', category_name: 'Emotions', level: 'Advanced', language_id: german.id },
  { name: 'Frustrated', definition: 'Feeling or expressing distress and annoyance resulting from an inability to change or achieve something.', category_name: 'Emotions', level: 'Advanced', language_id: english.id },
  { name: 'Frustriert', definition: 'Das Gefühl oder die Darstellung von Not und Ärger, die aus der Unfähigkeit resultieren, etwas zu ändern oder zu erreichen.', category_name: 'Emotions', level: 'Advanced', language_id: german.id },
  { name: 'Content', definition: 'In a state of peaceful happiness.', category_name: 'Emotions', level: 'Advanced', language_id: english.id },
  { name: 'Zufrieden', definition: 'In einem Zustand des friedlichen Glücks.', category_name: 'Emotions', level: 'Advanced', language_id: german.id },
  { name: 'Anxious', definition: 'Experiencing worry, unease, or nervousness, typically about an imminent event or something with an uncertain outcome.', category_name: 'Emotions', level: 'Advanced', language_id: english.id },
  { name: 'Ängstlich', definition: 'Erleben von Sorge, Unbehagen oder Nervosität, typischerweise über ein bevorstehendes Ereignis oder etwas mit unsicherem Ausgang.', category_name: 'Emotions', level: 'Advanced', language_id: german.id },


  # Nature - Beginner
  { name: 'Tree', definition: 'A woody perennial plant, typically having a single stem or trunk growing to a considerable height and bearing lateral branches at some distance from the ground.', category_name: 'Nature', level: 'Beginner', language_id: english.id },
  { name: 'Baum', definition: 'Eine holzige, mehrjährige Pflanze, die typischerweise einen einzigen Stamm oder Stamm hat, der eine beträchtliche Höhe erreicht und seitliche Äste in einiger Entfernung vom Boden trägt.', category_name: 'Nature', level: 'Beginner', language_id: german.id },
  { name: 'River', definition: 'A large natural stream of water flowing in a channel to the sea, a lake, or another such stream.', category_name: 'Nature', level: 'Beginner', language_id: english.id },
  { name: 'Fluss', definition: 'Ein großer natürlicher Wasserlauf, der in einem Kanal zum Meer, einem See oder einem anderen solchen Strom fließt.', category_name: 'Nature', level: 'Beginner', language_id: german.id },
  { name: 'Flower', definition: 'The seed-bearing part of a plant, typically surrounded by brightly colored petals.', category_name: 'Nature', level: 'Beginner', language_id: english.id },
  { name: 'Blume', definition: 'Der samenproduzierende Teil einer Pflanze, typischerweise von leuchtend gefärbten Blütenblättern umgeben.', category_name: 'Nature', level: 'Beginner', language_id: german.id },
  { name: 'Leaf', definition: 'A flattened structure of a higher plant, typically green and blade-like, that is attached to a stem.', category_name: 'Nature', level: 'Beginner', language_id: english.id },
  { name: 'Blatt', definition: 'Eine abgeflachte Struktur einer höheren Pflanze, typischerweise grün und klingenartig, die an einem Stiel befestigt ist.', category_name: 'Nature', level: 'Beginner', language_id: german.id },
  { name: 'Grass', definition: 'Plants with narrow green leaves, commonly found on lawns and in fields.', category_name: 'Nature', level: 'Beginner', language_id: english.id },
  { name: 'Gras', definition: 'Pflanzen mit schmalen grünen Blättern, die häufig auf Rasenflächen und in Feldern vorkommen.', category_name: 'Nature', level: 'Beginner', language_id: german.id },
  { name: 'Rock', definition: 'A solid mineral material forming part of the surface of the earth and other similar planets.', category_name: 'Nature', level: 'Beginner', language_id: english.id },
  { name: 'Felsen', definition: 'Ein festes Mineralmaterial, das einen Teil der Oberfläche der Erde und anderer ähnlicher Planeten bildet.', category_name: 'Nature', level: 'Beginner', language_id: german.id },
  { name: 'Sky', definition: 'The region of the atmosphere and outer space seen from the earth.', category_name: 'Nature', level: 'Beginner', language_id: english.id },
  { name: 'Himmel', definition: 'Der Bereich der Atmosphäre und des Weltraums, der von der Erde aus zu sehen ist.', category_name: 'Nature', level: 'Beginner', language_id: german.id },

  # Nature - Intermediate
  { name: 'Mountain', definition: 'A large natural elevation of the earth\'s surface rising abruptly from the surrounding level; a large steep hill.', category_name: 'Nature', level: 'Intermediate', language_id: english.id },
  { name: 'Berg', definition: 'Eine große natürliche Erhebung der Erdoberfläche, die abrupt aus der Umgebung aufsteigt; ein großer steiler Hügel.', category_name: 'Nature', level: 'Intermediate', language_id: german.id },
  { name: 'Forest', definition: 'A large area covered chiefly with trees and undergrowth.', category_name: 'Nature', level: 'Intermediate', language_id: english.id },
  { name: 'Wald', definition: 'Ein großes Gebiet, das hauptsächlich mit Bäumen und Unterholz bedeckt ist.', category_name: 'Nature', level: 'Intermediate', language_id: german.id },
  { name: 'River', definition: 'A large natural stream of water flowing in a channel to the sea, a lake, or another river.', category_name: 'Nature', level: 'Intermediate', language_id: english.id },
  { name: 'Fluss', definition: 'Ein großer natürlicher Wasserlauf, der in einem Kanal zum Meer, einem See oder einem anderen Fluss fließt.', category_name: 'Nature', level: 'Intermediate', language_id: german.id },
  { name: 'Hill', definition: 'A naturally raised area of land, not as high or craggy as a mountain.', category_name: 'Nature', level: 'Intermediate', language_id: english.id },
  { name: 'Hügel', definition: 'Ein natürlicher erhöhter Bereich des Landes, nicht so hoch oder zerklüftet wie ein Berg.', category_name: 'Nature', level: 'Intermediate', language_id: german.id },
  { name: 'Ocean', definition: 'A very large expanse of sea.', category_name: 'Nature', level: 'Intermediate', language_id: english.id },
  { name: 'Ozean', definition: 'Ein sehr großes Meer.', category_name: 'Nature', level: 'Intermediate', language_id: german.id },
  { name: 'Desert', definition: 'A barren area of landscape where little precipitation occurs and consequently living conditions are hostile for plant and animal life.', category_name: 'Nature', level: 'Intermediate', language_id: english.id },
  { name: 'Wüste', definition: 'Ein kahles Gebiet der Landschaft, in dem wenig Niederschlag fällt und folglich die Lebensbedingungen für Pflanzen und Tiere feindlich sind.', category_name: 'Nature', level: 'Intermediate', language_id: german.id },


  # Nature - Advanced
  { name: 'Ecosystem', definition: 'A biological community of interacting organisms and their physical environment.', category_name: 'Nature', level: 'Advanced', language_id: english.id },
  { name: 'Ökosystem', definition: 'Eine biologische Gemeinschaft von wechselwirkenden Organismen und ihrer physischen Umgebung.', category_name: 'Nature', level: 'Advanced', language_id: german.id },
  { name: 'Biodiversity', definition: 'The variety of life in the world or in a particular habitat or ecosystem.', category_name: 'Nature', level: 'Advanced', language_id: english.id },
  { name: 'Biodiversität', definition: 'Die Vielfalt des Lebens auf der Welt oder in einem bestimmten Lebensraum oder Ökosystem.', category_name: 'Nature', level: 'Advanced', language_id: german.id },
  { name: 'Glacier', definition: 'A slowly moving mass or river of ice formed by the accumulation and compaction of snow on mountains or near the poles.', category_name: 'Nature', level: 'Advanced', language_id: english.id },
  { name: 'Gletscher', definition: 'Eine sich langsam bewegende Masse oder ein Fluss aus Eis, der durch die Ansammlung und Verdichtung von Schnee auf Bergen oder in der Nähe der Pole entsteht.', category_name: 'Nature', level: 'Advanced', language_id: german.id },
  { name: 'Savannah', definition: 'A grassy plain in tropical and subtropical regions, with few trees.', category_name: 'Nature', level: 'Advanced', language_id: english.id },
  { name: 'Savanne', definition: 'Eine grasbewachsene Ebene in tropischen und subtropischen Regionen mit wenigen Bäumen.', category_name: 'Nature', level: 'Advanced', language_id: german.id },
  { name: 'Tundra', definition: 'A vast, flat, treeless Arctic region in which the subsoil is permanently frozen.', category_name: 'Nature', level: 'Advanced', language_id: english.id },
  { name: 'Tundra', definition: 'Eine weite, flache, baumlose arktische Region, in der der Untergrund dauerhaft gefroren ist.', category_name: 'Nature', level: 'Advanced', language_id: german.id },


  # Health
  # Health - Beginner
  { name: 'Doctor', definition: 'A person who is qualified to treat people who are ill.', category_name: 'Health', level: 'Beginner', language_id: english.id },
  { name: 'Arzt', definition: 'Eine Person, die qualifiziert ist, kranke Menschen zu behandeln.', category_name: 'Health', level: 'Beginner', language_id: german.id },
  { name: 'Hospital', definition: 'A place where people who are ill or injured are treated and taken care of.', category_name: 'Health', level: 'Beginner', language_id: english.id },
  { name: 'Krankenhaus', definition: 'Ein Ort, an dem kranke oder verletzte Menschen behandelt und versorgt werden.', category_name: 'Health', level: 'Beginner', language_id: german.id },
  { name: 'Medicine', definition: 'A substance used to treat illness or injury.', category_name: 'Health', level: 'Beginner', language_id: english.id },
  { name: 'Medizin', definition: 'Eine Substanz, die zur Behandlung von Krankheit oder Verletzung verwendet wird.', category_name: 'Health', level: 'Beginner', language_id: german.id },
  { name: 'Bandage', definition: 'A strip of material used to bind a wound or to protect an injured part of the body.', category_name: 'Health', level: 'Beginner', language_id: english.id },
  { name: 'Verband', definition: 'Ein Streifen Material, der verwendet wird, um eine Wunde zu verbinden oder einen verletzten Körperteil zu schützen.', category_name: 'Health', level: 'Beginner', language_id: german.id },
  { name: 'Exercise', definition: 'Physical activity that is done to become stronger and healthier.', category_name: 'Health', level: 'Beginner', language_id: english.id },
  { name: 'Übung', definition: 'Körperliche Aktivität, die durchgeführt wird, um stärker und gesünder zu werden.', category_name: 'Health', level: 'Beginner', language_id: german.id },

  # Health - Intermediate
  { name: 'Vaccine', definition: 'A substance used to stimulate the production of antibodies and provide immunity against diseases.', category_name: 'Health', level: 'Intermediate', language_id: english.id },
  { name: 'Impfstoff', definition: 'Eine Substanz, die verwendet wird, um die Produktion von Antikörpern zu stimulieren und Immunität gegen Krankheiten zu gewährleisten.', category_name: 'Health', level: 'Intermediate', language_id: german.id },
  { name: 'Therapy', definition: 'Treatment intended to relieve or heal a disorder.', category_name: 'Health', level: 'Intermediate', language_id: english.id },
  { name: 'Therapie', definition: 'Behandlung zur Linderung oder Heilung einer Störung.', category_name: 'Health', level: 'Intermediate', language_id: german.id },
  { name: 'Nutrition', definition: 'The process of providing or obtaining the food necessary for health and growth.', category_name: 'Health', level: 'Intermediate', language_id: english.id },
  { name: 'Ernährung', definition: 'Der Prozess der Bereitstellung oder des Erhalts der für Gesundheit und Wachstum notwendigen Nahrung.', category_name: 'Health', level: 'Intermediate', language_id: german.id },
  { name: 'Allergy', definition: 'A damaging immune response by the body to a substance, especially pollen, fur, a particular food, or dust.', category_name: 'Health', level: 'Intermediate', language_id: english.id },
  { name: 'Allergie', definition: 'Eine schädliche Immunantwort des Körpers auf eine Substanz, insbesondere Pollen, Fell, ein bestimmtes Lebensmittel oder Staub.', category_name: 'Health', level: 'Intermediate', language_id: german.id },
  { name: 'Symptom', definition: 'A physical or mental feature that is regarded as indicating a condition of disease.', category_name: 'Health', level: 'Intermediate', language_id: english.id },
  { name: 'Symptom', definition: 'Ein physisches oder mentales Merkmal, das als Hinweis auf eine Krankheitsbedingung angesehen wird.', category_name: 'Health', level: 'Intermediate', language_id: german.id },

  # Health - Advanced
  { name: 'Cardiology', definition: 'The branch of medicine that deals with diseases and abnormalities of the heart.', category_name: 'Health', level: 'Advanced', language_id: english.id },
  { name: 'Kardiologie', definition: 'Der Zweig der Medizin, der sich mit Krankheiten und Anomalien des Herzens befasst.', category_name: 'Health', level: 'Advanced', language_id: german.id },
  { name: 'Oncology', definition: 'The study and treatment of tumors.', category_name: 'Health', level: 'Advanced', language_id: english.id },
  { name: 'Onkologie', definition: 'Die Erforschung und Behandlung von Tumoren.', category_name: 'Health', level: 'Advanced', language_id: german.id },
  { name: 'Neurology', definition: 'The branch of medicine or biology that deals with the anatomy, functions, and organic disorders of nerves and the nervous system.', category_name: 'Health', level: 'Advanced', language_id: english.id },
  { name: 'Neurologie', definition: 'Der Zweig der Medizin oder Biologie, der sich mit der Anatomie, den Funktionen und organischen Störungen der Nerven und des Nervensystems befasst.', category_name: 'Health', level: 'Advanced', language_id: german.id },
  { name: 'Psychiatry', definition: 'The study and treatment of mental illness, emotional disturbance, and abnormal behavior.', category_name: 'Health', level: 'Advanced', language_id: english.id },
  { name: 'Psychiatrie', definition: 'Das Studium und die Behandlung von psychischen Erkrankungen, emotionalen Störungen und abnormem Verhalten.', category_name: 'Health', level: 'Advanced', language_id: german.id },
  { name: 'Epidemiology', definition: 'The branch of medicine which deals with the incidence, distribution, and possible control of diseases.', category_name: 'Health', level: 'Advanced', language_id: english.id },
  { name: 'Epidemiologie', definition: 'Der Zweig der Medizin, der sich mit dem Auftreten, der Verbreitung und der möglichen Kontrolle von Krankheiten befasst.', category_name: 'Health', level: 'Advanced', language_id: german.id },

  # Sports - Beginner
  { name: 'Ball', definition: 'A round object used in many sports.', category_name: 'Sports', level: 'Beginner', language_id: english.id },
  { name: 'Ball', definition: 'Ein runder Gegenstand, der in vielen Sportarten verwendet wird.', category_name: 'Sports', level: 'Beginner', language_id: german.id },
  { name: 'Goal', definition: 'A point scored in some sports such as soccer, hockey, and basketball.', category_name: 'Sports', level: 'Beginner', language_id: english.id },
  { name: 'Tor', definition: 'Ein Punkt, der in einigen Sportarten wie Fußball, Hockey und Basketball erzielt wird.', category_name: 'Sports', level: 'Beginner', language_id: german.id },
  { name: 'Coach', definition: 'A person who trains and teaches athletes or sports teams.', category_name: 'Sports', level: 'Beginner', language_id: english.id },
  { name: 'Trainer', definition: 'Eine Person, die Sportler oder Sportmannschaften trainiert und unterrichtet.', category_name: 'Sports', level: 'Beginner', language_id: german.id },
  { name: 'Team', definition: 'A group of players forming one side in a competitive game or sport.', category_name: 'Sports', level: 'Beginner', language_id: english.id },
  { name: 'Mannschaft', definition: 'Eine Gruppe von Spielern, die eine Seite in einem Wettkampfspiel oder Sport bilden.', category_name: 'Sports', level: 'Beginner', language_id: german.id },
  { name: 'Referee', definition: 'An official who watches a game or match closely to ensure that the rules are adhered to.', category_name: 'Sports', level: 'Beginner', language_id: english.id },
  { name: 'Schiedsrichter', definition: 'Ein Offizieller, der ein Spiel oder Match genau beobachtet, um sicherzustellen, dass die Regeln eingehalten werden.', category_name: 'Sports', level: 'Beginner', language_id: german.id },
  { name: 'Player', definition: 'A person who takes part in a game or sport.', category_name: 'Sports', level: 'Beginner', language_id: english.id },
  { name: 'Spieler', definition: 'Eine Person, die an einem Spiel oder Sport teilnimmt.', category_name: 'Sports', level: 'Beginner', language_id: german.id },
  { name: 'Score', definition: 'The number of points achieved in a game or test.', category_name: 'Sports', level: 'Beginner', language_id: english.id },
  { name: 'Punktzahl', definition: 'Die Anzahl der Punkte, die in einem Spiel oder Test erzielt wurden.', category_name: 'Sports', level: 'Beginner', language_id: german.id },


  # Sports - Intermediate
  { name: 'Soccer', definition: 'A sport in which two teams of eleven players each try to score by kicking a ball into the other team\'s goal.', category_name: 'Sports', level: 'Intermediate', language_id: english.id },
  { name: 'Fußball', definition: 'Ein Sport, bei dem zwei Mannschaften mit jeweils elf Spielern versuchen, ein Tor zu erzielen, indem sie einen Ball in das Tor der anderen Mannschaft schießen.', category_name: 'Sports', level: 'Intermediate', language_id: german.id },
  { name: 'Basketball', definition: 'A game played between two teams of five players each on a rectangular court, usually indoors. Each team tries to score by tossing the ball through the opponent\'s goal, an elevated horizontal hoop and net.', category_name: 'Sports', level: 'Intermediate', language_id: english.id },
  { name: 'Basketball', definition: 'Ein Spiel, das zwischen zwei Mannschaften mit jeweils fünf Spielern auf einem rechteckigen Spielfeld, normalerweise in der Halle, gespielt wird. Jede Mannschaft versucht zu punkten, indem sie den Ball durch das gegnerische Tor, einen erhöhten horizontalen Reifen und ein Netz, wirft.', category_name: 'Sports', level: 'Intermediate', language_id: german.id },
  { name: 'Tennis', definition: 'A game in which two or four players strike a ball with rackets over a net stretched across a court.', category_name: 'Sports', level: 'Intermediate', language_id: english.id },
  { name: 'Tennis', definition: 'Ein Spiel, bei dem zwei oder vier Spieler einen Ball mit Schlägern über ein Netz schlagen, das über ein Spielfeld gespannt ist.', category_name: 'Sports', level: 'Intermediate', language_id: german.id },
  { name: 'Swimming', definition: 'The sport or activity of propelling oneself through water using the limbs.', category_name: 'Sports', level: 'Intermediate', language_id: english.id },
  { name: 'Schwimmen', definition: 'Der Sport oder die Aktivität, sich mit den Gliedmaßen durch Wasser zu bewegen.', category_name: 'Sports', level: 'Intermediate', language_id: german.id },

  # Sports - Advanced
  { name: 'Marathon', definition: 'A long-distance running race, strictly one of 26 miles 385 yards (42.195 km).', category_name: 'Sports', level: 'Advanced', language_id: english.id },
  { name: 'Marathon', definition: 'Ein Langstreckenlauf, der streng genommen eine Strecke von 42,195 km umfasst.', category_name: 'Sports', level: 'Advanced', language_id: german.id },
  { name: 'Triathlon', definition: 'An athletic contest consisting of three different events, typically swimming, cycling, and long-distance running.', category_name: 'Sports', level: 'Advanced', language_id: english.id },
  { name: 'Triathlon', definition: 'Ein sportlicher Wettkampf, der aus drei verschiedenen Disziplinen besteht, typischerweise Schwimmen, Radfahren und Langstreckenlauf.', category_name: 'Sports', level: 'Advanced', language_id: german.id },
  { name: 'Decathlon', definition: 'An athletic event taking place over two days, in which each competitor takes part in the same prescribed ten events.', category_name: 'Sports', level: 'Advanced', language_id: english.id },
  { name: 'Zehnkampf', definition: 'Ein sportliches Ereignis, das über zwei Tage stattfindet, bei dem jeder Teilnehmer an den gleichen zehn vorgeschriebenen Disziplinen teilnimmt.', category_name: 'Sports', level: 'Advanced', language_id: german.id },
  { name: 'Endurance', definition: 'The ability to endure an unpleasant or difficult process or situation without giving way.', category_name: 'Sports', level: 'Advanced', language_id: english.id },
  { name: 'Ausdauer', definition: 'Die Fähigkeit, einen unangenehmen oder schwierigen Prozess oder eine Situation zu ertragen, ohne nachzugeben.', category_name: 'Sports', level: 'Advanced', language_id: german.id },
  { name: 'Rehabilitation', definition: 'The action of restoring someone to health or normal life through training and therapy after imprisonment, addiction, or illness.', category_name: 'Sports', level: 'Advanced', language_id: english.id },
  { name: 'Rehabilitation', definition: 'Die Maßnahme, jemanden durch Training und Therapie nach einer Haftstrafe, Sucht oder Krankheit wieder gesund oder zu einem normalen Leben zu führen.', category_name: 'Sports', level: 'Advanced', language_id: german.id },
  { name: 'Biomechanics', definition: 'The study of the mechanical laws relating to the movement or structure of living organisms.', category_name: 'Sports', level: 'Advanced', language_id: english.id },
  { name: 'Biomechanik', definition: 'Das Studium der mechanischen Gesetze in Bezug auf die Bewegung oder Struktur lebender Organismen.', category_name: 'Sports', level: 'Advanced', language_id: german.id },
  { name: 'Sportsmanship', definition: 'Fair and generous behavior or treatment of others, especially in a sports contest.', category_name: 'Sports', level: 'Advanced', language_id: english.id },
  { name: 'Sportlichkeit', definition: 'Faires und großzügiges Verhalten oder Behandlung anderer, insbesondere in einem sportlichen Wettkampf.', category_name: 'Sports', level: 'Advanced', language_id: german.id },
  { name: 'Kinesiology', definition: 'The study of the mechanics of body movements.', category_name: 'Sports', level: 'Advanced', language_id: english.id },
  { name: 'Kinesiologie', definition: 'Das Studium der Mechanik der Körperbewegungen.', category_name: 'Sports', level: 'Advanced', language_id: german.id },


  # Art - Beginner
  { name: 'Painting', definition: 'The process or art of using paint, in a picture, as a protective coating, or as decoration.', category_name: 'Art', level: 'Beginner', language_id: english.id },
  { name: 'Malerei', definition: 'Der Prozess oder die Kunst, Farbe in einem Bild, als Schutzschicht oder zur Dekoration zu verwenden.', category_name: 'Art', level: 'Beginner', language_id: german.id },
  { name: 'Sculpture', definition: 'The art of making two- or three-dimensional representative or abstract forms, especially by carving stone or wood or by casting metal or plaster.', category_name: 'Art', level: 'Beginner', language_id: english.id },
  { name: 'Skulptur', definition: 'Die Kunst, zwei- oder dreidimensionale repräsentative oder abstrakte Formen herzustellen, insbesondere durch das Schnitzen von Stein oder Holz oder durch das Gießen von Metall oder Gips.', category_name: 'Art', level: 'Beginner', language_id: german.id },
  { name: 'Paint', definition: 'A colored substance spread over a surface to dry and leave a thin decorative or protective coating.', category_name: 'Art', level: 'Beginner', language_id: english.id },
  { name: 'Farbe', definition: 'Eine gefärbte Substanz, die auf eine Oberfläche aufgetragen wird, um zu trocknen und eine dünne dekorative oder schützende Schicht zu hinterlassen.', category_name: 'Art', level: 'Beginner', language_id: german.id },
  { name: 'Brush', definition: 'An implement with a handle and bristles used for painting.', category_name: 'Art', level: 'Beginner', language_id: english.id },
  { name: 'Pinsel', definition: 'Ein Werkzeug mit einem Griff und Borsten, das zum Malen verwendet wird.', category_name: 'Art', level: 'Beginner', language_id: german.id },
  { name: 'Drawing', definition: 'A picture or diagram made with a pencil, pen, or crayon rather than paint.', category_name: 'Art', level: 'Beginner', language_id: english.id },
  { name: 'Zeichnung', definition: 'Ein Bild oder Diagramm, das mit einem Bleistift, Stift oder Wachsmalstift und nicht mit Farbe gemacht wurde.', category_name: 'Art', level: 'Beginner', language_id: german.id },
  { name: 'Color', definition: 'The property possessed by an object of producing different sensations on the eye as a result of the way it reflects or emits light.', category_name: 'Art', level: 'Beginner', language_id: english.id },
  { name: 'Farbe', definition: 'Die Eigenschaft eines Objekts, verschiedene Empfindungen im Auge zu erzeugen, als Ergebnis der Art und Weise, wie es Licht reflektiert oder emittiert.', category_name: 'Art', level: 'Beginner', language_id: german.id },
  { name: 'Canvas', definition: 'A strong, unbleached cloth used as a surface for painting.', category_name: 'Art', level: 'Beginner', language_id: english.id },
  { name: 'Leinwand', definition: 'Ein starkes, ungebleichtes Tuch, das als Oberfläche zum Malen verwendet wird.', category_name: 'Art', level: 'Beginner', language_id: german.id },
  { name: 'Gallery', definition: 'A room or building for the display or sale of works of art.', category_name: 'Art', level: 'Beginner', language_id: english.id },
  { name: 'Galerie', definition: 'Ein Raum oder Gebäude zur Ausstellung oder zum Verkauf von Kunstwerken.', category_name: 'Art', level: 'Beginner', language_id: german.id },

  # Art - Intermediate
  { name: 'Photography', definition: 'The art or practice of taking and processing photographs.', category_name: 'Art', level: 'Intermediate', language_id: english.id },
  { name: 'Fotografie', definition: 'Die Kunst oder Praxis, Fotografien zu machen und zu bearbeiten.', category_name: 'Art', level: 'Intermediate', language_id: german.id },
  { name: 'Ceramics', definition: 'The art of making objects out of clay and similar materials treated by firing.', category_name: 'Art', level: 'Intermediate', language_id: english.id },
  { name: 'Keramik', definition: 'Die Kunst, Gegenstände aus Ton und ähnlichen Materialien herzustellen, die durch Brennen behandelt werden.', category_name: 'Art', level: 'Intermediate', language_id: german.id },
  { name: 'Palette', definition: 'A thin board or slab on which an artist lays and mixes colors.', category_name: 'Art', level: 'Intermediate', language_id: english.id },
  { name: 'Palette', definition: 'Ein dünnes Brett oder eine Platte, auf die ein Künstler Farben legt und mischt.', category_name: 'Art', level: 'Intermediate', language_id: german.id },
  { name: 'Exhibit', definition: 'A public display of works of art or other items of interest.', category_name: 'Art', level: 'Intermediate', language_id: english.id },
  { name: 'Ausstellung', definition: 'Eine öffentliche Ausstellung von Kunstwerken oder anderen interessanten Gegenständen.', category_name: 'Art', level: 'Intermediate', language_id: german.id },
  { name: 'Abstract', definition: 'Art that does not attempt to represent external reality, but seeks to achieve its effect using shapes, colors, and textures.', category_name: 'Art', level: 'Intermediate', language_id: english.id },
  { name: 'Abstrakt', definition: 'Kunst, die nicht versucht, die äußere Realität darzustellen, sondern ihre Wirkung durch Formen, Farben und Texturen zu erzielen.', category_name: 'Art', level: 'Intermediate', language_id: german.id },
  { name: 'Portrait', definition: 'A painting, drawing, photograph, or engraving of a person, especially one depicting only the face or head and shoulders.', category_name: 'Art', level: 'Intermediate', language_id: english.id },
  { name: 'Porträt', definition: 'Ein Gemälde, eine Zeichnung, ein Foto oder ein Stich einer Person, insbesondere eines, das nur das Gesicht oder Kopf und Schultern darstellt.', category_name: 'Art', level: 'Intermediate', language_id: german.id },
  { name: 'Sketch', definition: 'A rough or unfinished drawing or painting, often made to assist in making a more finished picture.', category_name: 'Art', level: 'Intermediate', language_id: english.id },
  { name: 'Skizze', definition: 'Eine grobe oder unvollendete Zeichnung oder Malerei, die oft gemacht wird, um bei der Erstellung eines fertigen Bildes zu helfen.', category_name: 'Art', level: 'Intermediate', language_id: german.id },
  { name: 'Medium', definition: 'The material or technique an artist uses to create their work.', category_name: 'Art', level: 'Intermediate', language_id: english.id },
  { name: 'Medium', definition: 'Das Material oder die Technik, die ein Künstler verwendet, um sein Werk zu schaffen.', category_name: 'Art', level: 'Intermediate', language_id: german.id },
  { name: 'Mosaic', definition: 'A picture or pattern produced by arranging together small colored pieces of hard material, such as stone, tile, or glass.', category_name: 'Art', level: 'Intermediate', language_id: english.id },
  { name: 'Mosaik', definition: 'Ein Bild oder Muster, das durch das Zusammenfügen kleiner farbiger Stücke aus hartem Material wie Stein, Fliesen oder Glas entsteht.', category_name: 'Art', level: 'Intermediate', language_id: german.id },


  # Art - Advanced
  { name: 'Impressionism', definition: 'A style or movement in painting originating in France in the 1860s, characterized by a concern with depicting the visual impression of the moment, especially in terms of the shifting effect of light and color.', category_name: 'Art', level: 'Advanced', language_id: english.id },
  { name: 'Impressionismus', definition: 'Ein Stil oder eine Bewegung in der Malerei, die in den 1860er Jahren in Frankreich entstand und sich dadurch auszeichnet, dass sie die visuelle Impression des Augenblicks darstellt, insbesondere in Bezug auf den wechselnden Effekt von Licht und Farbe.', category_name: 'Art', level: 'Advanced', language_id: german.id },
  { name: 'Cubism', definition: 'An early 20th-century style and movement in art, especially painting, in which perspective with a single viewpoint was abandoned and use was made of simple geometric shapes, interlocking planes, and later, collage.', category_name: 'Art', level: 'Advanced', language_id: english.id },
  { name: 'Kubismus', definition: 'Ein Stil und eine Bewegung in der Kunst, insbesondere in der Malerei, die Anfang des 20. Jahrhunderts entstand und bei der die Perspektive mit einem einzigen Blickwinkel aufgegeben wurde und einfache geometrische Formen, ineinandergreifende Ebenen und später Collagen verwendet wurden.', category_name: 'Art', level: 'Advanced', language_id: german.id },
  { name: 'Surrealism', definition: 'A 20th-century avant-garde movement in art and literature that sought to release the creative potential of the unconscious mind.', category_name: 'Art', level: 'Advanced', language_id: english.id },
  { name: 'Surrealismus', definition: 'Eine avantgardistische Bewegung in Kunst und Literatur des 20. Jahrhunderts, die darauf abzielte, das kreative Potenzial des Unbewussten freizusetzen.', category_name: 'Art', level: 'Advanced', language_id: german.id },
  { name: 'Fresco', definition: 'A technique of mural painting executed upon freshly laid lime plaster.', category_name: 'Art', level: 'Advanced', language_id: english.id },
  { name: 'Fresko', definition: 'Eine Technik der Wandmalerei, die auf frisch aufgetragenem Kalkputz ausgeführt wird.', category_name: 'Art', level: 'Advanced', language_id: german.id },
  { name: 'Installation', definition: 'A genre of three-dimensional works that are often site-specific and designed to transform the perception of a space.', category_name: 'Art', level: 'Advanced', language_id: english.id },
  { name: 'Installation', definition: 'Ein Genre von dreidimensionalen Werken, die oft ortsspezifisch sind und darauf abzielen, die Wahrnehmung eines Raums zu verändern.', category_name: 'Art', level: 'Advanced', language_id: german.id },
  { name: 'Renaissance', definition: 'The revival of art and literature under the influence of classical models in the 14th–16th centuries.', category_name: 'Art', level: 'Advanced', language_id: english.id },
  { name: 'Renaissance', definition: 'Die Wiederbelebung von Kunst und Literatur unter dem Einfluss klassischer Modelle im 14. bis 16. Jahrhundert.', category_name: 'Art', level: 'Advanced', language_id: german.id },
  { name: 'Avant-garde', definition: 'New and unusual or experimental ideas, especially in the arts, or the people introducing them.', category_name: 'Art', level: 'Advanced', language_id: english.id },
  { name: 'Avantgarde', definition: 'Neue und ungewöhnliche oder experimentelle Ideen, insbesondere in den Künsten, oder die Menschen, die sie einführen.', category_name: 'Art', level: 'Advanced', language_id: german.id },

  # Literature - Beginner
  { name: 'Novel', definition: 'A fictitious prose narrative of book length, typically representing character and action with some degree of realism.', category_name: 'Literature', level: 'Beginner', language_id: english.id },
  { name: 'Roman', definition: 'Eine fiktive Prosanarrative von Buchlänge, die typischerweise Charaktere und Handlung mit einem gewissen Grad an Realismus darstellt.', category_name: 'Literature', level: 'Beginner', language_id: german.id },
  { name: 'Poetry', definition: 'Literary work in which the expression of feelings and ideas is given intensity by the use of distinctive style and rhythm.', category_name: 'Literature', level: 'Beginner', language_id: english.id },
  { name: 'Poesie', definition: 'Literarisches Werk, in dem die Ausdruckskraft von Gefühlen und Ideen durch den Einsatz eines unverwechselbaren Stils und Rhythmus verstärkt wird.', category_name: 'Literature', level: 'Beginner', language_id: german.id },
  { name: 'Book', definition: 'A written or printed work consisting of pages glued or sewn together along one side and bound in covers.', category_name: 'Literature', level: 'Beginner', language_id: english.id },
  { name: 'Buch', definition: 'Ein schriftliches oder gedrucktes Werk, das aus Seiten besteht, die an einer Seite zusammengeklebt oder genäht und in Einbände gebunden sind.', category_name: 'Literature', level: 'Beginner', language_id: german.id },
  { name: 'Story', definition: 'A narrative, either true or fictitious, in prose or verse, designed to interest, amuse, or instruct the hearer or reader.', category_name: 'Literature', level: 'Beginner', language_id: english.id },
  { name: 'Geschichte', definition: 'Eine Erzählung, entweder wahr oder fiktiv, in Prosa oder Versen, die darauf abzielt, den Zuhörer oder Leser zu interessieren, zu amüsieren oder zu unterrichten.', category_name: 'Literature', level: 'Beginner', language_id: german.id },
  { name: 'Author', definition: 'A writer of a book, article, or report.', category_name: 'Literature', level: 'Beginner', language_id: english.id },
  { name: 'Autor', definition: 'Ein Schriftsteller eines Buches, Artikels oder Berichts.', category_name: 'Literature', level: 'Beginner', language_id: german.id },
  { name: 'Title', definition: 'The name of a book, composition, or other artistic work.', category_name: 'Literature', level: 'Beginner', language_id: english.id },
  { name: 'Titel', definition: 'Der Name eines Buches, einer Komposition oder eines anderen Kunstwerks.', category_name: 'Literature', level: 'Beginner', language_id: german.id },
  { name: 'Chapter', definition: 'A main division of a book, typically with a number or title.', category_name: 'Literature', level: 'Beginner', language_id: english.id },
  { name: 'Kapitel', definition: 'Ein Hauptabschnitt eines Buches, typischerweise mit einer Nummer oder einem Titel.', category_name: 'Literature', level: 'Beginner', language_id: german.id },
  { name: 'Library', definition: 'A building or room containing collections of books, periodicals, and sometimes films and recorded music for people to read, borrow, or refer to.', category_name: 'Literature', level: 'Beginner', language_id: english.id },
  { name: 'Bibliothek', definition: 'Ein Gebäude oder Raum mit Sammlungen von Büchern, Zeitschriften und manchmal Filmen und aufgezeichneter Musik, die Menschen zum Lesen, Ausleihen oder Nachschlagen zur Verfügung stehen.', category_name: 'Literature', level: 'Beginner', language_id: german.id },

  # Literature - Intermediate
  { name: 'Drama', definition: 'A play for theater, radio, or television.', category_name: 'Literature', level: 'Intermediate', language_id: english.id },
  { name: 'Drama', definition: 'Ein Schauspiel für Theater, Radio oder Fernsehen.', category_name: 'Literature', level: 'Intermediate', language_id: german.id },
  { name: 'Essay', definition: 'A short piece of writing on a particular subject.', category_name: 'Literature', level: 'Intermediate', language_id: english.id },
  { name: 'Aufsatz', definition: 'Ein kurzer Text über ein bestimmtes Thema.', category_name: 'Literature', level: 'Intermediate', language_id: german.id },
  { name: 'Novel', definition: 'A fictitious prose narrative of book length, typically representing character and action with some degree of realism.', category_name: 'Literature', level: 'Intermediate', language_id: english.id },
  { name: 'Roman', definition: 'Eine fiktive Prosanarrative von Buchlänge, die typischerweise Charaktere und Handlung mit einem gewissen Grad an Realismus darstellt.', category_name: 'Literature', level: 'Intermediate', language_id: german.id },
  { name: 'Poem', definition: 'A piece of writing that partakes of the nature of both speech and song, that is nearly always rhythmical, usually metaphorical, and often exhibits such formal elements as meter, rhyme, and stanzaic structure.', category_name: 'Literature', level: 'Intermediate', language_id: english.id },
  { name: 'Gedicht', definition: 'Ein Stück Schrift, das sowohl die Natur von Rede als auch von Gesang teilt, das fast immer rhythmisch, meist metaphorisch ist und oft solche formalen Elemente wie Metrik, Reim und Strophenstruktur aufweist.', category_name: 'Literature', level: 'Intermediate', language_id: german.id },
  { name: 'Genre', definition: 'A category of artistic composition, as in music or literature, characterized by similarities in form, style, or subject matter.', category_name: 'Literature', level: 'Intermediate', language_id: english.id },
  { name: 'Genre', definition: 'Eine Kategorie der künstlerischen Komposition, wie in der Musik oder Literatur, gekennzeichnet durch Ähnlichkeiten in Form, Stil oder Thema.', category_name: 'Literature', level: 'Intermediate', language_id: german.id },
  { name: 'Plot', definition: 'The main events of a play, novel, movie, or similar work, devised and presented by the writer as an interrelated sequence.', category_name: 'Literature', level: 'Intermediate', language_id: english.id },
  { name: 'Handlung', definition: 'Die Hauptereignisse eines Stücks, Romans, Films oder ähnlichen Werks, die vom Autor als eine miteinander verbundene Sequenz entwickelt und präsentiert werden.', category_name: 'Literature', level: 'Intermediate', language_id: german.id },
  { name: 'Character', definition: 'A person in a novel, play, or movie.', category_name: 'Literature', level: 'Intermediate', language_id: english.id },
  { name: 'Charakter', definition: 'Eine Person in einem Roman, Stück oder Film.', category_name: 'Literature', level: 'Intermediate', language_id: german.id },
  { name: 'Narrator', definition: 'A person who narrates something, especially a character who recounts the events of a novel or narrative poem.', category_name: 'Literature', level: 'Intermediate', language_id: english.id },
  { name: 'Erzähler', definition: 'Eine Person, die etwas erzählt, insbesondere ein Charakter, der die Ereignisse eines Romans oder erzählenden Gedichts schildert.', category_name: 'Literature', level: 'Intermediate', language_id: german.id },
  { name: 'Setting', definition: 'The place or type of surroundings where something is positioned or where an event takes place.', category_name: 'Literature', level: 'Intermediate', language_id: english.id },
  { name: 'Schauplatz', definition: 'Der Ort oder die Art der Umgebung, in der sich etwas befindet oder ein Ereignis stattfindet.', category_name: 'Literature', level: 'Intermediate', language_id: german.id },

  # Literature - Advanced
  { name: 'Modernism', definition: 'A style or movement in the arts that aims to break with classical and traditional forms.', category_name: 'Literature', level: 'Advanced', language_id: english.id },
  { name: 'Modernismus', definition: 'Ein Stil oder eine Bewegung in den Künsten, der darauf abzielt, mit klassischen und traditionellen Formen zu brechen.', category_name: 'Literature', level: 'Advanced', language_id: german.id },
  { name: 'Postmodernism', definition: 'A late 20th-century style and concept in the arts, architecture, and criticism that represents a departure from modernism and has at its heart a general distrust of grand theories and ideologies as well as a problematic relationship with any notion of “art.”', category_name: 'Literature', level: 'Advanced', language_id: english.id },
  { name: 'Postmodernismus', definition: 'Ein Stil und Konzept in den Künsten, der Architektur und der Kritik des späten 20. Jahrhunderts, der einen Bruch mit dem Modernismus darstellt und im Kern ein allgemeines Misstrauen gegenüber großen Theorien und Ideologien sowie eine problematische Beziehung zu jedem Begriff von "Kunst" hat.', category_name: 'Literature', level: 'Advanced', language_id: german.id },
  { name: 'Metaphor', definition: 'A figure of speech in which a word or phrase is applied to an object or action to which it is not literally applicable.', category_name: 'Literature', level: 'Advanced', language_id: english.id },
  { name: 'Metapher', definition: 'Eine Redewendung, bei der ein Wort oder eine Phrase auf ein Objekt oder eine Handlung angewendet wird, auf die es nicht wörtlich anwendbar ist.', category_name: 'Literature', level: 'Advanced', language_id: german.id },
  { name: 'Allegory', definition: 'A story, poem, or picture that can be interpreted to reveal a hidden meaning, typically a moral or political one.', category_name: 'Literature', level: 'Advanced', language_id: english.id },
  { name: 'Allegorie', definition: 'Eine Geschichte, ein Gedicht oder ein Bild, das so interpretiert werden kann, dass es eine verborgene Bedeutung offenbart, typischerweise eine moralische oder politische.', category_name: 'Literature', level: 'Advanced', language_id: german.id },
  { name: 'Protagonist', definition: 'The leading character or one of the major characters in a drama, movie, novel, or other fictional text.', category_name: 'Literature', level: 'Advanced', language_id: english.id },
  { name: 'Protagonist', definition: 'Die Hauptfigur oder eine der wichtigsten Figuren in einem Drama, Film, Roman oder einem anderen fiktionalen Text.', category_name: 'Literature', level: 'Advanced', language_id: german.id },
  { name: 'Foreshadowing', definition: 'A literary device in which a writer gives an advance hint of what is to come later in the story.', category_name: 'Literature', level: 'Advanced', language_id: english.id },
  { name: 'Vorahnung', definition: 'Ein literarisches Mittel, bei dem ein Autor einen vorausdeutenden Hinweis darauf gibt, was später in der Geschichte kommen wird.', category_name: 'Literature', level: 'Advanced', language_id: german.id },
  { name: 'Epiphany', definition: 'A moment of sudden revelation or insight.', category_name: 'Literature', level: 'Advanced', language_id: english.id },
  { name: 'Erleuchtung', definition: 'Ein Moment plötzlicher Offenbarung oder Einsicht.', category_name: 'Literature', level: 'Advanced', language_id: german.id },
  { name: 'Irony', definition: 'The expression of one\'s meaning by using language that normally signifies the opposite, typically for humorous or emphatic effect.', category_name: 'Literature', level: 'Advanced', language_id: english.id },
  { name: 'Ironie', definition: 'Der Ausdruck der eigenen Bedeutung durch die Verwendung von Sprache, die normalerweise das Gegenteil bedeutet, typischerweise für humorvolle oder emphatische Wirkung.', category_name: 'Literature', level: 'Advanced', language_id: german.id },
  { name: 'Satire', definition: 'The use of humor, irony, exaggeration, or ridicule to expose and criticize people\'s stupidity or vices, particularly in the context of contemporary politics and other topical issues.', category_name: 'Literature', level: 'Advanced', language_id: english.id },
  { name: 'Satire', definition: 'Der Einsatz von Humor, Ironie, Übertreibung oder Spott, um die Dummheit oder Laster der Menschen bloßzustellen und zu kritisieren, insbesondere im Kontext der zeitgenössischen Politik und anderer aktueller Themen.', category_name: 'Literature', level: 'Advanced', language_id: german.id },


  # Technology - Beginner
  { name: 'Computer', definition: 'An electronic device for storing and processing data.', category_name: 'Technology', level: 'Beginner', language_id: english.id },
  { name: 'Computer', definition: 'Ein elektronisches Gerät zur Speicherung und Verarbeitung von Daten.', category_name: 'Technology', level: 'Beginner', language_id: german.id },
  { name: 'Internet', definition: 'A global network connecting millions of computers, allowing them to communicate.', category_name: 'Technology', level: 'Beginner', language_id: english.id },
  { name: 'Internet', definition: 'Ein globales Netzwerk, das Millionen von Computern verbindet und ihnen die Kommunikation ermöglicht.', category_name: 'Technology', level: 'Beginner', language_id: german.id },
  { name: 'Mouse', definition: 'A small handheld device that is moved across a mat or flat surface to move the cursor on a computer screen.', category_name: 'Technology', level: 'Beginner', language_id: english.id },
  { name: 'Maus', definition: 'Ein kleines Handgerät, das über eine Matte oder eine flache Oberfläche bewegt wird, um den Cursor auf einem Computerbildschirm zu bewegen.', category_name: 'Technology', level: 'Beginner', language_id: german.id },
  { name: 'Keyboard', definition: 'A panel of keys that operate a computer or typewriter.', category_name: 'Technology', level: 'Beginner', language_id: english.id },
  { name: 'Tastatur', definition: 'Ein Tastenfeld, das einen Computer oder eine Schreibmaschine bedient.', category_name: 'Technology', level: 'Beginner', language_id: german.id },
  { name: 'Screen', definition: 'The flat surface on a computer, TV, or other electronic devices where images and data are displayed.', category_name: 'Technology', level: 'Beginner', language_id: english.id },
  { name: 'Bildschirm', definition: 'Die flache Oberfläche eines Computers, Fernsehers oder anderer elektronischer Geräte, auf der Bilder und Daten angezeigt werden.', category_name: 'Technology', level: 'Beginner', language_id: german.id },
  { name: 'Phone', definition: 'A device that allows people to talk to each other over long distances.', category_name: 'Technology', level: 'Beginner', language_id: english.id },
  { name: 'Telefon', definition: 'Ein Gerät, das es Menschen ermöglicht, über große Entfernungen miteinander zu sprechen.', category_name: 'Technology', level: 'Beginner', language_id: german.id },
  { name: 'Email', definition: 'Messages distributed by electronic means from one computer user to one or more recipients via a network.', category_name: 'Technology', level: 'Beginner', language_id: english.id },
  { name: 'E-Mail', definition: 'Nachrichten, die auf elektronischem Wege von einem Computernutzer an einen oder mehrere Empfänger über ein Netzwerk verteilt werden.', category_name: 'Technology', level: 'Beginner', language_id: german.id },

  # Technology - Intermediate
  { name: 'Software', definition: 'The programs and other operating information used by a computer.', category_name: 'Technology', level: 'Intermediate', language_id: english.id },
  { name: 'Software', definition: 'Die Programme und andere Betriebsinformationen, die von einem Computer verwendet werden.', category_name: 'Technology', level: 'Intermediate', language_id: german.id },
  { name: 'Hardware', definition: 'The physical parts of a computer system.', category_name: 'Technology', level: 'Intermediate', language_id: english.id },
  { name: 'Hardware', definition: 'Die physischen Teile eines Computersystems.', category_name: 'Technology', level: 'Intermediate', language_id: german.id },
  { name: 'Database', definition: 'A structured set of data held in a computer, especially one that is accessible in various ways.', category_name: 'Technology', level: 'Intermediate', language_id: english.id },
  { name: 'Datenbank', definition: 'Ein strukturiertes Datenset, das in einem Computer gehalten wird, insbesondere eines, das auf verschiedene Weisen zugänglich ist.', category_name: 'Technology', level: 'Intermediate', language_id: german.id },
  { name: 'Network', definition: 'A group of interconnected computers.', category_name: 'Technology', level: 'Intermediate', language_id: english.id },
  { name: 'Netzwerk', definition: 'Eine Gruppe von miteinander verbundenen Computern.', category_name: 'Technology', level: 'Intermediate', language_id: german.id },
  { name: 'Browser', definition: 'A software application used to access and view websites.', category_name: 'Technology', level: 'Intermediate', language_id: english.id },
  { name: 'Browser', definition: 'Eine Softwareanwendung, die verwendet wird, um auf Websites zuzugreifen und sie anzuzeigen.', category_name: 'Technology', level: 'Intermediate', language_id: german.id },
  { name: 'Algorithm', definition: 'A process or set of rules to be followed in calculations or other problem-solving operations, especially by a computer.', category_name: 'Technology', level: 'Intermediate', language_id: english.id },
  { name: 'Algorithmus', definition: 'Ein Prozess oder Satz von Regeln, die bei Berechnungen oder anderen Problemlösungsoperationen befolgt werden müssen, insbesondere von einem Computer.', category_name: 'Technology', level: 'Intermediate', language_id: german.id },
  { name: 'Cybersecurity', definition: 'The practice of protecting systems, networks, and programs from digital attacks.', category_name: 'Technology', level: 'Intermediate', language_id: english.id },
  { name: 'Cybersicherheit', definition: 'Die Praxis, Systeme, Netzwerke und Programme vor digitalen Angriffen zu schützen.', category_name: 'Technology', level: 'Intermediate', language_id: german.id },

  # Technology - Advanced
  { name: 'Artificial Intelligence', definition: 'The theory and development of computer systems able to perform tasks that normally require human intelligence, such as visual perception, speech recognition, decision-making, and translation between languages.', category_name: 'Technology', level: 'Advanced', language_id: english.id },
  { name: 'Künstliche Intelligenz', definition: 'Die Theorie und Entwicklung von Computersystemen, die Aufgaben ausführen können, die normalerweise menschliche Intelligenz erfordern, wie visuelle Wahrnehmung, Spracherkennung, Entscheidungsfindung und Übersetzung zwischen Sprachen.', category_name: 'Technology', level: 'Advanced', language_id: german.id },
  { name: 'Quantum Computing', definition: 'The use of quantum-mechanical phenomena such as superposition and entanglement to perform computation.', category_name: 'Technology', level: 'Advanced', language_id: english.id },
  { name: 'Quantencomputing', definition: 'Die Nutzung quantenmechanischer Phänomene wie Superposition und Verschränkung zur Durchführung von Berechnungen.', category_name: 'Technology', level: 'Advanced', language_id: german.id },
  { name: 'Blockchain', definition: 'A system in which a record of transactions made in bitcoin or another cryptocurrency is maintained across several computers that are linked in a peer-to-peer network.', category_name: 'Technology', level: 'Advanced', language_id: english.id },
  { name: 'Blockchain', definition: 'Ein System, in dem ein Transaktionsverlauf in Bitcoin oder einer anderen Kryptowährung auf mehreren Computern gespeichert wird, die in einem Peer-to-Peer-Netzwerk verbunden sind.', category_name: 'Technology', level: 'Advanced', language_id: german.id },
  { name: 'Big Data', definition: 'Extremely large data sets that may be analyzed computationally to reveal patterns, trends, and associations.', category_name: 'Technology', level: 'Advanced', language_id: english.id },
  { name: 'Big Data', definition: 'Extrem große Datensätze, die rechnerisch analysiert werden können, um Muster, Trends und Zusammenhänge zu erkennen.', category_name: 'Technology', level: 'Advanced', language_id: german.id },
  { name: 'Virtual Reality', definition: 'The computer-generated simulation of a three-dimensional image or environment.', category_name: 'Technology', level: 'Advanced', language_id: english.id },
  { name: 'Virtuelle Realität', definition: 'Die computergenerierte Simulation eines dreidimensionalen Bildes oder einer Umgebung.', category_name: 'Technology', level: 'Advanced', language_id: german.id },
  { name: 'Augmented Reality', definition: 'An enhanced version of reality created by the use of technology to overlay digital information on an image of something being viewed through a device.', category_name: 'Technology', level: 'Advanced', language_id: english.id },
  { name: 'Erweiterte Realität', definition: 'Eine erweiterte Version der Realität, die durch den Einsatz von Technologie geschaffen wird, um digitale Informationen auf ein Bild von etwas zu überlagern, das durch ein Gerät betrachtet wird.', category_name: 'Technology', level: 'Advanced', language_id: german.id },
  { name: 'Machine Learning', definition: 'A type of artificial intelligence that allows software applications to become more accurate at predicting outcomes without being explicitly programmed to do so.', category_name: 'Technology', level: 'Advanced', language_id: english.id },
  { name: 'Maschinelles Lernen', definition: 'Eine Art der künstlichen Intelligenz, die es Softwareanwendungen ermöglicht, genauer Ergebnisse vorherzusagen, ohne explizit dafür programmiert zu sein.', category_name: 'Technology', level: 'Advanced', language_id: german.id },
  { name: 'Internet of Things', definition: 'The interconnection via the Internet of computing devices embedded in everyday objects, enabling them to send and receive data.', category_name: 'Technology', level: 'Advanced', language_id: english.id },
  { name: 'Internet der Dinge', definition: 'Die Vernetzung von über das Internet eingebetteten Computergeräten in Alltagsgegenständen, die es ihnen ermöglicht, Daten zu senden und zu empfangen.', category_name: 'Technology', level: 'Advanced', language_id: german.id },
  { name: 'Cloud Computing', definition: 'The practice of using a network of remote servers hosted on the Internet to store, manage, and process data, rather than a local server or a personal computer.', category_name: 'Technology', level: 'Advanced', language_id: english.id },
  { name: 'Cloud-Computing', definition: 'Die Praxis, ein Netzwerk von entfernten Servern zu nutzen, die im Internet gehostet werden, um Daten zu speichern, zu verwalten und zu verarbeiten, anstatt einen lokalen Server oder einen persönlichen Computer zu verwenden.', category_name: 'Technology', level: 'Advanced', language_id: german.id },
  { name: '3D Printing', definition: 'The action or process of making a physical object from a three-dimensional digital model, typically by laying down many thin layers of a material in succession.', category_name: 'Technology', level: 'Advanced', language_id: english.id },
  { name: '3D-Druck', definition: 'Die Aktion oder der Prozess, ein physisches Objekt aus einem dreidimensionalen digitalen Modell zu erstellen, typischerweise durch das Auftragen vieler dünner Schichten eines Materials nacheinander.', category_name: 'Technology', level: 'Advanced', language_id: german.id },
  { name: 'Biotechnology', definition: 'The exploitation of biological processes for industrial and other purposes, especially the genetic manipulation of microorganisms for the production of antibiotics, hormones, etc.', category_name: 'Technology', level: 'Advanced', language_id: english.id },
  { name: 'Biotechnologie', definition: 'Die Nutzung biologischer Prozesse für industrielle und andere Zwecke, insbesondere die genetische Manipulation von Mikroorganismen zur Produktion von Antibiotika, Hormonen usw.', category_name: 'Technology', level: 'Advanced', language_id: german.id },
  { name: 'Nanotechnology', definition: 'The branch of technology that deals with dimensions and tolerances of less than 100 nanometers, especially the manipulation of individual atoms and molecules.', category_name: 'Technology', level: 'Advanced', language_id: english.id },
  { name: 'Nanotechnologie', definition: 'Der Bereich der Technologie, der sich mit Dimensionen und Toleranzen von weniger als 100 Nanometern befasst, insbesondere mit der Manipulation einzelner Atome und Moleküle.', category_name: 'Technology', level: 'Advanced', language_id: german.id },
  { name: 'Robotics', definition: 'The branch of technology that deals with the design, construction, operation, and application of robots.', category_name: 'Technology', level: 'Advanced', language_id: english.id },
  { name: 'Robotik', definition: 'Der Bereich der Technologie, der sich mit dem Design, Bau, Betrieb und der Anwendung von Robotern befasst.', category_name: 'Technology', level: 'Advanced', language_id: german.id },
  { name: 'Telecommunications', definition: 'The transmission of information over significant distances to communicate.', category_name: 'Technology', level: 'Advanced', language_id: english.id },
  { name: 'Telekommunikation', definition: 'Die Übertragung von Informationen über große Entfernungen zur Kommunikation.', category_name: 'Technology', level: 'Advanced', language_id: german.id },
  { name: 'Wireless', definition: 'A term used to describe telecommunications in which electromagnetic waves carry the signal over part or all of the communication path.', category_name: 'Technology', level: 'Advanced', language_id: english.id },
  { name: 'Drahtlos', definition: 'Ein Begriff, der verwendet wird, um Telekommunikation zu beschreiben, bei der elektromagnetische Wellen das Signal über einen Teil oder den gesamten Kommunikationsweg übertragen.', category_name: 'Technology', level: 'Advanced', language_id: german.id },
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
