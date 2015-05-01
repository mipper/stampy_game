minetest.register_entity(":__builtin:item", {
	initial_properties = {
		hp_max = 1,
		physical = true,
		collisionbox = {-0.17,-0.17,-0.17, 0.17,0.17,0.17},
		visual = "sprite",
		visual_size = {x=0.5, y=0.5},
		textures = {""},
		spritediv = {x=1, y=1},
		initial_sprite_basepos = {x=0, y=0},
		is_visible = false,
		timer = 0,
	},
	
	itemstring = '',
	physical_state = true,

	set_item = function(self, itemstring)
		self.itemstring = itemstring
		local stack = ItemStack(itemstring)
		local itemtable = stack:to_table()
		local itemname = nil
		if itemtable then
			itemname = stack:to_table().name
		end
		local item_texture = nil
		local item_type = ""
		if minetest.registered_items[itemname] then
			item_texture = minetest.registered_items[itemname].inventory_image
			item_type = minetest.registered_items[itemname].type
		end
		prop = {
                        is_visible = true,
                        visual = "wielditem",
                        textures = {itemname},
                        visual_size = {x=0.20, y=0.20},
                        automatic_rotate = math.pi * 0.35,
                }
		if itemname == "default:apple" then
			prop.visual_size = {x=0.5,y=0.5}
		end
		self.object:set_properties(prop)
	end,

	get_staticdata = function(self)
		--return self.itemstring
		return minetest.serialize({
			itemstring = self.itemstring,
			always_collect = self.always_collect,
			timer = self.timer,
		})
	end,

	on_activate = function(self, staticdata, dtime_s)
		if string.sub(staticdata, 1, string.len("return")) == "return" then
			local data = minetest.deserialize(staticdata)
			if data and type(data) == "table" then
				self.itemstring = data.itemstring
				self.always_collect = data.always_collect
				self.timer = data.timer
				if not self.timer then
					self.timer = 0
				end
				self.timer = self.timer+dtime_s
			end
		else
			self.itemstring = staticdata
		end
		self.object:set_armor_groups({immortal=1})
		self.object:setvelocity({x=0, y=2, z=0})
		self.object:setacceleration({x=0, y=-10, z=0})
		self:set_item(self.itemstring)
	end,
	
	on_step = function(self, dtime)
		local time = tonumber(minetest.setting_get("remove_items"))
		if not time then
			time = 300
		end
		if not self.timer then
			self.timer = 0
		end
		if not self.lastbob then
			self.lastbob = 0
		end
		self.timer = self.timer + dtime
		if time ~= 0 and (self.timer > time) then
			self.object:remove()
		end

		local p = self.object:getpos()
		-- items get pushed up inside solid blocks
		if minetest.registered_nodes[minetest.get_node(p).name].walkable and math.abs(self.object:getvelocity().y) < .1 then
			p.y = p.y + 1
		end

		p.y = p.y - self.lastbob
		local bobdiff = math.sin(2*self.timer)/6 + .4
		self.lastbob = bobdiff
		local bobpos = {x=p.x, y=p.y+bobdiff, z=p.z}
		self.object:setpos(bobpos)

		local p2 = {x=p.x, y=p.y+.5, z=p.z}
		local name = minetest.get_node(p2).name

		if name == "default:lava_flowing" or name == "default:lava_source" then
			minetest.sound_play("builtin_item_lava", {pos=self.object:getpos()})
			self.object:remove()
			return
		end

		if string.find(name, "default:water") then
			local get_flowing_dir = function(self)
				local pos = self.object:getpos()
				local posname = minetest.get_node(pos).name
				local param2 = minetest.get_node(pos).param2
				local p4 = {
					{x=1,y=0,z=0},
					{x=-1,y=0,z=0},
					{x=0,y=0,z=1},
					{x=0,y=0,z=-1},
				}
				local out = {x=0,y=0,z=0}
				local num = 0
				for i=1,4 do
					local p2 = vector.add(pos, p4[i])
					local name = minetest.get_node(p2).name
					local par2 = minetest.get_node(p2).param2
					-- param2 == 13 means water is falling down a block
					if (name == "default:water_flowing" and par2 <= param2 and param2 < 13) or (name == "default:water_flowing" and par2 == 13) or name == "air" or (posname == "default:water_source" and name == "default:water_flowing") then
						out = vector.add(out, p4[i])
						num = num + 1
					end
				end
				if num then
					return out
				else
					return false
				end
			end
			
			local v = get_flowing_dir(self)
			if v then
				self.object:setvelocity({x=0,y=0,z=0})
				self.object:setacceleration({x=0, y=0, z=0})
				self.physical_state = false
				self.object:set_properties({
					physical = false
				})
				local p = self.object:getpos()
				p.x = p.x + v.x / 2 * dtime
				p.z = p.z + v.z / 2 * dtime
				self.object:setpos(p)
			end
		end
		
		p.y = p.y - 0.3
		local nn = minetest.env:get_node(p).name
		-- If node is not registered or node is walkably solid
		if not minetest.registered_nodes[nn] or minetest.registered_nodes[nn].walkable then
			if self.physical_state then
				self.object:setvelocity({x=0,y=0,z=0})
				self.object:setacceleration({x=0, y=0, z=0})
				self.physical_state = false
				self.object:set_properties({
					physical = false
				})
			end
		else
			if not self.physical_state then
				self.object:setvelocity({x=0,y=0,z=0})
				self.object:setacceleration({x=0, y=-10, z=0})
				self.physical_state = true
				self.object:set_properties({
					physical = true
				})
			end
		end
	end,

	on_punch = function(self, hitter)
		if self.itemstring ~= '' then
			local left = hitter:get_inventory():add_item("main", self.itemstring)
			if not left:is_empty() then
				self.itemstring = left:to_string()
				return
			end
		end
		self.object:remove()
	end,
})

if minetest.setting_get("log_mods") then
	minetest.log("action", "builtin_item loaded")
end
