#!/usr/bin/ruby
require 'euler_helper.rb'

def try d, len
  i = 2
  d2 = d[0...len] 
  d  = d[len...d.size] 
  until d.empty?
    d2sum = digits(d2.join.to_i * i)
    len = d2sum.size
    if d[0...len] == d2sum
      d = d[len...d.size] 
      i += 1
    else
      return false
    end
  end
  true 
end

def concatenated_product? d
  #d = digits(n)
  return (1..(d.size/2)).detect {|l| try d.clone, l }
end

res = nil
benchmark do
  res = (1..9).to_a.reverse.permutation.detect {|d| concatenated_product?(d) }
end
puts res.join
#puts res.map{|a| a.join}.inspect
#puts concatenated_product?(digits(918273645))
