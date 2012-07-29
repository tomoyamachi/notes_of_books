def iter(i=0,a=[], arry, sum)
  if i == arry.length
    if sum(a) == sum
      p "Yes : #{a} = #{sum}"
    end
  else
    iter(i+1,a, arry,sum)
    a.push(arry[i])
    iter(i+1,a,arry,sum)
    a.pop
  end
end

def sum(*args)
  i = 0
  args.flatten.each { |a| i += a }
  return i
end

iter([1,2,3,4,7], 13)
