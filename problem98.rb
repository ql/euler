require 'set'

def uniq_letters w
  w.split(//).uniq
end

def wordkey w
  [w.size, uniq_letters(w).size]
end

def square? x
#  sq = Math.sqrt(x) 
#  sq == sq.truncate
  x.include?(x.to_i)
  #square_numbers.include?(x.to_i)
end

def square_anagram(*ws)
  puts "checking #{ws.inspect}"
  w1 = ws.shift
  wk = wordkey(w1.to_s)
  sq1 =  square_numbers[wk].detect do |s|
    ws.all? do |w|
      tran = w.tr(w1, s.to_s).to_i
      square_numbers[wk].include?(tran)
    end
  end
  if sq1
    r = [sq1] + ws.map {|w| w.tr(w1, sq1.to_s).to_i }
    puts "Gotcha! #{r.inspect}"
    r
  end
end

def square_numbers
  @square_numbers ||= begin
  puts 'initializing squares'
  ($min_square..$max_square).inject({}) do |h, x|
    s = x ** 2
    h[wordkey(s.to_s)] ||= Set.new
    h[wordkey(s.to_s)] << s
    h
  end
  end
#  ($min_square..$max_square).inject(Set.new) { |s, x| s << x ** 2 }
#  end
end

words = File.open('./words.txt').read
words = words.gsub('"','').split(',')

anagrams = words.inject({}) do |h, w|
  key = w.split(//).sort.join
  h[key] ||= []
  h[key] << w
  h
end.select do |k,v|
  v.size > 1
end

params = anagrams.keys.map {|w| wordkey(w) }
puts params.uniq.inspect

max_len = anagrams.keys.map(&:size).max
min_len = anagrams.keys.map(&:size).min
puts max_len
puts min_len

$max_square = Math.sqrt(('9' * max_len).to_i).to_i
$min_square = Math.sqrt(('1' + ('0' * (min_len-1))).to_i).to_i

puts anagrams.values.map {|v| square_anagram(*v) }.compact.flatten.max
