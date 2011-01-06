require 'euler_helper.rb'

DESCRIPTION= <<DESC
You are given the following information, but you may prefer to do some research for yourself.
1 Jan 1900 was a Monday.
Thirty days has September,
April, June and November.
All the rest have thirty-one,
Saving February alone,
Which has twenty-eight, rain or shine.
And on leap years, twenty-nine.
A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.

How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?
DESC

def leap? year
  return true if year % 4 == 0 && year % 100 != 0
  return true if year % 4 == 0 && year % 100 == 0 && year % 400 == 0
  return false
end

def solve
  months = [nil, 31,28,31,30, 31,30,31,31,30,31,30,31]
  count = 0
  day, month, year = 1,1,1900
  dayofweek = 1

  while year < 2001
    day += 1
    dayofweek += 1
    dayofweek = 1 if dayofweek > 7

    if day > ((month == 2 && leap?(year)) ? 29 : months[month])
      day = 1
      month += 1
      if month > 12
        year += 1
        month = 1
      end
    end
    if year > 1900 && dayofweek == 7 && day == 1
      count += 1
    end
  end 
  return count
end

benchmark do
  puts solve
end
