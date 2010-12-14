#!/usr/bin/ruby
require 'euler_helper.rb'

i = 1

POWERS = [1, 10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000, 1000000000, 10000000000]
def orders n, count
  i,result = 0, 0
  while i < count && n >= 1
    result += (10 ** i) * (n % 10)
    n /= 10
    i += 1
  end
  result
end

def summarize bound
  r = 0
  (1..9).each{|a| r += a ** a} 
  (10..bound).each do |a|
    a = (a ** a) % POWERS.last
    POWERS.each do |pow|
      r += pow * (a % 10)
      a /= 10
    end
  end
   r = orders(r,10)
end 

benchmark do
  puts summarize(1000)
  #res = digits(res)
  #puts res[(res.size-10)...res.size].join
end
