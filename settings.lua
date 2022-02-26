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
  }
})