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

p 'Destroying all orders...'
Order.destroy_all
p 'Destroying all tags...'
Tag.destroy_all
p 'Destroying all users...'
User.destroy_all
p 'Destroying all locations...'
Location.destroy_all

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

p 'Creating 4 new Locations...'

location1 = Location.new
location1.name = 'MultiPark Moema'
location1.category = 'Estacionamento'
location1.save

location2 = Location.new
location2.name = 'Posto Shell Center'
location2.category = 'Posto'
location2.save

location3 = Location.new
location3.name = 'Drive Carrefour Pinheiros'
location3.category = 'Mercado'
location3.save

location4 = Location.new
location4.name = 'Pedágio Bandeirantes'
location4.category = 'Pedágio'
location4.save

p '------------------------------------------------------------------------------------'

p 'Creating new tags...'

puts "Fetching car makers..."
makers_url = 'https://fipeapi.appspot.com/api/1/carros/marcas.json'
serialized = URI.open(makers_url).read
makers_array = JSON.parse(serialized)
puts "Done fetching."


User.all.each do |user|
  (1..5).to_a.sample.times do
    maker = makers_array.sample

    # fetch a random model from the maker
    model = JSON.parse(URI.open("https://fipeapi.appspot.com/api/1/carros/veiculos/#{maker['id']}.json").read).sample

    new_tag = Tag.create!(
      user: user,
      nickname: "Carro do #{Faker::Name.unique.male_first_name}",
      plate: "#{('A'..'Z').to_a.shuffle[0,3].join}-#{Faker::Number.number(digits: 4)}",
      maker: maker['fipe_name'],
      model: model['name'].split(' ')[0].capitalize,
      year: rand(2000..Date.today.year),
    )
    puts "Created #{new_tag.nickname} with plate #{new_tag.plate}, a #{new_tag.model} from #{new_tag.maker} year #{new_tag.year}"
    
    #adding orders to TAG
    t1 = Time.parse("2021-06-01 12:00:00")
	  t2 = Time.parse("2021-06-23 17:00:00")
    3.times do
      order = Order.new
      order.tag = new_tag
      order.location = Location.all.sample
      order.value = (15...35).to_a.sample
      order.created_at = rand(t1..t2)
      order.save
    end
  end
  puts "Created 3 orders for each TAG"
end

puts "DONE!"
