surface.CreateFont("LCD", 50, 400, true, false, "LCD_Large");
surface.CreateFont("LCD", 125, 400, true, false, "LCD_ExtraLarge");
GM.EffectsOn = CreateClientConVar( "gmr_effects", "1", true, false )
GM.LightsOn = CreateClientConVar( "gmr_lights", "1", true, false )

include("cl_setup.lua");
include("shared.lua")
include("cl_networking.lua");
include("cl_draw.lua");
include("garage.lua");
include("help_menu.lua");
include("cl_misc.lua");
include("cl_draw_scoreboard.lua");
include("cl_leaderscreen.lua");
include("draw_race.lua");
include("draw_demo.lua");
