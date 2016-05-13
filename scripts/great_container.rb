class GreatContainer
	attr_accessor :elements, :name
	attr_reader :created_at
	attr_writer :important
	@@count = 0

	def initialize(name, collection)
		@elements = collection
		@created_at = Time.now
		@name = name
		@@count += 1
	end

	def [](index); @elements[index-1] if index > 0; end

	def []=(index, value); @elements[index-1] = value if index > 0; end

	def self.count; @@count; end

	class << self
		def reset
			@@count = 0
		end
	end
end
holder1 = GreatContainer.new("Lives", [1,2,3,4,5,6,7,8,9])
holder2 = GreatContainer.new "Days", (1..365).to_a
puts GreatContainer.count # 2
GreatContainer.reset 
puts holder1.class.count # 0
holder1[0] # nil
holder1[1] = -1
puts holder1.elements.to_s # [-1, 2, 3, 4, 5, 6, 7, 8, 9]