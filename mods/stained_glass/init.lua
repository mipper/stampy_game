for _, row in ipairs(dye.dyes) do
	local name = row[1]
	local cname = "stained_glass:"..name
	local wname = "dye:"..name
	local img = "glass_"..name..".png"
	local str = name.." Stained Glass"
	str = string.gsub(str, "_", " ")
	local desc = string.gsub(" "..str, "%W%l", string.upper):sub(2)
	minetest.register_node(cname, {
		description = desc,
		drawtype = "glasslike",
		tiles = {img},
		paramtype = "light",
		sunlight_propagates = true,
		use_texture_alpha = true,
		is_ground_content = true,
		groups = {cracky=3, oddly_breakable_by_hand=3},
		sounds = default.node_sound_glass_defaults(),
	})
	minetest.register_craft({
		output = cname..' 8',
		recipe = {
			{"default:glass", "default:glass", "default:glass"},
			{"default:glass", wname,           "default:glass"},
			{"default:glass", "default:glass", "default:glass"},
		}
	})
end


