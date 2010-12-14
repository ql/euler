#!/usr/bin/ruby
require 'benchmark'
F = 1 / ((Math.sqrt(5)-1) / 2)
SQ = Math.sqrt(5)

fibs = {}
def fib n
  i = 2
  a1 = 1
  a2 = 1
  while i < n
    b1,b2 = a1,a2
    a2 = a2 + a1 
    a1 = b2
    i+=1
  end
  a2
  #((F ** n) / SQ).round
end

def first x
  en = x * 10
  st = 1
  curr = 1
  raise 'error' unless sz(fib(en)) > x
  while en -st > 1
    if sz(fib(curr)) < x
      st = curr
      curr = ((en + curr) / 2).round
    else
      en = curr
      curr = ((st + curr) / 2).round
    end
    puts "st = #{st}, en = #{en}"
  end
  st 
end

def digsum n
  n.to_s.split(//).inject(0) {|acc, s| acc+=s.to_i}
end

def sz n
  n.to_s.size
end

def ff2
  x, y, n = 1, 1, 1
  while true
    x, y, n = y, x + y, n+1
    if x.to_s.length == 1_000 then
      puts n
      break
    end
  end
end


puts Benchmark.measure {res = first 1000}
puts Benchmark.measure {res = ff2}
#puts sz(fib(res))
#puts sz(fib(res-1))
#puts sz(fib(res+1))
