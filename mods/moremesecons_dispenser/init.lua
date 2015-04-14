local function drop_chest_stuff()
	return function(pos, oldnode, oldmetadata, digger)
		local meta = minetest.env:get_meta(pos)
		meta:from_table(oldmetadata)
		local inv = meta:get_inventory()
		for i=1,inv:get_size("main") do
			local stack = inv:get_stack("main", i)
			if not stack:is_empty() then
				local p = {x=pos.x+math.random(0, 5)/5-0.5, y=pos.y, z=pos.z+math.random(0, 5)/5-0.5}
				minetest.add_item(p, stack)
			end
		end
	end
end

minetest.register_node("moremesecons_dispenser:dropper", {
	description = "Dropper",
	tiles = {
		"default_furnace_top.png",  "default_furnace_bottom.png",
		"default_furnace_side.png", "default_furnace_side.png",
		"default_furnace_side.png", "dropper_front_horizontal.png",
	},
	groups = {snappy = 2, oddly_breakable_by_hand = 3},
	paramtype2 = "facedir",
	mesecons = {effector = {
		action_on = function (pos, node)
			local dir = minetest.facedir_to_dir(node.param2)
			local pos_under, pos_above = {x=pos.x - dir.x, y=pos.y - dir.y, z=pos.z - dir.z},
								{x=pos.x - 2*dir.x, y=pos.y - 2*dir.y, z=pos.z - 2*dir.z}
			nodeupdate(pos)
			
			local inv = minetest.get_meta(pos):get_inventory()
			local invlist = inv:get_list("main")
			minetest.sound_play("click3", {pos = pos})
			for i, stack in ipairs(invlist) do
				if stack:get_name() ~= nil and stack:get_name() ~= "" then --obtain the first non-empty item slot
					minetest.env:add_item(pos_under, stack:take_item())
					inv:set_stack("main", i, stack)
					return
				end
			end
		end
	}},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",	"invsize[8,9;]"..
									"list[context;main;0,0;8,4;]"..
									"list[current_player;main;0,4;8,4;]")
		local inv = meta:get_inventory()
		inv:set_size("main", 4*8)
	end,
	after_dig_node = drop_chest_stuff(),
})



minetest.register_node("moremesecons_dispenser:dispenser", {
	description = "Dispenser",
	tiles = {
		"default_furnace_top.png",  "default_furnace_bottom.png",
		"default_furnace_side.png", "default_furnace_side.png",
		"default_furnace_side.png", "dispenser_front_horizontal.png",
	},
	groups = {snappy = 2, oddly_breakable_by_hand = 3},
	paramtype2 = "facedir",
	mesecons = {effector = {
		action_on = function (pos, node)
			local dir = minetest.facedir_to_dir(node.param2)
			local pos_under, pos_above = {x=pos.x - dir.x, y=pos.y - dir.y, z=pos.z - dir.z},
								{x=pos.x - 2*dir.x, y=pos.y - 2*dir.y, z=pos.z - 2*dir.z}
			nodeupdate(pos)
			
			local inv = minetest.get_meta(pos):get_inventory()
			local invlist = inv:get_list("main")
			for i, stack in ipairs(invlist) do
				if stack:get_name() ~= nil and stack:get_name() ~= "" then --obtain the first non-empty item slot
					minetest.sound_play("click1", {pos = pos})
					if stack:get_name() == "bucket:bucket_water" then
						minetest.set_node(pos_under, {name="default:water_source"})
						inv:set_stack("main", i, "bucket:bucket_empty")
						return
					end
					if stack:get_name() == "bucket:bucket_lava" then
						minetest.set_node(pos_under, {name="default:lava_source"})
						inv:set_stack("main", i, "bucket:bucket_empty")
						return
					end
					if stack:get_name() == "throwing:arrow" then
						local obj = minetest.env:add_entity(pos_under, "throwing:arrow_entity")
						obj:setvelocity({x=-dir.x*22, y=0, z=-dir.z*22})
						obj:setacceleration({x=-dir.x*-3, y=-10, z=-dir.z*-3})
						obj:setyaw(math.atan(dir.x/dir.z) - math.pi/2)
						minetest.sound_play("throwing_sound", {pos=pos})
						stack:take_item()
						inv:set_stack("main", i, stack)
						return
					end
					minetest.env:add_item(pos_under, stack:take_item())
					inv:set_stack("main", i, stack)
					return
				end
			end
			minetest.sound_play("click2", {pos = pos})
		end
	}},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",	"invsize[8,9;]"..
									"list[context;main;0,0;8,4;]"..
									"list[current_player;main;0,4;8,4;]")
		local inv = meta:get_inventory()
		inv:set_size("main", 4*8)
	end,
	after_dig_node = drop_chest_stuff(),
})


minetest.register_craft({
	output = 'moremesecons_dispenser:dropper',
	recipe = {
		{'default:cobble', 'default:cobble',      'default:cobble'},
		{'default:cobble', '',                    'default:cobble'},
		{'default:cobble', 'default:mese_crystal','default:cobble'},
	}
})


minetest.register_craft({
	output = 'moremesecons_dispenser:dispenser',
	recipe = {
		{'default:cobble', 'default:cobble',      'default:cobble'},
		{'default:cobble', 'throwing:bow_wood',   'default:cobble'},
		{'default:cobble', 'default:mese_crystal','default:cobble'},
	}
})



