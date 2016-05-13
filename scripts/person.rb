class Person
  attr_accessor :name, :age, :city
  def initialize(hash)
    set_hash(hash)
    @created_at = Time.new
    @updated_at = Time.new
    @secret_number = Time.now.to_i
  end

  def update(hash = {})
    set_hash hash
  	@updated_at = Time.new
  	self
  end
 
  private
  
  def set_secret_code(new_code)
    @secret_number = new_code
  end

  def set_hash(hash)
    @name = hash[:name] if hash.has_key?(:name)
    @age  = hash[:age]  if hash.has_key?(:age)
    @city = hash[:city] if hash.has_key?(:city)
  end
end

person = Person.new name: 'Dmytro', age: 28, city: 'Chernivtsy'
puts person.inspect # <Person:... @name="Dmytro", @age=28, @city="Chernivtsy", @created_at=2014-05-28 19:06:14 +0300, @updated_at=2014-05-28 19:06:14 +0300, @secret_number=1401293174>
person.instance_variable_set(:@secret_number, 1234567)
puts person.inspect # <Person:... @name="Dmytro", @age=28, @city="Chernivtsy", @created_at=2014-05-28 19:06:14 +0300, @updated_at=2014-05-28 19:06:14 +0300, @secret_number=1234567>
puts person.send('update', {city: 'Lviv'}).inspect #<Person:... @name="Dmytro", @age=28, @city="Lviv", @created_at=2014-05-28 19:06:14 +0300, @updated_at=2014-05-28 19:06:14 +0300, @secret_number=1234567>
puts person.send(:set_hash, {:age => 30})
puts person.inspect # <Person:... @name="Dmytro", @age=30, @city="Lviv", @created_at=2014-05-28 19:06:14 +0300, @updated_at=2014-05-28 19:06:14 +0300, @secret_number=1234567>