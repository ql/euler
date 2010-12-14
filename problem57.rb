#!/usr/bin/ruby
require 'euler_helper.rb'

def square_root_iter limit
  num, denom = 1,1
  counter,i  = 0, 0
  while i < limit
    num, denom = 2*denom+num, denom+num
    counter += 1 if num.to_s.size > denom.to_s.size
    i+=1
  end
  counter
end

benchmark do
  puts square_root_iter(1000)
end
