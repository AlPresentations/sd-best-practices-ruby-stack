require './great_container'

class Holder
	def initialize(name, object)
		@elements = GreatContainer.new(name, [object])
	end

  	def <<(object)
  		if validate_object(object)
	  		@elements[@elements.elements.size+1] = object
	  		return true
	  	end
	  	false	
  	end

  	def name; @elements.name; end	

  	def to_s; caption + ". I hold #{@elements.elements}"; end	

	protected

	def caption; "My name is #{name}"; end	

  	private	

  	def validate_object(object)
  		object.nil? || object.empty? ? false : true
  	end
end
bascket = Holder.new("Bascket", "Red Ball")
bascket << "Green Ball"
puts bascket # My name is Bascket. I hold ["Red Ball", "Green Ball"]
