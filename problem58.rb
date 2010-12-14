#!/usr/bin/ruby
require 'euler_helper.rb'

<<COMM
Starting with 1 and spiralling anticlockwise in the following way, a square spiral with side length 7 is formed.

37 36 35 34 33 32 31
38 17 16 15 14 13 30
39 18  5  4  3 12 29
40 19  6  1  2 11 28
41 20  7  8  9 10 27
42 21 22 23 24 25 26
43 44 45 46 47 48 49

It is interesting to note that the odd squares lie along the bottom right diagonal, but what is more interesting is that 8 out of the 13 numbers lying along both diagonals are prime; that is, a ratio of 8/13  62%.

If one complete new layer is wrapped around the spiral above, a square spiral with side length 9 will be formed. If this process is continued, what is the side length of the square spiral for which the ratio of primes along both diagonals first falls below 10%?
COMM
$results = {}
def diagonals n
  rows, i, c, c2, k, num = nil, nil, nil, nil, nil, nil 
  if precalc = $results.keys.select {|k| k < n}.max
    rows = precalc
    num, i, c, c2 = $results[precalc]
  else
    rows = 3
    i = 2
    c, c2, k = 0, 0, 0
    num = 1
  end
  while rows <= n
    c += 4
    c2 += 1 if prime?(num += i)
    c2 += 1 if prime?(num += i)
    c2 += 1 if prime?(num += i)
    num += i
    #num += i
    i+=2 
    rows+=2 
    $results[rows] = [num, i, c, c2] if rows % 1000 < 4
  end
  (c2 / c.to_f) * 100
end

def percentage n 
  diags = diagonals(n)
  diags.count {|n| prime? n } / (diags.size).to_f * 100
end

#puts diagonals(26242)
#puts diagonals(26241)
#puts diagonals(26240)
#puts diagonals(26243)
min = 1
max = 40000
n = max-1
benchmark do
  while (min - max).abs > 1
    if diagonals(n) > 10
      n, min = (n+max)/2, n
    elsif diagonals(n) < 10
      n, max = (min+n)/2, n
    else 
      break
    end 
  end 
  puts n-1
end
