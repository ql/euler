require 'benchmark'

def f n
  r = 1
  i = n
  while i > 1
    r *= i
    i -= 1
  end
  r
end

def sum list
  list.inject(0) {|acc, i| acc += i}
end

def mul list
  list.inject(1) {|acc, i| acc *= i}
end

def prime? n
  return false if n % 2 == 0 && n != 2
  sq = Math.sqrt(n).ceil
  i = 3
  while i <= sq 
    return false if n % i == 0
    i += 2
  end
  true
end

def profile
  require 'rubygems'
  require 'ruby-prof'
  RubyProf.start
  yield
  result = RubyProf.stop

  # Print a flat profile to text
  printer = RubyProf::FlatPrinter.new(result)
  printer.print(STDOUT, 0)
end

def benchmark message=''
  puts "#{message} "+ Benchmark.measure(message) { yield }.to_s
end

def factors_all(n)
  x = n
  factors = []
  sq = Math.sqrt(n).floor
  (2..sq).each do |prime|
     #next if n % prime != 0
     #break if prime > sq
     if (n % prime == 0)
       factors.push(prime)
     end
  end
  factors + factors.map {|f| x / f} + [1,n]
end

def factors(n)
  x = n
  factors = []
  sq = Math.sqrt(n).floor
  (2..sq).each do |prime|
     #next if n % prime != 0
     #break if prime > sq
     if (n % prime == 0)
       factors.push(prime)
     end
  end
  factors
end

def factorize(n)
  return [n] if n < 4
  x = n
  factors = []
  sq = Math.sqrt(n).floor
  primes_under(sq).each do |prime|
     next if n % prime != 0 || n ==1
     #break if prime > sq
      
     while (n % prime == 0)
       factors.push(prime)
       n /= prime
     end
  end
  factors.push(n) unless n == 1
  factors
end

def each_digit n, base = 10
  while n >= 1
    yield(n % base)
    n /= base
  end  
end

def digits n
  q = []
  each_digit(n) {|d| q.unshift(d) }
  q
end

def count_digits n, base=10
  i=0
  while n >= 1
    n /= base
    i+=1
  end
  i
end

def int? i
 i.to_i == i
end

def primes_under n #euler sieve
  candidates = (1..n).to_a
  fin = (n**0.5).ceil

  # Loop over the candidates, marking out each multiple.
  # If the current candidate is already checked off then
  # continue to the next iteration.
  for i in 2..fin do
    next if candidates[i-1].nil?
    for j in i..candidates.size/i+1 do
      candidates[j*i-1] = nil
    end
  end
  candidates.shift
  candidates.compact!
end

class Integer
  def each_digit base = 10
    n = self
    while n >= 1
      yield(n % base)
      n /= base
    end  
  end

  def digits
    q = []
    each_digit {|d| q.unshift(d) }
    q
  end
end

class Array
  def except *x
    self - x.to_a.flatten
  end

  def sum
    self.inject(:+)
  end
end

def overput str
  STDOUT.write("\r#{str}")
  STDOUT.flush
end
