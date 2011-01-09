require 'euler_helper.rb'

ROMAN = {
  1 => 'I',
  5 => 'V',
  10 => 'X',
  50 => 'L',
  100 => 'C',
  500 => 'D',
  1000 => 'M',
  4 => 'IV',
  9 => 'IX',
  40 => 'XL',
  90 => 'XC',
  400 => 'CD',
  900 => 'CM'
}

def romanize n
  keys = ROMAN.keys.sort
  r = ''
  while n > 0
    if n >= keys.last
      r += ROMAN[keys.last]
      n -= keys.last
    else
      keys.pop
    end
  end
  r
end

def parse_roman roman
  inv_roman = ROMAN.invert
  r = 0
  while roman.size > 0
    if inv_roman.key?(roman[0..1])
      r += inv_roman[roman[0..1]]
      if roman.size > 2
        roman = roman[2..-1] 
      else
        roman = ''
      end
    else
      r += inv_roman[roman[0..0]]
      if roman.size > 1
        roman = roman[1..-1]
      else
        roman = ''
      end
    end
  end
  r
end

def compact roman
  romanize(parse_roman(roman))
end

def solve
  numbers = File.read('roman.txt').split(/\n/).map!(&:strip)
  numbers.inject(0) {|memo, n| memo += (n.size - compact(n).size)}
end

benchmark do
  puts solve.inspect
end
