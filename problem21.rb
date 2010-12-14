#!/bin/env ruby
require 'benchmark'

<<COMM
Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
If d(a) = b and d(b) = a, where a  b, then a and b are an amicable pair and each of a and b are called amicable numbers.

For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

Evaluate the sum of all the amicable numbers under 10000.
COMM
def factors(n)
  x = n
  factors = []
  sq = Math.sqrt(n).floor
  (2..sq).each do |prime|
     #next if n % prime != 0
     #break if prime > sq
     if (n % prime == 0)
       factors.push(prime)
     end
  end
  factors + factors.map {|f| x / f} + [1]
end

def sum seq
  seq.inject(0) {|ac,i| ac+=i}
end

def d n
  sum(factors(n))
end

def amicable? n
  (d(d(n)) == n) && (d(n) != n)
end

amic = (1..10000).select {|d| amicable?(d) }
puts amic.inspect
puts amic.map{|a| d(a) }.inspect
puts sum(amic)
