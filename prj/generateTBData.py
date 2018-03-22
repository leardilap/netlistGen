#!/usr/bin/env python  

from random import *
from math import *

n = 1000
c = 200.453

aNbits = 12       # range of variable A in SW
aNbitsHW = 27     # A input Multiplier in HW
aNshift = aNbitsHW-aNbits

bNbits = 12       # range of variable B in SW
bNbitsHW = 18     # B input Multiplier in HW
bNshift = bNbitsHW - bNbits

cNbitsHW = 48     # C input Multiplier in HW
cNshift = aNshift + bNshift

def toHex(val, nbits):
  hexVal = hex((val + (1 << nbits)) % (1 << nbits))[2:] #remove the 0x
  lenVal = len(hexVal)
  hexNbitsLen = int(ceil(nbits/4.))
  extra_zeros = '0' * (hexNbitsLen - lenVal) # may not get used..
  return (extra_zeros + hexVal)

def dataGen(nbits):
  return randint(-2**(nbits-1),2**(nbits-1)-1)

hFile = open('input_data.txt', 'w')
hFile.write("a[%i],b[%i],c[%i],result[%i]\n" % (aNbitsHW,bNbitsHW,cNbitsHW,aNbitsHW))

for i in range (0 , n):

  a = dataGen(aNbits) #random signed value inside 12 bits
  b = dataGen(bNbits)
  
  a_h = a*(2**aNshift) # shift up 15 places
  b_h = b*(2**bNshift)  # shift up 6 places
  c_h = int(round(c*(2**cNshift))) # shift up 21 places
  
  result_h = int(floor(((a_h * b_h - c_h)*(2**-cNshift)))) # shift down 21 places to fit in 27 bits shift left does not do round but floor
  
  print "a=", a, "b=", b, "c=", c, "a*b-c=", a*b-c, "round=" , int(floor(a*b-c)), "result_h=", result_h, ("%s,%s,%s,%s" % (toHex(a_h,aNbitsHW),toHex(b_h,bNbitsHW),toHex(c_h,cNbitsHW),toHex(result_h,aNbitsHW)))
  
  hFile.write("%s,%s,%s,%s\n" % (toHex(a_h,aNbitsHW),toHex(b_h,bNbitsHW),toHex(c_h,cNbitsHW),toHex(result_h,aNbitsHW)))

hFile.close()




 
