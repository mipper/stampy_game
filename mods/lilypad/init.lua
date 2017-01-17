-- adapted from plantlife modpack

minetest.register_node("lilypad:waterlily", {
	description = "Lily Pad",
	drawtype = "nodebox",
	tiles = { 
		"waterlily.png"
	},
	inventory_image = "waterlily.png",
	wield_image  = "waterlily.png",
	sunlight_propagates = true,
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = true,
	groups = {snappy = 3,flammable=2, level=0, dig_immediate=3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.4, -0.5, -0.4, 0.4, -0.45, 0.4 },
	},
	node_box = {
		type = "fixed",
		fixed = { -0.5, -0.49, -0.5, 0.5, -0.49, 0.5 },
	},
	buildable_to = true,
	liquids_pointable = true,
	on_place = function(itemstack, placer, pointed_thing)
		local pt = pointed_thing
		local top_pos = {x=pt.under.x, y=pt.under.y+1, z=pt.under.z}
		local under_node = minetest.get_node(pt.under)

		if under_node.name ~= "default:water_source" then return end

		math.randomseed(top_pos.x + top_pos.y + top_pos.z)
		minetest.set_node(top_pos, {name = "lilypad:waterlily", param2 = math.random(0,3)})
		math.randomseed(os.time())
		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
		end
})

minetest.register_alias("flowers:waterlily", "lilypad:waterlily")

