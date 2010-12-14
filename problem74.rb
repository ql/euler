require 'euler_helper.rb'

FACTORIALS = [1, 1, 2, 6, 24, 120, 720, 5040, 40320, 362880]

$chains = {}
def fact_chain_length n
 #overput n
 chain = [n]
 c = n.digits.map{|dig| FACTORIALS[dig] }.inject(:+)
 until chain.include?(c)  do
   chain.push c
   c = c.digits.map{|dig| FACTORIALS[dig] }.inject(:+)
   #puts chain.inspect
 end
 chain.size
end
  
benchmark do
  r = (1000000.downto(1)).count {|x| fact_chain_length(x) == 60 }
  puts r
end
