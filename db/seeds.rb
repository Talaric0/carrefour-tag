# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'open-uri'
require 'nokogiri'
require 'faker'

p 'Destroying all tags...'
Tag.destroy_all
p 'Destroying all users...'
User.destroy_all

p '------------------------------------------------------------------------------------'

p 'Creating 3 new Users...'

3.times do
  user = User.new
  user.first_name = Faker::Name.first_name
  user.last_name = Faker::Name.last_name
  user.cpf = Faker::Number.number(digits: 11)
  user.email = "#{user.first_name.downcase}_#{user.last_name.downcase}@gmail.com"
  user.password = '123456'
  user.save!
  user.photo.attach(io: open('https://source.unsplash.com/featured/?face'),
                     filename: "#{user.first_name}_avatar.jpg")

  p "#{user.first_name} created with email #{user.email} and password 123456"
end

p '------------------------------------------------------------------------------------'

p 'Creating new tags...'
