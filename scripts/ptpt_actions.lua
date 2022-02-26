-- ptpt_actions

--==============================================================================

function TeleportToPlayer(player_index, destinations_frame)
  local player = game.players[player_index]
  local ui_player_list = destinations_frame.ptpt_player_list_dropdown
  local target_player_name = ui_player_list.get_item(ui_player_list.selected_index)
  local target_player = GetPlayerByName(target_player_name)
  local destination = target_player.position

  PerformTeleport(player, destination, target_player_name)
  CloseUI(player_index)
end -- TeleportToPlayer

--------------------------------------------------------------------------------

-- teleports player after checking if target is safe - loops until success / limit
function PerformTeleport(player, destination, destination_name) 
  local surface = global.ptpt.surface

  -- loop until valid teleport destination can be found
  local valid_dest = false
  local count = 0
  while valid_dest == false and count <= 100 do
    if surface.can_place_entity({ name = "character", position = destination }) then
      valid_dest = true
    else
      destination.x = destination.x + GetRandomAmount(WOBBLE/2)
      destination.y = destination.y + GetRandomAmount(WOBBLE/2)
    end
    count = count + 1 -- limits to prevent infinate loop
  end

  local result = false
  if valid_dest then
    game.print( {"",  {"text.ptpt_mod_print_name"}, {"text.ptpt_teleported"}, player.name, {"text.ptpt_to"}, destination_name, "  (", destination.x, ",", destination.y, ") "} )
    result = player.teleport(destination, surface)
  end
  
  if result == false then
    game.print( {"",  {"text.ptpt_mod_print_name"}, {"text.unable_to_teleport"}, player.name, {"text.ptpt_to"}, destination_name, "  (", destination.x, ",", destination.y, ") ", {"text.count"}, count} )
  end
end -- PerformTeleport
