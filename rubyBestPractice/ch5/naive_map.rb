require "benchmark"
def naive_map(array, &block)
  new_arr = []
  array.each {|e| new_arr << block.call(e)}
  return new_arr
end

def naive_map_recur(array,&block)
  return [] if array.empty?
  [ yield(array[0]) ] + naive_map_recur(array[1..-1],&block)
end

def naive_map_via_inject(array, &block)
  array.inject([]) {|s,e| [yield(e)] +s}
end

N = 100_000
Benchmark.bmbm do |x|
  a = [1,2,3,4,5]
  x.report("naive map") do
    N.times { naive_map(a) {|x| x+1} }
  end

  x.report("naive map recur") do
    N.times { naive_map_recur(a) {|x| x+1} }
  end

  x.report("naive map via inject") do
    N.times { naive_map_via_inject(a) {|x| x+1} }
  end
end
