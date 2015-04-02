minetest.register_tool("shears:shears", {
    description = "Shears",
    inventory_image = "shears.png",
    tool_capabilities = {
        max_drop_level=3,
        groupcaps= {
            crumbly={times={[1]=5.00, [2]=3.50, [3]=3.00}, uses=80, maxlevel=1}
        }
    }
})

minetest.register_craft({
	output = "shears:shears",
	recipe = {
		{"", "default:steel_ingot"},
		{"default:steel_ingot", ""},
	}
})

