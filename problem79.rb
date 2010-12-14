require 'euler_helper.rb'
NAME ="By analysing a user's login attempts, can you determine the secret numeric passcode?"
DESCRIPTION =" A common security method used for online banking is to ask the user for three random characters from a passcode. For example, if the passcode was 531278, they may ask for the 2nd, 3rd, and 5th characters; the expected reply would be: 317.

The text file, keylog.txt, contains fifty successful login attempts.

Given that the three characters are always asked for in order, analyse the file so as to determine the shortest possible secret passcode of unknown length."

keylog = %w{319 680 180 690 129 620 762 689 762 318 368 710 720 710 629 168 160 689 716 731 736 729 316 729 729 710 769 290 719 680 318 389 162 289 162 718 729 319 790 680 890 362 319 760 316 729 380 319 728 716}.map!(&:to_i)

def variants triplet
  t = triplet.digits
  [[t[0], t[1]], [t[0], t[2]], [t[1],t[2]]] 
end

def solve keylog
  cartesian_order = keylog.inject([]) {|acc, arr| acc += variants(arr) }
  result = []
  last = (cartesian_order.map(&:last).uniq - cartesian_order.map(&:first).uniq)[0]
  until cartesian_order.empty?
    digit = (cartesian_order.map(&:first).uniq - cartesian_order.map(&:last).uniq)[0]
    cartesian_order.delete_if {|pair| pair.first == digit }
    result.push digit
  end
  result + [last]
end

puts solve(keylog).join
