#!/usr/bin/ruby
require 'euler_helper.rb'

def digits n
  q = []
  each_digit(n) {|d| q.unshift(d) }
  q
end

def circular arr
  arr2 = arr.clone
  res = []
  res.push arr2.push(arr2.shift).clone
  while arr2 != arr
    res.push arr2.push(arr2.shift).clone
  end
  res
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

benchmark do
  primes = primes_under(1000000).inject({}) {|acc, i| acc[i] = 1; acc}
  puts primes.keys.select {|p| circular(digits(p)).map{|a| a.join.to_i}.all? {|t| primes[t] == 1}}.size
end

