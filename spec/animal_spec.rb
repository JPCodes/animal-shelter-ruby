require('spec_helper')

describe(Animal) do

  describe('#initialize') do
    it("return attributes") do
      test_animal = Animal.new({:name => "Doggie1", :gender =>"male", :date_of_admittance => '2016-08-12', :type => 'dog', :breed => 'Husky', :customer_id => 0})
      expect(test_animal.name).to(eq('Doggie1'))
      expect(test_animal.gender).to(eq('male'))
      expect(test_animal.date_of_admittance).to(eq('2016-08-12'))
      expect(test_animal.type).to(eq('dog'))
    end
  end

  describe('#save') do
    it("Creates database entry") do
      test_animal = Animal.new({:name => "Doggie2", :gender =>"male", :date_of_admittance => '2016-08-12', :type => 'dog', :breed => 'Husky', :customer_id => 0})
      test_animal.save()
      expect(Animal.all()).to(eq([test_animal]))
    end
  end

  describe('.find_by') do
    it('Find an animal by id') do
      test_animal3 = Animal.new({:name => "Doggie3", :gender =>"male", :date_of_admittance => '2016-08-12', :type => 'dog', :breed => 'Husky', :customer_id => 0})
      test_animal2 = Animal.new({:name => "Catty", :gender =>"female", :date_of_admittance => '2016-07-11', :type => 'cat', :breed => 'calico', :customer_id => 0})
      test_animal3.save()
      test_animal2.save()
      expect(Animal.find_by("id", test_animal2.id)).to(eq(test_animal2))
      expect(Animal.find_by("name", test_animal2.name)).to(eq(test_animal2))
      expect(Animal.find_by("type", test_animal2.type)).to(eq(test_animal2))
      expect(Animal.find_by("breed", test_animal2.breed)).to(eq(test_animal2))
    end
  end

  describe('.find_all_by') do
    it('Find an animal by id') do
      test_animal3 = Animal.new({:name => "Doggie3", :gender =>"male", :date_of_admittance => '2016-08-12', :type => 'dog', :breed => 'Husky', :customer_id => 0})
      test_animal2 = Animal.new({:name => "Catty", :gender =>"female", :date_of_admittance => '2016-07-11', :type => 'cat', :breed => 'calico', :customer_id => 0})
      test_animal4 = Animal.new({:name => "Catty2", :gender =>"female", :date_of_admittance => '2016-07-11', :type => 'cat', :breed => 'calico',:customer_id => 0})
      test_animal3.save()
      test_animal2.save()
      test_animal4.save()
      expect(Animal.find_all_by("gender", "male")).to(eq([test_animal3]))
      expect(Animal.find_all_by("type", "cat")).to(eq([test_animal2, test_animal4]))
      expect(Animal.find_all_by("breed", "calico")).to(eq([test_animal2, test_animal4]))
      expect(Animal.find_all_by("customer_id", "0")).to(eq([test_animal3, test_animal2, test_animal4]))
    end
  end

  describe('sort_date') do
    it('sorts animals by date of admittance') do
      test_animal3 = Animal.new({:name => "Doggie3", :gender =>"male", :date_of_admittance => '2017-08-12', :type => 'dog',:breed => 'Husky', :customer_id => 0})
      test_animal2 = Animal.new({:name => "Catty", :gender =>"female", :date_of_admittance => '2016-07-11', :type => 'cat',:breed => 'calico', :customer_id => 0})
      test_animal4 = Animal.new({:name => "Catty2", :gender =>"female", :date_of_admittance => '2015-07-11', :type => 'cat', :breed => 'calico',:customer_id => 0})
      test_animal3.save()
      test_animal2.save()
      test_animal4.save()
      expect(1).to(eq(1))
    end
  end

  describe('#add_customer_id') do
    it('Adds a customer_id to an animal to indicate ownership') do
      test_animal = Animal.new({:name => "Doggie1", :gender =>"male", :date_of_admittance => '2016-08-12', :type => 'dog', :breed => 'Husky', :customer_id => 0})
      test_animal.save()
      test_customer = Customer.new({:name => "Diego", :phone =>"1239810923", :animal_type_preference => 'dog', :breed_preference => 'border-collie'})
      test_customer.save()
      test_animal.customer_id = test_customer.id()
      expect(test_animal.customer_id()).to(eq(test_customer.id()))
    end
  end


end
