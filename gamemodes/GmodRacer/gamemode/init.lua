AddCSLuaFile("cl_init.lua");
AddCSLuaFile("shared.lua");
AddCSLuaFile("player_methods.lua");
AddCSLuaFile("cl_draw.lua");
AddCSLuaFile("cl_networking.lua");
AddCSLuaFile("default_stats.lua");
AddCSLuaFile("garage.lua");
AddCSLuaFile("cl_setup.lua");
AddCSLuaFile("help_menu.lua");
AddCSLuaFile("maps_setup.lua");
AddCSLuaFile("cl_misc.lua");
AddCSLuaFile("cl_draw_scoreboard.lua");
AddCSLuaFile("cl_leaderscreen.lua");
AddCSLuaFile("draw_demo.lua");
AddCSLuaFile("draw_race.lua");

RunConsoleCommand("sv_allowdownload", "1");
RunConsoleCommand("sv_allowupload", "1");
RunConsoleCommand("net_maxfilesize", "64");


function GM:PlayerNoClip ( Player )
	if Player:Team() == 0 then
		return false;
	else
		return true;
	end
end


RunConsoleCommand('mp_falldamage', '1');
RunConsoleCommand('lua_log_sv', '1');
--RunConsoleCommand('sv_downloadurl', 'http://0m3gaserver.info/fastdownload/gmr/orangebox/garrysmod'); -- NO >:|
RunConsoleCommand('net_maxfilesize', '64');
RunConsoleCommand('sv_alltalk', '1');
ChatName = "#1 | GMR";

resource.AddFile("resource/fonts/lcd.ttf");

local Folder = string.Replace( GM.Folder, "gamemodes/", "" );

for k, v in pairs(file.Find(Folder.."sound/gmracer/*", "THIRDPARTY")) do
	resource.AddFile("sound/gmracer/" .. v);
end

for k, v in pairs(file.Find("*.wav", "GAME" .. "sound/vehicles/junker/")) do
	resource.AddFile("sound/vehicles/junker/" .. v);
end

for k, v in pairs(file.Find("*", "GAME" .. "materials/gmracer/*")) do
	resource.AddFile("materials/gmracer/" .. v);
end

for k, v in pairs(file.Find("*", "GAME" .. "materials/maps/")) do
	resource.AddFile("materials/maps/" .. v);
end

for k, v in pairs(file.Find(Folder.."materials/buggy_reskins/*", "THIRDPARTY")) do
	resource.AddFile("materials/buggy_reskins/" .. v);
end

for k, v in pairs(file.Find("*", "GAME" .. "models/carparts/")) do
	resource.AddFile("models/carparts/" .. v);
end

for k, v in pairs(file.Find("*", "GAME" .. "materials/spoilers/")) do
	resource.AddFile("materials/spoilers/" .. v);
end

for k, v in pairs(file.Find("*", "GAME" .. "materials/models/spoilers/")) do
	resource.AddFile("materials/models/spoilers/" .. v);
end


include("sv_setup.lua");
include("shared.lua");
include("sv_binds.lua");
include("sv_networking.lua");
include("jeep_template.lua");
include("think.lua");
include("sv_helpers.lua");
include("melbourne.lua");

GM.SpawnCarParts = true;
GM.AllowTestVehicle = true;
GM.AllowVehicleDebris = true;

concommand.Add("gmr_givecash", function(ply, argStr) 
local arg1 = ply
local arg2 = argStr
local arg3 = true
GAMEMODE.GiveCash(arg1,arg2,arg3) 
end )
function GM.GiveCash ( Player, Text, Bool )
	local ExplodedString = string.Explode(" ", string.lower(Text));
	
	if Player:Team() > 4 then Player:PrintMessage(HUD_PRINTTALK, "Sorry, but you must be a VIP to give cash to other players."); return false; end
	
	local PlayerPart = ExplodedString[2];
	local ToGive = math.Round(tonumber(ExplodedString[3]));
	
	if !ToGive then Player:PrintMessage(HUD_PRINTTALK, "You must enter a number value. Example: !Give John 5"); return false; end
	if !PlayerPart then Player:PrintMessage(HUD_PRINTTALK, "You must enter a player's partial name. Example: !Give John 5"); return false; end
	if ToGive <= 0 then Player:PrintMessage(HUD_PRINTTALK, "You must give a positive number!"); return false; end
	if ToGive > Player:GetCash() then Player:PrintMessage(HUD_PRINTTALK, "You don't have enough cash for that!"); return false; end
	
	local Player_ToGive= nil;
	local NumberFound = 0;
							
	for k, v in pairs(player.GetAll()) do
		if string.find(string.lower(v:Nick()), PlayerPart) then
			Player_ToGive = v;
			NumberFound = NumberFound + 1;
		end
	end
							
	if !Player_ToGive then Player:PrintMessage(HUD_PRINTTALK, "Could not find a player with '" .. PlayerPart .. "' in their name!"); return false; end
	if NumberFound != 1 then Player:PrintMessage(HUD_PRINTTALK, "More than one user with '" .. PlayerPart .. "' in their name!"); return false; end
	
	Player_ToGive:PrintMessage(HUD_PRINTTALK, "You received $" .. ToGive .. " from " .. Player:Nick() .. ".");
	Player:PrintMessage(HUD_PRINTTALK, "You sent $" .. ToGive .. " to " .. Player_ToGive:Nick() .. ".");
									
	Player_ToGive:AddCash(ToGive);
	Player:AddCash(ToGive * -1);
end
--AddChatCommand('give', GM.GiveCash);


function GM.SetTeam ( Player, Hint )
	Player:SetTeam(Hint);
end