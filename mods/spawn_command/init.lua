
spawn_command = {}
spawn_command.pos = {x=-62, y=3, z=-43}

if minetest.setting_get_pos("static_spawnpoint") then
    spawn_command.pos = minetest.setting_get_pos("static_spawnpoint")
end

minetest.register_chatcommand("spawn", {
    description = "Teleport you to spawn point.",
    func = function(name)
        local player = minetest.get_player_by_name(name)
        if player == nil then
            -- just a check to prevent the server crashing
            return false
        end
        local pos = player:getpos()
        player:setpos(spawn_command.pos)
       -- player:set_look_yaw(1.6)
        minetest.chat_send_player(name, "Teleported to spawn!")
    end,
})
