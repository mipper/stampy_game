minetest.register_node("sponge:sponge_wet",{
	description = "Wet Sponge",
	tiles = {"sponge_wet.png"},
	paramtype = "light",
	groups = {crumbly=3, level=0, dig_immediate=3, oddly_breakable_by_hand=1}
})

minetest.register_node("sponge:sponge_dry",{
	description = "Dry Sponge",
	tiles = {"sponge.png"},
	paramtype = "light",
	groups = {crumbly=3, level=0, dig_immediate=1, oddly_breakable_by_hand=1, flammable=1},
	after_place_node = function(pos, placer, itemstack)
			local vm = minetest.get_voxel_manip()
			local p1 = {x=pos.x-17,y=pos.y-17,z=pos.z-17}
			local p2 = {x=pos.x+17,y=pos.y+17,z=pos.z+17}
			local emin, emax = vm:read_from_map(p1, p2)
			local data = vm:get_data()
			local area = VoxelArea:new{ MinEdge = emin, MaxEdge = emax }
			local c_air = minetest.get_content_id("air")
			local c_w = minetest.get_content_id("water_flowing")
			local c_ws = minetest.get_content_id("water_source")
			local c_sw = minetest.get_content_id("sponge:sponge_wet")
			local iswet = false
			local dist = 0
			for x=pos.x-7,pos.x+7,1 do
				for z=pos.z-7,pos.z+7,1 do
					for y=pos.y-7,pos.y+7,1 do
						local p_pos = area:index(x, y, z)
						dist = math.abs(x-pos.x) + math.abs(y-pos.y) + math.abs(z-pos.z)
						if (data[p_pos] == c_w or data[p_pos] == c_ws) and dist <= 7 then
							data[p_pos] = c_air
							iswet = true
						end
					end
				end
			end
			if iswet then
				data[area:index(pos.x, pos.y, pos.z)] = c_sw
			end
			vm:set_data(data)
			vm:calc_lighting()
			vm:update_liquids()
			vm:write_to_map()
			vm:update_map()
			return false
	end,	
})

minetest.register_node("sponge:dry_leaves",{
	description = "Dry Leaves",
	tiles = {"sponge_dry_leaves.png"},
	drawtype = "allfaces_optional",
	paramtype = "light",
	groups = {dig_immediate=1, oddly_breakable_by_hand=1}
})

-------------------------------------------------------------------------------------------------
--Craft

minetest.register_craft({
		type = "cooking",
		output = "sponge:sponge_dry 1",
		recipe = "sponge:sponge_wet",
		cooktime = 5,
	})
minetest.register_craft({
		type = "cooking",
		output = "sponge:dry_leaves",
		recipe = "group:leaves",
		cooktime = 3,
	})
minetest.register_craft({
		output = "sponge:sponge_dry 1",
		recipe = {
			{"sponge:dry_leaves","sponge:dry_leaves"},
			{"sponge:dry_leaves","sponge:dry_leaves"},
			},
		cooktime = 3,
	})



