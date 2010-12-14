require 'euler_helper.rb'
require 'timeout'
NAME ="		Investigate the Diophantine equation x2 − Dy2 = 1."
DESCRIPTION =" What is most surprising is that the important mathematical constant,
Hence, by considering minimal solutions in x for D  7, the largest x is obtained when D=5.

Find the value of D  1000 in minimal solutions of x for which the largest value of x is obtained.  "

def dio_minx d
  return -1 if int?(Math.sqrt(d))
  i = 2
  i2 = i ** 2
  until int?(Math.sqrt(1+d*(i2))) do
    i2 = (i += 1) ** 2
  end
  return i, Math.sqrt(1+d*(i ** 2)), d

end
 #, , , , 61, 109, 149,  151, 157, 181, 193, 199, 211, 214, 233, 241, 244, 253, 261, 262, 268, 271, 277, 281, 283, 298, 301, 307, 309, 313, 317, 331, 334

cands = [61, 109,  149, 151, 157, 181, 193, 199, 211, 214, 233, 241, 244, 253, 261, 262, 268, 271, 277, 281, 283, 298, 301, 307, 309, 313, 317, 331, 334, 337, 343, 349, 353, 358, 367, 379, 382, 394, 397, 409, 412, 419, 421, 431, 433, 436, 446, 449, 454, 457, 461, 463, 466, 477, 478, 481, 487, 489, 491, 493, 501, 502, 508, 509, 511, 517, 521, 523, 524, 526, 537, 538, 541, 547, 549, 553, 554, 556, 559, 562, 565, 569, 571, 581, 586, 589, 593, 596, 597, 599, 601, 604, 607, 610, 613, 614, 617, 619, 622, 628, 631, 633, 634, 637, 641, 643, 649, 652, 653, 655, 661, 662, 664, 669, 673, 679, 681, 683, 685, 686, 691, 694, 701, 709, 716, 718, 719, 721, 724, 733, 737, 739, 742, 746, 749, 751, 753, 754, 757, 758, 763, 764, 766, 769, 771, 772, 773, 778, 787, 789, 790, 794, 796, 797, 801, 802, 805, 809, 811, 814, 821, 823, 826, 829, 834, 835, 838, 844, 845, 849, 853, 856, 857, 859, 861, 862, 863, 865, 869, 871, 877, 881, 883, 886, 889, 893, 907, 911, 913, 917, 919, 921, 922, 926, 928, 929, 931, 932, 937, 941, 946, 947, 949, 951, 953, 955, 956, 964, 965, 967, 970, 971, 972, 974, 976, 977, 981, 988, 989, 991, 997, 998]
cands = [331, 617, 778]

benchmark do
  out = []
  res = {}
  (2..1000).each do |d|
    begin
      Timeout::timeout(600) { y, res[d]=dio_minx(d); puts "#{d}: #{res[d]}" }
    rescue Timeout::Error => e
      puts "x for #{d} out of time"
      out.push(d)
    end
  end
  puts out.inspect
  puts res.values.max
  puts res.select{|k,v| v == res.values.max}.inspect
end
