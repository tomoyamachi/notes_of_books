module EvenSeriese
  class Node
    def initialize(num=0)
      @value = num
      @next = lambda { Node.new(num+2)}
    end

    attr_reader :value
    def next
      @next.call
    end
  end
end

e = EvenSeriese::Node.new(30)

def lazy_list(node,num)
  arr=[]
  num.times do
    arr << node.value
    node = node.next
  end
  return arr
end

p lazy_list(e,10)
p lazy_list(e,10).map{|n| n if n % 3 == 0}
p "======"
p lazy_list(e,40).map{|n| n if n % 3 == 0}.join(" ")

