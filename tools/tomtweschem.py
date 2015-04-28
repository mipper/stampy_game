# This version uses the new nodes in mods in stampy_game
# and has extra blockdata orientation conversions for pistons, pumpkins, chests, buttons, etc. (in convdir)

# copy this to ~/.mcedit/filters/


# Minecraft to Minetest WE schematic MCEdit filter
# by sfan5

displayName = "-> Minetest WE schematic"

#Reference MC: http://media-mcw.cursecdn.com/8/8c/DataValuesBeta.png
#Reference MT:
# https://github.com/minetest/common/blob/master/mods/default/init.lua
# https://github.com/minetest/common/blob/master/mods/wool/init.lua
# https://github.com/minetest/common/blob/master/mods/stairs/init.lua
conversionTable = [
	#blockid blockdata minetest-nodename
	#blockdata -1 means ignore
	#blockdata -2 means copy without change
	#blockdata -3 means copy and convert the mc facedir value to mt facedir
	#blockdata -4 is for stairs to support upside down ones

	(1  , -1, "default:stone"),
	(2  , -1, "default:dirt_with_grass"),
	(3  , -1, "default:dirt"),
	(4  , -1, "default:cobble"),
	(5  ,  3, "default:junglewood"),
	(5  , -1, "default:wood"),
	(6  ,  3, "default:junglesapling"),
	(6  , -1, "default:sapling"),
	(7  , -1, "bedrock:bedrock"),
	(8  , -1, "default:water_flowing"),
	(9  , -1, "default:water_source"),
	(10 , -1, "default:lava_flowing"),
	(11 , -1, "default:lava_source"),
	(12 , -1, "default:sand"),
	(13 , -1, "default:gravel"),
	(14 , -1, "default:stone_with_gold"),
	(15 , -1, "default:stone_with_iron"),
	(16 , -1, "default:stone_with_coal"),
	(17 ,  3, "default:jungletree"),
	(17 , -1, "default:tree"),
	(18 ,  3, "default:jungleleaves"),
	(18 , -1, "default:leaves"),
	(19 , 0, "sponge:sponge_dry"),
	(19 , 1, "sponge:sponge_wet"),
	(20 , -1, "default:glass"),
	(21 , -1, "default:stone_with_lapis"),
	(22 , -1, "default:lapisblock"),
	(24 ,  1, "default:sandstonebrick"),
	(24 , -1, "default:sandstone"),
	(26 , -1, "wool:red"),
	(30 , -1, "mobs:cobweb"),
	(31 ,  0, "default:dry_shrub"),
	(31 ,  1, "default:grass_4"),
	(31 ,  2, "default:grass_3"),
	(31 , -1, "default:grass_1"),
	(32 , -1, "default:dry_shrub"),
	(35 ,  0, "wool:white"),
	(35 ,  1, "wool:orange"),
	(35 ,  2, "wool:magenta"),
	(35 ,  3, "wool:light_blue"),
	(35 ,  4, "wool:yellow"),
	(35 ,  5, "wool:green"),
	(35 ,  6, "wool:pink"),
	(35 ,  7, "wool:dark_grey"),
	(35 ,  8, "wool:grey"),
	(35 ,  9, "wool:cyan"),
	(35 , 10, "wool:violet"),
	(35 , 11, "wool:blue"),
	(35 , 12, "wool:brown"),
	(35 , 13, "wool:dark_green"),
	(35 , 14, "wool:red"),
	(35 , 15, "wool:black"),
	(37 , -1, "flowers:dandelion_yellow"),
	(38 , -1, "flowers:rose"),
	(41 , -1, "default:goldblock"),
	(42 , -1, "default:steelblock"),
	(43 ,  0, "default:stonebrick"),
	(43 ,  1, "default:sandstone"),
	(43 ,  2, "default:wood"),
	(43 ,  3, "default:cobble"),
	(43 ,  4, "default:brick"),
	(43 ,  5, "default:stonebrick"),
	(44 ,  0, "stairs:slab_stone"),
	(44 ,  1, "stairs:slab_sandstone"),
	(44 ,  2, "stairs:slab_wood"),
	(44 ,  3, "stairs:slab_cobble"),
	(44 ,  4, "stairs:slab_brick"),
	(44 ,  5, "stairs:slab_stonebrick"),
	(44 ,  8, "stairs:slab_stoneupside_down"),
	(44 ,  9, "stairs:slab_sandstoneupside_down"),
	(44 , 10, "stairs:slab_woodupside_down"),
	(44 , 11, "stairs:slab_cobbleupside_down"),
	(44 , 12, "stairs:slab_brickupside_down"),
	(44 , 13, "stairs:slab_stonebrickupside_down"),
	(45 , -1, "default:brick"),
	(46 , -1, "tnt:tnt"),
	(47 , -1, "default:bookshelf"),
	(48 , -1, "default:mossycobble"),
	(49 , -1, "default:obsidian"),
	(50 , 5, "torches:floor"),
	(50 , -3, "torches:wall"),
	(51 , -1, "fake_fire:fake_fire"),
	(53 , -4, "stairs:stair_wood"),
	(54 , -3, "default:chest"),
	(56 , -1, "default:stone_with_diamond"),
	(57 , -1, "default:diamondblock"),
	(58 , -1, "crafting:workbench"),
	(61 , -3, "default:furnace"),
	(62 , -3, "default:furnace_active"),
	(63 , -3, "signs:sign_yard"),
	(64 , -1, "doors:door_wood_t_1"),
	(65 , -3, "default:ladder"),
	(66 , -1, "default:rail"),
	(67 , -4, "stairs:stair_cobble"),
	(68 , -3, "signs:sign_wall"),
	(71 , -1, "doors:door_steel_t_1"),
	(78 , -1, "default:snow"),
	(79 , -1, "default:ice"),
	(80 , -1, "default:snowblock"),
	(81 , -1, "default:cactus"),
	(82 , -1, "default:clay"),
	(83 , -1, "default:papyrus"),
	(84 , -1, "jdukebox:box"),
	(85 , -1, "default:fence_wood"),
	(86 , -3, "farming:pumpkin_face"),
	(91 , -3, "farming:pumpkin_face_light"),
	(92 , -1, "cake:cake"),
	(96 , -3, "doors:trapdoor"),
	(98 , -1, "default:stonebrick"),
	(101 , -1, "xpanes:pane_iron"),
	(102 , -1, "xpanes:pane_glass"),
	(103 , -1, "crops:melon"),
	(106 , -3, "moreblocks:rope"),
	(107, -3, "gate:fencegate"),
	(108, -4, "stairs:stair_brick"),
	(109, -4, "stairs:stair_stonebrick"),
	(110, -1, "default:dirt"),
	(111 ,  -1, "wool:green"),

	(113 , -1, "default:fence_wood"),
	(116 , -1, "wool:red"),
	(117 , -1, "vessels:glass_bottle"),
	(118 , -1, "mesecons_lightstone:lightstone_darkgray_off"),

	(125,  3, "default:junglewood"),
	(125, -1, "default:wood"),
	(126,  3, "stairs:slab_junglewood"),
	(126, -1, "stairs:slab_wood"),
	(127, -1, "farming:cocoa_3"),
	(128, -4, "stairs:stair_sandstone"),
	(129, -1, "default:stone_with_emerald"),
	(132, -1, "jungle:tripwire"),
	(133, -1, "default:emeraldblock"),
	(134, -4, "stairs:stair_wood"),
	(135, -4, "stairs:stair_wood"),
	(136, -4, "stairs:stair_junglewood"),
	(139, -1, "default:cobble"),
	(140 , -1, "flowers:dandelion_yellow"),
	(145 , -1, "itemframes:pedestal"),
	(146 , -3, "default:chest"),
	(149 , -1, "wool:pink"),

	(155 , -1, "quartz:block"),
	(156 , -3, "moreblocks:stairs_quartz"),		# ???

	(159 ,  0, "hardenedclay:hardened_clay_white"),
	(159 ,  1, "hardenedclay:hardened_clay_orange"),
	(159 ,  2, "hardenedclay:hardened_clay_magenta"),
	(159 ,  3, "hardenedclay:hardened_clay_light_blue"),
	(159 ,  4, "hardenedclay:hardened_clay_yellow"),
	(159 ,  5, "hardenedclay:hardened_clay_green"),
	(159 ,  6, "hardenedclay:hardened_clay_pink"),
	(159 ,  7, "hardenedclay:hardened_clay_dark_grey"),
	(159 ,  8, "hardenedclay:hardened_clay_grey"),
	(159 ,  9, "hardenedclay:hardened_clay_cyan"),
	(159 , 10, "hardenedclay:hardened_clay_violet"),
	(159 , 11, "hardenedclay:hardened_clay_blue"),
	(159 , 12, "hardenedclay:hardened_clay_brown"),
	(159 , 13, "hardenedclay:hardened_clay_dark_green"),
	(159 , 14, "hardenedclay:hardened_clay_red"),
	(159 , 15, "hardenedclay:hardened_clay_black"),

	(165 , -1, "jumping:trampoline"),
	(167 , -3, "doors:trapdoor"),
	(169 , -1, "ocean:sea_lantern"),
	(170 , -1, "farming:straw"),

	(171 ,  0, "carpet:white"),
	(171 ,  1, "carpet:orange"),
	(171 ,  2, "carpet:magenta"),
	(171 ,  3, "carpet:light_blue"),
	(171 ,  4, "carpet:yellow"),
	(171 ,  5, "carpet:green"),
	(171 ,  6, "carpet:pink"),
	(171 ,  7, "carpet:dark_grey"),
	(171 ,  8, "carpet:grey"),
	(171 ,  9, "carpet:cyan"),
	(171 , 10, "carpet:violet"),
	(171 , 11, "carpet:blue"),
	(171 , 12, "carpet:brown"),
	(171 , 13, "carpet:dark_green"),
	(171 , 14, "carpet:red"),
	(171 , 15, "carpet:black"),

	(172 , -1, "hardenedclay:hardened_clay"),

	(183, -3, "gate:fencegate"),
	(184, -3, "gate:fencegate"),
	(185, -3, "gate:fencegate"),
	(186, -3, "gate:fencegate"),
	(187, -3, "gate:fencegate"),

	(188, -3, "default:fence_wood"),
	(189, -3, "default:fence_wood"),
	(190, -3, "default:fence_wood"),
	(191, -3, "default:fence_wood"),
	(192, -3, "default:fence_wood"),

	(193 , -1, "doors:door_wood_t_1"),
	(194 , -1, "doors:door_wood_t_1"),
	(195 , -1, "doors:door_wood_t_1"),
	(196 , -1, "doors:door_wood_t_1"),
	(197 , -1, "doors:door_wood_t_1"),

	#Mesecons section
	# Reference: https://github.com/Jeija/minetest-mod-mesecons/blob/master/mesecons_alias/init.lua
	(23 , -3, "moremesecons_dispenser:dispenser"),
	(27 , -1, "carts:powerrail"),
	(25 , -1, "mesecons_noteblock:noteblock", "mesecons"),
	(29 , -3, "mesecons_pistons:piston_sticky_off", "mesecons"),
	(33 , -3, "mesecons_pistons:piston_normal_off", "mesecons"),
	(55 , -1, "default:mese"),
	(69 , -3, "mesecons_walllever:wall_lever_off", "mesecons"),
	(70 , -1, "mesecons_pressureplates:pressure_plate_stone_off", "mesecons"),
	(72 , -1, "mesecons_pressureplates:pressure_plate_wood_off", "mesecons"),
	(73 , -1, "default:stone_with_mese", "mesecons"),
	(74 , -1, "default:stone_with_mese", "mesecons"),
	(75 , -3, "mesecons_torch:mesecon_torch_off", "mesecons"),
	(76 , -3, "mesecons_torch:mesecon_torch_on", "mesecons"),
	(77 , -3, "mesecons_button:button_off", "mesecons"),
	(93 , -3, "mesecons_delayer:delayer_off", "mesecons"),
	(94 , -3, "mesecons_delayer:delayer_on", "mesecons"),
	(123, -1, "mesecons_lightstone_red_off", "mesecons"),
	(124, -1, "mesecons_lightstone_red_on", "mesecons"),
	(137, -1, "mesecons_commandblock:commandblock_off", "mesecons"),
	(143 , -3, "mesecons_button:button_off", "mesecons"),
	(151, -1, "mesecons_solarpanel:solar_panel_off", "mesecons"),
	(152, -1, "default:mese", "mesecons"),
	(154, -1, "hopper:hopper"),
	(158, -3, "moremesecons_dispenser:dropper"),
	
	#Nether section
	# Reference: https://github.com/PilzAdam/nether/blob/master/init.lua
	(43 ,  6, "nether:brick", "nether"),
	(87 , -1, "nether:rack", "nether"),
	(88 , -1, "nether:sand", "nether"),
	(89 , -1, "nether:glowstone", "nether"),
	(90 , -3, "nether:portal", "nether"),

	#Riesenpilz Section
	# Reference: https://github.com/HybridDog/riesenpilz/blob/master/init.lua
	(39 , -1, "riesenpilz:brown", "riesenpilz"),
	(40 , -1, "riesenpilz:red", "riesenpilz"),
	(99 , -3, "riesenpilz:head_brown", "riesenpilz"),
	(100, -3, "riesenpilz:head_brown", "riesenpilz"),
]

inputs = (
	("Output filename", "string"),
	("Enabled Mods", "label"),
	("Mesecons", ("False", "True")),
	("Nether", ("False", "True")),
	("Riesenpilz", ("False", "True")),
)

def mc2mtFacedir(blockdata):
	#Minetest
	# x+ = 2
	# x- = 3
	# z+ = 1
	# z- = 0
	#Minecraft
	# x+ = 3
	# x- = 1
	# z+ = 0
	# z- = 2
	tbl = {
		3: 2,
		1: 3,
		0: 1,
		2: 0,
	}
	return tbl.get(blockdata, 0)

def stairsdir(blockdata):
	tbl = {
		3: 2,
		1: 1,
		0: 3,
		2: 0,
	}
	return tbl.get(blockdata, 0)

def convdir(name, blockdata):
	#Minetest
	# x+ = 2
	# x- = 3
	# z+ = 1
	# z- = 0
	#Minecraft
	# x+ = 3
	# x- = 1
	# z+ = 0
	# z- = 2
	tbl = {
		3: 2,
		1: 3,
		0: 1,
		2: 0,
	}
	torch = {	# wallmounted
		1: 2,
		2: 3,
		3: 5,
		4: 4,
		5: 1,
	}
	trap = {	# facedir
		0: 0,
		1: 2,
		2: 3,
		3: 1,
	}
	lad = {		# wallmounted
		2: 4,
		3: 5,
		4: 3,
		5: 2,
	}
	chest = {		# facedir
		2: 0,
		3: 2,
		4: 3,
		5: 1,
	}
	signw = {
		2: 0,
		3: 2,
		4: 3,
		5: 1,
	}
	dela = {	# facedir
		0: 1,
		1: 2,
		2: 3,
		3: 0,
	}
	but = {	# facedir
		0: 0,
		1: 1,
		2: 3,
		3: 2,
		4: 0,
		5: 0,
	}
	pump = {
		3: 1,
		1: 3,
		0: 2,
		2: 0,
	}
	out = name, tbl.get(blockdata, 0)

	if "torch" in name:
		out = name, torch.get(blockdata, 0)
	elif "gate" in name:
		if blockdata & 4:
			name = name + "_open"
		out = name, pump.get(blockdata & 3, 0)
	elif "trapdoor" in name:
		d = blockdata & 3
		if blockdata & 8:
			name = name + "_top"
		if blockdata & 4:
			name = name + "_open"
		out = name, trap.get(d, 0)
	elif "piston" in name:
		d = blockdata & 7
		if d == 1:
			out = name.replace(":piston", ":piston_up"), 0
		elif d == 0:
			out = name.replace(":piston", ":piston_down"), 0
		else:
			out = name, signw.get(d, 0)
	elif "delayer" in name:
		d = blockdata & 3
		v = blockdata >> 2
		name = name + "_%u" % (v+1)
		out = name, dela.get(d, 0)
	elif "button" in name or "lever" in name:
		out = name, but.get(blockdata & 7, 0)
	elif "ladder" in name:
		out = name, lad.get(blockdata, 0)
	elif "chest" in name or "furnace" in name:
		out = name, chest.get(blockdata, 0)
	elif "moreblocks:rope" in name:
		if blockdata & 1:
			out = name, 4
		if blockdata & 2:
			out = name, 2
		if blockdata & 4:
			out = name, 5
		if blockdata & 8:
			out = name, 3
	elif "pumpkin" in name:
		out = name, pump.get(blockdata, 0)
	elif "signs:sign_wall" in name:
		out = name, signw.get(blockdata, 0)
	elif "signs:sign_yard" in name:
		if blockdata < 3 or blockdata > 13:
			out = name, 2
		if blockdata > 2 and blockdata < 6:
			out = name, 3
		if blockdata > 5 and blockdata < 10:
			out = name, 0
		if blockdata > 9 and blockdata < 14:
			out = name, 1
	elif "dispenser" in name:
		out = name, signw.get(blockdata, 0)
	return out

def mc2mtstairs(tpl):
	if tpl[1] >= 4:
		return (tpl[0] + "upside_down", stairsdir(tpl[1] - 4))
	else:
		return (tpl[0], stairsdir(tpl[1]))


def findConversion(blockid, blockdata, mods):
	if blockid == 0:
		return None
	for cnv in conversionTable:
		if blockid != cnv[0]:
			continue
		#     comment out == always assume mods are available...
		#if len(cnv) >= 4:
		#	if mods.get(cnv[3], False) == False:
		#		continue 
		if cnv[1] == -1:
			return (cnv[2], 0)
		elif cnv[1] == -2:
			return (cnv[2], blockdata)
		elif cnv[1] == -3:
			#return (cnv[2], mc2mtFacedir(blockdata))
			try:
				return convdir(cnv[2], blockdata)
			except:
				print("dirfail", cnv[2], blockdata)
		elif cnv[1] == -4:
			return mc2mtstairs((cnv[2], blockdata))
		elif cnv[1] != blockdata:
			continue
		return (cnv[2], 0)
	return None

def perform(level, box, options):
	try:
		f = open(options["Output filename"] + ".we", 'w')
	except:
		raise

	origin = (
		box.minx + int((box.maxx - box.minx) / 2),
		box.miny + int((box.maxy - box.miny) / 2),
		box.minz + int((box.maxz - box.minz) / 2),
	)
	
	mods = {}
	for arg in options.keys():
		if options[arg] == "True":
			mods[arg.lower()] = True
	ign = [175,28,36,34,131,52,97]		# do not report these blocks as missing
	notfound = []
	for x in xrange(box.minx, box.maxx):
		print(x, box.maxx, "%u%% done" % (100*(x-box.minx)/(box.maxx-box.minx)))
		for z in xrange(box.minz, box.maxz):
			for y in xrange(box.miny, box.maxy):
				c = findConversion(level.blockAt(x, y, z), level.blockDataAt(x, y, z), mods)
				if c == None:
					if level.blockAt(x, y, z) > 0 and level.blockAt(x, y, z) not in ign:
						tt = "%i %i" % (level.blockAt(x, y, z), level.blockDataAt(x, y, z))
						print("***", tt)
						if tt not in notfound:
							notfound.append(tt)
					continue
				calcpos = (origin[0] - x, y - origin[1], z - origin[2])
				fmttpl = calcpos + (c[0], level.blockLightAt(x, y, z), c[1])
				f.write("%d %d %d %s %d %d\n" % fmttpl)

	f.close()

	notfound.sort()
	print("unknown blocks:", notfound)

