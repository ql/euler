#!/usr/bin/ruby
require 'euler_helper.rb'
#
<<COMM
We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39  186 = 7254, containing multiplicand, multiplier, and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.

COMM

def pandigital? a,b
  res = a*b
  return false if (res >= 10000) || (res <= 1000) || res.to_s.index('0')
  return res if "#{a}#{b}#{res}".split(//).uniq.size == 9
end

perm = (1..9).to_a.permutation(5) 
pans = {}
benchmark do
  perm.each do |digits|
    r = pandigital?(digits[0],digits[1..4].join.to_i)
    pans[r] = [digits[0],digits[1..4].join.to_i] if r

    r = pandigital?(digits[0..1].join.to_i,digits[2..4].join.to_i)
    pans[r] = [digits[0..1].join.to_i,digits[2..4].join.to_i] if r
  end 
  puts sum(pans.keys)
end
