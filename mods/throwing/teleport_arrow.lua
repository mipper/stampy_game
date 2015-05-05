minetest.register_craftitem("throwing:arrow_teleport", {
	description = "Teleport Arrow",
	inventory_image = "throwing_arrow_teleport.png",
})

minetest.register_node("throwing:arrow_teleport_box", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			-- Shaft
			{-6.5/17, -1.5/17, -1.5/17, 6.5/17, 1.5/17, 1.5/17},
			--Spitze
			{-4.5/17, 2.5/17, 2.5/17, -3.5/17, -2.5/17, -2.5/17},
			{-8.5/17, 0.5/17, 0.5/17, -6.5/17, -0.5/17, -0.5/17},
			--Federn
			{6.5/17, 1.5/17, 1.5/17, 7.5/17, 2.5/17, 2.5/17},
			{7.5/17, -2.5/17, 2.5/17, 6.5/17, -1.5/17, 1.5/17},
			{7.5/17, 2.5/17, -2.5/17, 6.5/17, 1.5/17, -1.5/17},
			{6.5/17, -1.5/17, -1.5/17, 7.5/17, -2.5/17, -2.5/17},
			
			{7.5/17, 2.5/17, 2.5/17, 8.5/17, 3.5/17, 3.5/17},
			{8.5/17, -3.5/17, 3.5/17, 7.5/17, -2.5/17, 2.5/17},
			{8.5/17, 3.5/17, -3.5/17, 7.5/17, 2.5/17, -2.5/17},
			{7.5/17, -2.5/17, -2.5/17, 8.5/17, -3.5/17, -3.5/17},
		}
	},
	tiles = {"throwing_arrow_teleport.png", "throwing_arrow_teleport.png", "throwing_arrow_teleport_back.png", "throwing_arrow_teleport_front.png", "throwing_arrow_teleport_2.png", "throwing_arrow_teleport.png"},
	groups = {not_in_creative_inventory=1},
})

local THROWING_ARROW_ENTITY={
	physical = false,
	timer=0,
	visual = "wielditem",
	visual_size = {x=0.1, y=0.1},
	textures = {"throwing:arrow_teleport_box"},
	lastpos={},
	collisionbox = {0,0,0,0,0,0},
	player = "",
}

-- http://stackoverflow.com/questions/1318220/lua-decimal-sign
math.sign = math.sign or function(x) return x<0 and -1 or x>0 and 1 or 0 end

THROWING_ARROW_ENTITY.on_step = function(self, dtime)
	self.timer=self.timer+dtime
	local pos = self.object:getpos()
	local v = self.object:getvelocity()
	local node = minetest.get_node(pos)
	local d = {}
	local dv = {x=math.sign(v.x), y=math.sign(v.y), z=math.sign(v.z)}
	d.x = pos.x + dv.x
	d.y = pos.y + dv.y
	d.z = pos.z + dv.z

	if self.timer > 0 then
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)
		local n = minetest.get_node({x=d.x,y=d.y,z=d.z}).name
		local i

		if n ~= "air" and n ~= "ignore" then
			if self.player ~= "" then
				i = 0
				while i < 20 do
					d.x = d.x - dv.x
					d.y = d.y - dv.y
					d.z = d.z - dv.z
					n = minetest.get_node({x=d.x,y=d.y,z=d.z}).name
					if n == "air" then
						i = 100
					end
				end
				self.player:setpos(d)
				self.player:get_inventory():add_item("main", ItemStack("throwing:arrow_teleport"))
			end
			self.object:setvelocity({x=0,y=0,z=0})
			self.object:remove()
		end
	end
	if self.timer > 8 then
		if self.player ~= "" then
			self.player:get_inventory():add_item("main", ItemStack("throwing:arrow_teleport"))
		end
		self.object:setvelocity({x=0,y=0,z=0})
		self.object:remove()
	end
end

minetest.register_entity("throwing:arrow_teleport_entity", THROWING_ARROW_ENTITY)

minetest.register_craft({
	output = 'throwing:arrow_teleport',
	recipe = {
		{'default:stick', 'default:stick', 'default:mese_crystal_fragment'},
	}
})
