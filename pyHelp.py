#!/usr/bin/python

"""pyHelp.py: These are my solutions to Python practice problems. 
There are a couple sources. Some came from an interview, but the bulk
are adapted from Nick Parlante, https://cs.stanford.edu/people/nick/,
2017 CodingBat, http://codingbat.com/python
"""

__author__ = "Jeffrey C. Long"
__copyright__ = "Copyright 2018"
__credits__ = ["Nick Parlante 2017"]
__license__ = "GPL"
__version__ = "1.0.1"
__maintainer__ = "Jeffrey C. Long"
__email__ = "jeffrey.c.long@gmail.com"
__status__ = "Development"



############################################################
# Write a function that returns the elements on odd 
# positions (0 based) in a list
############################################################

def solution(input):
    output = []
    for i, val in enumerate(input):
        if i % 2 == 1:
            output.append(val)
    return output

assert solution([0,1,2,3,4,5]) == [1,3,5]


############################################################
# Write a function that returns the cumulative sum of 
# elements in a list
############################################################

def solution(input):
    output = []
    cumulativeSum = 0
    for i, val in enumerate(input):
        cumulativeSum = cumulativeSum + input[i]
        output.append(cumulativeSum)
    return output

assert solution([1,1,1]) == [1,2,3]
assert solution([1,-1,3]) == [1,0,3]


############################################################
# Write a function that takes a number and returns a list 
# of its digits
############################################################

def solution(input):
    output = []
    output = [int(x) for x in str(input)]
    return output

assert solution(123) == [1,2,3]
assert solution(400) == [4,0,0]


############################################################
## Centered Average
############################################################

def solution(j):
    k = []
    l = []
    n = 0
    cumulativeSum = 0
    centeredAverage = 0
    j.sort()
    k = j[:-1] 
    l = k[1:]
    n = len(l)
    # Median:
    # return l[n/2] if n%2==0 else (l[n/2-1]+l[n/2])/2
    # Centered Average:
    for i, val in enumerate(l):
        cumulativeSum = cumulativeSum + l[i]
    centeredAverage = int(cumulativeSum/n)
    return centeredAverage

assert solution([1, 2, 3, 4, 100]) == 3
assert solution([1, 1, 5, 5, 10, 8, 7]) == 5
assert solution([-10, -4, -2, -4, -2, 0]) == -3



############################################################
### CodingBat Python Practice  #############################
############################################################


############################################################
# The parameter weekday is True if it is a weekday, and the 
# parameter vacation is True if we are on vacation. We 
# sleep in if it is not a weekday or we're on vacation. 
# Return True if we sleep in.
############################################################

def sleep_in(weekday, vacation):
  if vacation == True:
    return True
  elif weekday == False:
    return True
  elif weekday == True:
    return False

assert sleep_in(False, False) == True
assert sleep_in(True, False) == False
assert sleep_in(False, True) == True


############################################################
# We have two monkeys, a and b, and the parameters a_smile 
# and b_smile indicate if each is smiling. We are in 
# trouble if they are both smiling or if neither of them is 
# smiling. Return True if we are in trouble.
############################################################

def monkey_trouble(a_smile, b_smile):
  if a_smile == True and b_smile == True:
    return True
  elif a_smile == False and b_smile == False:
    return True
  else: 
    return False

assert monkey_trouble(True, True) == True
assert monkey_trouble(False, False) == True
assert monkey_trouble(True, False) == False


############################################################
# Given two int values, return their sum. Unless the two 
# values are the same, then return double their sum.
############################################################

def sum_double(a, b):
  if a != b:
    c = a + b
    return c
  else:
    c = 2 * (a + b)
    return c

assert sum_double(1, 2) == 3
assert sum_double(3, 2) == 5
assert sum_double(2, 2) == 8


############################################################
# Given an int n, return the absolute difference between n 
# and 21, except return double the absolute difference if n 
# is over 21.
############################################################

def diff21(n):
  if n < 22:
    absoluteDiff = 21 - n
    return absoluteDiff
  else:
    absoluteDoubleDiff = 2 * (n - 21)
    return absoluteDoubleDiff

assert diff21(19) == 2
assert diff21(10) == 11
assert diff21(21) == 0


############################################################
# We have a loud talking parrot. The "hour" parameter is 
# the current hour time in the range 0..23. We are in 
# trouble if the parrot is talking and the hour is before 
# 7 or after 20. Return True if we are in trouble.
############################################################

def parrot_trouble(talking, hour):
  if talking == True and hour < 7:
    return True
  elif talking == True and hour > 20:
    return True
  else:
    return False

assert parrot_trouble(True, 6) == True
assert parrot_trouble(True, 7) == False
assert parrot_trouble(False, 6) == False


############################################################
# Given 2 ints, a and b, return True if one if them is 10 
# or if their sum is 10.
############################################################

def makes10(a, b):
  if a == 10 or b == 10:
    return True
  elif a + b == 10:
    return True
  else:
    return False

assert makes10(9, 10) == True
assert makes10(9, 9) == False
assert makes10(1, 9) == True


############################################################
# Given an int n, return True if it is within 10 of 100 or 
# 200. Note: abs(num) computes the absolute value of a 
# number.
############################################################

def near_hundred(n):
  if abs(n-100) < 11 or abs(n-200) < 11:
    return True
  else:
    return False

assert near_hundred(93) == True
assert near_hundred(90) == True
assert near_hundred(89) == False


############################################################
# Given 2 int values, return True if one is negative and 
# one is positive. Except if the parameter "negative" is 
# True, then return True only if both are negative.
############################################################

def pos_neg(a, b, negative):
  if (a < 0 and b < 0) and negative == True:
    return True
  elif ((a < 0) != (b < 0)) and (negative == False):
    return True
  else:
    return False

assert pos_neg(1, -1, False) == True
assert pos_neg(-1, 1, False) == True
assert pos_neg(-4, -5, True) == True


############################################################
# Given a string, return a new string where "not " has been 
# added to the front. However, if the string already begins 
# with "not", return the string unchanged.
############################################################

def not_string(str):
  if str == 'not':
    return str
  elif "not " not in str:
    negatedString = "not " + str
    return negatedString
  else:
    return str

assert not_string('candy') == 'not candy'
assert not_string('x') == 'not x'
assert not_string('not bad') == 'not bad'


############################################################
# Given a non-empty string and an int n, return a new 
# string where the char at index n has been removed. The 
# value of n will be a valid index of a char in the 
# original string (i.e. n will be in the range 
# 0..len(str)-1 inclusive).
############################################################

def missing_char(str, n):
  s = list(str)
  s[n] = ''
  return "".join(s)

assert missing_char('kitten', 1) == 'ktten'
assert missing_char('kitten', 0) == 'itten'
assert missing_char('kitten', 4) == 'kittn'


############################################################
# Given a string, return a new string where the first and 
# last chars have been exchanged.
############################################################

def front_back(str):
  n = len(str)
  if n <= 1:
    return str
  middleBits = str[1:n-1]  
  newS = str[n-1] + middleBits + str[0]
  return newS

assert front_back('code') == 'eodc'
assert front_back('a') == 'a'
assert front_back('ab') == 'ba'


#####################################################
# Warm-Up 2
#####################################################


############################################################
# Given a string and a non-negative int n, return a larger 
# string that is n copies of the original string.
############################################################

def string_times(str, n):
  return str * n

assert string_times('Hi', 2) == 'HiHi'
assert string_times('Hi', 3) == 'HiHiHi'
assert string_times('Hi', 1) == 'Hi'


############################################################
# Given a string and a non-negative int n, we'll say that 
# the front of the string is the first 3 chars, or whatever 
# is there if the string is less than length 3. Return n 
# copies of the front;
############################################################

def front_times(str, n):
  front = str[0:3]
  return front * n

assert front_times('Chocolate', 2) == 'ChoCho'
assert front_times('Chocolate', 3) == 'ChoChoCho'
assert front_times('Abc', 3) == 'AbcAbcAbc'


############################################################
# Given a string, return a new string made of every other 
# char starting with the first, so "Hello" yields "Hlo".
############################################################

def string_bits(str):
  n = len(str)
  s = ""
  for i in range(n):
    if i % 2 == 0:
      s = s + str[i]
  return s

assert string_bits('Hello') == 'Hlo'
assert string_bits('Hi') == 'H'
assert string_bits('Heeololeo') == 'Hello'


############################################################
# Given a non-empty string like "Code" return a string like 
# "CCoCodCode".
############################################################

def string_splosion(str):
  result = ""
  for i in range(len(str)+1):
    result = result + str[:i] 
  return result

assert string_splosion('Code') == 'CCoCodCode'
assert string_splosion('abc') == 'aababc'
assert string_splosion('ab') == 'aab'


############################################################
# Given an array of ints, return True if one of the first 4 
# elements in the array is a 9. The array length may be 
# less than 4.
############################################################

def array_front9(nums):
  logic = False
  for i in range(len(nums)):
    if nums[i] == 9:
      logic = True
    if i == 3:
      break
  return logic

assert array_front9([1, 2, 9, 3, 4]) == True
assert array_front9([1, 2, 3, 4, 9]) == False
assert array_front9([1, 2, 3, 4, 5]) == False


############################################################
# Given an array of ints, return True if the sequence of 
# numbers 1, 2, 3 appears in the array somewhere.
############################################################

def array123(nums):
  for i in range(len(nums)-2):
    if nums[i] == 1: # can use and instead of sep ifs
      if nums[i+1] == 2:
        if nums[i+2] == 3:
          return True
  else:
    return False

assert array123([1, 1, 2, 3, 1]) == True
assert array123([1, 1, 2, 4, 1]) == False
assert array123([1, 1, 2, 1, 2, 3]) == True


############################################################
# Given a string, return the count of the number of times 
# that a substring length 2 appears in the string and also 
# as the last 2 chars of the string, so "hixxxhi" yields 1 
# (we won't count the end substring).
############################################################

def last2(str):
  n = len(str)
  if n < 2:
    return 0

  ending = str[n-2:]
  count = 0
  
  for i in range(n-2):
      test = str[i:i+2] # The second index IS NOT +1
      if test == ending:
        count += 1
  return count

assert last2('hixxhi') == 1
assert last2('xaxxaxaxx') == 1
assert last2('axxxaaxx') == 2


############################################################
# Given an array of ints, return the number of 9's in the 
# array.
############################################################

def array_count9(nums):
  count = 0
  for i in range(len(nums)):
    if nums[i]==9:
      count += 1
  return count

assert array_count9([1, 2, 9]) == 1
assert array_count9([1, 9, 9]) == 2
assert array_count9([1, 9, 9, 3, 9]) == 3


############################################################
# Given 2 strings, a and b, return the number of the 
# positions where they contain the same length 2 substring. 
# So "xxcaazz" and "xxbaaz" yields 3, since the "xx", "aa", 
# and "az" substrings appear in the same place in both 
# strings.
############################################################

def string_match(a, b):
  n = len(a)
  m = len(b)
  if n < m:
    testN = n
  else:
    testN = m
    
  if testN < 2:
    return 0
  
  count = 0
  for i in range(testN-1):
    if a[i:i+2] == b[i:i+2]:
      count += 1
  return count

assert string_match('xxcaazz', 'xxbaaz') == 3
assert string_match('abc', 'abc') == 2
assert string_match('abc', 'axc') == 0


############################################################
# Given a string name, e.g. "Bob", return a greeting of the 
# form "Hello Bob!".
############################################################

def hello_name(name):
  return "Hello "+name+"!"

assert hello_name('Bob') == 'Hello Bob!'
assert hello_name('Alice') == 'Hello Alice!'
assert hello_name('X') == 'Hello X!'


############################################################
# Given two strings, a and b, return the result of putting 
# them together in the order abba, e.g. "Hi" and "Bye" 
# returns "HiByeByeHi".
############################################################

def make_abba(a, b):
  return a + b + b + a

assert make_abba('Hi', 'Bye') == 'HiByeByeHi'
assert make_abba('Yo', 'Alice') == 'YoAliceAliceYo'
assert make_abba('What', 'Up') == 'WhatUpUpWhat'


############################################################
# The web is built with HTML strings like "<i>Yay</i>" 
# which draws Yay as italic text. In this example, the "i" 
# tag makes <i> and </i> which surround the word "Yay". 
# Given tag and word strings, create the HTML string with 
# tags around the word, e.g. "<i>Yay</i>".
############################################################

def make_tags(tag, word):
  return "<"+tag+">"+word+"</"+tag+">"

assert make_tags('i', 'Yay') == '<i>Yay</i>'
assert make_tags('i', 'Hello') == '<i>Hello</i>'
assert make_tags('cite', 'Yay') == '<cite>Yay</cite>'


############################################################
# Given an "out" string length 4, such as "<<>>", and a 
# word, return a new string where the word is in the middle 
# of the out string, e.g. "<<word>>".
############################################################

def make_out_word(out, word):
  preOut = out[:2]
  postOut = out[2:]
  return preOut + word + postOut

assert make_out_word('<<>>', 'Yay') == '<<Yay>>'
assert make_out_word('<<>>', 'WooHoo') == '<<WooHoo>>'
assert make_out_word('[[]]', 'word') == '[[word]]'


############################################################
# Given a string, return a new string made of 3 copies of 
# the last 2 chars of the original string. The string 
# length will be at least 2.
############################################################

def extra_end(str):
  stutter = str[-2:]
  return stutter * 3

assert extra_end('Hello') == 'lololo'
assert extra_end('ab') == 'ababab'
assert extra_end('Hi') == 'HiHiHi'


############################################################
# Given a string, return the string made of its first two 
# chars, so the String "Hello" yields "He". If the string 
# is shorter than length 2, return whatever there is, so 
# "X" yields "X", and the empty string "" yields the 
# empty string "".
############################################################

def first_two(str):
  prefix = str[:2]
  return prefix

assert first_two('Hello') == 'He'
assert first_two('abcdefg') == 'ab'
assert first_two('ab') == 'ab'


############################################################
# Given a string of even length, return the first half. So 
# the string "WooHoo" yields "Woo".
############################################################

def first_half(str):
  return str[:len(str)/2]

assert first_half('WooHoo') == 'Woo'
assert first_half('HelloThere') == 'Hello'
assert first_half('abcdef') == 'abc'


############################################################
# Given a string, return a version without the first and 
# last char, so "Hello" yields "ell". The string length 
# will be at least 2.
############################################################

def without_end(str):
  n = len(str)
  middleBits = str[1:n-1]
  return middleBits

assert without_end('Hello') == 'ell'
assert without_end('java') == 'av'
assert without_end('coding') == 'odin'


############################################################
# Given 2 strings, a and b, return a string of the form 
# short+long+short, with the shorter string on the outside 
# and the longer string on the inside. The strings will not 
# be the same length, but they may be empty (length 0).
############################################################

def combo_string(a, b):
  aLen = len(a)
  bLen = len(b)
  if aLen < bLen:
    return a + b + a
  else:
    return b + a + b

assert combo_string('Hello', 'hi') == 'hiHellohi'
assert combo_string('hi', 'Hello') == 'hiHellohi'
assert combo_string('aaa', 'b') == 'baaab'


############################################################
# Given 2 strings, return their concatenation, except omit 
# the first char of each. The strings will be at least 
# length 1.
############################################################

def non_start(a, b):
  return a[1:] + b[1:]

assert non_start('Hello', 'There') == 'ellohere'
assert non_start('java', 'code') == 'avaode'
assert non_start('shotl', 'java') == 'hotlava'


############################################################
# Given a string, return a "rotated left 2" version where 
# the first 2 chars are moved to the end. The string length 
# will be at least 2.
############################################################

def left2(str):
  prefix = str[:2]
  suffix = str[2:]
  return suffix + prefix

assert left2('Hello') == 'lloHe'
assert left2('java') == 'vaja'
assert left2('Hi') == 'Hi'


############################################################
# Given an array of ints, return True if 6 appears as 
# either the first or last element in the array. The array 
# will be length 1 or more.
############################################################

def first_last6(nums):
  n = len(nums)
# Remember that indices are zero based!
  if nums[0] == 6 or nums[n-1] == 6:
    return True
  else:
    return False

assert first_last6([1, 2, 6]) == True
assert first_last6([6, 1, 2, 3]) == True
assert first_last6([13, 6, 1, 2, 3]) == False


############################################################
# Given an array of ints, return True if the array is 
# length 1 or more, and the first element and the last 
# element are equal.
############################################################

def same_first_last(nums):
  n = len(nums)
  if n > 0:
    if nums[0] == nums[n-1]:
      return True
    else:
      return False
  else:
    return False

assert same_first_last([1, 2, 3]) == False
assert same_first_last([1, 2, 3, 1]) == True
assert same_first_last([1, 2, 1]) == True


############################################################
# Return an int array length 3 containing the first 3 
# digits of pi, {3, 1, 4}.
############################################################

def make_pi():
  return [3, 1, 4]

assert make_pi() == [3, 1, 4]


############################################################
# Given 2 arrays of ints, a and b, return True if they have 
# the same first element or they have the same last 
# element. Both arrays will be length 1 or more.
############################################################

def common_end(a, b):
  aLen = len(a)
  bLen = len(b)
  if a[0] == b[0] or a[aLen-1] == b[bLen-1]:
    return True
  else:
    return False

assert common_end([1, 2, 3], [7, 3]) == True
assert common_end([1, 2, 3], [7, 3, 2]) == False
assert common_end([1, 2, 3], [1, 3]) == True


############################################################
# Given an array of ints length 3, return the sum of all 
# the elements.
############################################################

def sum3(nums):
  return nums[0] + nums[1] + nums[2]

assert sum3([1, 2, 3]) == 6
assert sum3([5, 11, 2]) == 18
assert sum3([7, 0, 0]) == 7


############################################################
# Given an array of ints length 3, return an array with the 
# elements "rotated left" so {1, 2, 3} yields {2, 3, 1}.
############################################################



#assert rotate_left3([1, 2, 3]) == [2, 3, 1]
#assert rotate_left3([5, 11, 9]) == [11, 9, 5]
#assert rotate_left3([7, 0, 0]) == [0, 0, 7]


