require('sinatra')
require('sinatra/reloader')
require('./lib/animal')
require('./lib/customer')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => 'animal_shelter'})

get('/') do
  erb(:index)
end

get('/admin') do
  erb(:admin)
end

get('/unadopted_animals') do
  @unadopted_animals = Animal.find_all_by("customer_id", "0")
  erb(:unadopted_animals)
end

get('/adopted_animals') do
  @adopted_animals = Animal.find_adopted()
  erb(:adopted_animals)
end

# Add Animal Routing
get('/add_animal') do
  erb(:add_animal)
end

post('/animal_new') do
  name = params.fetch('name')
  gender = params.fetch('gender')
  type = params.fetch('type')
  breed = params.fetch('breed')
  date = params.fetch('date_of_admittance')
  Animal.new({:name => name, :gender => gender, :type => type, :breed => breed, :date_of_admittance => date}).save()
  @unadopted_animals = Animal.find_all_by("customer_id", "0")
  erb(:unadopted_animals)
end
# End Add Animal Routing
