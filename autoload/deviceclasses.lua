DoFile("gamemode.lua") -- Getting the gamemode from "gamemode.lua"

DeviceClass = {}

if GameMode == 1 then -- if we are playing Realistic, loading realistic version of deviceclasses.lua

	DoFile("Scripts/datatables/classtables/realistic/deviceclasses.lua")
	
	DeviceClass = RealisticTable

else -- if we are playing Arcade or if the value of "GameMode" is anything else but "0", defaulting to arcade version of deviceclasses.lua

	DoFile("Scripts/datatables/classtables/arcade/deviceclasses.lua")
	
	DeviceClass = ArcadeTable

end