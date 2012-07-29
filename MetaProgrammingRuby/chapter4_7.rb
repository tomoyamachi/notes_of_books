class Fixnum
  alias :old_plus :+

  def +(n)
    self.old_plus(n).old_plus(1)
  end
end

puts 4 + 3 ## 8
