require 'euler_helper.rb'
require "mathn"
NAME ="	Listing reduced proper fractions in ascending order of size."
DESCRIPTION =" Consider the fraction, n/d, where n and d are positive integers. If nd and HCF(n,d)=1, it is called a reduced proper fraction.

If we list the set of reduced proper fractions for d  8 in ascending order of size, we get:

1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8

It can be seen that 2/5 is the fraction immediately to the left of 3/7.

By listing the set of reduced proper fractions for d  1,000,000 in ascending order of size, find the numerator of the fraction immediately to the left of 3/7."


def max_denom target, bound
  bound.downto(1).select {|n| n % target.denominator == 0 }[1]
end

def leftmost_fraction target, bound
  start_d = max_denom target, bound
  start_n = start_d * target - 2
  (start_d..bound).map do |denom| 
    (start_n..start_n+10).select {|x| x/denom < target}.compact.max / denom
  end.max
end

def full_check target, bound
  (2..bound).map do |d|
    (1...d).select {|n| n/d < target}.compact.max / d rescue 0
  end.compact.max
end

puts leftmost_fraction( 7/9, 1000).inspect
puts full_check( 7/9, 1000).inspect
