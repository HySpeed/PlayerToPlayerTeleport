-- ptpt_utils

--==============================================================================

function BuildPlayerNameList()
  local player_list = {}
  local online_player_names = {}
  local offline_player_names = {}
  local show_offline = settings.global["ptpt_show_offline_players"].value

  for _, player in pairs( game.players ) do
    if player.connected  then
      table.insert( online_player_names, player.name )
    else
      if show_offline == true then
        local name = player.name .. OFFLINE
        table.insert( offline_player_names, name )
      end
    end
  end

  table.sort( online_player_names )
  player_list = online_player_names

  if next( offline_player_names ) ~= nil then -- ensure offline is not empty
    table.sort( offline_player_names )
    for _, player_name in pairs( offline_player_names ) do
      table.insert( player_list, player_name )
    end
  end

  return player_list
end -- BuildPlayerNameList

-------------------------------------------------------------------------------

function GetPlayerByName( chosen_name )
  local search_name = chosen_name

  -- trim the ' (OFFLINE)' from the chosen name if there
  local offline_index = string.find(chosen_name, OFFLINE, 1, true)
  if offline_index ~= nil then
    search_name = string.sub(chosen_name, 1, offline_index-1)
  end

  for _, player in pairs( game.players ) do
    if player.name == search_name then
      return player
    end
  end
end -- GetPlayerByName

-------------------------------------------------------------------------------

function SkipIntro()
  -- Removes crashsite and cutscene start
	-- Skips popup message to press tab to start playing
  if remote.interfaces["freeplay"] then -- In "sandbox" mode, freeplay is not available
    remote.call( "freeplay", "set_disable_crashsite", true )
    remote.call( "freeplay", "set_skip_intro", true )
  end
end -- SkipIntro

--------------------------------------------------------------------------------

function GetRandomAmount( limit )
-- return a random non-zero value from negative to positive given value
  local result = 0
  while result == 0 do
    result = math.random( -limit, limit )
  end
  return result
end -- GetRandomAmount

--------------------------------------------------------------------------------
