require 'euler_helper.rb'
NAME ="Relatively prime"
DESCRIPTION ="Euler's Totient function, φ(n) [sometimes called the phi function], is used to determine the number of numbers less than n which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine, φ(9)=6."

def fastphi(n)
  list = factorize(n)
  return list.first - 1 if list.size == 1
  list.uniq!
  list.inject(n) do |acc, i|
    acc *= (i - 1)
    acc /= i
  end
end

res = nil
benchmark do
  res =(2..1000000).inject({}) do |acc, i|
    overput(i)
    acc[i] = i.to_f / fastphi(i)
    acc
  end
end
benchmark do
  max = res.values.max
  puts res.select{|k,v| v == max}.inspect
end
