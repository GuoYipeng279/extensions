DoFile("gamemode.lua") -- Getting the gamemode "gamemode.lua"

ReconClass = {}

if GameMode == 1 then -- if we are playing Realistic, loading realistic version of reconclasses.lua

	DoFile("Scripts/datatables/classtables/realistic/reconclasses.lua")
	
	ReconClass = RealisticTable

else -- if we are playing Arcade or if the value of "GameMode" is anything else but "0", defaulting to arcade version of reconclasses.lua

	DoFile("Scripts/datatables/classtables/arcade/reconclasses.lua")
	
	ReconClass = ArcadeTable

end