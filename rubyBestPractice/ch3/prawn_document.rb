def method_missing(name, *args, &block)
  puts "Call #{name} with #{args.inspect}"
end

1.no_method
2.foo("a","b")
