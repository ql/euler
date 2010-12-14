#!/usr/bin/ruby
require 'euler_helper.rb'

<<COMM
It can be seen that the number, 125874, and its double, 251748, contain exactly the same digits, but in a different order.

Find the smallest positive integer, x, such that 2x, 3x, 4x, 5x, and 6x, contain the same digits.
COMM

def solve
  (1...1000000).detect do |n|
    [1,2,3,4,5].map{|mul| mul * n}.map(&:digits).map(&:sort).inject {|acc, i| (acc == i) ? acc : false }
  end
end

benchmark do
  puts solve.inspect
end
