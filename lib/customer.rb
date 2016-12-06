class Customer
  attr_reader(:name, :phone, :animal_type_preference, :type, :owner_id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @phone = attributes.fetch(:phone)
    @animal_type_preference = attributes.fetch(:animal_type_preference)
    @breed_preference = attributes.fetch(:breed_preference)
  end

end
