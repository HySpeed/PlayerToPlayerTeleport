-- ptpt_actions

--==============================================================================

function TeleportToPlayer( player_index, destinations_uiframe )
-- teleports player after checking if target is safe - loops until success / limit
  local player = game.players[player_index]
  local ui_player_list = destinations_uiframe.ptpt_player_list_dropdown
  local target_player_name = ui_player_list.get_item( ui_player_list.selected_index )
  local target_player = GetPlayerByName(target_player_name)
  local target_position = { x = target_player.position.x, y = target_player.position.y }

  local tp_allowed_from = CheckTpAwayAllowed( player )
  local tp_allowed_to = CheckTpToAllowed( target_player )
  if tp_allowed_from and tp_allowed_to then
    local valid_dest, count = FindTeleportDestination( target_player, target_position )
    PerformTeleport( player, target_player, target_position, valid_dest, count )
  end

end -- TeleportToPlayer

--------------------------------------------------------------------------------

function FindTeleportDestination( target_player, target_position ) 
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
  return valid_dest, count
end -- FindTeleportDestination

--------------------------------------------------------------------------------

function PerformTeleport( player, target_player, target_position, valid_dest, count ) 
  local result = false
  if valid_dest then
    game.print( {"",  {"text.ptpt_mod_print_name"}, {"text.ptpt_teleported"}, player.name, 
        {"text.ptpt_to"}, target_player.name, "  (", target_player.position.x, ",", target_player.position.y, ") "} )
    result = player.teleport(target_position, target_player.surface)
  end
  
  if result == false then
    game.print( {"",  {"text.ptpt_mod_print_name"}, {"text.ptpt_tp_failed_no_destiation"}, player.name, 
        {"text.ptpt_to"}, target_player.name, "  (", target_position.x, ",", 
        target_position.y, ") ", {"text.ptpt_count"}, count} )
  end
end -- PerformTeleport

--------------------------------------------------------------------------------

function CheckTpAwayAllowed( player )
-- if 'tp away' limiting is enabled and there are biters near the teleporting player, deny the teleport
  local allowed = true

  if settings.global["ptpt_allow_tp_away_from_biters"].value == false then
    local check_range = settings.global["ptpt_distance_tp_away"].value
    local enemies = {}
    enemies = player.surface.find_entities_filtered( {position = player.position, radius = check_range, force = "enemy"} )
    if #enemies > 0 then
      allowed = false
      game.print( {"", {"text.ptpt_mod_print_name"}, {"text.ptpt_tp_denied_biters_near_source"}, player.name } )
    end
  end
  return allowed
end -- CheckTpAwayAllowed

--------------------------------------------------------------------------------

function CheckTpToAllowed( target_player )
-- if 'tp to' limiting is enabled and there are biters near the target player, deny the teleport
  local allowed = true

  if settings.global["ptpt_allow_tp_to_nearby_biters"].value == false then
    local check_range = settings.global["ptpt_distance_tp_to"].value
    local  enemies = {}
    enemies = target_player.surface.find_entities_filtered( {position = target_player.position, radius = check_range, force = "enemy"} )
    if #enemies > 0 then
      allowed = false
      game.print( {"", {"text.ptpt_mod_print_name"}, {"text.ptpt_tp_denied_biters_near_target"}, target_player.name } )
    end
  end
  return allowed
end -- CheckTpToAllowed

--------------------------------------------------------------------------------

