#!/usr/bin/ruby
require 'euler_helper.rb'

DIVISORS = [2, 3,5,7,11,13,17]
def substring_divisible? d
  DIVISORS.enum_with_index.all? {|div,i| d[(i+1)...(i+4)].join.to_i % div == 0}
end
puts substring_divisible?(digits(1406357289))
benchmark do
puts (0..9).to_a.permutation.select{|p| substring_divisible?(p)}.map{|a| a.join.to_i}.inject(:+)
end
