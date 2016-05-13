class R
  attr_accessor :a, :b
  def initialize(a,b)
    raise ZeroDivisionError, "Couldn't instantiate as division by 0" if b == 0
    @a, @b = a,b
  end # a - above, b - below

  @@operation_types = []
  def self.define_operation(name, block)
    define_method(name) do |arg|
      if arg.is_a? R
        block.call self, arg
      elsif arg.is_a? Numeric
        block.call self, R.new(arg, 1)
      elsif arg.respond_to? :to_rat
        block.call self, arg.to_rat
      else
        raise ArgumentError, "Argument should be a Rational or Number, couldn't do #{name} with #{arg.class}"
      end
    end
  end

  define_operation :+, lambda{|l,r| R.new(l.a*r.b + r.a*l.b, l.b*r.b)}
  define_operation :-, lambda{|l,r| R.new(l.a*r.b - r.a*l.b, l.b*r.b)}
  define_operation :*, lambda{|l,r| R.new(l.a*r.a, l.b*r.b)}
  define_operation :/, lambda{|l,r| R.new(l.a*r.b, l.b*r.a)}

  def to_s; "#{a}/#{b}"; end

  def to_rat; self; end
end

r1 = R.new(2, 3)
r2 = R.new(3, 7)
puts r1 + r2 # 23/21
puts r2/r1 # 9/14
puts r1 - 4 # -10/3
begin
puts r1*"12" # Argument should be a Rational or Number, couldn't do * with String (ArgumentError)
rescue => e
 puts e
end


class String
  def to_rat
    a, b = self.split("/")
    R.new(a.to_i, b.to_i == 0 ? 1 : b.to_i)
  end

  def to_image_tag
    "<img src=\"#{self}\" />"
  end
  
  alias :to_image :to_image_tag
end  
r1 = R.new(2, 3)
puts r1*"12" # Argument should be a Rational or Number, couldn't do * with String (ArgumentError)
str_path = "http://some.image.data/some_image.gif"
puts str_path.to_image #