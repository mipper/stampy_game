# Update font metrics

# Usage: python met.py > c2; mv c2 ../characters

import os
from PIL import Image

f = open("../characters", "r")
i=0

for l in f.readlines():
	if i==0 or i==1:
		print(l, end="")
	if i==1: fn = "%s.png" % l.strip()
	if i==2:
		im = Image.open(fn)
		if fn == "_sp.png":
			print("4")
		else:
			print(im.size[0]+1)
	i += 1
	if i==3: i = 0


