require 'euler_helper.rb'

DESCRIPTION = <<DESC
In the 5 by 5 matrix below, the minimal path sum from the top left to the bottom right, by only moving to the right and down, is indicated in bold red and is equal to 2427.		
131	673	234	103	18
201	96	342	965	150
630	803	746	422	111
537	699	497	121	956
805	732	524	37	331
	
Find the minimal path sum, in matrix.txt (right click and 'Save Link/Target As...'), a 31K text file containing a 80 by 80 matrix, from the top left to the bottom right by only moving right a
DESC

sample = <<MATR
131	673	234	103	18
201	96	342	965	150
630	803	746	422	111
537	699	497	121	956
805	732	524	37	331
MATR

def prepare matrtxt
  matrtxt.split(/\n/).map{|row| row.split.map(&:to_i) }
end

def prepare_file matrtxt
  matrtxt.split(/\n/).map{|row| row.split(/,/).map(&:to_i) }
end

def a(x,y)
  @matrix[x][y]
end

def f(m,n, memo={})
  memo[[m,n]] ||= if m == 1 && n == 1
    a(1,1)
  elsif m == 1
    f(1, n-1) + a(m,n)
  elsif n == 1
    f(m-1, n) + a(m,n)
  else
    [f(m-1,n), f(m, n-1)].min + a(m, n)
  end
end

def dijkstra matrix, initrow
  msize = matrix.map(&:size).sum
  row, col = initrow, 0
  paths = {[row,col] => matrix[row][col]}

  adjacent = lambda {|i,j| 
    r = []
    r += [[i-1,j]] if i > 0
    r += [[i+1,j]] if i < matrix.size-1
    r += [[i,j+1]] if j < matrix.size-1
    r
  }

  path_to = lambda {|i,j| 
    r = []
    r += [[i-1,j]] if i > 0
    r += [[i+1,j]] if i < matrix.size-1
    r += [[i,j-1]] if j > 0

#    puts r.inspect
    return r.map{|point| paths[[point[0], point[1]]] }.compact.min
  }

  edge = adjacent.call(row,col)
  
  while paths.keys.size < msize
    curr_paths = edge.inject({}) do |memo, point|
      p1 = path_to.call(*point)
      p2 = matrix[point[0]][point[1]]
#      puts p1.inspect
#      puts p2.inspect
      memo[p1 + p2] = point
      memo
    end
    m = curr_paths.keys.min
    to_add = curr_paths[m]
    paths[to_add] = m
#    puts edge.inspect
    edge.delete(to_add)
#    puts edge.inspect
    edge |= adjacent.call(*to_add)
    edge -= paths.keys
#    puts edge.inspect
#    puts paths.keys.inspect
    overput paths.size
    return paths if to_add == [matrix.size - 1 , matrix.size - 1]
  end
  
  paths
end

benchmark do
  matrix = prepare_file(File.read('matrix.txt'))
  #matrix = prepare(sample)
  tree = dijkstra(matrix, 0)
  m = (0...matrix.size).map {|a| tree[[a,matrix.size-1]]}.compact.min
  puts
  puts m
  puts
  m
  puts
  puts absmin
end
