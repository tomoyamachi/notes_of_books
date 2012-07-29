require "open-uri"
loop do
  puts( open("http://finance.google.com/finance?cid=983582").read[/<span class="\w+" id="ref_983582_c">([+-]?\d+\.\d+)/m,1])
  sleep(30)
end
