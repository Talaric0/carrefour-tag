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
  user.address = Faker::Address.full_address
  user.email = "#{user.first_name.downcase}_#{user.last_name.downcase}@gmail.com"
  user.password = '123456'
  user.save!
  user.photo.attach(io: open('https://source.unsplash.com/featured/?face'),
                     filename: "#{user.first_name}_avatar.jpg")

  p "#{user.first_name} created with email #{user.email} and password 123456"
end

p 'Creating users for André and Bruno'

andre = User.new
  andre.first_name = "André"
  andre.last_name = "Carneiro"
  andre.cpf = "12345678910"
  andre.address = Faker::Address.full_address
  andre.email = "#{andre.first_name.downcase.parameterize}.#{andre.last_name.downcase.parameterize}@gmail.com"
  andre.password = '123456'
  andre.save!
  andre.photo.attach(io: open('https://ca.slack-edge.com/T024J94Q9MY-U024UNJK6Q3-a074b806d67a-512'),
                     filename: "#{andre.first_name.parameterize}_avatar.jpg")

  p "#{andre.first_name} created with email #{andre.email} and password 123456"

bruno = User.new
  bruno.first_name = "Bruno"
  bruno.last_name = "Francisco"
  bruno.cpf = "12345678911"
  bruno.address = Faker::Address.full_address
  bruno.email = "#{bruno.first_name.downcase.parameterize}.#{bruno.last_name.downcase.parameterize}@gmail.com"
  bruno.password = '123456'
  bruno.save!
  bruno.photo.attach(io: open('https://ca.slack-edge.com/T024J94Q9MY-U025AUYL4NM-f07ad27ee974-512'),
                     filename: "#{bruno.first_name.parameterize}_avatar.jpg")

  p "#{bruno.first_name} created with email #{bruno.email} and password 123456"

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
      maker: "#{maker['id']}-#{maker['fipe_name']}",
      model: model['name'].split(" ")[0],
      year: rand(2008..Date.today.year),
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
