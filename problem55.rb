#!/usr/bin/ruby
require 'euler_helper.rb'

LIMIT = 50

def palindrome? number
  arr = number.digits
  if arr.size % 2 == 0
    arr[0...(arr.size/2)] == arr[(arr.size/2)...arr.size].reverse
  else
    arr[0...(arr.size/2)] == arr[(arr.size/2 + 1)...arr.size].reverse
  end
end

def lychrel? n
  i = 1
  n += n.digits.reverse.join.to_i
  until palindrome?(n) || i > LIMIT
    n += n.digits.reverse.join.to_i
    i += 1
  end
  
  return i > LIMIT 
end

puts (1..10000).select{|s| lychrel?(s) }.size
