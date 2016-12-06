require('spec_helper')


describe(Customer) do
  describe('#initialize') do
    it ("return attributes") do
      test_customer = Customer.new({:name => "James", :phone =>"9713453423", :animal_type_preference => 'cat', :breed_preference => 'calico'})
      expect(test_customer.name).to(eq('James'))
      expect(test_customer.phone).to(eq('9713453423'))
      expect(test_customer.animal_type_preference).to(eq('cat'))
      expect(test_customer.breed_preference).to(eq('calico'))
    end
  end
  describe('#save') do
    it ("Creates database entry") do
      test_customer = Customer.new({:name => "James", :phone =>"9713453423", :animal_type_preference => 'cat', :breed_preference => 'calico'})
      test_customer.save()
      expect(Customer.all()).to(eq([test_customer]))
    end
  end

  describe('.find_all_by') do
    it "will find customers by attribute" do
      test_customer1 = Customer.new({:name => "James", :phone =>"9713453423", :animal_type_preference => 'cat', :breed_preference => 'calico'})
      test_customer2 = Customer.new({:name => "Diego", :phone =>"1239810923", :animal_type_preference => 'dog', :breed_preference => 'border-collie'})
      test_customer3 = Customer.new({:name => "McChicken", :phone =>"123123123", :animal_type_preference => 'chicken', :breed_preference => 'silkie'})
      test_customer1.save()
      test_customer2.save()
      test_customer3.save()
      expect(Customer.find_all_by("animal_type_preference","chicken")).to(eq([test_customer3]))
    end
  end
end
