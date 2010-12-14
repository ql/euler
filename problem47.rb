#!/usr/bin/ruby
require 'euler_helper.rb'

i = 1

def test i, number
  (0...number).to_a.all?{|n| factorize(i+n).uniq.size == number}
end 

benchmark do
  until test(i,4) do
    i+=1
  end
  puts i
end
