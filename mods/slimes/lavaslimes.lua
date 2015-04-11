-- sounds
local lava_sounds = {
	damage = { file = "green_slime_damage", gain = 0.25},
	death = { file = "green_slime_death", gain = 0.25},
	jump = { file = "green_slime_jump", gain = 0.25},
	land = { file = "green_slime_land", gain = 0.25},
	attack = { file = "green_slime_attack", gain = 0.25},
	random = {}
}
-- textures : top, bottom, front, back, left, right
local lava_textures = {"lava_slime_top.png", "lava_slime_bottom.png", "lava_slime_front.png", "lava_slime_sides.png", "lava_slime_sides.png", "lava_slime_sides.png"}

slimes:register_slime ("slimes:lavabig", {
	type = "monster",
	class ="lava",
	name = "slimes:lavabig",
	passive = false,
	size = 2,
	max_hp = 6,
	damage = 3,
	sounds = lava_sounds,
	textures = lava_textures,
	blood = "lava_slime_blood.png",
	gravity = 9.8,
	drops = {
		type = "entity",
		name = "slimes:lavamedium",
		chance = 0, min = 1, max = 2},
	-- damage by
	water_damage = 10,
	lava_damage = 0,
	light_damage = 0,
	fall_damage = 0,
	spawn = "nether:rack"
})
slimes:register_slime ("slimes:lavamedium", {
	type = "monster",
	class ="lava",
	name = "slimes:lavamedium",
	passive = false,
	size = 1,
	max_hp = 4,
	damage = 2,
	sounds = lava_sounds,
	textures = lava_textures,
	blood = "lava_slime_blood.png",
	gravity = 9.8,
	drops = {
		type = "entity",
		name = "slimes:lavasmall",
		chance = 0, min = 1, max = 4},
	-- damage by
	water_damage = 10,
	lava_damage = 0,
	light_damage = 0,
	fall_damage = 0,
	spawn = "nether:rack"
})
slimes:register_slime ("slimes:lavasmall", {
	type = "monster",
	class ="lava",
	name = "slimes:lavasmall",
	passive = false,
	size = 0.5,
	max_hp = 2,
	damage = 1,
	sounds = lava_sounds,
	textures = lava_textures,
	blood = "lava_slime_blood.png",
	gravity = 9.8,
	drops = {
		type = "item",
		name = "tnt:gunpowder 1",
		chance = 4, min = 1, max = 2},
	-- damage by
	water_damage = 10,
	lava_damage = 0,
	light_damage = 0,
	fall_damage = 0,
	spawn = "nether:rack"
})

slimes:register_spawn("slimes:lavabig", {"nether:rack"},{"air","nether:rack"}, 20, 4, 5000, 8, -5000)
slimes:register_spawn("slimes:lavamedium", {"nether:rack"},{"air","nether:rack"}, 20, 4, 10000, 8, -5000)
slimes:register_spawn("slimes:lavasmall", {"nether:rack"},{"air","nether:rack"}, 20, 4, 15000, 8, -5000)

