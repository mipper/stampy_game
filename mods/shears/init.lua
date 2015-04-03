minetest.register_tool("shears:shears", {
    description = "Shears",
    inventory_image = "shears.png",
    tool_capabilities = {
	stack_max = 1,
	max_drop_level=3,
        groupcaps= {
	        full_punch_interval = 0.5,
	        max_drop_level=1,
		crumbly={times={[1]=5.00, [2]=3.50, [3]=3.00}, uses=80, maxlevel=1},
		leaves={times={[1]=0,[2]=0,[3]=0}, uses=283, maxlevel=1},
		wool={times={[1]=0.2,[2]=0.2,[3]=0.2}, uses=283, maxlevel=1},
		snappy={times={[1]=0.2,[2]=0.2,[3]=0.2}, uses=283, maxlevel=1},
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

