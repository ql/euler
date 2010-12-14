require 'euler_helper.rb'
require 'mathn'
NAME ="Triangles"
DESCRIPTION =" 120 cm: (30,40,50), (20,48,52), (24,45,51)

Given that L is the length of the wire, for how many values of L  1,500,000 can exactly one integer sided right angle triangle be formed?"

def slowphi(n)
  list = factorize(n).uniq.sort
  candidates = (1...n).to_a
  list.each {|k| (1..(n/k).ceil).each {|i| candidates[i*k-1] = nil }}
  candidates.compact!
end

def triangles p
  (1..p).map do |a|
    b = p - p**2/(2.0*(p-a))
    if b > 0 && int?(b) && int?(Math.sqrt(a**2 + b**2))
      [a,b, p-a-b].map(&:to_i)
    end
  end.compact.map(&:sort).uniq
end

def pyth_triplet m,n
  [m**2 - n**2, 2*m*n, m**2 + n**2]
end

def pyth_max_m bound
  Math.sqrt(1+2*bound).ceil / 2
end

def count_triplets bound
  res = {}
  used_triplets = {}
  (2..pyth_max_m(bound)).each do |m|
    (1...m).each do |n|
      next unless m.gcd(n) == 1
      triplet = pyth_triplet(m, n)
      gcd = triplet.inject(:gcd)
      triplet.map! {|t| t/gcd}.sort!
      next if used_triplets.key?(triplet)
      sum = triplet.inject(:+)
      (1..(bound/sum).floor).each do |k|
         res[k*sum] = res[k*sum]+1 rescue 1 if k*sum < bound
      end
      used_triplets[triplet] = 1
    end
  end
  res
end

def count_exactly_one bound
  count_triplets(bound).count {|k,v| v == 1}
end


max = 1_500_000

#benchmark do
#  puts (12..max).inject({}) {|acc, n| sz = triangles(n).size; acc[n] = sz if sz > 0; acc }.count{|k,v| v ==1}
#end
benchmark do
  puts count_exactly_one(max)
end
