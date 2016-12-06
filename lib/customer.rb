class Customer
  attr_reader(:name, :phone, :animal_type_preference, :breed_preference)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @animal_type_preference = attributes.fetch(:animal_type_preference)
    @breed_preference = attributes.fetch(:breed_preference)
  end
  define_method(:save) do
    DB.exec("INSERT INTO customers (name, phone, animal_type_preference, breed_preference) VALUES ('#{@name}', '#{@phone}', '#{@animal_type_preference}', '#{@breed_preference}');")
  end

    define_singleton_method(:all) do
      returned_customers = DB.exec("SELECT * FROM customers")
      customers = []
      returned_customers.each() do |customer|
        name = customer.fetch('name')
        phone = customer.fetch('phone')
        animal_type_preference = customer.fetch('animal_type_preference')
        breed_preference = customer.fetch('breed_preference')
        customers.push(Customer.new({:name => name, :phone => phone, :animal_type_preference => animal_type_preference, :breed_preference => breed_preference}))
      end
      customers
    end

    define_method(:==) do |other_customer|
      self.name.==(other_customer.name).&(self.phone.==(other_customer.phone)).&(self.animal_type_preference.==(other_customer.animal_type_preference)).&(self.breed_preference.==(other_customer.breed_preference))
    end

end
