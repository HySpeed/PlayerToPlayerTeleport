-- settings.lua

-- runtime-global settings (can be changed in game)
data:extend({
  {
  type = "bool-setting",
  name = "ptpt_teleport_to_player",
  setting_type = "runtime-global",
  default_value = true,
  order = "b"
  },
  {
    type = "bool-setting",
    name = "ptpt_show_offline_players",
    setting_type = "runtime-global",
    default_value = true,
    order = "d"
  },
  {
    type = "bool-setting",
    name = "ptpt_allow_tp_away_from_biters",
    setting_type = "runtime-global",
    default_value = true,
    order = "f"
  },
  {
    type = "double-setting",
    name = "ptpt_distance_tp_away",
    setting_type = "runtime-global",
    default_value = 10,
    minimum_value = 1,
    order = "g"
  },
  {
    type = "bool-setting",
    name = "ptpt_allow_tp_to_nearby_biters",
    setting_type = "runtime-global",
    default_value = true,
    order = "h"
  },
  {
    type = "double-setting",
    name = "ptpt_distance_tp_to",
    setting_type = "runtime-global",
    default_value = 10,
    minimum_value = 1,
    order = "i"
  }
})