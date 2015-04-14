minetest.register_node("hopper:hopper", {
	description = "Hopper",
	drawtype = "normal",
	tiles = {"hopper_top.png", "hopper_outside.png", "hopper_outside.png", "hopper_outside.png", "hopper_outside.png", "hopper_outside.png"},
	inventory_image = "hopper.png",
	groups = {cracky=2,level=1},
})

minetest.register_abm({
	nodenames = {"hopper:hopper"},
	interval = 2,
	chance = 1,
	action = function(pos, node)
		local objs = minetest.env:get_objects_inside_radius({x=pos.x, y=pos.y+1, z=pos.z}, .8)
		for i, obj in ipairs(objs) do
			if not obj:is_player() then
				local o = obj:get_luaentity()
				if o.get_staticdata then
					local q = o:get_staticdata()
					local p = minetest.deserialize(q)
					local stack = ItemStack(p.itemstring)
					local cpos = minetest.find_node_near(pos, 1.5, {"default:chest"})
					if cpos then
						local meta = minetest.env:get_meta(cpos)
						local inv = meta:get_inventory()
						if inv:room_for_item("main", stack) then
							inv:add_item("main", stack)
							obj:remove()
						end
					end
				end
			end
		end
	end
})


minetest.register_craft({
	output = 'hopper:hopper',
	recipe = {
		{'default:steel_ingot', '',                    'default:steel_ingot'},
		{'default:steel_ingot', 'default:chest',       'default:steel_ingot'},
		{'',                    'default:steel_ingot', ''},
	}
})


