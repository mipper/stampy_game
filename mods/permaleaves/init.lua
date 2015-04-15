minetest.register_node("permaleaves:leaves", {
	description = "Permanent Leaves",
	drawtype = "allfaces_optional",
	visual_scale = 1.3,
	tiles = {"default_leaves.png"},
	paramtype = "light",
	waving = 1,
	is_ground_content = false,
	groups = {snappy=3, flammable=2, leaves=1},
	sounds = default.node_sound_leaves_defaults(),
})
