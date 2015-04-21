from PIL import Image

im = Image.open("ascii.png")

w = {}
w[32] = 4
for l in open("ascii.properties").readlines():
	if l.strip() != "":
		m = l[6:].split("=")
		w[int(m[0])] = int(m[1])

print(" ")
print("_sp")
print("4")

for i in range(33,127):
	x = i % 16
	y = i//16
	z = chr(i)
	if z.isalnum():
		if z.isupper():
			f = "_%s_.png" % z.lower()
		else:
			f = "_%s.png" % z
	else:
		f = "_c%s.png" % i
	im2 = im.copy()
	#print(z,x,y)
	im2 = im2.crop((16*x, 16*y, 16*x+16, 16*y+16))
	for yy in range(16):
		for xx in range(16):
			if im2.getpixel((xx,yy))[3] == 255:
				im2.putpixel((xx,yy), (0,0,0))
	print(z)
	print(f[:-4])
	print(w[i])
	im2.save(f)

