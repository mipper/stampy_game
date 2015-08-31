mg = {}

local ENABLE_SNOW = false
local DEBUG = false

local DMAX = 20
local AREA_SIZE = 80

dofile(minetest.get_modpath(minetest.get_current_modname()).."/nodes.lua")
c_air = minetest.get_content_id("air")
c_ignore = minetest.get_content_id("ignore")
c_water = minetest.get_content_id("default:water_source")
c_grass  = minetest.get_content_id("default:dirt_with_grass")
c_dry_grass  = minetest.get_content_id("mg:dirt_with_dry_grass")
c_dirt_snow  = minetest.get_content_id("default:dirt_with_snow")
c_snow  = minetest.get_content_id("default:snow")
c_sapling  = minetest.get_content_id("default:sapling")
c_tree  = minetest.get_content_id("default:tree")
c_leaves  = minetest.get_content_id("default:leaves")
c_junglesapling  = minetest.get_content_id("default:junglesapling")
c_jungletree  = minetest.get_content_id("default:jungletree")
c_jungleleaves  = minetest.get_content_id("default:jungleleaves")
c_savannasapling  = minetest.get_content_id("mg:savannasapling")
c_savannatree = minetest.get_content_id("mg:savannatree")
c_savannaleaves  = minetest.get_content_id("mg:savannaleaves")
c_pinesapling  = minetest.get_content_id("mg:pinesapling")
c_pinetree = minetest.get_content_id("mg:pinetree")
c_pineleaves  = minetest.get_content_id("mg:pineleaves")
c_dirt  = minetest.get_content_id("default:dirt")
c_stone  = minetest.get_content_id("default:stone")
c_water  = minetest.get_content_id("default:water_source")
c_ice  = minetest.get_content_id("default:ice")
c_sand  = minetest.get_content_id("default:sand")
c_sandstone  = minetest.get_content_id("default:sandstone")
c_desert_sand  = minetest.get_content_id("default:desert_sand")
c_desert_stone  = minetest.get_content_id("default:desert_stone")
c_snowblock  = minetest.get_content_id("default:snowblock")
c_cactus  = minetest.get_content_id("default:cactus")
c_grass_1  = minetest.get_content_id("default:grass_1")
c_grass_2  = minetest.get_content_id("default:grass_2")
c_grass_3  = minetest.get_content_id("default:grass_3")
c_grass_4  = minetest.get_content_id("default:grass_4")
c_grass_5  = minetest.get_content_id("default:grass_5")
c_grasses = {c_grass_1, c_grass_2, c_grass_3, c_grass_4, c_grass_5}
c_jungle_grass  = minetest.get_content_id("default:junglegrass")
c_dry_shrub  = minetest.get_content_id("default:dry_shrub")
c_papyrus  = minetest.get_content_id("default:papyrus")


local cache = {}


local function get_vn(x, z, noise, village)
	local vx, vz, vs = village.vx, village.vz, village.vs
	return (noise - 2) * 20 +
		(40 / (vs * vs)) * ((x - vx) * (x - vx) + (z - vz) * (z - vz))
end


local function get_base_surface_at_point(x, z, vnoise, villages, ni, noise1, noise2, noise3, noise4)
	local index = 65536*x+z
	if cache[index] ~= nil then return cache[index] end
	cache[index] = 25*noise1[ni]+noise2[ni]*noise3[ni]/3
	if noise4[ni] > 0.8 then
		cache[index] = cliff(cache[index], noise4[ni]-0.8)
	end
	local s = 0
	local t = 0
	local noise = vnoise[ni]
	for _, village in ipairs(villages) do
		local vn = get_vn(x, z, noise, village)
		if vn < 40 then
			cache[index] = village.vh
			return village.vh
		elseif vn < 200 then
			s = s + ((cache[index] * (vn - 40) + village.vh * (200 - vn)) / 160) / (vn - 40)
			t = t + 1 / (vn - 40)
		end
	end
	if t > 0 then
		cache[index] = s / t
	end
	return cache[index]
end

local function surface_at_point(x, z, ...)
	return get_base_surface_at_point(x, z, unpack({...}))
end


function inside_village(x, z, village, vnoise)
	return get_vn(x, z, vnoise:get2d({x = x, y = z}), village) <= 40
end

local wseed
minetest.register_on_mapgen_init(function(mgparams)
	wseed = math.floor(mgparams.seed/10000000000)
end)
function get_bseed(minp)
	return wseed + math.floor(5*minp.x/47) + math.floor(873*minp.z/91)
end

function get_bseed2(minp)
	return wseed + math.floor(87*minp.x/47) + math.floor(73*minp.z/91) + math.floor(31*minp.y/12)
end


dofile(minetest.get_modpath(minetest.get_current_modname()).."/we.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/rotate.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/buildings.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/villages.lua")

local function get_distance(x1, x2, z1, z2)
	return (x1-x2)*(x1-x2)+(z1-z2)*(z1-z2)
end


local function get_perlin_map(seed, octaves, persistance, scale, minp, maxp)
	local sidelen = maxp.x - minp.x +1
	local pm = minetest.get_perlin_map(
                {offset=0, scale=1, spread={x=scale, y=scale, z=scale}, seed=seed, octaves=octaves, persist=persistance},
                {x=sidelen, y=sidelen, z=sidelen}
        )
        return pm:get2dMap_flat({x = minp.x, y = minp.z, z = 0})
end

local function copytable(t)
	local t2 = {}
	for key, val in pairs(t) do
		t2[key] = val
	end
	return t2
end

local function mg_generate(minp, maxp, emin, emax, vm)
	local a = VoxelArea:new{
		MinEdge={x=emin.x, y=emin.y, z=emin.z},
		MaxEdge={x=emax.x, y=emax.y, z=emax.z},
	}
	
	local treemin = {x=emin.x, y=minp.y, z=emin.z}
	local treemax = {x=emax.x, y=maxp.y, z=emax.z}
	
	local sidelen = maxp.x-minp.x+1
	
	local noise1 = get_perlin_map(12345, 6, 0.5, 256, minp, maxp)
	local noise2 = get_perlin_map(56789, 6, 0.5, 256, minp, maxp)
	local noise3 = get_perlin_map(42, 3, 0.5, 32, minp, maxp)
	local noise4 = get_perlin_map(8954, 8, 0.5, 1024, minp, maxp)
	
	local noise1raw = minetest.get_perlin(12345, 6, 0.5, 256)
	
	local vcr = VILLAGE_CHECK_RADIUS
	local villages = {}
	for xi = -vcr, vcr do
	for zi = -vcr, vcr do
		for _, village in ipairs(villages_at_point({x = minp.x + xi * 80, z = minp.z + zi * 80}, noise1raw)) do
			village.to_grow = {}
			villages[#villages+1] = village
		end
	end
	end
	
	
	local pr = PseudoRandom(get_bseed(minp))
	
	local village_noise = minetest.get_perlin(7635, 3, 0.5, 16)
	local village_noise_map = get_perlin_map(7635, 3, 0.5, 16, minp, maxp)
	local va = VoxelArea:new{MinEdge=minp, MaxEdge=maxp}
	local data = vm:get_data()
	local param2_data = vm:get_param2_data()
	
	for _, village in ipairs(villages) do
		village.to_add = generate_village(village, minp, maxp, data, param2_data, a, village_noise)
	end

	vm:set_data(data)
	vm:set_param2_data(param2_data)

	vm:calc_lighting(
		{x = minp.x - 16, y = minp.y, z = minp.z - 16},
		{x = maxp.x + 16, y = maxp.y, z = maxp.z + 16}
	)

	vm:write_to_map(data)

	local meta
	for _, village in ipairs(villages) do
	for _, n in pairs(village.to_add) do
		minetest.set_node(n.pos, n.node)
		if n.meta ~= nil then
			meta = minetest.get_meta(n.pos)
			meta:from_table(n.meta)
			if n.node.name == "default:chest" then
				local inv = meta:get_inventory()
				local items = inv:get_list("main")
				for i = 1, inv:get_size("main") do
					inv:set_stack("main", i, ItemStack(""))
				end
				local numitems = pr:next(3, 20)
				for i = 1, numitems do
					local ii = pr:next(1, #items)
					local prob = items[ii]:get_count() % 2 ^ 8
					local stacksz = math.floor(items[ii]:get_count() / 2 ^ 8)
					if pr:next(0, prob) == 0 and stacksz>0 then
						local stk = ItemStack({
							name = items[ii]:get_name(),
							count = pr:next(1, stacksz),
							wear = items[ii]:get_wear(),
							metadata = items[ii]:get_metadata()
						})
						local ind = pr:next(1, inv:get_size("main"))
						while not inv:get_stack("main", ind):is_empty() do
							ind = pr:next(1, inv:get_size("main"))
						end
						inv:set_stack("main", ind, stk)
					end
				end
			end
		end
	end
	end
end

minetest.register_on_generated(function(minp, maxp, seed)
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	mg_generate(minp, maxp, emin, emax, vm)
end)

