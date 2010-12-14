#!/usr/bin/ruby
require 'euler_helper.rb'

def variants filler, count
  orig_count = count
  r = []
  count -= 1
  while count > -1
    r += ([filler] * count + ['x'] * (orig_count - count)).permutation.to_a.uniq
    count -= 1
  end
  r
end

def double_arr_replace src, dest, marker #double_arr_replace([1,2,3,3,3], [:a, :b, :c], 3) -> [1,2,:a,:b,:c]
  src.enum_with_index.each do |val, index|
    src[index] = dest.shift || val if val == marker
  end
  src
end

def masks n
  digits = n.digits
  double = digits.select {|a| digits.count(a) > 1}.uniq
  return [] if double.empty?
  
  double.map do |d|
    variants(d, digits.count(d)).map {|v| double_arr_replace(n.digits, v, d).join}.uniq
  end.flatten
end

def replacible_primes bound
  primes = primes_under(bound)
  results = {}
  primes.each do |prime|
    masks(prime).each { |mask| puts prime if mask=='x2x3x3'; results[mask] = results.key?(mask) ? results[mask]+1 : 1 }
  end
  results
end

benchmark do
  r = replacible_primes(1000000)
  max = r.values.max
  puts max
  puts r.select{|k,v| v == 8}.inspect
end
#puts masks(56663).inspect
#puts double_arr_replace([1,2,3,3,3], [:a, :a, :c], 3).inspect
