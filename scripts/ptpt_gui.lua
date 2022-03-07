-- ptpt_gui

local mod_gui = require("mod-gui")

--==============================================================================

function SetupPlayerUI( player_index )
  local player = game.players[player_index]

  --remove any old ui frame component
  if (player.gui["left"][player_index .. "_ptpt_frame"]) then
      player.gui["left"][player_index .. "_ptpt_frame"].destroy()
  end

  --setup new button, start by removing old button if it exists
  if (mod_gui.get_button_flow(player).ptpt_control_destinations) then
      mod_gui.get_button_flow(player).ptpt_control_destinations.destroy()
  end

  mod_gui.get_button_flow(player).add {
      type = "sprite-button",
      name = "ptpt_control_destinations",
      tooltip = {"gui.ptpt_button_destinations"},
      sprite = "entity/character",
      style = "mod_gui_button"
  }
end -- SetupPlayerUI

-------------------------------------------------------------------------------

function OpenUI(player_index)
  local player = game.players[player_index]
  local gui = player.gui.left
  local destinations_frame =
      gui.add {
      type = "frame",
      name = "ptpt_destinations_frame",
      direction = "vertical",
      caption = {"gui.ptpt_text_title_destinations"}
  }
  
  -- add drop down
  local player_names = BuildPlayerNameList()
  destinations_frame.add({
    type = "drop-down",
    name = "ptpt_player_list_dropdown",
    items = player_names,
    selected_index = 1
  })

  -- add button to teleport
  destinations_frame.add({
    type = "button",
    name = "ptpt_teleport_button"
  })

  -- only enable teleport button if enabled in settings
  if settings.global["ptpt_teleport_to_player"].value == true then
    destinations_frame["ptpt_teleport_button"].enabled = true
    destinations_frame["ptpt_teleport_button"].caption = {"gui.ptpt_button_teleport_enabled"}
  else
    destinations_frame["ptpt_teleport_button"].enabled = false
    destinations_frame["ptpt_teleport_button"].caption = {"gui.ptpt_button_teleport_disabled"}
  end
  global.ptpt[player_index].show_players = true
end -- OpenUI

--------------------------------------------------------------------------------

function CloseUI(player_index)
  local player = game.players[player_index]
  if (player) then
      if player.gui.left.ptpt_destinations_frame then
        player.gui.left.ptpt_destinations_frame.destroy()
      end
  end
  global.ptpt[player_index].show_players = false
end -- CloseUI

--------------------------------------------------------------------------------
