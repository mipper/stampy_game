local trampoline_punch = function(pos, node)
	local id = string.sub(node.name, #node.name)
	id = id + 1
	if id == 7 then id = 1 end
	minetest.add_node(pos, {name = string.sub(node.name, 1, #node.name - 1)..id})
end

for i = 1, 6 do
	minetest.register_node("jumping:trampoline"..i, {
		description = "Slime block",
		paramtype = "light",
		on_punch = trampoline_punch,
		tiles = {
			"slime.png",
		},
		drawtype = "liquid",
		sunlight_propagates = true,
		alpha = 190,
		groups = {level=0, dig_immediate=3, oddly_breakable_by_hand=1, bouncy=20+i*20, fall_damage_add_percent=-100},
	})
end

minetest.register_craft({
	output = "jumping:trampoline1",
	recipe = {
		{"mesecons_materials:glue", "mesecons_materials:glue", "mesecons_materials:glue"},
		{"mesecons_materials:glue", "mesecons_materials:glue", "mesecons_materials:glue"},
		{"mesecons_materials:glue", "mesecons_materials:glue", "mesecons_materials:glue"},
	}
})



