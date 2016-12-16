import os, pty, serial, binascii

master, slave = pty.openpty()
s_name = os.ttyname(slave)
ser = serial.Serial(s_name)

########################################################

from PIL import Image
import numpy as np

im = Image.open('lena512.gif')

imL = im.convert('L')

arr = np.asarray(imL)

print (arr[0][1])

for i in range(75):
	for j in range(256):
		ser.write(arr[i][j].tostring())
		#print arr[i][j]
'''
for row in arr:
	for elem in row:
		ser.write(elem.tostring())
'''
	
#######################################################

out_arr = np.zeros(shape=(256,256), dtype=np.uint8)

#print (os.read(master,1).decode("ascii"))

#print b'h'

'''
for m in range(256):
	print (int.from_bytes(os.read(master,1), byteorder='big'))
	#print (type(os.read(master,1)))
#print os.read(master,1)

'''

for i in range(75):
	for j in range(256):
		out_arr[i][j] = int.from_bytes(os.read(master,1), byteorder='big')

im2 = Image.fromarray(np.uint8(out_arr))


im2.save('out.gif')
