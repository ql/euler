require './euler_helper.rb'


@sqsum = {}
def sqsum n
  @sqsum[n] ||= begin
    digits(n).map{|d| d*d }.sum
  end
end

def add_cont n
  until n == 1 || n == 89
    n = sqsum n
  end
  n == 89
end

def solve n
  (1..n).count {|x| add_cont(x) }
end

benchmark do
  puts solve(10_000_000)
end
