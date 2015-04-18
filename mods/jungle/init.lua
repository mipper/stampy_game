
if minetest.find_nodes_in_area_under_air then
	dofile(minetest.get_modpath("jungle").."/temple.lua")
	minetest.log("action", "Jungle temple mod loaded")
else
	minetest.log("action", "Your Minetest version is too old; there will be no jungle temples.")
end


