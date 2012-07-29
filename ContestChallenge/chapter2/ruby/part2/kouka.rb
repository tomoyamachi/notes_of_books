require "rspec"
class HungryCoins
  def initialize(*arry)
    i ||= 0
    @coins = [1,5,10,50,100,500]
    @coins.each do |cnum|
      self.instance_variable_set("@c#{cnum}", arry[i])
      i += 1
    end
  end

  def run(total)
    i=0
    @coins.reverse.each do |money|
      count = 0
      while (money <= total) && (self.instance_variable_get("@c#{money}") > count)
        total -= money
        count += 1
        i += 1
      end
    end
    p i
  end

  def minus(total)

  end

end

describe HungryCoins do
  it "#(3,2,1,3,0,2) 620 should 6" do
    @hc = HungryCoins.new(3,2,1,3,0,2)
    (@hc.run(620)).should == 6
  end
end
