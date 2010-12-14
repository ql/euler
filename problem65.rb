require 'euler_helper.rb'
NAME ="	Find the sum of digits in the numerator of the 100th convergent of the continued fraction for e."
DESCRIPTION =" What is most surprising is that the important mathematical constant,
e = [2; 1,2,1, 1,4,1, 1,6,1 , ... , 1,2k,1, ...].

The first ten terms in the sequence of convergents for e are:
2, 3, 8/3, 11/4, 19/7, 87/32, 106/39, 193/71, 1264/465, 1457/536, ...

The sum of digits in the numerator of the 10th convergent is 1+4+5+7=17.

Find the sum of digits in the numerator of the 100th convergent of the continued fraction for e."

def e_conv n
  def k(x)
    return 2 if x == 1
    (x % 3 == 0) ? x * 2 / 3 : 1
  end
  num, denom = 1, k(n)
  while n > 0
    num, denom = denom, num + denom*k(n-=1)
  end
  return num, denom
end

n,d= e_conv(100)
puts n.digits.inject(:+)
