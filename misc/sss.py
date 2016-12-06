import os, pty, serial

master, slave = pty.openpty()
s_name = os.ttyname(slave)

ser = serial.Serial(s_name)

# To Write to the device
ser.write(b'Your text')

# To read from the device
print(os.read(master,1000))




#image processing

from PIL import Image
import numpy

im = Image.open('lena512.gif')

imL = im.convert('L')

arr = numpy.asarray(imL)
