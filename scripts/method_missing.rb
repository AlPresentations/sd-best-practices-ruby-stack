class Target
    def identify; self.inspect; end
    # target methods here
end

class Delegator
  def initialize(target)
    @target = target
  end

  def method_missing(name, *args, &block)
    @target.send(name, *args, &block)
  end
end

class Presenter < Delegator
  # proxy methods here
end

puts (obj = Target.new).inspect # 
obj_presenter = Presenter.new obj
puts obj_presenter.identify