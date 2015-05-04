-----------------------------------------------------------------------------------------------
local title		= "Fishing - Mossmanikin's version"
local version 	= "0.2.3"
local mname		= "fishing"
-----------------------------------------------------------------------------------------------
-- original by wulfsdad (http://forum.minetest.net/viewtopic.php?id=4375)
-- this version by Mossmanikin (https://forum.minetest.net/viewtopic.php?id=6480)
-- License (code & textures): 	WTFPL
-- Contains code from: 		animal_clownfish, animal_fish_blue_white, fishing (original), stoneage
-- Looked at code from:		default, farming
-- Dependencies: 			default
-- Supports:				animal_clownfish, animal_fish_blue_white, animal_rat, mobs
-----------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------

dofile(minetest.get_modpath("fishing").."/settings.txt")
dofile(minetest.get_modpath("fishing").."/bobber.lua")
dofile(minetest.get_modpath("fishing").."/crafting.lua")
dofile(minetest.get_modpath("fishing").."/fishes.lua")

-----------------------------------------------------------------------------------------------
-- Fishing Pole
-----------------------------------------------------------------------------------------------

local V = 22
local G = 9

bobbers = {}

local flist = {
	"fishing:fish_raw",
	"fishing:fish_raw",
	"fishing:fish_raw",
	"fishing:fish_raw",
	"fishing:pike",
	"fishing:pike",
	"fishing:shark",
}

local clist = {
	"default:stick",
	"lilypad:waterlily",
	"dye:black",
	"food:bowl",
	"default:book",
}

------------------------------------------------------------ Definition --------

local throw_rod = function( itemstack, user, pointed )
	if bobbers[user:get_player_name()] ~= nil then
		if bobbers[user:get_player_name()]:get_hp() > 300 then
			minetest.chat_send_player(user:get_player_name(), "You caught nothing.")
			minetest.sound_play("fishing_bobber1", {
				pos = bobbers[user:get_player_name()]:getpos(),
				gain = 0.5,
			})
			bobbers[user:get_player_name()]:remove()
			bobbers[user:get_player_name()] = nil
			return
		end

		local inv = user:get_inventory()
		local itemname
		local item
		if math.random(100) < 80 then
			itemname = flist[math.random(1,#flist)]
		else
			itemname = clist[math.random(1,#clist)]
		end
		minetest.chat_send_player(user:get_player_name(), "You caught a "..minetest.registered_items[itemname].description..".")
		item = {name=itemname, count=1}
		--inv:add_item("main", item)
		minetest.add_item(user:getpos(), item)
		minetest.sound_play("fishing_bobber1", {
			pos = bobbers[user:get_player_name()]:getpos(),
			gain = 0.5,
		})
		bobbers[user:get_player_name()]:remove()
		bobbers[user:get_player_name()] = nil
		return
	end

	if itemstack:peek_item() ~= nil then
		local dir = user:get_look_dir()
		local pos = user:getpos()
		local obj = minetest.env:add_entity( {
			x = pos.x,
			y = pos.y + 1.5,
			z = pos.z
		}, 'fishing:rod_ent' )
		obj:get_luaentity().launcher = user or nil
		obj:setvelocity( {
			x = dir.x * V,
			y = dir.y * V,
			z = dir.z * V
		})
		obj:setacceleration( {
			x = dir.x * -1,
			y = -G,
			z = dir.z * -1
		})
	end
	if not minetest.setting_getbool("creative_mode") then
		itemstack:add_wear(500)
	end
	return itemstack
end

local rod_ent = {
	physical = false,
	textures = { 'fishing_bobber.png' },
	collisionbox = { 0, 0, 0, 0, 0, 0 },
	visual_size = {x=.5, y=.5},
	launcher = nil,
	bobber = nil,
}

rod_ent.on_step = function( self, dtime )
	if self.launcher == nil then self.object:remove(); return end

	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)

	if node.name ~= 'air' then
		pos = minetest.env:find_node_near( pos, 1, 'default:water_source' )
		if pos ~= nil then
			bobbers[self.launcher:get_player_name()] = minetest.add_entity({interval = 1,x=pos.x, y=pos.y+(45/64), z=pos.z}, "fishing:bobber_entity")
			minetest.sound_play("fishing_bobber2", {
				pos = pos,
				gain = 0.5,
			})
		else
			bobbers[self.launcher:get_player_name()] = nil
		end
		self.object:remove()
	end
end

-------------------------------------------------------------- Register --------

minetest.register_entity( 'fishing:rod_ent', rod_ent )


local function rod_wear(itemstack, user, pointed_thing, uses)
	itemstack:add_wear(65535/(uses-1))
	return itemstack
end

minetest.register_tool("fishing:pole", {

	description = "Fishing Rod",
	groups = {},
	inventory_image = "fishing_pole.png",
	wield_image = "fishing_pole.png^[transformFXR270",
	stack_max = 1,
	liquids_pointable = true,
	on_use = throw_rod,
})


