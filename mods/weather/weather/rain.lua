rain_sounds = {}
rain_inside = {}

local function find_glass(pos)
	for i=1,12 do
		if minetest.get_node({x=pos.x, y=pos.y+i, z=pos.z}).name ~= "air" then
			return true
		end
	end
	return false
end

-- Rain
minetest.register_globalstep(function(dtime)
	if weather ~= "rain" then
		for _, player in ipairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			if rain_sounds[name] then
				minetest.sound_stop(rain_sounds[name])
				rain_sounds[name] = nil
			end
		end
		return
	end
	for _, player in ipairs(minetest.get_connected_players()) do
		local ppos = player:getpos()
		local name = player:get_player_name()
		local desnode = {"default:desert_sand", "default:desert_stone"}
		local inside = find_glass(ppos)

		-- Make sure player is not in a cave/house...
		local ppos2 = addvectors(ppos, {x=0, y=12, z=0})
		if minetest.find_node_near(ppos, 14, desnode) or (minetest.get_node_light(ppos, 0.5) and minetest.get_node_light(ppos, 0.5) < 3) or ppos.y < -5 then
			if rain_sounds[name] then
				minetest.sound_stop(rain_sounds[name])
				rain_sounds[name] = nil
			end
			return
		end

		if not rain_sounds[name] or inside ~= rain_inside[name] then
			if rain_sounds[name] then
				minetest.sound_stop(rain_sounds[name])
				rain_sounds[name] = nil
			end
			if not inside then
				rain_sounds[name] = minetest.sound_play("rain", {to_player = name, loop = true})
			else
				rain_sounds[name] = minetest.sound_play("rain_inside", {to_player = name, loop = true})
			end
			rain_inside[name] = inside
		end

		-- from https://github.com/xeranas/weather_pack:

		for i=35, 1,-1 do
			local random_pos_x, random_pos_y, random_pos_z = get_random_pos_by_player_look_dir(player)
			if minetest.get_node_light({x=random_pos_x, y=random_pos_y, z=random_pos_z}, 0.5) == 15 then
				minetest.add_particle({
				pos = {x=random_pos_x, y=random_pos_y, z=random_pos_z},
				velocity = {x=0, y=-10, z=0},
				acceleration = {x=0, y=-30, z=0},
				expirationtime = 0.2,
				size = math.random(0.5, 3),
				collisiondetection = true,
				collision_removal = true,
				vertical = true,
				texture = "rain_raindrop_"..math.random(1, 3)..".png",
				playername = player:get_player_name()
				})
			end
		end
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

