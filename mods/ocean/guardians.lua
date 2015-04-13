-- textures: top, bottom, front, back, left, right
local guardian_textures = {"guardian_side1.png", "guardian_side1.png", "guardian_front.png", "guardian_side2.png", "guardian_side2.png", "guardian_side3.png"}

ocean:register_guardian ("ocean:guardian", {
	name = "ocean:guardian",
	type = "monster",
	passive = false,
	size = 1,
	textures = guardian_textures,
	gravity = 0,
	max_hp = 12,
	damage = 4,
	drop = "ocean:prismarine 1",
	drops = {	
		type = "item",
		name = "ocean:prismarine",
		chance = 2, min = 1, max = 2},
	-- damage by
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
	fall_damage = 0,
	-- spawn block
	spawn = "ocean:prismarine"
})
ocean:register_spawn("ocean:guardian", {"default:water_source"},{"ocean:prismarine_bricks","ocean:prismarine"}, 20, 0, 20, 8, 0)


