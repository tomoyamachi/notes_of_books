p %w[foo bar baz].map(&:capitalize)

class Filter
  def initialize
    @constraints =[]
  end

  def constraint(&block)
    @constraints << block
  end

  def to_proc
    lambda {|e| @constraints.all? {|fn| fn.call(e)} }
  end
end

filter = Filter.new

filter.constraint{|x| x > 10}
p (0..30).select(&filter)

filter.constraint{|x| x.even?}
p (0..30).select(&filter)
