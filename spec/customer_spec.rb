require('spec_helper')


describe(Customer) do
  describe('#initialize') do
    it ("return attributes") do
      test_customer = Customer.new({:name => "James", :phone =>"9713453423", :animal_type_preference => 'cats', :breed_preference => 'calico'})
      expect(test_customer.name).to(eq('James'))
      expect(test_customer.phone).to(eq('9713453423'))
      expect(test_customer.animal_type_preference).to(eq('cats'))
      expect(test_customer.breed_preference).to(eq('calico'))
    end
  end
  describe('#save') do
    it ("Creates database entry") do
      test_customer = Customer.new({:name => "James", :phone =>"9713453423", :animal_type_preference => 'cats', :breed_preference => 'calico'})
      test_customer.save()
      expect(Customer.all()).to(eq([test_customer]))
    end
  end



end
