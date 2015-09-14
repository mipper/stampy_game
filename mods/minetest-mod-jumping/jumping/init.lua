	minetest.register_node("jumping:trampoline", {
		description = "Slime Block",
		paramtype = "light",
		tiles = {
			"slime.png",
		},
		drawtype = "glasslike",
		sunlight_propagates = true,
		use_texture_alpha = true,
		is_ground_content = true,
		groups = {level=0, dig_immediate=3, oddly_breakable_by_hand=1, bouncy=90, fall_damage_add_percent=-100},
	})

minetest.register_craft({
	output = "jumping:trampoline",
	recipe = {
		{"mesecons_materials:glue", "mesecons_materials:glue", "mesecons_materials:glue"},
		{"mesecons_materials:glue", "mesecons_materials:glue", "mesecons_materials:glue"},
		{"mesecons_materials:glue", "mesecons_materials:glue", "mesecons_materials:glue"},
	}
})



