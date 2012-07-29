class Inbox
  attr_reader :unread_count
  def initialize
    @messages = []
    @unread_count=0
  end

  def <<(msg)
    @unread_count += 1
    @messages << msg
    return self
  end
end

i = Inbox.new
i << "msg1" << "msg2"
p i.unread_count

class Tree
  include Comparable
  attr_reader :age
  def initialize(age)
    @age = age
  end

  def <=>(other_tree)
    age <=> other_tree.age
  end
end

a = Tree.new(1)
b = Tree.new(2)
c = Tree.new(3)
p a < b
p c == a
p c.between?(a,b)
p b.between?(a,c)
