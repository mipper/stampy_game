
--
-- Helper functions
--

local function is_water(pos)
	local nn = minetest.get_node(pos).name
	return minetest.get_item_group(nn, "water") ~= 0
end

local function get_sign(i)
	if i == 0 then
		return 0
	else
		return i / math.abs(i)
	end
end

local function get_velocity(v, yaw, y)
	local x = -math.sin(yaw) * v
	local z =  math.cos(yaw) * v
	return {x = x, y = y, z = z}
end

local function get_v(v)
	return math.sqrt(v.x ^ 2 + v.z ^ 2)
end

--
-- Boat entity
--

local boat = {
	physical = true,
	collisionbox = {-0.5, -0.7, -0.5, 0.5, 0.3, 0.5},
	visual = "mesh",
	mesh = "boat.obj",
	textures = {"default_wood.png"},

	driver = nil,
	v = 0,
	last_v = 0,
	removed = false
}

function boat.on_rightclick(self, clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	local name = clicker:get_player_name()
	if self.driver and clicker == self.driver then
		self.driver = nil
		clicker:set_detach()
		default.player_attached[name] = false
		default.player_set_animation(clicker, "stand" , 30)
	elseif not self.driver then
		self.driver = clicker
		clicker:set_attach(self.object, "", {x = 0, y = 11, z = -3}, {x = 0, y = 0, z = 0})
		default.player_attached[name] = true
		minetest.after(0.2, function()
			default.player_set_animation(clicker, "sit" , 30)
		end)
		self.object:setyaw(clicker:get_look_yaw() - math.pi / 2)
	end
end

function boat.on_activate(self, staticdata, dtime_s)
	self.object:set_armor_groups({immortal = 1})
	if staticdata then
		self.v = tonumber(staticdata)
	end
	self.last_v = self.v
end

function boat.get_staticdata(self)
	return tostring(self.v)
end

function boat.on_punch(self, puncher, time_from_last_punch, tool_capabilities, direction)
	if not puncher or not puncher:is_player() or self.removed then
		return
	end
	if self.driver and puncher == self.driver then
		self.driver = nil
		puncher:set_detach()
		default.player_attached[puncher:get_player_name()] = false
	end
	if not self.driver then
		self.removed = true
		-- delay remove to ensure player is detached
		minetest.after(0.1, function()
			self.object:remove()
		end)
		if not minetest.setting_getbool("creative_mode") then
			puncher:get_inventory():add_item("main", "boats:boat")
		end
	end
end

function boat.on_step(self, dtime)
	local b = -.1
	self.v = get_v(self.object:getvelocity()) * get_sign(self.v)
	local pos = self.object:getpos()
	local velo = self.object:getvelocity()
	if self.driver then
		local ctrl = self.driver:get_player_control()
		local yaw = self.driver:get_look_yaw() - math.pi / 2
		local v = 1.
		if ctrl.up then
			self.object:setyaw(yaw)
			if math.abs(velo.x) + math.abs(velo.z) < 5 then
				self.object:setacceleration({x = -math.sin(yaw) * v, y = velo.y, z = math.cos(yaw) * v})
			end
			return
		end
		if ctrl.down then
			self.object:setyaw(yaw)
			if math.abs(velo.x) + math.abs(velo.z) < 5 then
				self.object:setacceleration({x = -math.sin(yaw) * -v, y = velo.y, z = math.cos(yaw) * -v})
			end
			return
		end
	end

	local name1 = minetest.get_node({x=pos.x, y=pos.y+.3, z=pos.z}).name
	local name2 = minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name
	local name3 = minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
	local vert = 0
	if (string.find(name1, "default:water") or string.find(name2, "default:water")) and velo.y < 8 then
		vert = 3
		self.object:setacceleration({x = velo.x * b, y = vert, z = velo.z * b})
		return
	end
	if name1 == "air" and name2 == "air" and string.find(name3, "default:water") and math.abs(velo.y) > .1 then
		self.object:setacceleration({x = velo.x * b, y = 0, z = velo.z * b})
		self.object:setvelocity({x = velo.x * b, y = 0, z = velo.z * b})
		self.object:setpos({x=pos.x, y=.5 + math.floor(pos.y), z=pos.z})
		return
	end
	if name3 == "air" then vert = -9.81 end
	self.object:setacceleration({x = velo.x * b, y = vert, z = velo.z * b})
end

minetest.register_entity("boats:boat", boat)

minetest.register_craftitem("boats:boat", {
	description = "Boat",
	inventory_image = "boat_inventory.png",
	wield_image = "boat_wield.png",
	wield_scale = {x = 2, y = 2, z = 1},
	liquids_pointable = true,

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		if not is_water(pointed_thing.under) then
			return
		end
		pointed_thing.under.y = pointed_thing.under.y + 0.5
		minetest.add_entity(pointed_thing.under, "boats:boat")
		if not minetest.setting_getbool("creative_mode") then
			itemstack:take_item()
		end
		return itemstack
	end,
})

minetest.register_craft({
	output = "boats:boat",
	recipe = {
		{"",           "",           ""          },
		{"group:wood", "",           "group:wood"},
		{"group:wood", "group:wood", "group:wood"},
	},
})

