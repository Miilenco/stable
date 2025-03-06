# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb

require 'faker'

puts "Clearing existing records..."
Booking.destroy_all
Horse.destroy_all
User.destroy_all

# Create users
puts "Creating users..."
# hash for profile pictures
profile_picture_dir = Dir.new('app/assets/images/profile_pictures/')
profile_picture_files = profile_picture_dir.children.to_h { |file| [file, "#{profile_picture_dir.path}#{file}"] }

users = []
10.times do
  new_user = User.new(
    email: Faker::Internet.unique.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: "password123"
  )
  # pick a random profile picture
  random_profile_picture = profile_picture_files.keys.sample
  new_user.profile_picture.attach(
    io: File.open(profile_picture_files[random_profile_picture]),
    filename: random_profile_picture,
    content_type: "image/jpg"
  )
  # save to database
  new_user.save!
  users << new_user
end

# Create horses
puts "Creating horses..."
breeds = ["Thoroughbred", "Arabian", "Quarter Horse", "Andalusian", "Friesian"]
locations = [
  "1600 Amphitheatre Parkway, Mountain View, CA 94043, USA",
  "10 Downing Street, London SW1A 2AA, UK",
  "221B Baker Street, London NW1 6XE, UK",
  "1 Infinite Loop, Cupertino, CA 95014, USA",
  "Eiffel Tower, Champ de Mars, 5 Avenue Anatole France, 75007 Paris, France",
  "Brandenburg Gate, Pariser Platz, 10117 Berlin, Germany",
  "Sydney Opera House, Bennelong Point, Sydney NSW 2000, Australia",
  "Shibuya Crossing, 2 Chome-2-1 Dogenzaka, Shibuya City, Tokyo 150-0043, Japan",
  "Taj Mahal, Dharmapuri, Forest Colony, Tajganj, Agra, Uttar Pradesh 282001, India",
  "Statue of Liberty, Liberty Island, New York, NY 10004, USA",
  "Christ the Redeemer, Parque Nacional da Tijuca - Alto da Boa Vista, Rio de Janeiro - RJ, 22290-330, Brazil",
  "Colosseum, Piazza del Colosseo, 1, 00184 Roma RM, Italy",
  "The Louvre, Rue de Rivoli, 75001 Paris, France",
  "Machu Picchu, Aguas Calientes, Cusco 08002, Peru",
  "Petronas Towers, Kuala Lumpur City Centre, 50088 Kuala Lumpur, Malaysia",
  "Niagara Falls, 6650 Niagara Pkwy, Niagara Falls, ON L2E 3E8, Canada",
  "Burj Khalifa, 1 Sheikh Mohammed bin Rashid Blvd, Dubai, UAE",
  "Grand Canyon Visitor Center, 450 AZ-64, Grand Canyon Village, AZ 86023, USA",
  "St. Basils Cathedral, Red Square, Moscow, Russia, 109012",
  "Table Mountain, Cape Town, 8001, South Africa",
  "Empire State Building, 20 W 34th St, New York, NY 10001, USA",
  "Times Square, Manhattan, NY 10036, USA",
  "Buckingham Palace, London SW1A 1AA, UK",
  "Hollywood Sign, Los Angeles, CA 90068, USA",
  "Champs-Élysées, 75008 Paris, France",
  "Sagrada Familia, Carrer de Mallorca, 401, 08013 Barcelona, Spain",
  "The White House, 1600 Pennsylvania Avenue NW, Washington, DC 20500, USA",
  "Giza Pyramids, Al Haram, Giza Governorate 3512201, Egypt",
  "Forbidden City, 4 Jingshan Front St, Dongcheng, Beijing, China",
  "Mount Everest Base Camp, Solukhumbu, Nepal",
  "Santorini, 84700, Greece",
  "Berlin TV Tower, Panoramastraße 1A, 10178 Berlin, Germany",
  "Copacabana Beach, Avenida Atlântica, Rio de Janeiro, RJ, Brazil",
  "The Great Wall of China, Huairou, Beijing, China",
  "Stonehenge, Salisbury SP4 7DE, UK",
  "Grand Bazaar, Beyazit, İstanbul, Turkey",
  "Golden Gate Bridge, San Francisco, CA 94129, USA",
  "Mount Fuji, Kitayama, Fujinomiya, Shizuoka 418-0112, Japan",
  "Marina Bay Sands, 10 Bayfront Ave, Singapore 018956",
  "Christchurch Cathedral, Christchurch Central City, Christchurch 8011, New Zealand"
]
pedigrees = [
  "Sire: Royal Gladiator
  Dam: Elite Dancer",
  "Sire: Freedom's Flight
  Dam: Whispering Willow",
  "Sire: Lightning Bolt
  Dam: Victory Lane",
  "Sire: Desert King
  Dam: Sunset Belle",
  "Sire: Cowboy Classic
  Dam: Prairie Rose",
  "Sire: War Paint
  Dam: Silver Starlet",
  "Sire: Ironclad Valor
  Dam: Silken Whisper",
  "Sire: Crimson Comet
  Dam: Azure Belle",
  "Sire: Shadow Dancer
  Dam: Moonlit Melody",
  "Sire: Golden Sovereign
  Dam: Emerald Tiara",
  "Sire: Thunderous Heart
  Dam: Starlight Grace",
  "Sire: Regal Eclipse
  Dam: Velvet Shadow",
  "Sire: Brave Prospect
  Dam: Diamond Dew",
  "Sire: Noble Knight
  Dam: Lady Liberty",
  "Sire: Wild Tempest
  Dam: Gentle Breeze",
  "Sire: Painted Warrior
  Dam: Summer Rain"
]
progeny_success_options = [
  "Crown Jewel (2019): Winner of the 1000 Guineas (Grade 1), and the Fillies' Mile (Grade 1). Earnings: £1,800,000.
  King's Ransom (2020): Winner of the Irish Derby (Grade 1) and the St Leger Stakes (Grade 1). Earnings: €2,500,000.
  Ascending Star (2021): Winner of the Breeders' Cup Juvenile (Grade 1). Earnings: $1,500,000.
  Demonstrates a strong propensity to produce stamina horses, with high percentages of offspring winning at distances of 10 furlongs and above.",
  "Flash Fire (2017): Winner of the Dubai Golden Shaheen (Grade 1). Earnings: $2,000,000.
  Rapid Run (2018): Winner of the July Cup (Grade 1) and the Diamond Jubilee Stakes (Grade 1). Earnings: £1,600,000.
  Velocity Queen (2022): Winner of the Breeders' Cup Sprint (Grade 1). Earnings: $1,000,000.
  Consistently produces offspring with exceptional early speed and high finishing velocity, excelling in sprint races.",
  "Heart of Gold (2016): Winner of the Melbourne Cup (Grade 1). Earnings: AUD$4,400,000.
  Spirit of Victory (2019): Winner of the Japan Cup (Grade 1). Earnings: ¥300,000,000.
  Lasting Legacy (2023): Winner of the Belmont Stakes (Grade 1). Earnings: $1,500,000.
  Known for producing horses with exceptional stamina and resilience, consistently performing well in long-distance races and major international events.",
  "Lightning Strike (2018): Winner of the Breeders' Cup Sprint (Grade 1). Earnings: $1,800,000.
  Rapid Fire (2020): Winner of the July Cup (Grade 1). Earnings: £1,200,000.
  Speed Queen (2022): Winner of the Golden Shaheen (Grade 1). Earnings: $2,000,000.
  Known for producing extremely fast offspring, excelling in sprint distances on dirt and turf.",
  "Royal Decree (2017): Winner of the Epsom Derby (Grade 1). Earnings: £1,600,000.
  Majestic Crown (2019): Winner of the Irish Derby (Grade 1). Earnings: €1,400,000.
  Sovereign Rule (2021): Winner of the Prix du Jockey Club (Grade 1). Earnings: €1,500,000.
  Known for producing classic distance horses, with strong stamina and excellent temperament.",
  "Desert Mirage (2015): Winner of the Dubai World Cup (Grade 1). Earnings: $6,000,000.
` Oasis Dream (2018): Winner of the Saudi Cup (Grade 1). Earnings: $10,000,000.
` Sandstorm Queen (2020): Winner of the Pegasus World Cup (Grade 1). Earnings: $1,750,000.
` Known for producing dirt track specialists, with high speed and exceptional resilience in international competition.",
  "Ocean Tide (2016): Winner of the Melbourne Cup (Grade 1). Earnings: AUD$4,000,000.
  Coastal Cruise (2019): Winner of the Caulfield Cup (Grade 1). Earnings: AUD$3,000,000.
  Harbor Master (2021): Winner of the Japan Cup (Grade 1). Earnings: ¥350,000,000.
  Known for producing staying horses, with strong finishes and adaptability to various turf courses."
]
race_record_options = [
  "Age 2:
    Maiden Special Weight, Santa Anita Park - 1st
    Del Mar Futurity (Grade 1), Del Mar - 3rd
    Breeders' Cup Juvenile (Grade 1), Churchill Downs - 2nd
  Age 3:
    Santa Anita Derby (Grade 1), Santa Anita Park - 2nd
    Kentucky Derby (Grade 1), Churchill Downs - 4th
    Preakness Stakes (Grade 1), Pimlico - 1st
    Belmont Stakes (Grade 1), Belmont Park - 3rd
    Travers Stakes (Grade 1), Saratoga- 2nd
  Age 4:
    Pegasus World Cup (Grade 1), Gulfstream Park- 3rd
    Dubai World Cup (Grade 1), Meydan Racecourse- 1st",
  "Age 2:
    Maiden Special Weight, Ascot - 1st
    Royal Lodge Stakes (Grade 2), Ascot - 2nd
  Age 3:
    2000 Guineas (Grade 1), Newmarket - 3rd
    Irish Derby (Grade 1), Curragh - 1st
    Prix du Jockey Club (Grade 1), Chantilly - 2nd
    Queen Elizabeth II Stakes (Grade 1), Ascot - 1st
  Age 4:
    Hong Kong Mile (Grade 1), Sha Tin - 1st
    Dubai Turf (Grade 1), Meydan - 2nd
  Age 5:
    Breeders' Cup Mile (Grade 1), Keeneland - 3rd",
  "Age 2:
    Maiden Special Weight, Del Mar - 1st
    Chandelier Stakes (Grade 1), Santa Anita - 2nd
  Age 3:
    Santa Anita Oaks (Grade 1), Santa Anita - 1st
    Kentucky Oaks (Grade 1), Churchill Downs - 3rd
    Acorn Stakes (Grade 1), Belmont Park - 2nd
    Coaching Club American Oaks (Grade 1), Saratoga - 1st
  Age 4:
    Breeders' Cup Distaff (Grade 1), Del Mar - 1st
    Personal Ensign Stakes (Grade 1), Saratoga - 2nd
  Age 5:
    Apple Blossom Handicap (Grade 1), Oaklawn Park - 1st",
  "Age 3:
    Maiden Claiming, Gulfstream Park - 2nd
    Maiden Claiming, Gulfstream Park - 1st
    Allowance Optional Claiming, Gulfstream Park - 3rd
  Age 4:
    Allowance, Tampa Bay Downs - 2nd
    Allowance, Tampa Bay Downs - 1st
    Claiming Race, Gulfstream Park - 1st
  Age 5:
    Allowance, Gulfstream Park - 3rd
    Allowance Optional Claiming, Gulfstream Park- 2nd",
  "Age 2:
    Maiden Special Weight, Turf Paradise - 1st
    Arizona Breeders' Futurity, Turf Paradise - 2nd
  Age 3:
    Sunland Derby (Grade 3), Sunland Park - 3rd
    Los Alamitos Derby (Grade 3), Los Alamitos - 1st
  Age 4:
    Hollywood Gold Cup (Grade 1), Santa Anita - 3rd
    Bing Crosby Stakes (Grade 1), Del Mar - 2nd
  Age 5:
    Clement L. Hirsch Stakes (Grade 1), Del Mar - 1st"
]

# hash for horse pictures
horse_picture_dir = Dir.new('app/assets/images/horse_pictures/')
horse_picture_files = horse_picture_dir.children.to_h { |file| [file, "#{horse_picture_dir.path}#{file}"] }

horses = []
20.times do
  new_horse = Horse.new(
    user: users.sample,
    name: Faker::Creature::Horse.unique.name,
    breed: breeds.sample,
    age: rand(3..15),
    location: locations.sample,
    stud_fee: rand(500..5000).to_f,
    pedigree: pedigrees.sample,
    progeny_success: progeny_success_options.sample,
    race_record: race_record_options.sample
  )

  3.times do
    # pick a random horse picture
    random_horse_picture = horse_picture_files.keys.sample
    new_horse.pictures.attach(
      io: File.open(horse_picture_files[random_horse_picture]),
      filename: random_horse_picture,
      content_type: "image/jpg"
    )
  end

  new_horse.save!
  horses << new_horse
end

# Create bookings
puts "Creating bookings..."
statuses = ["pending", "accepted", "declined", "cancelled", "completed"]

30.times do
  horse = horses.sample
  user = (users - [horse.user]).sample # Ensures requester isn't the horse owner
  start_date = Date.today + rand(1..30) # Random date within the next month
  end_date = start_date + rand(1..7) # Booking lasts 1-7 days

  Booking.create!(
    user: user,
    horse: horse,
    start_date: start_date,
    end_date: end_date,
    status: statuses.sample, # Randomly assigns status
    price_at_booking: horse.stud_fee
  )
end

puts "Seeding completed!"
