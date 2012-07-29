event "sky drop down" do
  @sky_height < 300
end

event "sky coming closer" do
  @sky_height < @mountains_height
end

setup do
  puts "set sky height"
  @sky_height = 100
end

setup do
  puts "set mountains height"
  @mountains_height = 200
end
