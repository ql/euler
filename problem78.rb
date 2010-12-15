require 'euler_helper.rb'
NAME ="Investigating the number of ways in which coins can be separated into piles."
DESCRIPTION ="Find the least value of n for which p(n) is divisible by one million."

def c n, memo
  count(n,n-1, memo) + 1
end

def count n, k, memo = {}
  memo[[n,k]] ||= if k == 2
    (n/2).floor + 1
  else
    (0..(n/k).floor).inject(0) {|acc, i| acc += count(n - k*i, k-1, memo) }
  end
end

def p(n, memo={})
  memo[n] ||= if n == 0
    1
  elsif n < 0
    0
  else
    (1..n).inject(0) {|acc, k| acc += ((-1)**(k+1) ) * ((p(n-k*(3*k-1)/2.0, memo)) + p(n-k*(3*k+1)/2.0, memo)) }
  end
end

def solve
  memo = {}
  i = 480
  pp = p2(i, memo)
  while pp  % 1_000_000 != 0
    i+=1
    pp = p2(i, memo)
  end
  i
end

def penta q
 (3*(q**2)-q)/2
end

def ubound n
  ((1+Math.sqrt(1+24*n)) / 6).ceil
end

def p2 n, memo = {}
  return 0 if n < 0
  memo[n] ||= if n == 0
    1
  else
    (1..ubound(n)).inject(0) {|acc, i| acc += (-1)**(i+1)*p2(n-penta(i), memo) + (-1)**(i+1)*p2(n-penta(-i), memo) } 
  end
  
end

benchmark do
  puts solve
end
