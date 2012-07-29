def distance(x1,y1,x2,y2)
  Math.hypot(x2-x1,y2-y1)
end

puts distance(1,1,3,3)

def load_file(name="hoge.rb",mode="rb")
  File.open(name,mode)
end

def story(opts)
  opts = {person:"Ichiro",animal:"Tiger"}.merge(opts)
  "#{opts[:person]} and #{opts[:animal]}"
end

puts story(person:"Tomoya",animal:"Lion")
puts story(animal:"Rabbit")

def distance2(*points)
  distance(*points.flatten)
end
