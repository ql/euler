def write number
digits= [1000 , 100 , 90 , 80 , 70 , 60 , 50 , 40 , 30 , 20 , 19 , 18 , 17 , 16 , 15 , 14 , 13 , 12 , 11 , 10 , 9 , 8 , 7 , 6 , 5 , 4 , 3 , 2 , 1]

names = {
1000 => 'thousand',
100 => 'hundred',
90 => 'ninety',
80 => 'eighty',
70 => 'seventy',
60 => 'sixty',
50 => 'fifty',
40 => 'forty',
30 => 'thirty',
20 => 'twenty',
19 => 'nineteen',
18 => 'eighteen',
17 => 'seventeen',
16 => 'sixteen',
15 => 'fifteen',
14 => 'fourteen',
13 => 'thirteen',
12 => 'twelve',
11 => 'eleven',
10 => 'ten',
9 => 'nine',
8 => 'eight',
7 => 'seven',
6 => 'six',
5 => 'five',
4 => 'four',
3 => 'three',
2 => 'two',
1 => 'one'
}

  word = ''
  digits.each do |digit|
    rem = number / digit
    number -= digit * rem 
    if rem > 0
      if digit == 100 && number > 0
        word += "#{names[rem]} #{names[digit]} and "
      elsif (digit == 100 || digits == 1000) && number == 0
        word += "#{names[rem]} #{names[digit]}"
      elsif digit < 100 && digit >= 20
          word += "#{names[digit]}-"
      else
          word += "#{names[digit]}"
      end
    end
  end
  word
end

def trimsize str
  str.gsub(/[ -]/, '').size
end

puts trimsize((1..1000).inject('') {|acc, i| acc+=write(i) }) + 3 # 3 is for "one" thousand
puts trimsize(write(342))
puts trimsize(write(115))
#(1..210).each {|i| puts write(i) }
