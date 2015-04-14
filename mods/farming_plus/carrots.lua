-- main `S` code in init.lua
local S
S = farming.S

minetest.register_node("farming_plus:carrot_1", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_carrot_1.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+3/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:carrot_2", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_carrot_2.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+5/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:carrot_3", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	drop = "",
	tiles = {"farming_carrot_3.png"},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+12/16, 0.5}
		},
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_node("farming_plus:carrot", {
	paramtype = "light",
	walkable = false,
	drawtype = "plantlike",
	tiles = {"farming_carrot_4.png"},
	drop = {
		max_items = 4,
		items = {
			{ items = {"farming_plus:carrot_item"}            },
			{ items = {"farming_plus:carrot_item"}, rarity = 2},
			{ items = {"farming_plus:carrot_item"}, rarity = 2},
			{ items = {'farming_plus:carrot_item'}, rarity = 5},
		}
	},
	groups = {snappy=3, flammable=2, not_in_creative_inventory=1,plant=1},
	sounds = default.node_sound_leaves_defaults(),
})

minetest.register_craftitem("farming_plus:carrot_item", {
	description = S("Carrot"),
	inventory_image = "farming_carrot.png",
	on_use = minetest.item_eat(3),
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming_plus:carrot_1")
	end
})

farming.add_plant("farming_plus:carrot", {"farming_plus:carrot_1", "farming_plus:carrot_2", "farming_plus:carrot_3"}, 50, 20)
