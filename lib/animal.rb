class Animal
  attr_reader(:name, :gender, :date_of_admittance, :type, :owner_id)

  define_method(:initialize) do |attributes|
    @name = attributes.fetch(:name)
    @gender = attributes.fetch(:gender)
    @date_of_admittance = attributes.fetch(:date_of_admittance)
    @type = attributes.fetch(:type)
    @owner_id = attributes.fetch(:owner_id)
  end

end
