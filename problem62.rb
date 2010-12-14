
#!/usr/bin/ruby
require 'euler_helper.rb'

<<COMM
The cube, 41063625 (3453), can be permuted to produce two other cubes: 56623104 (3843) and 66430125 (4053). In fact, 41063625 is the smallest cube which has exactly three permutations of its digits which are also cube.

Find the smallest cube for which exactly five permutations of its digits are cube.
COMM

SQUARES = [0,1,4,9,16,25,36,49,64,81]
def csum n
  n.digits.inject(:+)
end

def cmul n
  n.digits.select{|d| d>0}.inject(:*)
end

def csq n
  n.digits.map{|d| SQUARES[d]}.inject(:+)
end

def mutations n
  n.digits.permutation.to_a.map! {|x| x.join.to_i}.uniq!
end

def permut? n
  cubes = nil
  benchmark("cubes...") do
    cubes = (340...10000).map{|i| i ** 3}
  end
  cubes_s = cubes.inject({}) {|acc,i| acc[csum(i)] ? acc[csum(i)].push(i) : acc[csum(i)]=[i] ; acc}
  cubes_m = cubes.inject({}) {|acc,i| acc[cmul(i)] ? acc[cmul(i)].push(i) : acc[cmul(i)]=[i] ; acc}
  cubes_q = cubes.inject({}) {|acc,i| acc[csq(i)] ? acc[csq(i)].push(i) : acc[csq(i)]=[i] ; acc}
  until cubes.empty?
      c = cubes.shift 
    #benchmark(c) do
      candidates = cubes_s[csum(c)]
      next if candidates.size < n
      candidates &= cubes_m[cmul(c)]
      next if candidates.size < n
      candidates &= cubes_q[csq(c)]
      next if candidates.size < n

      unless candidates.size < n
        digs = c.digits.sort
        return c if candidates.map(&:digits).map(&:sort).count {|cand| cand == digs } == n
      end
    #end
  end
end


benchmark do
  puts permut?(5).inspect
end
