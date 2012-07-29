class A
  def count
    "one"
  end
end

module AppendTwo
  def count
    "#{super} two"
  end
end

module AppendThree
  def count
    "#{super} three"
  end
end

a = A.new
a.extend(AppendTwo)
a.extend(AppendThree)
p a.count
