sum = 0
File.foreach("data.txt"){|line| sum += line[/total: (\d+)/,1].to_f}
p sum

enum = File.foreach("data.txt")
sum2 = enum.inject(0){|s,r| s + r[/total: (\d+)/,1].to_f }
p sum2

def head(file_name, max_lines=10)
  File.open(file_name) do |file|
    file.each do |line|
      puts line
      break if file.lineno == max_lines
    end
  end
end

head "data.txt",3


keys=[];values=[]
File.open("data.txt") do |file|
  file.each do |line|
    (file.lineno.odd? ? keys : values) << line.chomp
  end
end
p Hash[*keys.zip(values).flatten]
