--init.lua
local active_tracks = {}

-- some classic C64 game chiptunes:
local discs = {
	-- Track name                                           Color
	{ "Critical Mass",                                      "yellow", },
	{ "Project Stealth Fighter (J.S. Bach)",                "blue",   },
	{ "Adidas Championship Football",                       "pink",   },
	{ "Out Run",                                            "green",  },
	{ "Back To The Future II",                              "red",    },
	{ "Airwolf",                                            "white", },
}

-- jukebox crafting

minetest.register_craft({
	output = 'jdukebox:box',
	recipe = {
		{'group:wood', 'group:wood', 'group:wood'},
		{'default:mese_crystal', 'default:diamond', 'default:mese_crystal'},
		{'group:wood', 'group:wood', 'group:wood'},
	}
})

--jdukebox

minetest.register_node("jdukebox:box", {
	description = "Jukebox",
	tiles = {"jdukebox_top.png", "deco_wood_oak_planks.png", "jdukebox_side.png"},
	--sounds = default.node_sounds_wood_defaults(),
	--paramtype = "facedir",
	groups = {oddly_breakable_by_hand=1, flammable=1, choppy=3},
	on_punch = function(pos, node, puncher, pointed_thing)
		if not puncher then return end

		local plname = puncher:get_player_name()
		if not plname then return end

		local wield = puncher:get_wielded_item():get_name()

		local track = active_tracks[plname]
		if track then
			local sound = track.sound
			local discid = track.disc
			pos.y = pos.y + 1
			minetest.add_item(pos, "jdukebox:disc_"..discid)
			minetest.sound_stop(sound)
			active_tracks[plname] = nil
		else
			local discid = wield:match("jdukebox:disc_(%d)")
			if discid then
				discid = tonumber(discid)
				puncher:set_wielded_item("")
				local sound = minetest.sound_play("jukebox_track_"..discid, {
					to_player = plname,
					--max_hear_distance = 16,
					gain = 10,
					loop = true
				})
				active_tracks[plname] = { disc=discid, sound=sound }
			end
		end
	end,
})

-- welcome to the jukebox, we got music and discs

for i = 1, #discs do
	local track_name, dye = discs[i][1], discs[i][2]

	minetest.register_alias("jdukebox:box"..i, "jdukebox:box")

	minetest.register_craftitem("jdukebox:disc_"..i, {
		description = track_name,
		inventory_image = "jdukebox_disc_"..i..".png",
		stack_max = 1,
	})

	minetest.register_craft({
		output = "jdukebox:disc_"..i,
		recipe = {
			{"default:coal_lump", "default:coal_lump", "default:coal_lump"},
			{"default:coal_lump", "dye:"..dye, "default:coal_lump"},
			{"default:coal_lump", "default:coal_lump", "default:coal_lump"},
		}
	})

end
