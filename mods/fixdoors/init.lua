minetest.register_abm({
	nodenames = {"doors:door_wood_t_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "doors:door_wood_t_1" then
			minetest.set_node({x=pos.x, y=pos.y, z=pos.z}, {name="doors:door_wood_b_1"})
		end
	end,
})
minetest.register_abm({
	nodenames = {"doors:door_wood_t_2"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "doors:door_wood_t_2" then
			minetest.set_node({x=pos.x, y=pos.y, z=pos.z}, {name="doors:door_wood_b_2"})
		end
	end,
})
minetest.register_abm({
	nodenames = {"doors:door_steel_t_1"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "doors:door_steel_t_1" then
			minetest.set_node({x=pos.x, y=pos.y, z=pos.z}, {name="doors:door_steel_b_1"})
		end
	end,
})
minetest.register_abm({
	nodenames = {"doors:door_steel_t_2"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "doors:door_steel_t_2" then
			minetest.set_node({x=pos.x, y=pos.y, z=pos.z}, {name="doors:door_steel_b_2"})
		end
	end,
})

