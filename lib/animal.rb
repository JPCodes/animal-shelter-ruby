class Animal
  attr_reader(:name, :gender, :date_of_admittance, :type, :customer_id, :id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @gender = attributes.fetch(:gender)
    @date_of_admittance = attributes.fetch(:date_of_admittance)
    @type = attributes.fetch(:type)
    @customer_id = attributes.fetch(:customer_id)
    @id = attributes.fetch(:id, nil)
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO animals (name, gender, date_of_admittance, type, customer_id) VALUES ('#{@name}', '#{@gender}', '#{@date_of_admittance}', '#{@type}', #{@customer_id}) RETURNING id;")
    @id = result.first().fetch('id').to_i()
  end

  define_singleton_method(:all) do
    returned_animals = DB.exec("SELECT * FROM animals")
    animals = []
    returned_animals.each() do |animal|
      name = animal.fetch('name')
      gender = animal.fetch('gender')
      date_of_admittance = animal.fetch('date_of_admittance')
      type = animal.fetch('type')
      customer_id = animal.fetch('customer_id').to_i
      id = animal.fetch('id').to_i
      animals.push(Animal.new(:name => name, :gender => gender, :date_of_admittance => date_of_admittance, :type => type, :customer_id => customer_id, :id => id))
    end
    animals
  end

  define_singleton_method(:find) do |id|
    all_animals = Animal.all()
    found_animal = nil
    all_animals.each() do |animal|
      if animal.id().to_i == id.to_i
        found_animal = animal
      end
    end
    found_animal
  end

  define_method(:==) do |other_animal|
    self.name().==(other_animal.name()).&(self.gender().==(other_animal.gender())).&(self.date_of_admittance().==(other_animal.date_of_admittance())).&(self.type().==(other_animal.type())).&(self.customer_id().==(other_animal.customer_id()))
  end

end
