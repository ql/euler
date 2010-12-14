#!/usr/bin/ruby
require 'euler_helper'

def primes_under_detect x
  primes = [2]

  i = 3
  while i < x 
    sq = Math.sqrt(i).round
    primes.push(i) unless primes.detect {|divisor| (divisor <= sq) ?  (i % divisor == 0) : break}
    i += 2
  end
  primes
end

@primes = primes_under_detect 100000
puts 'primes ready'

def prime? n
  @primes.include?(n)
end

def prime2 n
  return false if n % 2 == 0
  sq = Math.sqrt(n).ceil
  i = 3
  while i <= sq 
    return false if n % i == 0
    i += 2
  end
  true
end

def quadratic a,b
  lambda {|x| x ** 2 + a * x + b }
end

def test a,b
  i = 0
  form = quadratic(a,b) 
  while prime2(form.call(i).abs)
    i += 1
  end
  i
end

res = {}
puts Benchmark.measure {
  (-1000..1000).each do |a|
    (-1000..1000).each do |b|
      t = test(a,b)
      res[t] = [a,b] if t > 0
    end
  end
}
puts res[res.keys.max].inspect
puts res.keys.max
