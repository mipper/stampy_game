--Blue Beam
minetest.register_node("beacon:bluebase", {
	visual_scale = 1.0,
	drawtype = "plantlike",
	tiles = {"bluebase.png"},
	paramtype = "light",
	walkable = false,
	diggable = false,
	light_source = 13,
	groups = {not_in_creative_inventory=1}
})

minetest.register_node("beacon:bluebeam", {
	visual_scale = 1.0,
	drawtype = "plantlike",
	tiles = {"bluebeam.png"},
	paramtype = "light",
	walkable = false,
	diggable = false,
	light_source = 50,
	groups = {not_in_creative_inventory=1}
})

minetest.register_abm({
	nodenames = {"beacon:bluebase"}, --makes small particles emanate from the beginning of a beam
	interval = 1,
	chance = 2,
	action = function(pos, node)
		minetest.add_particlespawner({
			amount = 32,
			time = 4,
			minpos = {x=pos.x-0.25, y=pos.y-0.25, z=pos.z-0.25},
			maxpos = {x=pos.x+0.25, y=pos.y+0.25, z=pos.z+0.25},
			minvel = {x=-0.8, y=-0.8, z=-0.8},
			maxvel = {x=0.8, y=0.8, z=0.8},
			minacc = {x=0,y=0,z=0},
			maxacc = {x=0,y=0,z=0},
			minexptime = 0.5,
			maxexptime = 1,
			minsize = 1,
			maxsize = 2,
			collisiondetection = false,
			texture = "blueparticle.png",
		})
	end,
})

--Red Beam
minetest.register_node("beacon:redbase", {
	visual_scale = 1.0,
	drawtype = "plantlike",
	tiles = {"redbase.png"},
	paramtype = "light",
	walkable = false,
	diggable = false,
	light_source = 13,
	groups = {not_in_creative_inventory=1}
})

minetest.register_node("beacon:redbeam", {
	visual_scale = 1.0,
	drawtype = "plantlike",
	tiles = {"redbeam.png"},
	paramtype = "light",
	walkable = false,
	diggable = false,
	light_source = 50,
	groups = {not_in_creative_inventory=1}
})

minetest.register_abm({
	nodenames = {"beacon:redbase"}, --makes small particles emanate from the beginning of a beam
	interval = 1,
	chance = 2,
	action = function(pos, node)
		minetest.add_particlespawner({
			amount = 32,
			time = 4,
			minpos = {x=pos.x-0.25, y=pos.y-0.25, z=pos.z-0.25},
			maxpos = {x=pos.x+0.25, y=pos.y+0.25, z=pos.z+0.25},
			minvel = {x=-0.8, y=-0.8, z=-0.8},
			maxvel = {x=0.8, y=0.8, z=0.8},
			minacc = {x=0,y=0,z=0},
			maxacc = {x=0,y=0,z=0},
			minexptime = 0.5,
			maxexptime = 1,
			minsize = 1,
			maxsize = 2,
			collisiondetection = false,
			texture = "redparticle.png",
		})
	end,
})

--Green Beam
minetest.register_node("beacon:greenbase", {
	visual_scale = 1.0,
	drawtype = "plantlike",
	tiles = {"greenbase.png"},
	paramtype = "light",
	walkable = false,
	diggable = false,
	light_source = 13,
	groups = {not_in_creative_inventory=1}
})

minetest.register_node("beacon:greenbeam", {
	visual_scale = 1.0,
	drawtype = "plantlike",
	tiles = {"greenbeam.png"},
	paramtype = "light",
	walkable = false,
	diggable = false,
	light_source = 50,
	groups = {not_in_creative_inventory=1}
})

minetest.register_abm({
	nodenames = {"beacon:greenbase"}, --makes small particles emanate from the beginning of a beam
	interval = 1,
	chance = 2,
	action = function(pos, node)
		minetest.add_particlespawner({
			amount = 32,
			time = 4,
			minpos = {x=pos.x-0.25, y=pos.y-0.25, z=pos.z-0.25},
			maxpos = {x=pos.x+0.25, y=pos.y+0.25, z=pos.z+0.25},
			minvel = {x=-0.8, y=-0.8, z=-0.8},
			maxvel = {x=0.8, y=0.8, z=0.8},
			minacc = {x=0,y=0,z=0},
			maxacc = {x=0,y=0,z=0},
			minexptime = 0.5,
			maxexptime = 1,
			minsize = 1,
			maxsize = 2,
			collisiondetection = false,
			texture = "greenparticle.png",
		})
	end,
})

--Green Beam
minetest.register_node("beacon:purplebase", {
	visual_scale = 1.0,
	drawtype = "plantlike",
	tiles = {"purplebase.png"},
	paramtype = "light",
	walkable = false,
	diggable = false,
	light_source = 13,
	groups = {not_in_creative_inventory=1}
})

minetest.register_node("beacon:purplebeam", {
	visual_scale = 1.0,
	drawtype = "plantlike",
	tiles = {"purplebeam.png"},
	paramtype = "light",
	walkable = false,
	diggable = false,
	light_source = 50,
	groups = {not_in_creative_inventory=1}
})

minetest.register_abm({
	nodenames = {"beacon:purplebase"}, --makes small particles emanate from the beginning of a beam
	interval = 1,
	chance = 2,
	action = function(pos, node)
		minetest.add_particlespawner({
			amount = 32,
			time = 4,
			minpos = {x=pos.x-0.25, y=pos.y-0.25, z=pos.z-0.25},
			maxpos = {x=pos.x+0.25, y=pos.y+0.25, z=pos.z+0.25},
			minvel = {x=-0.8, y=-0.8, z=-0.8},
			maxvel = {x=0.8, y=0.8, z=0.8},
			minacc = {x=0,y=0,z=0},
			maxacc = {x=0,y=0,z=0},
			minexptime = 0.5,
			maxexptime = 1,
			minsize = 1,
			maxsize = 2,
			collisiondetection = false,
			texture = "purpleparticle.png",
		})
	end,
})
