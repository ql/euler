require 'euler_helper.rb'
NAME ="How many different ways can one hundred be written as a sum of at least two positive integers?"
DESCRIPTION ="How many different ways can one hundred be written as a sum of at least two positive integers?"

def c n
  count n,n-1
end

def count n, k, memo = {}
  memo[[n,k]] ||= if k == 2
    (n/2).floor + 1
  else
    (0..(n/k).floor).inject(0) {|acc, i| acc += count(n - k*i, k-1, memo) }
  end
end

m = 100
benchmark do
  puts c(m)
end
