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
  matrtxt.split(/\n/).map{|row| row.split(/,/).map(&:to_i) }
end

def a(x,y)
  @matrix[x-1][y-1]
end

def f(m,n, memo={})
  memo[[m,n]] ||= if m == 1 && n == 1
    a(1,1)
  elsif m == 1
    f(1, n-1, memo) + a(m,n)
  elsif n == 1
    f(m-1, n, memo) + a(m,n)
  else
    [f(m-1,n, memo), f(m, n-1, memo)].min + a(m, n)
  end
end

def solve matrix
  @matrix = prepare(matrix)
  f(@matrix.size, @matrix.size)
end

benchmark do
  puts solve(File.read('matrix.txt')).inspect
end
