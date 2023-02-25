DoFile("gamemode.lua") -- Getting the gamemode from "gamemode.lua"

Bullets = {}
	
if GameMode == 1 then -- if we are playing Realistic, loading realistic version of bulletclasses.lua

	DoFile("Scripts/datatables/classtables/realistic/bulletclasses.lua")
	
	Bullets = RealisticTable

else -- if we are playing Arcade or if the value of "GameMode" is anything else but "0", defaulting to arcade version of bulletclasses.lua

	DoFile("Scripts/datatables/classtables/arcade/bulletclasses.lua")
	
	Bullets = ArcadeTable

end