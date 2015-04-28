-- Global farming namespace
farming = {}
farming.path = minetest.get_modpath("farming")

-- Load files
dofile(farming.path .. "/api.lua")
dofile(farming.path .. "/nodes.lua")
dofile(farming.path .. "/hoes.lua")
dofile(farming.path .. "/cocoa.lua")

-- WHEAT
farming.register_plant("farming:wheat", {
	description = "Wheat Seed",
	inventory_image = "farming_wheat_seed.png",
	steps = 8,
	minlight = 3,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland"}
})
minetest.register_craftitem("farming:flour", {
	description = "Flour",
	inventory_image = "farming_flour.png",
})

minetest.register_craftitem("farming:bread", {
	description = "Bread",
	inventory_image = "farming_bread.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	type = "shapeless",
	output = "farming:flour",
	recipe = {"farming:wheat", "farming:wheat", "farming:wheat", "farming:wheat"}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "farming:bread",
	recipe = "farming:flour"
})

-- Cotton
farming.register_plant("farming:cotton", {
	description = "Cotton seed",
	inventory_image = "farming_cotton_seed.png",
	steps = 8,
	minlight = 13,
	maxlight = default.LIGHT_MAX,
	fertility = {"grassland", "desert"}
})

minetest.register_alias("farming:string", "farming:cotton")

minetest.register_craft({
	output = "wool:white",
	recipe = {
		{"farming:cotton", "farming:cotton"},
		{"farming:cotton", "farming:cotton"},
	}
})

-- Straw
minetest.register_craft({
	output = "farming:straw",
	recipe = {
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
		{"farming:wheat", "farming:wheat", "farming:wheat"},
	}
})

minetest.register_craft({
	output = "farming:wheat 9",
	recipe = {
		{"farming:straw"},
	}
})

-- Single ABM Handles Growing of All Plants (from farming redo by Tenplus1)

minetest.register_abm({
	nodenames = {"group:growing"},
	neighbors = {"farming:soil_wet", "default:jungletree"},
	interval = 80,
	chance = 2,

	action = function(pos, node)

		-- get node type (e.g. farming:wheat_1)
		local plant = node.name:split("_")[1].."_"
		local numb = node.name:split("_")[2]

		-- check if fully grown
		if not minetest.registered_nodes[plant..(numb + 1)] then return end
		
		-- Check for Cocoa Pod
		if plant == "farming:cocoa_"
		and minetest.find_node_near(pos, 1, {"default:jungletree", "moretrees:jungletree_leaves_green"}) then

			if minetest.get_node_light(pos) < 13 then return end

		else
		
			-- check if on wet soil
			pos.y = pos.y-1
			if minetest.get_node(pos).name ~= "farming:soil_wet" then return end
			pos.y = pos.y+1
		
			-- check light
			if minetest.get_node_light(pos) < 13 then return end
		
		end
		
		-- grow
		minetest.set_node(pos, {name=plant..(numb + 1)})

	end
})


