# -*- coding: utf-8 -*-
class GetoutMaze
  attr_accessor :start, :goal
  def initialize(maze)
    @maze = ( maze.split("\n") ).map{|line| line.split // }
    @start = search_mark("S")
    # @d_arry = []
    # dx = [1,0,-1,0];dy = [0,1,0,-1]
    # dy.each do |y|;dx.each do |x|
    #   @d_arry << [x,y]
    # end;end
    @d_arry = [[1,0],[-1,0],[0,1],[0,-1]]
    @visited = [@start]
  end

  def search_maze(queue=[[@start]])
    queue = queue
    while !queue.empty?
      # queue #=> [ [ [0,1],[1,1] ], [ [0,1],[0,2] ] ] うしろほど最新
      top_queue = queue.first   #もっとも古いキューを実行
      point = top_queue.last    # 選んだキューのなかの、その時点たどりついている地点
      queue.shift             #  もっとも古いキューを消す

      # えらんだ地点の、x,yをそれぞれ移動
      next_points(point).each do |cx,cy|
          unless @visited.include?([cx,cy])
            @visited << [cx,cy]
            # 通路であれば、それをqueueに追加
            case @maze[cy][cx]
            when "."
              now_queue = top_queue.dup.push([cx,cy]) # [[Array]]だと、参照渡しっぽくなるので、複製して別の[[Array]]にする
              queue << now_queue
            # ゴールなら、最短を表示
            when "G"
              puts "最短の道のり : #{top_queue.size}"
              top_queue.each do |x,y|
                @maze[y][x] = "$"
              end
              @maze.each{|line| str=""; line.each{|c| str += c} ; puts str}
            end
          end
      end
    end
  end

  def next_points(current_point)
    next_point_arry=[]
    @d_arry.each do |dx,dy|
      cx = current_point[0] + dx
      cy = current_point[1] + dy
      next_point_arry << [cx,cy] if cx >= 0 && cx <10 && cy >= 0 && cy < 10
    end
    return next_point_arry
  end
    #   a = queue.last
    #   cx = a[0] +dx
    #   cy = a[1]+dy
    #   if cx >= 0 && cx <10 && cy >= 0 && cy < 10
    #     unless @visited.include? [cx,cy]
    #       @visited << [cx,cy]
    #       case @maze[cy][cx]
    #       when "."
    #         p "========================"
    #         queue << [cx,cy]
    #         p queue
    #         search_maze(queue)
    #       when "G"
    #         p "finish"
    #         queue
    #         p @visited.size
    #         queue.size
    #         queue.each do |x,y|
    #           @maze[y][x] = "$"
    #         end
    #         @maze.each{|line| str=""; line.each{|c| str += c} ; puts str}
    #       end
    #     end
    #   end
private
  def search_mark(mark)
    x = nil;y = 0
    @maze.each do |line|
      if line.index(mark)
        x = line.index(mark)
        break
      end
      y += 1
    end
    return [x,y]
  end

end

maze = <<END
#S######.#
......#..#
.#.##.##.#
.#........
##.##.####
....#....#
.#######.#
....#.....
.####.###.
....#...G#
END
sample = GetoutMaze.new(maze)

sample.search_maze

