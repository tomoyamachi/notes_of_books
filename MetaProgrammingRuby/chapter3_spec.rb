require "rspec"
class Using
  def dispose
    @disposed = true
  end

  def disposed?
    @disposed
  end

end

module Kernel
  def using(using)
    begin
      yield
    ensure
      using.dispose
    end
  end

end

describe Using do
  before :each do
    @u = Using.new
  end

  it '#disposed? in normal mode' do
    using(@u) { }
    @u.should be_disposed
  end

  it '#disposed? in Exceptional mode' do
    lambda { using(@u){ raise Exception } }.should raise_error
    @u.should be_disposed

  end

end

var = "Scope gate"

MyClass = Class.new do
  puts "#{var} in class"

  define_method :my_method do
    puts "#{var} in method"
  end
  define_method :say do |n|
    puts "Hi, #{n}"
  end
end
MyClass.new.say "Tom"


#p124
def math(a,b)
  yield(a,b)
end

def teach_math(a,b, &operate)
  puts math(a,b, &operate)
end

obj = teach_math(2,3) { |x,y| x + y }

#p124
def create_proc(&the_proc)
  the_proc
end
p = create_proc{ |name| "Hello, #{name}." }
puts p.class
puts p.call("Bill")

# p126
#define_method :double do |callable|
def double(callable)
   callable.call * 2
end
l = lambda {return 10}
puts double l

#p = Proc.new { return 10 }
#puts double p

#p127
l_arity = ->(a,b){ [a,b]}
p_arity = Proc.new { |a,b| [a,b]}

p p_arity.call(1)
#p l_arity.call(1)
p p_arity.call(1,2)
p l_arity.call(1,2)
p p_arity.call(1,2,3)
#p l_arity.call(1,2,3)

#p129
class CallMethod
  def initialize(value)
    @x = value
  end

  def my_method
    puts @x
  end
end
obj = CallMethod.new(1)
m = obj.method :my_method
m.call
obj.instance_eval { @x = 2 }
m.call
