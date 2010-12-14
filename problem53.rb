#!/usr/bin/ruby
require 'euler_helper.rb'

<<COMM
There are exactly ten ways of selecting three from five, 12345:

123, 124, 125, 134, 135, 145, 234, 235, 245, and 345

In combinatorics, we use the notation, 5C3 = 10.

In general,nCr = 	n!
r!(nr)!	,where r  n, n! = n(n1)...321, and 0! = 1.


It is not until n = 23, that a value exceeds one-million: 23C10 = 1144066.

How many, not necessarily distinct, values of  nCr, for 1  n  100, are greater than one-million?
COMM

def c n, r
  f(n) / (f(r)*f(n-r))
end

def solve bound, limit
  res = 0
  (1..bound).each do |n|
    (1..n).each do |r| 
      if c(n,r) > limit
        #puts [n,r].inspect
        res += 1 
      end
    end
  end
  res
end

benchmark do
  puts solve(100, 1000000)
end
