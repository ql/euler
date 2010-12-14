#!/usr/bin/ruby
#puts (1..80).map {|i| 2 ** i}.map {|s| [s, s.to_s.split(//).map{|d| d.to_i}.inject(0){|a,k| a+=k}] }.map{|e| e.inspect}.join("\n")

def powers n
  (1..n).map {|i| 2 ** i}
end

def digsum n
  n.to_s.split(//).inject(0){|a,k| a+=k.to_i}
end

def draw x
  puts ((x > 0) ? '+' : '-') * x.abs
end
  
#powers(180).map{|p| digsum(p)-digsum(p/2) }.each {|x| draw(x)}
puts digsum(2 ** 1000)
