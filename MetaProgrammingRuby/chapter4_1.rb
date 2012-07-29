result = class MyClass
           self
end
puts result

class MyClass
  #
  def my_method
    #
  end
end

def add_method_to(a_class)
  a_class.class_eval do
    def m; "Hello"; end
  end
end

add_method_to String
puts "abc".m
puts "abc".methods.grep /^m$/

str = "this is test"

def str.all_up
  self.upcase
end

def metho(str)
  puts str.all_up
end
metho str

obj = Object.new
eigenclass = class << obj
               self
end

puts eigenclass.class

def obj.my_singleton
end

puts eigenclass.instance_methods.grep /my/

class MyClass
  def my_method;"my mthod is here"; end
  alias :m :my_method
end

obj = MyClass.new
p obj.m
