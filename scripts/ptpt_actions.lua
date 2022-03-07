-- ptpt_actions

--==============================================================================

function TeleportToPlayer( player_index, destinations_uiframe )
-- teleports player after checking if target is safe - loops until success / limit
  local player = game.players[player_index]
  local ui_player_list = destinations_uiframe.ptpt_player_list_dropdown
  local target_player_name = ui_player_list.get_item( ui_player_list.selected_index )
  local target_player = GetPlayerByName(target_player_name)
  local target_position = target_player.position

  -- loop until valid teleport position can be found
  local valid_dest = false
  local count = 0
  while valid_dest == false and count < 100 do
    if target_player.surface.can_place_entity({ name = "character", position = target_position }) then
      valid_dest = true
    else
      target_position.x = target_position.x + GetRandomAmount( WOBBLE / 2 )
      target_position.y = target_position.y + GetRandomAmount( WOBBLE / 2 )
    end
    count = count + 1 -- limit to prevent infinate loop
  end

  local result = false
  if valid_dest then
    game.print( {"",  {"text.ptpt_mod_print_name"}, {"text.ptpt_teleported"}, player.name, 
        {"text.ptpt_to"}, target_player.name, "  (", target_player.position.x, ",", target_player.position.y, ") "} )
    result = player.teleport(target_position, target_player.surface)
  end
  
  if result == false then
    game.print( {"",  {"text.ptpt_mod_print_name"}, {"text.ptpt_unable_to_teleport"}, player.name, 
        {"text.ptpt_to"}, target_player.name, "  (", target_position.x, ",", 
        target_position.y, ") ", {"text.ptpt_count"}, count} )
  end
end -- TeleportToPlayer

--------------------------------------------------------------------------------

function PerformTeleport(player, target_player, destination_name) 
end -- PerformTeleport
