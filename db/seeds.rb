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
users = []
10.times do
  users << User.create!(
    email: Faker::Internet.unique.email,
    password: "password123"
  )
end

# Create horses
puts "Creating horses..."
breeds = ["Thoroughbred", "Arabian", "Quarter Horse", "Andalusian", "Friesian"]
locations = ["Newmarket, UK", "Lexington, USA", "Chantilly, France", "Sydney, Australia", "Dubai, UAE"]

horses = []
20.times do
  horses << Horse.create!(
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
end

# Create bookings
puts "Creating bookings..."
statuses = ["pending", "accepted", "declined"]

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

