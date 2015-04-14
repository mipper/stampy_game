dofile(minetest.get_modpath("ocean").."/room.lua")

-- mapgenv6.cpp; np_terrain_base
local perl1 = {SEED1 = 82341, OCTA1 = 5, PERS1 = 0.6, SCAL1 = 250}

minetest.register_node("ocean:prismarine", {
	description = "Prismarine",
	drawtype = "normal",
	tiles = {"prismarine.png"},
	groups = {cracky=2,level=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("ocean:dark_prismarine", {
	description = "Dark Prismarine",
	drawtype = "normal",
	tiles = {"prismarine_dark.png"},
	groups = {cracky=2,level=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("ocean:prismarine_bricks", {
	description = "Prismarine Bricks",
	drawtype = "normal",
	tiles = {"prismarine_bricks.png"},
	groups = {cracky=2,level=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("ocean:sea_lantern", {
	description = "Sea Lantern",
	tiles = {"sea_lantern.png"},
	light_source = 14,
	groups = {cracky=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_glass_defaults(),
})

minetest.register_craftitem("ocean:prismarine_crystals", {
	description = "Prismarine Crystals",
	inventory_image = "prismarine_crystals.png",
})

minetest.register_craftitem("ocean:prismarine_shard", {
	description = "Prismarine Shard",
	inventory_image = "prismarine_shard.png",
})

minetest.register_craft({
	output = 'ocean:sea_lantern',
	recipe = {
		{'ocean:prismarine_shard',    'ocean:prismarine_crystals', 'ocean:prismarine_shard'},
		{'ocean:prismarine_crystals', 'ocean:prismarine_crystals', 'ocean:prismarine_crystals'},
		{'ocean:prismarine_shard',    'ocean:prismarine_crystals', 'ocean:prismarine_shard'},
	}
})

minetest.register_craft({
	output = 'ocean:prismarine_bricks',
	recipe = {
		{'ocean:prismarine_shard',    'ocean:prismarine_shard', 'ocean:prismarine_shard'},
		{'ocean:prismarine_shard',    'ocean:prismarine_shard', 'ocean:prismarine_shard'},
		{'ocean:prismarine_shard',    'ocean:prismarine_shard', 'ocean:prismarine_shard'},
	}
})

minetest.register_craft({
	output = 'ocean:dark_prismarine',
	recipe = {
		{'ocean:prismarine_shard',    'ocean:prismarine_shard', 'ocean:prismarine_shard'},
		{'ocean:prismarine_shard',    'dye:black',              'ocean:prismarine_shard'},
		{'ocean:prismarine_shard',    'ocean:prismarine_shard', 'ocean:prismarine_shard'},
	}
})

minetest.register_craft({
	output = 'ocean:prismarine',
	recipe = {
		{'ocean:prismarine_shard',    'ocean:prismarine_shard'},
		{'ocean:prismarine_shard',    'ocean:prismarine_shard'},
	}
})

minetest.register_craft({
	output = 'ocean:prismarine_shard 4',
	recipe = {
		{'ocean:prismarine'},
	}
})

local function hlp_fnct(pos, name)
	local n = minetest.get_node_or_nil(pos)
	if n and n.name and n.name == name then
		return true
	else
		return false
	end
end

local function ground(pos, old)
	local p2 = pos
	while hlp_fnct(p2, "default:water_source") do
		p2.y = p2.y - 1
	end
	if p2.y < old.y then
		return p2
	else
		return old
	end
end

local function make_entrance(pos)
 local gang = {x=pos.x+10,y=pos.y, z=pos.z}
 for iy=2,3,1 do
	for iz=0,6,1 do
		minetest.set_node({x=gang.x+1,y=gang.y+iy,z=gang.z+iz}, {name = "default:water_source"})
		if iz >=3 and iy == 3 then
			minetest.set_node({x=gang.x,y=gang.y+iy+1,z=gang.z+iz},   {name="ocean:prismarine_bricks"})
			minetest.set_node({x=gang.x+1,y=gang.y+iy+1,z=gang.z+iz}, {name="ocean:prismarine_bricks"})
			minetest.set_node({x=gang.x+2,y=gang.y+iy+1,z=gang.z+iz}, {name="ocean:prismarine_bricks"})
		end
	end
 end
end

local function make(pos)
 minetest.log("action", "Created monument at ("..pos.x..","..pos.y..","..pos.z..")")
 for iy=0,10,1 do
	for ix=iy,22-iy,1 do
		for iz=iy,22-iy,1 do
			if iy <1 then minetest.set_node({x=pos.x+ix,y=pos.y,z=pos.z+iz}, {name="ocean:prismarine"}) end
			if ix == iy or ix == 22-iy or iz == iy or iz == 22-iy then
				minetest.set_node({x=pos.x+ix,y=pos.y+iy,z=pos.z+iz}, {name="ocean:prismarine_bricks"})
			else
				minetest.set_node({x=pos.x+ix,y=pos.y+iy,z=pos.z+iz}, {name="ocean:prismarine"})
			end
		end
	end
 end
 minetest.set_node({x=pos.x+10,y=pos.y+11,z=pos.z+10}, {name="ocean:sea_lantern"})
 minetest.set_node({x=pos.x+12,y=pos.y+11,z=pos.z+12}, {name="ocean:sea_lantern"})
 minetest.set_node({x=pos.x+10,y=pos.y+11,z=pos.z+12}, {name="ocean:sea_lantern"})
 minetest.set_node({x=pos.x+12,y=pos.y+11,z=pos.z+10}, {name="ocean:sea_lantern"})
 ocean.make_room(pos)
 minetest.after(2, ocean.make_pillars, pos)
 make_entrance({x=pos.x,y=pos.y, z=pos.z})
end

minetest.register_on_generated(function(minp, maxp, seed)
	if minp.y > 0 then return end
	math.randomseed(seed)
	local cnt = 0

	local perlin1 = minetest.env:get_perlin(perl1.SEED1, perl1.OCTA1, perl1.PERS1, perl1.SCAL1)
	local noise1 = perlin1:get2d({x=minp.x,y=minp.y})--,z=minp.z})
		
	if noise1 < -.2 then
	 local mpos = {x=math.random(minp.x,maxp.x), y=math.random(minp.y,maxp.y), z=math.random(minp.z,maxp.z)}

		local p2 = minetest.find_node_near(mpos, 25, {"default:dirt","default:sand","default:desert_sand","default:stone"})	
		while p2 == nil and cnt < 5 do
			cnt = cnt+1
			mpos = {x=math.random(minp.x,maxp.x), y=math.random(minp.y,maxp.y), z=math.random(minp.z,maxp.z)}
			p2 = minetest.find_node_near(mpos, 25, {"default:dirt","default:sand","default:desert_sand","default:stone"})	
		end
		if p2 == nil then return end
		if p2.y > 0 then return end

		local off = 0
		local opos1 = {x=p2.x+22,y=p2.y-1,z=p2.z+22}
		local opos2 = {x=p2.x+22,y=p2.y-1,z=p2.z}
		local opos3 = {x=p2.x,   y=p2.y-1,z=p2.z+22}
		local opos1_n = minetest.get_node_or_nil(opos1)
		local opos2_n = minetest.get_node_or_nil(opos2)
		local opos3_n = minetest.get_node_or_nil(opos3)
		if opos1_n and opos1_n.name and opos1_n.name == "default:water_source" then
			p2 = ground(opos1, p2)
		end
		if opos2_n and opos2_n.name and opos2_n.name == "default:water_source" then
			p2 = ground(opos2, p2)
		end
		if opos3_n and opos3_n.name and opos3_n.name == "default:water_source" then
			p2 = ground(opos3, p2)
		end
		if minetest.find_node_near({x=p2.x,y=0,z=p2.z}, 22, {"default:dirt_with_grass"}) or minetest.find_node_near({x=p2.x,y=0,z=p2.z}, 80, {"ocean:prismarine"}) then return end
		--local wnode = minetest.get_node_or_nil({x=p2.x,y=-2,z=p2.z})
		--if wnode and wnode.name ~= "water_source" then return end
		if minetest.find_node_near({x=p2.x,y=-2,z=p2.z}, 2, {"default:water_source"}) and minetest.find_node_near({x=p2.x+20,y=-2,z=p2.z+20}, 2, {"default:water_source"}) then
			local raise = math.floor(-p2.y/3)
			if raise > 10 then raise = 10 end
			p2.y = p2.y + raise
			if p2.y > -35 and p2.y < -5 then minetest.after(0.8,make,p2) end
		end
	end
end)


