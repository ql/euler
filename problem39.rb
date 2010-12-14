#!/usr/bin/ruby
require 'euler_helper.rb'

def solution? a, perimeter
  p2 = perimeter - a
  b = p2 / 2.0 - (a ** 2) / (2.0 * p2)
  return nil if b <= 0
  if b.to_i == b
    #puts "a = #{a}, b = #{b}, c =#{p2 - b}, #{a**2}+#{b**2}= #{a**2+b**2}==#{(p2-b)**2}, #{a+b+(p2 -b)}=#{perimeter}"
    [a, b.to_i]
  else
    nil
  end
end

def count_solutions perimeter
  (1..(perimeter/3)).to_a.map{|a| solution?(a, perimeter) }.compact.map{|pair| pair.sort}.uniq.size
end

benchmark do
  puts (1..1000).detect {|p| count_solutions(p) == 8}
end
