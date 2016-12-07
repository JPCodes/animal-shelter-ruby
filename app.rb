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

# Admin page
get('/admin') do
  erb(:admin)
end
# End Admin page

# View adopted/unadopted animals Routing
get('/unadopted_animals') do
  @unadopted_animals = Animal.find_all_by("customer_id", "0")
  erb(:unadopted_animals)
end

get('/adopted_animals') do
  @unadopted_animals = Animal.find_adopted()
  puts "inspecting: ", @adopted_animals.inspect
  erb(:adopted_animals)
end
# End View adopted/unadopted animals Routing

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
  Animal.new({:name => name, :gender => gender, :type => type, :breed => breed, :date_of_admittance => date, :customer_id => 0}).save()
  @unadopted_animals = Animal.find_all_by("customer_id", "0")
  erb(:unadopted_animals)
end
# End Add Animal Routing

# Specific Animal view Routing
get('/animal/:id') do
  @current_animal = Animal.find_by('id', params.fetch('id').to_i)
  erb(:animal)
end
# End Specific Animal view Routing

# Add Customer Routing
get('/add_customer') do
  erb(:add_customer)
end

post('/customer_new') do
  name = params.fetch('name')
  phone = params.fetch('phone')
  animal_type_preference = params.fetch('animal_type_preference')
  breed_preference = params.fetch('breed_preference')
  Customer.new({:name => name, :phone => phone, :animal_type_preference => animal_type_preference, :breed_preference => breed_preference}).save()
  @customers = Customer.all()
  erb(:customers)
end
# End Add Customer Routing

# Specific Customer view Routing
get('/customer/:id') do
  @customer = Customer.find_by('id', params.fetch('id').to_i)
  @unadopted_animals = Animal.find_all_by("customer_id", "0")

  erb(:customer)
end
# End Specific Customer view Routing

# View all Customers
get('/view_customers') do
  @customers = Customer.all()
  erb(:customers)
end
# End View all Customers
