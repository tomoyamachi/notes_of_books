def create_lake_arry(lake_map)
  lake_arry=[]
  lake_map.each_line do |line|
    arry=[]
    line_without_mark = line.chomp("\n")
    line_without_mark.each_char{|c| arry << c}
    lake_arry << arry
  end
  lake_arry
end

def solve(lake_map)
  count = 0
  lake_arry = create_lake_arry lake_map
  for y in 0..(lake_arry.length)-1
    line=lake_map[y]
    for x in 0..(line.size)-1
      if lake_map[y][x] == "w"
        count += 1
        check_around(lake_arry,x,y)
      end
    end
  end
  p count
end

def check_around(lake_arry,x,y)
  lake_arry[y][x] = "."
  for dy in -1..1
    for dx in -1..1
      nx = x + dx
      ny = y + dy
      if nx >= 0 && nx < 12 && ny >= 0 && ny < 12 &&  lake_arry[ny][nx] == "w"
        lake_arry[ny][nx] = "."
        check_around(lake_arry,ny,nx)
      end
    end
  end
end

lake = <<END
w......www.
www..ww....
w......wwww
...www..ww.
w..........
ww.........
....wwww...
wwwwwww....
...www.....
....w......
......wwwww
........www
END
solve lake
