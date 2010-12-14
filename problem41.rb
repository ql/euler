#!/usr/bin/ruby
require 'euler_helper.rb'

def digits n
  q = []
  each_digit(n) {|d| q.unshift(d) }
  q
end

def primes_under x
  primes = [2]

  i = 3
  while i < x 
    sq = Math.sqrt(i).round
    primes.push(i) unless primes.detect {|divisor| (divisor <= sq) ?  (i % divisor == 0) : break}
    i += 2
  end
  primes
end

def largest_pd_prime under
  primes = nil
  benchmark do
    primes = primes_under(under)#.inject({}) {|acc, i| acc[i] = 1; acc}
  end
  benchmark do
    primes = primes[primes.index(primes.detect{|p| p > (under / 10) })..(primes.size - 1)]
  end
  benchmark do
    primes = primes.select {|p| (d = digits(p)) && d.uniq.size == d.size }
  end

  puts primes.last
end
#benchmark do
#  largest_pd_prime 1000000
 #largest_pd_prime 1000000000
#end

pr = nil
benchmark do
  candidates = (1..7).to_a.permutation(7).to_a.map{|p| p.join.to_i}
  pr = candidates.select {|n| prime?(n) }
end
puts pr.sort.last
