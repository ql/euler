#!/bin/env ruby
require 'benchmark'

<<COMM
A perfect number is a number for which the sum of its proper divisors is exactly equal to the number. For example, the sum of the proper divisors of 28 would be 1 + 2 + 4 + 7 + 14 = 28, which means that 28 is a perfect number.

A number n is called deficient if the sum of its proper divisors is less than n and it is called abundant if this sum exceeds n.

As 12 is the smallest abundant number, 1 + 2 + 3 + 4 + 6 = 16, the smallest number that can be written as the sum of two abundant numbers is 24. By mathematical analysis, it can be shown that all integers greater than 28123 can be written as the sum of two abundant numbers. However, this upper limit cannot be reduced any further by analysis even though it is known that the greatest number that cannot be expressed as the sum of two abundant numbers is less than this limit.

Find the sum of all the positive integers which cannot be written as the sum of two abundant numbers.
COMM

def factors(n)
  x = n
  factors = []
  sq = Math.sqrt(n).floor
  (2..sq).each do |prime|
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
  sum(factors(n).uniq)
end

def abundant? n
  d(n) > n
end

def is_ab_sum? n, list
  i_greater = list.index(list.detect{|a| a >= n})
  l2 = i_greater ? list[0...i_greater] : list
  l2.reverse.detect {|ab| abundant?(n - ab) }
end

abundants = (1..28123).select {|i| abundant?(i)}.freeze
puts 'abs calculated'
puts Benchmark.measure {
  puts sum((1..28123).select{|i| not is_ab_sum?(i, abundants) }).inspect
}
