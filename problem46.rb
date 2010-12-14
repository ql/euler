#!/usr/bin/ruby
require 'euler_helper.rb'

primes = primes_under 10000

def goldbach? n, primes
  primes.select{|p| p < n}.any? {|p| int?(Math.sqrt((n-p)/2))}
end

i = 7
while (primes.include?(i))|| goldbach?(i, primes)
  i+=2
end
puts i
