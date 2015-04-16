-- Based on:
--------------------------------------------------------------------------------
--	Farwalk Orb
--------------------------------------------------------------------------------
--	Throw the orb to teleport to it's landing position.
--
--	(c)2012 Fernando Zapata (ZLovesPancakes, Franz.ZPT)
--	Code licensed under GNU GPLv2
--		http://www.gnu.org/licenses/gpl-2.0.html
--	Content licensed under CC BY-SA 3.0
--		http://creativecommons.org/licenses/by-sa/3.0/
--------------------------------------------------------------------------------

------------------------------------------------------ Global Variables --------

local V = 15
local G = 9

------------------------------------------------------------ Definition --------

local throw_orb = function( itemstack, user, pointed )
	if itemstack:peek_item() ~= nil then
		local dir = user:get_look_dir()
		local pos = user:getpos()
		local obj = minetest.env:add_entity( {
			x = pos.x,
			y = pos.y + 1.5,
			z = pos.z
		}, 'snowball:snowball_ent' )
		obj:get_luaentity().launcher = user or nil
		obj:setvelocity( {
			x = dir.x * V,
			y = dir.y * V,
			z = dir.z * V
		})
		obj:setacceleration( {
			x = dir.x * -3,
			y = -G,
			z = dir.z * -3
		})
	end
	if not minetest.setting_getbool("creative_mode") then
		itemstack:take_item()
	end
	return itemstack
end

local snowball_ent = {
	physical = false,
	textures = { 'default_snowball.png' },
	collisionbox = { 0, 0, 0, 0, 0, 0 },
	launcher = nil,
}

snowball_ent.on_step = function( self, dtime )
	local pos = self.object:getpos()
	local node = minetest.env:get_node(pos)
		local objs = minetest.env:get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 1.5)
		for k, obj in pairs(objs) do
			if obj:get_luaentity() ~= nil then
				if obj:get_luaentity().name ~= "snowball:snowball_ent" and obj:get_luaentity() ~= self.launcher then
					local damage = 1
					obj:punch(self.object, 1.0, {
						full_punch_interval=1.0,
						damage_groups={fleshy=damage},
					}, nil)
					self.object:remove()
				end
			end
		end

	if node.name ~= 'air' then
		self.object:remove()
	end
end

-------------------------------------------------------------- Register --------

minetest.register_entity( 'snowball:snowball_ent', snowball_ent )

minetest.register_craftitem( 'snowball:snowball', {
	description	= 'Snowball',
	inventory_image	= 'default_snowball.png',
	on_use		= throw_orb
})

minetest.register_craft({
	output = 'default:snowblock',
	recipe = {
		{'snowball:snowball', 'snowball:snowball'},
		{'snowball:snowball', 'snowball:snowball'},
	}
})

