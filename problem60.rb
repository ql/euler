#!/usr/bin/ruby
require 'euler_helper.rb'

<<COMM
The primes 3, 7, 109, and 673, are quite remarkable. By taking any two primes and concatenating them in any order the result will always be prime. For example, taking 7 and 109, both 7109 and 1097 are prime. The sum of these four primes, 792, represents the lowest sum for a set of four primes with this property.

Find the lowest sum for a set of five primes for which any two primes concatenate to produce another prime.
COMM

PRIMES = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199]


def prime? n
  return false if PRIMES.any? {|p| n % p == 0 && n!=p}
  sq = Math.sqrt(n).ceil
  i = 211
  while i <= sq 
    return false if n % i == 0
    i += 2
  end
  true
end

def maxdepth hash, dep = 0
  hash.map do |k,v|
    if v.is_a?(Hash)
      maxdepth(v, dep+1)
    else
      dep+1
    end
  end.max
end

def mut_prime? x, y
  prime?("#{x}#{y}".to_i) && prime?("#{y}#{x}".to_i) 
end

def filter_mprimes list
  return list if list.size < 2
  r = {}
  list.each do |p|
    r[p] = list.select {|prime| mut_prime?(p, prime) }
    r[p] = filter_mprimes(r[p])
  end
  r.delete_if{|k,v| v.empty? }
end

def flattenh hash, p = []
  hash.inject([]) do |acc, pair|
    k, v = pair
    acc+=if v.is_a?(Array)
      [p + [k] + v]
    elsif v.is_a?(Hash)
      flattenh(v, p+[k])
    else
      raise v.inspect
    end
  end
end
#
res = filter_mprimes(primes_under(10000))

puts flattenh(res).select{|a| a.size > 4}.map(&:sort).uniq.map{|a| a.inject(:+)}.min
