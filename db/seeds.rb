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
Horse.destroy_all
User.destroy_all

# Create users
puts "Creating users..."
users = []
5.times do
  users << User.create!(
    email: Faker::Internet.unique.email,
    password: "password123"
  )
end

# Create horses
puts "Creating horses..."
breeds = ["Thoroughbred", "Arabian", "Quarter Horse", "Andalusian", "Friesian"]
locations = ["Newmarket, UK", "Lexington, USA", "Chantilly, France", "Sydney, Australia", "Dubai, UAE"]

20.times do
  Horse.create!(
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

puts "Seeding completed!"
