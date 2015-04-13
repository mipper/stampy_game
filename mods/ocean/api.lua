ocean = {}

local function near_floor(pos)
	local n = minetest.get_node_or_nil({x=pos.x,y=pos.y-2,z=pos.z})
	if n and n.name and n.name ~= "default:water_source" then
		return true
	else
		return false
	end
end

function ocean:register_guardian (name, def)
	
	local defbox = def.size/2
	minetest.register_entity(name,{
		initial_properties = {
			name = name,
			hp_max = def.max_hp,
			visual_size = {x = def.size, y = def.size, z = def.size},
			visual = "cube",
			textures = def.textures, -- top, bottom, front, back, left, right
			collisionbox = {-defbox, -defbox, -defbox, defbox, defbox, defbox},
			physical = true,
		},
		timer = 6,
		timer2 = 1,
		yaw = 0,
		direction = {},
		status = 2, --1 = jump, 2 = rotate
		found_target = false,

		-- ON ACTIVATE --
		on_activate = function(self)
			self.object:setacceleration({x = 0, y = 0, z = 0})
		end,

		-- ON PUNCH --
		on_punch = function(self)
			local pos = self.object:getpos()
			--minetest.sound_play(def.sounds.damage.file, {pos = pos,gain = (def.sounds.damage.gain or 0.25)})
			--effect(pos, 20*math.random(), def.blood)
			check_for_guardian_death (self,def)
		end,

		-- ON STEP --
		on_step = function(self, dtime)

			self.timer2 = self.timer2 + dtime
			local pos = self.object:getpos()

			if self.status == 2 and (self.timer2 >= 0.5) then

				self.timer2 = 1.2
				self.status = 1

				-- FIXME
				if guardian_lonely(self, pos) and not minetest.env:find_node_near(pos, 24, def.spawn) then
					self.object:remove()
				end
				if pos.y > 2 then
					self.object:setvelocity({x = self.direction.x/5, y = -5, z = self.direction.z/5})
				end
				-- FIXME improve IA
				local objs = minetest.env:get_objects_inside_radius(pos, 24)
				local ppos = {}
				local attack_player
				self.found_target = false
				self.yaw = math.random() * 360
				for i, obj in ipairs(objs) do
					if obj:is_player() and damage_enabled and not def.passive then
						self.found_target = obj
						attack_player = true
						break
					end
					if self.found_target == false
						and obj:get_luaentity()
						and (obj:get_luaentity().name == "ocean:guardian") then
							self.found_target = obj
							attack_player = false
					end
				end
				if self.found_target  ~= false then
					local target = self.found_target:getpos()
					ppos = {x = target.x - pos.x, y = target.y - pos.y, z = target.z - pos.z}
					if ppos.x ~= 0 and ppos.z ~= 0 then --found itself as an object
						self.yaw = math.abs(math.atan(ppos.x/ppos.z) - math.pi / 2)
						if ppos.z < 0 then self.yaw = self.yaw + math.pi end
						--self.found_target = true
					end				
				end

				self.object:setyaw(self.yaw)
				self.object:set_properties({automatic_rotate = 0})
				if ppos.y > 0 and pos.y < -1 then
					self.direction = {x = math.cos(self.yaw)*2, y = .6, z = math.sin(self.yaw)*2}
				else
					self.direction = {x = math.cos(self.yaw)*2, y = -.3, z = math.sin(self.yaw)*2}
				end
				--minetest.sound_play(def.sounds.jump.file, {pos = pos,gain = (def.sounds.jump.gain or 0.25)})
				--self.object:set_properties({visual_size = {x = def.size, y = def.size - (def.size/8), z = def.size}})
			end

			self.timer = self.timer + dtime

			if self.timer2 > 1.3 then

				self.object:setvelocity(self.direction)
				if near_floor(pos) then
					self.object:setvelocity({x = self.direction.x/5, y = 2, z = self.direction.z/5})
					self.object:setacceleration({x = self.direction.x/5, y = 3, z = self.direction.z/5})
				else
					self.object:setacceleration({x = self.direction.x/5, y = self.direction.y/5, z = self.direction.z/5})
				end
				if too_close(self, pos) and not attack_player then
					self.object:setyaw(self.yaw + math.pi)
					self.object:setvelocity({x = -self.direction.x/5, y = -self.direction.y/5, z = -self.direction.z/5})
					self.object:setacceleration({x = math.random(-20,20)/20, y = math.random(-5,5)/20, z = math.random(-20,20)/20})
				end
				self.timer2 = 0
			end

			if (self.timer >= 6
				or (self.timer >= 1 
				and self.found_target ~= false)) then

				self.timer = 0
				self.timer2 = 0
				self.status = 2

				if self.found_target == false then self.object:set_properties({automatic_rotate = math.pi * 8}) end

				--minetest.sound_play(def.sounds.land.file, {pos = pos,gain = (def.sounds.land.gain or 0.25)})

				local n = minetest.get_node(pos)

				if damage_enabled then
					check_for_guardian_death (self,def)

					local objs = minetest.env:get_objects_inside_radius(pos, def.size*1.75)
					for i, obj in ipairs(objs) do
						if obj:is_player() and not def.passive then
							obj:punch(self.object, 1.0, {full_punch_interval=1.0,damage_groups = {fleshy=def.damage}})
							--minetest.sound_play(def.sounds.attack.file, {pos = pos,gain = (def.sounds.attack.gain or 0.25)})
						end
					end
				end
			end


		end,
	})
end

function too_close (self, pos)
	local objs = minetest.env:get_objects_inside_radius(pos, 2)
	local count = 0
	for i, obj in pairs(objs) do
		if obj:get_luaentity() and (obj:get_luaentity().name == "ocean:guardian") then
			count = count + 1
		end
	end
	if count > 2 then return true end
	return false
end

-- check if guardian is alone
function guardian_lonely (self, pos)
	local objs = minetest.env:get_objects_inside_radius(pos, 32)
	local count = 0
	local playernear = false
	for i, obj in pairs(objs) do
		if obj:is_player() then playernear = true end
		if obj:get_luaentity() and (obj:get_luaentity().name == "ocean:guardian") then
			count = count + 1
		end
	end
	if count > 10 then self.object:remove() end
	return not playernear
end

-- check for death
function check_for_guardian_death(self,def)

	if self.object:get_hp() > 0 then return end

	local pos = self.object:getpos()
	pos.y = pos.y + 0.5

	--if (def.sounds.death.file ~= nil ) then minetest.sound_play(def.sounds.death.file, {pos = pos,gain = (def.sounds.death.gain or 0.25)}) end
	self.object:remove()

	local chance = def.drops.chance
	if math.random(1, def.drops.chance+1) == 1 or def.drops.chance == 0 then
		local min = def.drops.min
		local max = def.drops.max
		local num = math.floor(math.random(min, max+1))
		if def.drops.type == "item" then
			for i=1,num do	minetest.env:add_item(pos, def.drop) end
		end
		if def.drops.type == "entity" then
			for i=1,num do	minetest.env:add_entity({x=pos.x, y=pos.y + (def.size*math.random()), z=pos.z + (def.size*math.random())}, def.drops.name)	end
		end
	end
end

-- check minimum distance to players
function ocean:check_player_dist(pos, node)
	for _,player in pairs(minetest.get_connected_players()) do
		local p = player:getpos()
		local dist = ((p.x-pos.x)^2 + (p.y-pos.y)^2 + (p.z-pos.z)^2)^0.5
		if dist < 24 then
			return 1
		end
	end
	return nil
end

-- spawn guardian
ocean.spawn = {}
function ocean:register_spawn(name, nodes, neighbors, max_light, min_light, chance, active_object_count, max_height)
	ocean.spawn[name] = true	
	minetest.register_abm({
		nodenames = nodes,
		neighbors = neighbors,
		interval = 30,
		chance = chance,
		action = function(pos, node, _, active_object_count_wider)

			-- do not spawn if too many active in area
			if active_object_count_wider > active_object_count
			or not pos then
				return
			end

			-- mobs cannot spawn inside protected areas
			if minetest.is_protected(pos, "") then
				return
			end

			-- do not spawn too close to players
			if ocean:check_player_dist(pos, node) then
				return
			end

			-- spawn above node
			pos.y = pos.y + 1

			-- check if light and height levels are ok to spawn
			local light = minetest.get_node_light(pos)
			if not light or light > max_light or light < min_light
			or pos.y > max_height then
				return
			end

			-- are we spawning inside a solid node?
			local nod = minetest.get_node_or_nil(pos)
			if not nod or not minetest.registered_nodes[nod.name]
			or minetest.registered_nodes[nod.name].walkable == true then
				return
			end
			pos.y = pos.y + 1
			nod = minetest.get_node_or_nil(pos)
			if not nod or not minetest.registered_nodes[nod.name]
			or minetest.registered_nodes[nod.name].walkable == true then
				return 
			end

			-- spawn mob half block higher
			pos.y = pos.y - 0.5
			minetest.add_entity(pos, name)

		end
	})
end

