-----------------------------------------------------------------------------------------------
-- Fishing - Mossmanikin's version - Bobber 0.1.7
-- License (code & textures): 	WTFPL
-- Contains code from: 		fishing (original), mobs, throwing, volcano
-- Supports:				3d_armor, animal_clownfish, animal_fish_blue_white, animal_rat, flowers_plus, mobs, seaplants
-----------------------------------------------------------------------------------------------

minetest.register_node("fishing:bobber_box", {
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
--			{ left, bottom, front,  right, top ,  back}
			{-8/16, -8/16,     0,  8/16,  8/16,     0}, -- feathers
			{-2/16, -8/16, -2/16,  2/16, -4/16,  2/16},	-- bobber
		}
	},
	tiles = {
		"fishing_bobber_top.png",
		"fishing_bobber_bottom.png",
		"fishing_bobber.png",
		"fishing_bobber.png",
		"fishing_bobber.png",
		"fishing_bobber.png^[transformFX"
	}, -- 
	groups = {not_in_creative_inventory=1},
})

local FISHING_BOBBER_ENTITY={
	hp_max = 605,
	water_damage = 1,
	physical = true,
	timer = 0,
	env_damage_timer = 0,
	visual = "wielditem",
	visual_size = {x=1/3, y=1/3, z=1/3},
	textures = {"fishing:bobber_box"},
	collisionbox = {-2/16, -4/16, -2/16,  2/16, 0/16,  2/16},
	view_range = 30,
	on_step = function(self, dtime)
		local pos = self.object:getpos()
		if BOBBER_CHECK_RADIUS > 0 then
			local objs = minetest.get_objects_inside_radius(pos, BOBBER_CHECK_RADIUS)
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name == "fishing:bobber_entity" then
						if obj:get_luaentity() ~= self then
							self.object:remove()
						end
					end
				end
			end
		end
		if math.random(1, 4) == 1 then
			self.object:setyaw(self.object:getyaw()+((math.random(0,360)-180)/2880*math.pi))
		end
		for _,player in pairs(minetest.get_connected_players()) do
			local s = self.object:getpos()
			local p = player:getpos()
			local dist = ((p.x-s.x)^2 + (p.y-s.y)^2 + (p.z-s.z)^2)^0.5
			if dist > self.view_range then
				-- make sound and remove bobber
				minetest.sound_play("fishing_bobber1", {
					pos = self.object:getpos(),
					gain = 0.5,
				})
				self.object:remove()
			end
		end
		if self.object:get_hp() > 310 then
			local find_fish = minetest.get_objects_inside_radius({x=pos.x,y=pos.y+0.5,z=pos.z}, 1)
			for k, obj in pairs(find_fish) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name == "animal_fish_blue_white:fish_blue_white" then
						if math.random(1, 30) == 1 then
							self.object:set_hp(310)
						end
					end
				end
			end
		end
		local do_env_damage = function(self)
			self.object:set_hp(self.object:get_hp()-self.water_damage)
			if self.object:get_hp() == 600 then
				self.object:moveto({x=pos.x,y=pos.y-0.015625,z=pos.z})
			elseif self.object:get_hp() == 595 then
				self.object:moveto({x=pos.x,y=pos.y+0.015625,z=pos.z})
			elseif self.object:get_hp() == 590 then
				self.object:moveto({x=pos.x,y=pos.y+0.015625,z=pos.z})
			elseif self.object:get_hp() == 585 then
				self.object:moveto({x=pos.x,y=pos.y-0.015625,z=pos.z})
				self.object:set_hp(self.object:get_hp()-(math.random(1, 275)))
			elseif self.object:get_hp() == 300 then
				minetest.sound_play("fishing_bobber1", {
					pos = self.object:getpos(),
					gain = 0.5,
				})
				minetest.add_particlespawner({
					amount = 30,
					time = .5,
					minpos = {x=pos.x,y=pos.y-0.0625,z=pos.z},
					maxpos = pos,
					minvel = {x=-2,y=-0.0625,z=-2},
					maxvel = {x=2,y=3,z=2},
					minacc = {x=0,y=-9.8,z=0},
					maxacc = {x=0,y=-9.8,z=0},
					minexptime = 0.3,
					maxexptime = 1.2,
					minsize = .25,
					maxsize = .5,
					collisiondetection = false,
					texture = "default_snow.png",
				})
				self.object:moveto({x=pos.x,y=pos.y-0.0625,z=pos.z})
			elseif self.object:get_hp() == 295 then
				self.object:moveto({x=pos.x,y=pos.y+0.0625,z=pos.z})
			elseif self.object:get_hp() == 290 then
				self.object:moveto({x=pos.x,y=pos.y+0.0625,z=pos.z})
			elseif self.object:get_hp() == 285 then
				self.object:moveto({x=pos.x,y=pos.y-0.1,z=pos.z})
			elseif self.object:get_hp() < 284 then	
				self.object:moveto({x=pos.x+(0.001*(math.random(-8, 8))),y=pos.y,z=pos.z+(0.001*(math.random(-8, 8)))})
				self.object:setyaw(self.object:getyaw()+((math.random(0,360)-180)/1440*math.pi))
			elseif self.object:get_hp() == 0 then
				-- make sound and remove bobber
				minetest.sound_play("fishing_bobber1", {
					pos = self.object:getpos(),
					gain = 0.5,
				})
				self.object:remove()
			end
		end
		do_env_damage(self)
	end,
}

minetest.register_entity("fishing:bobber_entity", FISHING_BOBBER_ENTITY)



