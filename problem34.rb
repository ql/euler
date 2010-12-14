#!/usr/bin/ruby
require 'euler_helper.rb'

FACTORIALS = {"6"=>720, "7"=>5040, "8"=>40320, "9"=>362880, "0"=>1, "1"=>1, "2"=>2, "3"=>6, "4"=>24, "5"=>120}
F2 = [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880]

def fsum? n
  n == sum(n.to_s.split(//).map{|c| FACTORIALS[c] })
end

def fsum2? n
  r = 0
  each_digit(n) do |digit|
    r += F2[digit]
  end  
  return n == r
end

res = nil
benchmark do
  res = (1..100000).select {|n| fsum2?(n) }
end
puts res.inspect
