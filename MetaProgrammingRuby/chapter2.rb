class MyClass
  def test(num)
    num * 3
  end
end

a = MyClass.new
puts a.test(1)

class MyClass
  define_method :test do |n|
    n * 4
  end
end

puts a.test(1)

class Lawyer
  def method_missing(method, *args)
    puts"#{method}(#{args})"
    puts "block" if block_given?
  end

  bob = Lawyer.new
  bob.test(3,4) do
    "Sample block"
  end
end

class Computer
  instance_methods.each do |m|
    undef_method m unless m.to_s =~ /^__|object_id|method_missing|respond_to?/
  end

  def method_missing(method, *args)
    puts "method missing"
  end
end
c = Computer.new
c.no_method
