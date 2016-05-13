class  Figure
	attr_accessor :x, :y

	def initialize(x = 0, y = 0); @x, @y = x, y; end

	def draw; raise NotImplementedError, "Method drow wosn't implementd in class #{self.class}"; end

	def area; raise NotImplementedError, "Method area wosn't implementd in class #{self.class}"; end

	def +(otherFigure)
		raise ArgumentError, 'Can add only instance of Figure' unless otherFigure.is_a?(Figure)
		self.area + otherFigure.area
	end
end

class Circle < Figure
	attr_accessor :radius
	def initialize(r, x = 0, y = 0)
		@radius = r
		super(x, y)
	end

	def area; Math::PI*radius*radius; end
end

class Square < Figure
	attr_accessor :a
	def initialize(a, x = 0, y = 0)
		@a = a
		super(x, y)
	end

	def area; a*a; end

end
puts Circle.new(10) + Square.new(5) # 339.1592653589793
puts Square.new(5) + Circle.new(10) # 339.1592653589793
