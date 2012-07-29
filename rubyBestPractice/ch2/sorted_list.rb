class SortedList
  include Enumerable
  def initialize
    @data = []
  end

  def <<(element)
    (@data << element).sort!
  end

  def each
    @data.each {|e| yield(e)}
  end
  def report(head)
    header = "#{head}\n#{'-'*head.size}"
    body = map{|e| yield(e)}.join("\n") + "\n"
    footer = Time.now
    [header, body, footer].join("\n")
  end
end
a = SortedList.new
a << 3;a.<< 1;a << 5
p a
x = 0;a.each{|e| x+= e}
p x
p a.map {|e| e+ 3}
p a.to_a
p a.inject(0){|s,e| s+e}
p a.select {|e| e>2}
puts a.report("Add fish"){|e| "Fish #{e}"}
