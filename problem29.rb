#!/usr/bin/ruby


def brute
  seq = []
  (2..100).each do |a|
    (2..100).each do |b|
      seq.push(a ** b)
    end
  end
  seq.uniq.size
end

def smart base
  seq = []
  i = 1
  while (base ** i) <= 100
    seq = seq + (2 * i).step((100 * i), i).to_a
    i+=1
  end
  seq.uniq.size
end

puts brute
puts 99 * 85 + 4 * 50 + smart(2) + smart(3)
puts smart(10)
