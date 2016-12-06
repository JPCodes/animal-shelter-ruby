require('spec_helper')

describe(Animal) do

  describe('#initialize') do
    it ("return attributes") do
      test_animal = Animal.new({:name => "Doggie1", :gender =>"male", :date_of_admittance => '2016-08-12', :type => 'dog', :customer_id => 0})
      expect(test_animal.name).to(eq('Doggie1'))
      expect(test_animal.gender).to(eq('male'))
      expect(test_animal.date_of_admittance).to(eq('2016-08-12'))
      expect(test_animal.type).to(eq('dog'))
    end
  end

  describe('#save') do
    it ("Creates database entry") do
      test_animal = Animal.new({:name => "Doggie2", :gender =>"male", :date_of_admittance => '2016-08-12', :type => 'dog', :customer_id => 0})
      test_animal.save()
      expect(Animal.all()).to(eq([test_animal]))
    end
  end

  describe('.find') do
    it ('Find an animal by id') do
      test_animal3 = Animal.new({:name => "Doggie3", :gender =>"male", :date_of_admittance => '2016-08-12', :type => 'dog', :customer_id => 0})
      test_animal2 = Animal.new({:name => "Catty", :gender =>"female", :date_of_admittance => '2016-07-11', :type => 'cat', :customer_id => 0})
      test_animal3.save()
      test_animal2.save()
      expect(Animal.find(test_animal2.id())).to(eq(test_animal2))
    end
  end


end
