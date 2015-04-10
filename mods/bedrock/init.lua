-- from https://github.com/4Evergreen4/minetest-tweaks/blob/master/bedrock.lua

BEDROCK_HEIGHT = -4000

--
--Bedrock Node
--
minetest.register_node("bedrock:bedrock", {
	description = "Bedrock",
	tiles = {"bedrock.png"},
	groups = { immortal = 1 },
})
--
--Generation of Bedrock
--
minetest.register_ore({
    ore_type       = "scatter",
    ore            = "bedrock:bedrock",
    wherein        = "default:stone",
    clust_scarcity = 1.5*1.5*1.5,
    clust_num_ores = 4,
    clust_size     = 4,
    height_min     = BEDROCK_HEIGHT-10,
    height_max     = BEDROCK_HEIGHT,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "bedrock:bedrock",
    wherein        = "default:air",
    clust_scarcity = 1.5*1.5*1.5,
    clust_num_ores = 4,
    clust_size     = 4,
    height_min     = BEDROCK_HEIGHT-10,
    height_max     = BEDROCK_HEIGHT,
})

minetest.register_ore({
    ore_type       = "scatter",
    ore            = "bedrock:bedrock",
    wherein        = "default:gravel",
    clust_scarcity = 1.5*1.5*1.5,
    clust_num_ores = 4,
    clust_size     = 4,
    height_min     = BEDROCK_HEIGHT-10,
    height_max     = BEDROCK_HEIGHT,
})


