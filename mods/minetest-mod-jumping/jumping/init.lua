	minetest.register_node("jumping:trampoline", {
		description = "Slime Block",
		paramtype = "light",
		tiles = {
			"slime.png",
		},
		drawtype = "liquid",
		sunlight_propagates = true,
		alpha = 190,
		groups = {level=0, dig_immediate=3, oddly_breakable_by_hand=1, bouncy=50, fall_damage_add_percent=-100},
	})

minetest.register_craft({
	output = "jumping:trampoline",
	recipe = {
		{"mesecons_materials:glue", "mesecons_materials:glue", "mesecons_materials:glue"},
		{"mesecons_materials:glue", "mesecons_materials:glue", "mesecons_materials:glue"},
		{"mesecons_materials:glue", "mesecons_materials:glue", "mesecons_materials:glue"},
	}
})



