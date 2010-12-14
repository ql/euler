#!/usr/bin/ruby
require 'euler_helper.rb'

def solve
  res = 1
  coeficients = [1, 10, 100, 1000, 10000, 100000, 1000000]
  i = 1
  start = 1
  c = coeficients.first
  while start < 1000000
    n = count_digits(start)
    if c >= i && c < i+n
      #puts "found! i,c,n #{i} #{c} #{n} = #{digits(start)[c-i]}"
      res *= digits(start)[c-i]
      coeficients.shift
      break if coeficients.empty?
      c = coeficients.first
    end
    i += n
    start += 1
  end
  res
end

benchmark do
  puts solve
end
