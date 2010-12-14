require 'euler_helper.rb'
NAME ="How many different ways can one hundred be written as a sum of at least two positive integers?"
DESCRIPTION ="How many different ways can one hundred be written as a sum of at least two positive integers?"

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
  i = 449
  pp = p2(i, memo)
  while pp  % 1_000_000 != 0
    i+=5
    pp = p2(i, memo)
    puts "#{i} ! #{pp}" if pp%1000 == 0
  end
  i
end

def penta q
 (3*(q**2)-q)/2
end

def p2 n, memo = {}
  memo[n] ||= if n == 0
    1
  elsif n < 0 
    0
  else
    (1..n).inject(0) {|acc, i| acc += (-1)**(i+1)*p2(n-penta(i), memo) + (-1)**(i+1)*p2(n-penta(-i), memo) } 
  end
  
end

m = 1000
benchmark do
  puts solve
end
