#!/usr/bin/ruby
require 'euler_helper'

<<COMM
Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:
1634 = 14 + 64 + 34 + 44
8208 = 84 + 24 + 04 + 84
9474 = 94 + 44 + 74 + 44

As 1 = 14 is not a sum it is not included.

The sum of these numbers is 1634 + 8208 + 9474 = 19316.

Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.
COMM

def brute pow, range
  pows = (0..9).inject({}) {|acc, i| acc[i.to_s] = i ** pow; acc}.freeze
  (2..range).select do |n|
    n == sum(n.to_s.split(//).map {|s| pows[s]})
  end
end

benchmark do
  puts sum(brute(5, 200000))
end
