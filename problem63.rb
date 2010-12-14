#!/usr/bin/ruby
require 'euler_helper.rb'

<<COMM
The 5-digit number, 16807=75, is also a fifth power. Similarly, the 9-digit number, 134217728=89, is a ninth power.

How many n-digit positive integers exist which are also an nth power?
COMM
rr = 0
for i in 1..23
  r = []
  for j in 1..15
    r.push(j) if (j ** i).to_s.size == i
  end
  puts r.inspect
  rr += r.size
end
puts rr
