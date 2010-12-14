#!/usr/bin/ruby
def collatz n
  i = 1
  while (n > 1) do
    if ((n % 2) == 0)
      n = n >> 1
    else
      n = 3*n + 1 
    end
    i += 1
  end
  i
end


cs = (1..1000000).inject({}) {|acc, i| acc[collatz(i)] = i; acc}
puts [cs.keys.max, cs[cs.keys.max]].inspect

