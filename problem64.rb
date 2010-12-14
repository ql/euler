require 'euler_helper.rb'
require 'mathn'
NAME ="How many continued fractions for N ≤ 10000 have an odd period?"
DESCRIPTION ="All square roots are periodic when written as continued fractions and can be written in the form:"

def sqroot x
  y = 1.0
  11.times {y = (y + x/y) / 2}
  y
end

def period x
  sq = sqroot x
  return 0 if int?(sq)

  ints = []
  coef = 1
  int = sq.to_i
  denom = x - int ** 2
  add = int

  until ints.include?([coef, add, denom]) do
    ints.push [coef, add, denom]
    #puts [coef, add, denom].inspect

    int = ((sq*coef +add) / denom.to_f).to_i
    #puts int
    add = add - int*denom
    #puts [coef, add, denom].inspect

    coef, denom = denom,  x - add ** 2
    coef, denom = coef / coef.gcd(denom), denom / coef.gcd(denom)
    add = -add
    #puts [coef, add, denom].inspect
    #puts
  end
  ints.size
end

benchmark do
  puts (2..10000).count {|n| period(n) % 2 == 1 }
end
