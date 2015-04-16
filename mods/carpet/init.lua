-- Carpet Mod!
-- By Jordan Snelling 2012
-- License LGPL
-- This mod adds carpets into Minetest.

for _, row in ipairs(dye.dyes) do
	local name = row[1]
	local cname = "carpet:"..name
	local wname = "wool:"..name
	local img = "wool_"..name..".png"
	local str = name.." Carpet"
	str = string.gsub(str, "_", " ")
	local desc = string.gsub(" "..str, "%W%l", string.upper):sub(2)
minetest.register_node(cname, {
	description = desc,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5,  0.5, -0.5+.5/16, 0.5},
		},
	},
	tiles = {img},
	inventory_image = img,
	wield_image = img,
	paramtype = "light",
	is_ground_content = true,
	walkable = false,
	buildable_to = true,
	selection_box = {
		type = "fixed", 
                fixed = {-1/2, -1/2, -1/2, 1/2, -1/2+.5/16, 1/2},
	},
	groups = {dig_immediate=2},
})
minetest.register_craft({
	output = cname..' 3',
	recipe = {
		{wname, wname},
	}
})
end


