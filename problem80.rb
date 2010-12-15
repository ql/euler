require 'euler_helper.rb'
require 'mathn'
NAME ="Calculating the digital sum of the decimal digits of irrational square roots."
DESCRIPTION =" It is well known that if the square root of a natural number is not an integer, then it is irrational. The decimal expansion of such square roots is infinite without any repeating pattern at all.

The square root of two is 1.41421356237309504880..., and the digital sum of the first one hundred decimal digits is 475.

For the first one hundred natural numbers, find the total of the digital sums of the first one hundred decimal digits for all the irrational square roots."

def to_frac arr, quant = 1
  int = arr.shift
  arr.reverse!
  int + quant/arr.inject(arr.first) {|acc, i| acc = i + 1/acc }
end

def period x
  sq = Math.sqrt x
  return 0 if int?(sq)

  ints = [sq.to_i]
  coef = 1
  int = sq.to_i
  denom = x - int ** 2
  add = int

  until ints.size > 200 do
    #puts [coef, add, denom].inspect

    int = ((sq*coef +add) / denom.to_f).to_i
    ints.push int
    #puts int
    add = add - int*denom
    #puts [coef, add, denom].inspect

    coef, denom = denom,  x - add ** 2
    coef, denom = coef / coef.gcd(denom), denom / coef.gcd(denom)
    add = -add
    #puts
  end
  ints
end

def precise_root x, precision
  to_frac(period(x),10**(precision-1)).to_i
end

def root_digits x, precision
  r = precise_root(x, precision)
  r = r.to_s.split(//).map(&:to_i)
  (precision - r.size() - 1).times {r.unshift(0)}
  r
end

def solve
  (1..100).inject(0) do |sum, y|
    sum = if int?(Math.sqrt(y))
      #puts "skipping #{i}"
      sum
    else
      r = root_digits(y, 120)
      sum + r[0...99].inject(:+) + Math.sqrt(y).to_i
    end
  end
end

benchmark do
  puts solve
end
