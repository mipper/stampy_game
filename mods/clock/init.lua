minetest.register_globalstep(function(dtime)
	local players  = minetest.get_connected_players()
	for i,player in ipairs(players) do
		local function has_clock(player)
			for _,stack in ipairs(player:get_inventory():get_list("main")) do
				if minetest.get_item_group(stack:get_name(), "clock") ~= 0 then
					return true
				end
			end
			return false
		end
		if has_clock(player) then
			local time = math.floor(16 * (minetest.get_timeofday() + .5) % 16 + 1)

			for j,stack in ipairs(player:get_inventory():get_list("main")) do
				if minetest.get_item_group(stack:get_name(), "clock") ~= 0 and
						minetest.get_item_group(stack:get_name(), "clock") ~= time then
					player:get_inventory():set_stack("main", j, "clock:"..time)
				end
			end
		end
	end
end)

local images = {
	"w1.png",
	"w2.png",
	"w3.png",
	"w4.png",
	"w5.png",
	"w6.png",
	"w7.png",
	"w8.png",
	"w9.png",
	"w10.png",
	"w11.png",
	"w12.png",
	"w13.png",
	"w14.png",
	"w15.png",
	"w16.png",
}

local i
for i,img in ipairs(images) do
	local inv = 1
	if i == 1 then
		inv = 0
	end
	minetest.register_tool("clock:"..(i), {
		description = "Clock",
		inventory_image = img,
		wield_image = img,
		stack_max = 1,
		groups = {not_in_creative_inventory=inv,clock=i}
	})
end

minetest.register_craft({
	output = "clock:1",
	recipe = {
		{"", "default:gold_ingot", ""},
		{"default:gold_ingot", "default:mese_crystal", "default:gold_ingot"},
		{"", "default:gold_ingot", ""},
	},
})
