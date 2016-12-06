class Customer
  attr_reader(:name, :phone, :animal_type_preference, :breed_preference, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @animal_type_preference = attributes.fetch(:animal_type_preference)
    @breed_preference = attributes.fetch(:breed_preference)
    @id = attributes.fetch(:id, nil)
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
        id = customer.fetch('id').to_i
        customers.push(Customer.new({:name => name, :phone => phone, :animal_type_preference => animal_type_preference, :breed_preference => breed_preference, :id => id}))
      end
      customers
    end

    define_method(:==) do |other_customer|
      self.name.==(other_customer.name).&(self.phone.==(other_customer.phone)).&(self.animal_type_preference.==(other_customer.animal_type_preference)).&(self.breed_preference.==(other_customer.breed_preference))
    end

    define_singleton_method(:find_all_by) do |attribute_name,attribute|
      all_customers = Customer.all()
      found_customers = []
      all_customers.each() do |customer|
        if eval("customer."+eval("attribute_name")).to_s == attribute.to_s
          found_customers.push(customer)
        end
      end
      found_customers
    end

end
