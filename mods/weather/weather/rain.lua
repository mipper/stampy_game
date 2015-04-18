-- Rain
minetest.register_globalstep(function(dtime)
	if weather ~= "rain" then return end
	for _, player in ipairs(minetest.get_connected_players()) do
		local ppos = player:getpos()

		-- Make sure player is not in a cave/house...
		if minetest.env:get_node_light(ppos, 0.5) ~= 15 then return end

		local minp = addvectors(ppos, {x=-9, y=7, z=-9})
		local maxp = addvectors(ppos, {x= 9, y=7, z= 9})

		local vel = {x=0, y=   -4, z=0}
		local acc = {x=0, y=-9.81, z=0}

		minetest.add_particlespawner({amount=25, time=0.5,
			minpos=minp, maxpos=maxp,
			minvel=vel, maxvel=vel,
			minacc=acc, maxacc=acc,
			minexptime=0.8, maxexptime=0.8,
			minsize=25, maxsize=25,
			collisiondetection=false, vertical=true, texture="weather_rain.png", player=player:get_player_name()})
	end
end)

minetest.register_abm({
	nodenames = {"fire:basic_flame"},
	interval = 8,
	chance = 1,
	action = function (pos, node, active_object_count, active_object_count_wider)
		if weather == "rain" and minetest.get_node_light(pos, 0.5) > 3 then
			minetest.remove_node(pos)
		end
	end
})

