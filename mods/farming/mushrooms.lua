minetest.register_node("farming:mushroom_brown", {
	description = "Mushroom",
	drawtype = "plantlike",
	tiles = { "farming_mushroom_brown.png" },
	inventory_image = "farming_mushroom_brown.png",
	wield_image = "farming_mushroom_brown.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	light_source = 2,
	groups = {snappy=3,flammable=2,mushroom=1,attached_node=1, dig_immediate=3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.015, 0.15 },
	},
})

minetest.register_node("farming:mushroom_red", {
	description = "Mushroom",
	drawtype = "plantlike",
	tiles = { "farming_mushroom_red.png" },
	inventory_image = "farming_mushroom_red.png",
	wield_image = "farming_mushroom_red.png",
	sunlight_propagates = true,
	paramtype = "light",
	walkable = false,
	groups = {snappy=3,flammable=2,mushroom=1,attached_node=1, dig_immediate=3, oddly_breakable_by_hand=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = { -0.15, -0.5, -0.15, 0.15, 0.015, 0.15 },
	},
})

minetest.register_craftitem("farming:mushroom_stew", {
	description = "Mushroom Stew",
        inventory_image = "farming_mushroom_stew.png",
	on_use = minetest.item_eat(6),
	stack_max = 64,
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:mushroom_stew",
	recipe = {'food:bowl', 'farming:mushroom_brown', 'farming:mushroom_red'}
})

minetest.register_abm({
	nodenames = {"default:dirt", "default:dirt_with_grass"},
	interval = 10,
	chance = 2000,
	action = function(pos, node, active_object_count, active_object_count_wider)
			local np = addvectors(pos, {x=0, y=1, z=0})
			if minetest.get_node(np).name ~= "air" then return end
			local p0 = {x=np.x-8, y=np.y-8, z=np.z-8}
			local p1 = {x=np.x+8, y=np.y+8, z=np.z+8}
			local count = #minetest.find_nodes_in_area(p0, p1, {"group:mushroom"})
			if count > 5 then return end
			if minetest.get_node_light(np, 0.5) < 13 then
				if math.random(1,2) == 1 then
					minetest.set_node(np, {name="farming:mushroom_brown"})
				else
					minetest.set_node(np, {name="farming:mushroom_red"})
				end
			end
	end,
})


