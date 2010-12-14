#!/usr/bin/ruby
require 'euler_helper.rb'

def digits n
  q = []
  each_digit(n) {|d| q.unshift(d) }
  q
end

def truncate arr
  arr2 = arr.clone
  res = [arr2.clone]
  while arr2.size > 1
    arr2.pop
    res.push arr2.clone
  end
  arr2 = arr.clone
  while arr2.size > 1
    arr2.shift
    res.push arr2.clone
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

def variants n
  truncate(digits(n))
end

benchmark do
  primes = primes_under(1000000).inject({}) {|acc, i| acc[i] = 1; acc}
  res = primes.keys.select {|p| variants(p).map{|a| a.join.to_i}.all? {|t| primes[t] == 1}}
  res = res.select {|n| n > 10}
  puts res.inspect
  puts sum(res)
  puts res.size
end
