local room = {"a","a","a","a","a","a","a","a","a",
	"a","c","a","c","a","c","a","c","a",
	"a","s","a","s","a","s","a","s","a",
	"a","a","a","a","a","a","a","a","a",
	"a","a","a","a","a","a","a","a","a",
	"a","a","a","a","a","a","a","a","a",
	"a","s","a","s","a","s","a","s","a",
	"a","c","a","c","a","c","a","c","a",
	"a","a","a","a","a","a","a","a","a"}

local code = {}
code["s"] = "ocean:prismarine"
code["eye"] = "ocean:sea_lantern"
code["men"] = "ocean:sea_lantern"
code["sun"] = "ocean:sea_lantern"
code["b"] = "ocean:prismarine"
code["a"] = "water_source"
code["c"] = "water_source"
code["l"] = "sponge:sponge"
code["t"] = "ocean:prismarine"

local function replace(str,iy)
	if iy == 0 and str == "s" then str = "sun" end
	if iy == 3 and str == "s" then str = "men" end
	return code[str]
end

function ocean.make_room(pos)
 local loch = {x=pos.x+7,y=pos.y+5, z=pos.z+7}
 for iy=0,4,1 do
	for ix=0,8,1 do
		for iz=0,8,1 do
			local n_str = room[tonumber(ix*9+iz+1)]
			if n_str == "c" and iy > 2 then
				if iy == 4 then
					minetest.set_node({x=loch.x+ix,y=loch.y-iy,z=loch.z+iz}, {name="default:goldblock"})
				else
					minetest.set_node({x=loch.x+ix,y=loch.y-iy,z=loch.z+iz}, {name="ocean:dark_prismarine"})
				end
			else
				minetest.set_node({x=loch.x+ix,y=loch.y-iy,z=loch.z+iz}, {name=replace(n_str,iy)})
				if n_str == "a" and math.random(1,30) > 29 then
					minetest.set_node({x=loch.x+ix,y=loch.y-iy,z=loch.z+iz}, {name="sponge:sponge_wet"})
				end
			end
		end
	end
 end
end

