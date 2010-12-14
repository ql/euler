require 'euler_helper.rb'
NAME ="What is the first value which can be written as the sum of primes in over five thousand different ways?"
DESCRIPTION ="How many different ways can one hundred be written as a sum of at least two positive integers?"

def c n, primes, memo
  count n, primes.first, primes, memo
end

def nxt k1, prim
  prim[prim.index(k1)+1] 
end

def count n, k, primes, memo = {}
  memo[[n,k]] ||= if k == 2 && n%2 == 0
    1
  elsif k == 2 && n%2 == 1
    0
  else
    (0..(n/k).floor).inject(0) {|acc, i| acc += count(n - k*i, nxt(k, primes), primes, memo) }
  end
end

def solve
  memo = {}
  primes = primes_under(200).reverse 
  i = 2
  while c(i, primes, memo) < 5000
    i+=1
  end
  i
end

benchmark do
  puts solve
end
