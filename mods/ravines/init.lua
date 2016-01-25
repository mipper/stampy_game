-- ravines mod, based on http://dev.minetest.net/VoxelManip#Example

local c_air = minetest.get_content_id("air")

local rarity = 0.1
local scale = 10
 
local perlin_scale = rarity*scale*100
local inverted_rarity = 1-rarity
 
minetest.register_on_generated(function(minp, maxp, seed)
 
	--avoid calculating perlin noises for unneeded places
	if maxp.y <= -550
	or minp.y >= 150 then
		return
	end
 
	local perlin1 = minetest.get_perlin(11,3, 0.5, perlin_scale)	--Get map specific perlin
	local x0,z0,x1,z1 = minp.x,minp.z,maxp.x,maxp.z	-- Assume X and Z lengths are equal
 
	if not ( perlin1:get2d( {x=x0, y=z0} ) > inverted_rarity ) 					--top left
	and not ( perlin1:get2d( { x = x0 + ( (x1-x0)/2), y=z0 } ) > inverted_rarity )--top middle
	and not (perlin1:get2d({x=x1, y=z1}) > inverted_rarity) 						--bottom right
	and not (perlin1:get2d({x=x1, y=z0+((z1-z0)/2)}) > inverted_rarity) 			--right middle
	and not (perlin1:get2d({x=x0, y=z1}) > inverted_rarity)  						--bottom left
	and not (perlin1:get2d({x=x1, y=z0}) > inverted_rarity)						--top right
	and not (perlin1:get2d({x=x0+((x1-x0)/2), y=z1}) > inverted_rarity) 			--left middle
	and not (perlin1:get2d({x=(x1-x0)/2, y=(z1-z0)/2}) > inverted_rarity) 			--middle
	and not (perlin1:get2d({x=x0, y=z1+((z1-z0)/2)}) > inverted_rarity) then		--bottom middle
		return
	end

	local heightmap = minetest.get_mapgen_object("heightmap")
	local hmi = 1
 
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
 	local pos, pos2
	local depth = math.random(15, 25)

	for z=minp.z,maxp.z do
		for x=minp.x,maxp.x do
			local test = math.abs(perlin1:get2d({x=x, y=z}))
			if test <= 0.1 then
				for y=math.max(minp.y, math.floor(test*100-depth+0.5)),math.min(heightmap[hmi]+15, maxp.y) do
					local p_pos = area:index(x, y, z)
					pos = {x=x, y=y, z=z}
					data[p_pos] = c_air
				end
			end
			hmi = hmi+1
		end
	end
 	vm:set_data(data)
	vm:calc_lighting()
	vm:update_liquids()
	vm:write_to_map()

	if pos then
		local i
		for i=1,10 do
			pos2 = minetest.find_node_near({x=pos.x+math.random(-10,10), y=pos.y+math.random(-10,10), z=pos.z+math.random(-10,10)}, 40, {"group:stone"})
			if pos2 ~= nil then
				if math.random(10) > 5 then
					minetest.set_node(pos2, {name="default:lava_source"})
				else
					minetest.set_node(pos2, {name="default:water_source"})
				end
			end
		end
	end
 
end)


