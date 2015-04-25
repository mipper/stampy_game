-- start pressure plate timers
minetest.register_abm({
	nodenames = {"mesecons_pressureplates:pressure_plate_wood_off", "mesecons_pressureplates:pressure_plate_stone_off"},
	interval = 10,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
			local timer = minetest.get_node_timer(pos)
			if not timer:is_started() then
				timer:start(tripwire_interval)
			end
	end,
})


