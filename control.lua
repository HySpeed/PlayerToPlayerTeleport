-- control

local mod_gui = require("mod-gui")
require("config")
require("scripts/ptpt_actions")
require("scripts/ptpt_gui")
require("scripts/ptpt_utils")

--==============================================================================

script.on_init(function() Init() end)
script.on_event(defines.events.on_runtime_mod_setting_changed, function(event) RuntimeSettingChanged(event) end)

script.on_event(defines.events.on_player_created,     function(event) PlayerCreated(event) end)
script.on_event(defines.events.on_player_joined_game, function(event) PlayerJoined(event) end)

script.on_event(defines.events.on_gui_click,          function(event) ProcessGuiEvent(event) end)

--------------------------------------------------------------------------------

function Init()
  SkipIntro()
  for _, player in pairs( game.players ) do
    SetupPlayer( player.index )
  end
end -- Init

--------------------------------------------------------------------------------

function PlayerCreated( event )
  SetupPlayer( event.player_index )
end -- PlayerCreated

--------------------------------------------------------------------------------

function PlayerJoined( event )
-- NOTE: ONLY ENABLE DURING DEVELOPMENT
    EnableDevConfiguration()
-- ^^ development only

  SetupPlayer( event.player_index )
end -- PlayerJoined

--------------------------------------------------------------------------------

function RuntimeSettingChanged( event )
  for _, player in pairs( game.players ) do
    SetupPlayer( player.index )
  end
end -- RuntimeSettingChanged

--==============================================================================

function SetupPlayer( player_index )
  if not global.ptpt then
    global.ptpt = {}
    global.ptpt.surface = game.surfaces[SURFACE_NAME]
  end

  if not global.ptpt[player_index] then
    global.ptpt[player_index] = {
      show_teleport = false
    }
  end

  SetupPlayerUI( player_index )
end -- SetupPlayer

--------------------------------------------------------------------------------

function ProcessGuiEvent( event )
  -- if dialog is open, close it.  If closed, open it
  local player_index = event.player_index
  if global.ptpt and event.element.name == "ptpt_control_destinations" then
    if global.ptpt[player_index].show_players then
        CloseUI( player_index )
    else
        OpenUI( player_index )
    end
  elseif global.ptpt and event.element.name == "ptpt_teleport_button" then
    TeleportToPlayer( player_index, event.element.parent )
  end
end -- ProcessGuiEvent

--------------------------------------------------------------------------------
