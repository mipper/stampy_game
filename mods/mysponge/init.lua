local mysponge_table = { -- item, ,desc, image, scale, nodegroup, bright
{"sponge_dry",   "Dry Sponge",    "sponge.png",     "0.5", {dig_immediate=1, oddly_breakable_by_hand=1, flammable=1}},
{"sponge_soaked","Wet Sponge",    "sponge_wet.png", "1",   {dig_immediate=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1}},
}
for i in ipairs(mysponge_table) do
	local item = mysponge_table[i][1]
	local desc = mysponge_table[i][2]
	local image = mysponge_table[i][3]
	local scale = mysponge_table[i][4]
	local nodegroup = mysponge_table[i][5]


minetest.register_node("mysponge:"..item,{
	description = desc,
	tiles = {image},
	paramtype = "light",
	groups = {crumbly=3, level=0, dig_immediate=1}
})

end

local air_nodes = {
	{"air1"},
	{"air2"},
	{"air3"},
	}
for i in ipairs(air_nodes) do
	local airnode = air_nodes[i][1]
minetest.register_node("mysponge:"..airnode,{
--	description = "Air 1",
	tiles = {"mysponge_air.png"},
	drawtype = "allfaces",
	walkable = false,
	pointable = false,
	paramtype = "light",
	groups = {not_in_creative_inventory=1}
})
end


minetest.register_node("mysponge:dry_leaves",{
	description = "Dry Leaves",
	tiles = {"mysponge_dry_leaves.png"},
	drawtype = "allfaces_optional",
	paramtype = "light",
	groups = {dig_immediate=1, oddly_breakable_by_hand=1}
})


-------------------------------------------------------------------------
--ABMs
-------------------------------------------------------------------------
--Set Air

--Air 1
minetest.register_abm({
	nodenames = {"group:water"},
	neighbors = {"mysponge:sponge_dry"},
	interval = 0.5,
	chance = 1,
	action = function(pos)
		minetest.set_node(pos, {name="mysponge:air1"})	
	end
})

--Air 2
minetest.register_abm({
	nodenames = {"group:water"},
	neighbors = {"mysponge:air1"},
	interval = 0.5,
	chance = 1,
	action = function(pos)
		minetest.set_node(pos, {name="mysponge:air2"})	
	end
})

--Air 3
minetest.register_abm({
	nodenames = {"group:water"},
	neighbors = {"mysponge:air2"},
	interval = 0.5,
	chance = 1,
	action = function(pos)
		minetest.set_node(pos, {name="mysponge:air3"})	
	end
})

-------------------------------------------------------------------------
--Set default Air
-------------------------------------------------------------------------

minetest.register_abm({
	nodenames = {"mysponge:air1","mysponge:air2","mysponge:air3"},
	interval = 6,
	chance = 1,
	action = function(pos)
		minetest.set_node(pos, {name="air"})	
	end
})

-------------------------------------------------------------------------
--Set Sponge
-------------------------------------------------------------------------

minetest.register_abm({
	nodenames = {"mysponge:sponge_dry"},
	neighbors = {"mysponge:air1"},
	interval = 3,
	chance = 1,
	action = function(pos)
		minetest.set_node(pos, {name="mysponge:sponge_soaked"})	
	end

})

-------------------------------------------------------------------------------------------------
--Craft

minetest.register_craft({
		type = "cooking",
		output = "default:water_source 3",
		recipe = "mysponge:sponge_soaked",
		cooktime = 5,
		replacements = {{"mysponge:sponge_soaked", "mysponge:sponge_dry"}},
	})
minetest.register_craft({
		type = "cooking",
		output = "mysponge:dry_leaves",
		recipe = "group:leaves",
		cooktime = 3,
	})
minetest.register_craft({
		output = "mysponge:sponge_dry 1",
		recipe = {
			{"mysponge:dry_leaves","mysponge:dry_leaves"},
			{"mysponge:dry_leaves","mysponge:dry_leaves"},
			},
		cooktime = 3,
	})



