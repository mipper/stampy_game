jungle = {}

local chest_stuff = {
	{name="default:steel_ingot", max = 5},
	{name="default:gold_ingot", max = 7},
	{name="default:diamond", max = 3},
	{name="default:emerald", max = 5},
	{name="default:book", max = 3},
	{name="mobs:rotten_flesh", max = 7},
	{name="bones:single_bone", max = 6},
}

-- get some random content for a chest
local function chest(pos)
	local meta = minetest.env:get_meta(pos)
	local inv  = meta:get_inventory()
	inv:set_size("main", 8*4)
	for i=0,math.random(2,6),1 do
		local stuff = chest_stuff[math.random(1,#chest_stuff)]
		local stack = {name=stuff.name, count = math.random(1,stuff.max)}
		if not inv:contains_item("main", stack) then
			inv:set_stack("main", math.random(1,32), stack)
		end
	end
end

local function disp(pos)
	local meta = minetest.env:get_meta(pos)
	local inv  = meta:get_inventory()
	inv:set_size("main", 3*3)
	local stack = {name="throwing:arrow", count = 16}
	inv:set_stack("main", 5, stack)
end

local function hlp_fnct(pos, name)
	local n = minetest.get_node_or_nil(pos)
	if n and n.name and n.name == name then
		return true
	else
		return false
	end
end

local function ground(pos)
	local p2 = pos
	while hlp_fnct(p2, "air") do
		p2.y = p2.y -1
	end
	return p2
end


minetest.register_on_generated(function(minp, maxp, seed)
	if math.random(1,5) > 1 then return end
	if #minetest.find_nodes_in_area(minp, maxp, {"default:desert_sand"}) > 0 then return end
	local plist = minetest.find_nodes_in_area_under_air(minp, maxp, {"default:dirt_with_grass"})
	if #plist == 0 then return end
	local pos = plist[1]
	if not minetest.find_node_near(pos, 8, {"group:tree"}) then return end
	if not minetest.find_node_near(pos, 50, {"group:water"}) then return end
	if     minetest.find_node_near(pos, 50, {"default:snow"}) then return end
	if     minetest.find_node_near(pos, 80, {"default:mossycobble"}) then return end
	if #minetest.find_nodes_in_area(minp, maxp, {"group:tree"}) < 30 then return end
	pos.y = pos.y - 3
	minetest.place_schematic(pos, minetest.get_modpath("jungle").."/schems/jtemple.mts")
	for x=pos.x-20,pos.x+20 do
		for z=pos.z-20, pos.z+20 do
			for y=pos.y-10,pos.y+10 do
				pos2 = {x=x, y=y, z=z}
				if minetest.get_node(pos2).name == "default:chest" then
					chest(pos2)
				end
				if minetest.get_node(pos2).name == "moremesecons_dispenser:dispenser" then
					disp(pos2)
				end
			end
		end
	end
	minetest.log("action", "Created jungle temple at ("..pos.x..","..pos.y..","..pos.z..")")
end)

tripwire_interval = 0.05

local on_timer = function (pos)
	local name = minetest.get_node(pos).name
	local timer = minetest.get_node_timer(pos)
	local meta = minetest.get_meta(pos)

	timer:start(tripwire_interval)

	if #minetest.get_objects_inside_radius(pos, 1) > 0 and meta:get_int("tripped") < 1 then
		meta:set_int("tripped", 1)
		for i=-10,10 do
			local p1 = {x=pos.x+i, y=pos.y, z=pos.z}
			local p2 = {x=pos.x, y=pos.y, z=pos.z+i}
			local p11 = {x=pos.x+i, y=pos.y+1, z=pos.z}
			local p22 = {x=pos.x, y=pos.y+1, z=pos.z+i}
			if minetest.get_node(p11).name == "moremesecons_dispenser:dispenser" then
				mesecon.receptor_on(p1)
				nodeupdate(p11)
			end
			if minetest.get_node(p22).name == "moremesecons_dispenser:dispenser" then
				mesecon.receptor_on(p2)
				nodeupdate(p22)
			end
		end
		minetest.after(3, function()
			meta:set_int("tripped", 2)
		end)
	end
	if #minetest.get_objects_inside_radius(pos, 1) == 0 and meta:get_int("tripped") == 2 then
		meta:set_int("tripped", 0)
		for i=-10,10 do
			local p1 = {x=pos.x+i, y=pos.y, z=pos.z}
			local p2 = {x=pos.x, y=pos.y, z=pos.z+i}
			local p11 = {x=pos.x+i, y=pos.y+1, z=pos.z}
			local p22 = {x=pos.x, y=pos.y+1, z=pos.z+i}
			if minetest.get_node(p11).name == "moremesecons_dispenser:dispenser" then
				mesecon.receptor_off(p1)
				nodeupdate(p11)
			end
			if minetest.get_node(p22).name == "moremesecons_dispenser:dispenser" then
				mesecon.receptor_off(p2)
				nodeupdate(p22)
			end
		end
	end
end

mesecon.register_node("jungle:tripwire", {
	description="Tripwire",
	drawtype = "raillike",
	inventory_image = "tripwire.png",
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.5+1/32, 0.5},
	},
	on_timer = on_timer,
	on_construct = function(pos, node, active_object_count, active_object_count_wider)
			local timer = minetest.get_node_timer(pos)
			timer:start(tripwire_interval)
	end,
},{
	tiles = {"tripwire.png"},
	groups = {dig_immediate=3},
	mesecons = {receptor = { state = mesecon.state.off }}
},{
	tiles = {"tripwire.png"},
	groups = {dig_immediate=3, not_in_creative_inventory=1},
	mesecons = {receptor = { state = mesecon.state.on }}
})

minetest.register_craft({
	output = "jungle:tripwire_off 2",
	recipe = {{"farming:cotton", "farming:cotton"}}
})



-- start timers
minetest.register_abm({
	nodenames = {"jungle:tripwire_off"},
	interval = 10,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
			local timer = minetest.get_node_timer(pos)
			if not timer:is_started() then
				timer:start(tripwire_interval)
			end
	end,
})

minetest.register_abm({
	nodenames = {"moremesecons_dispenser:dispenser"},
	interval = 10,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec",	"size[9,8;]"..
						default.gui_bg..
						default.gui_bg_img..
						default.gui_slots..
						"list[context;main;3,.5;3,3;]"..
						"list[current_player;main;0,6.85;9,1;]"..
						"list[current_player;main;0,3.75;9,3;9]"..
						"label[3,-0.2;Dispenser]"..
						"label[0,3.25;Inventory]"..
						default.get_hotbar_bg(0,6.85))
		local inv = meta:get_inventory()
		inv:set_size("main", 3*3)
	end,
})


