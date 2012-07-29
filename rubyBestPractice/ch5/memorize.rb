# -*- coding: utf-8 -*-
def fib(n)
  return n if (0..1).include? n
  fib(n-1) + fib(n-2)
end
p fib 10

def memo_fib(n)
  @fibs ||= [0,1]
  @fibs[n] ||= memo_fib(n-2) + memo_fib(n-1)
end
p memo_fib(1000)

def rgb2hex_cache(rgb)
  @rgb2hex ||= Hash.new do |colors,value|
    colors[value]=value.map {|e| "%02x" % e}.join
  end
  @rgb2hex[rgb]
end

def hex2rgb_cache(hex)
  @hex2rgb ||= Hash.new do |colors,value|
    # 文字列を3分割する
    r,g,b = value[0..1],value[2..3],value[4..5]
    colors[value] = [r,g,b].map {|e| e.to_i(16) }
  end
  @hex2rgb[hex]
end

p hex2rgb_cache("fff45f")
