-- mods/default/craftitems.lua

minetest.register_craftitem("default:stick", {
	description = "Stick",
	inventory_image = "default_stick.png",
	groups = {stick=1},
})

minetest.register_craftitem("default:paper", {
	description = "Paper",
	inventory_image = "default_paper.png",
})

minetest.register_craftitem("default:book", {
	description = "Book",
	inventory_image = "default_book.png",
	groups = {book=1},
})

-- from https://github.com/ShadowNinja/minetest_game/blob/writable-books/mods/default/craftitems.lua
minetest.register_craftitem("default:writablebook", {
	description = "Book and Quill",
	inventory_image = "book_writable.png",
	groups = {book=1},
	stack_max = 1,
	on_use = function(itemstack, user, pointed_thing)
		local player_name = user:get_player_name()
		local data = minetest.deserialize(itemstack:get_metadata())
		local title, text, owner = "", "", player_name
		if data then
			title, text, owner = data.title, data.text, data.owner
		end
		local formspec
		if owner == player_name then
			formspec = "size[8,8]"..default.gui_bg..default.gui_bg_img..
				"field[0.5,1;7.5,0;title;Title:;"..
					minetest.formspec_escape(title).."]"..
				"textarea[0.5,1.5;7.5,7;text;Contents:;"..
					minetest.formspec_escape(text).."]"..
				"button_exit[2.5,7.5;3,1;save;Save]"
		else
			formspec = "size[8,8]"..default.gui_bg..default.gui_bg_img..
				"label[1,0.5;"..minetest.formspec_escape(title).."]"..
				"label[0.5,1.5;"..minetest.formspec_escape(text).."]"
		end
		minetest.show_formspec(user:get_player_name(), "default:writablebook", formspec)
	end,
})

minetest.register_on_player_receive_fields(function(player, form_name, fields)
	if form_name ~= "default:writablebook" or not fields.save then
		return
	end
	local stack = player:get_wielded_item()
	if minetest.get_item_group(stack:get_name(), "book") == 0 then
		return
	end
	local data = minetest.deserialize(stack:get_metadata())
	if not data then data = {} end
	data.title, data.text, data.owner =
		fields.title, fields.text, player:get_player_name()
	stack:set_metadata(minetest.serialize(data))
	player:set_wielded_item(stack)
end)

minetest.register_craftitem("default:coal_lump", {
	description = "Coal",
	inventory_image = "default_coal_lump.png",
	groups = {coal = 1}
})

minetest.register_craftitem("default:charcoal", {
	description = "Charcoal",
	inventory_image = "charcoal.png",
	groups = {coal = 1},
})

minetest.register_craftitem("default:mese_crystal", {
	description = "Mese Crystal",
	inventory_image = "default_mese_crystal.png",
})

minetest.register_craftitem("default:diamond", {
	description = "Diamond",
	inventory_image = "default_diamond.png",
})

minetest.register_craftitem("default:emerald", {
	description = "Emerald",
	inventory_image = "emerald.png",
})

minetest.register_craftitem("default:clay_lump", {
	description = "Clay",
	inventory_image = "default_clay_lump.png",
})

minetest.register_craftitem("default:steel_ingot", {
	description = "Steel Ingot",
	inventory_image = "default_steel_ingot.png",
})

minetest.register_craftitem("default:copper_ingot", {
	description = "Copper Ingot",
	inventory_image = "default_copper_ingot.png",
})

minetest.register_craftitem("default:bronze_ingot", {
	description = "Bronze Ingot",
	inventory_image = "default_bronze_ingot.png",
})

minetest.register_craftitem("default:gold_ingot", {
	description = "Gold Ingot",
	inventory_image = "default_gold_ingot.png"
})

minetest.register_craftitem("default:mese_crystal_fragment", {
	description = "Mese Crystal Fragment",
	inventory_image = "default_mese_crystal_fragment.png",
})

minetest.register_craftitem("default:clay_brick", {
	description = "Clay Brick",
	inventory_image = "default_clay_brick.png",
})

minetest.register_craftitem("default:obsidian_shard", {
	description = "Obsidian Shard",
	inventory_image = "default_obsidian_shard.png",
})
