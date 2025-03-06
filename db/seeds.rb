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
    pedigree: Faker::Lorem.sentence(word_count: 5),
    progeny_success: Faker::Lorem.sentence(word_count: 10),
    race_record: Faker::Lorem.paragraph(sentence_count: 3)
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
