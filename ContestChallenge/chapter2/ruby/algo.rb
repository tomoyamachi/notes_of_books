class Ball
  def initialize(ballnums)
    #(ballnums.to_s).each_char{ |s| arr.push(s.to_i)}
    @balls = ballnums.split(/\s/).map{ |i| i.to_i}
  end
  def check_ball
    array1 = [];array2 = []
    flag = true
    for i in 0..@balls.size-1
      if array1.empty? || @balls[i] > array1.last
        array1.push(@balls[i])
      elsif array2.empty? || @balls[i] > array2.last
        array2.push(@balls[i])
      else
        flag = false
        break
      end
    end
    return flag
  end
end

class Sum_of_integer
  def initialize(n,s)
    @count = n
    @total = s
  end
  def detect
    count = 0
    a = (0..@total).to_a
    lists = a.combination(@count).to_a
    lists.each{ |list| count += 1 if list.inject(0){|sum,i| sum + i} == @total }
    return count
  end
end

class Number_of_island
  def initialize(island)
    @island = island
  end
  def return_num
    @count = 0;@iarry = []
    @island.each_line do |l|
      arr = []
      l.each_char{ |s| arr.push(s.to_i) if s == "0" or s == "1"}
      @iarry.push(arr)
    end

    @all_set = []
    for x in 0..11;for y in 0..11
        @all_set.push([x,y])
    end;end

    @complete_set = []
    @all_set.each do |x,y|
      if !@complete_set.include?([x,y])
        @complete_set.push([x,y])
        if @iarry[y][x] == 1
          @count += 1
          check_around(x,y)
        end
      end
    end
    return @count
  end
  def check_around(x,y)
    [[y+1,x],[y,x+1],[y-1,x],[y,x-1]].each do |y,x|
      if y < 12 && x < 12 && y >= 0 && x >= 0
        if !@complete_set.include?([x,y])
          @complete_set.push([x,y])
          check_around(x,y) if @iarry[y][x] == 1
        end
      end
    end
  end
end

require "rspec"
require "rubygems"
require "./ball"
# describe Ball do
#   it "1 2 3 4 5 6 7 8 9 10 puts YES" do
#     balls = Ball.new("1 2 3 4 5 6 7 8 9 10")
#     balls.check_ball.should == true
#   end
#   it "10 9 8 7 6 5 4 3 2 1 puts NO" do
#     balls = Ball.new("10 9 8 7 6 5 4 3 2 1")
#     balls.check_ball.should == false
#   end
#   it "3 1 4 2 5 6 7 8 9 10 puts YES" do
#     balls = Ball.new("3 1 4 2 5 6 7 8 9 10")
#     balls.check_ball.should == true
#   end
# end

# describe Sum_of_integer do
#   it "3,6 return 3" do
#     ints = Sum_of_integer.new(3,6)
#     ints.detect.should == 3
#   end

#   it "3,1 return 0" do
#     ints = Sum_of_integer.new(3,1)
#     ints.detect.should == 0
#   end

#   it "2,3 return 2" do
#     ints = Sum_of_integer.new(2,3)
#     ints.detect.should == 2
#   end

# end

# describe Number_of_island do
#   it "return 5" do
#     island = <<EOF
# 111100001111
# 111000001111
# 110000001111
# 100000001111
# 000100010000
# 000000111000
# 000001111100
# 100011111110
# 110001111100
# 111000111000
# 111100010000
# 000000000000
# EOF
#     n = Number_of_island.new(island)
#     n.return_num.should == 5
#   end

#   it "return 13" do
#     island = <<EOF
# 010001111100
# 110010000010
# 010010000001
# 010000000001
# 010000000110
# 010000111000
# 010000000100
# 010000000010
# 010000000001
# 010010000001
# 010010000010
# 111001111100
# EOF
#     n = Number_of_island.new(island)
#     n.return_num.should == 13
#   end
#   it "return 4" do
#     island = <<EOF
# 000000000000
# 111111111111
# 100010100001
# 100010100001
# 100010100001
# 100010100001
# 100100100101
# 101000011101
# 100000000001
# 100000000001
# 111111111111
# 100000000001
# EOF
#     n = Number_of_island.new(island)
#     n.return_num.should == 4
#   end

# end
