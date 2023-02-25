--SceneFile="Missions\Multi\Scene13.scn"

function luaPrecacheUnits()
	PrepareClass(314) -- Lexington
	PrepareClass(315) -- Yorktown
	PrepareClass(25) -- Clemson
	PrepareClass(27) -- Elco PT
	PrepareClass(112) -- Devastator
	PrepareClass(108) -- Dauntless
	PrepareClass(134) -- Hurricane
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAC13Mission")
end

function luaInitQAC13Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Comp13"..dateandtime

	Mission.HelperLog = false
	Mission.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.."!")
	
	-- lokalizacios feltoltesek
	--AddLockitPathToSelection("missionglobals")
	--LoadSelectedPaths()

	-- lobby
-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")

	if LobbySettings.TimeLimit == "globals.none" then
		Mission.LobbyCountDown = 0
	elseif LobbySettings.TimeLimit == "globals.5m" then
		Mission.LobbyCountDown = 5 * 60
	elseif LobbySettings.TimeLimit == "globals.10m" then
		Mission.LobbyCountDown = 10 * 60
	elseif LobbySettings.TimeLimit == "globals.15m" then
		Mission.LobbyCountDown = 15 * 60
	elseif LobbySettings.TimeLimit == "globals.20m" then
		Mission.LobbyCountDown = 20 * 60
	elseif LobbySettings.TimeLimit == "globals.25m" then
		Mission.LobbyCountDown = 25 * 60
	elseif LobbySettings.TimeLimit == "globals.30m" then
		Mission.LobbyCountDown = 30 * 60
	else
-- RELEASE_LOGOFF  		luaLog(" LobbySettings.TimeLimit contains non-handled string | LobbySettings.TimeLimit: "..LobbySettings.TimeLimit)
		Mission.LobbyCountDown = 0
	end

	if LobbySettings.PointLimit == "globals.none" then
		Mission.PointLimit = 0
	elseif LobbySettings.PointLimit == "500" then
		Mission.PointLimit = 500
	elseif LobbySettings.PointLimit == "1000" then
		Mission.PointLimit = 1000
	elseif LobbySettings.PointLimit == "2000" then
		Mission.PointLimit = 2000
	elseif LobbySettings.PointLimit == "3000" then
		Mission.PointLimit = 3000
	elseif LobbySettings.PointLimit == "4000" then
		Mission.PointLimit = 4000
	elseif LobbySettings.PointLimit == "5000" then
		Mission.PointLimit = 5000
	else
-- RELEASE_LOGOFF  		luaLog(" LobbySettings.PointLimit contains non-handled string | LobbySettings.PointLimit: "..LobbySettings.PointLimit)
		Mission.PointLimit = 0
	end

	-- globalban hasznalando
	this.Multiplayer = true
	this.ThinkCounter = 0
	Mission.MultiplayerType = "Competitive"
	Mission.MultiplayerNumber = 13
	Mission.CompetitiveParty = PARTY_JAPANESE

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- mission tablak, valtozok
	Mission.US = {}
	Mission.Jap = {}

	-- spawn pontok
	Mission.Jap.HiryuPoint = FindEntity("Comp - HiryuPoint")
	Mission.Jap.SoryuPoint = FindEntity("Comp - SoryuPoint")

	-- amerikai objektumok
	Mission.US.Carriers = {}
		table.insert(Mission.US.Carriers, luaFindHidden("Comp - Lexington"))
		table.insert(Mission.US.Carriers, luaFindHidden("Comp - Yorktown"))

	Mission.US.CarrierPaths = {}
		table.insert(Mission.US.CarrierPaths, FindEntity("Comp - LexigtonPath"))
		table.insert(Mission.US.CarrierPaths, FindEntity("Comp - YorktownPath"))

	Mission.US.CV1EntryPoints = {}
		table.insert(Mission.US.CV1EntryPoints, GetPosition(FindEntity("Comp - USCV1EnrtyPoint 1")))
		table.insert(Mission.US.CV1EntryPoints, GetPosition(FindEntity("Comp - USCV1EnrtyPoint 2")))
	Mission.US.CV2EntryPoints = {}
		table.insert(Mission.US.CV2EntryPoints, GetPosition(FindEntity("Comp - USCV2EnrtyPoint 1")))
		table.insert(Mission.US.CV2EntryPoints, GetPosition(FindEntity("Comp - USCV2EnrtyPoint 2")))

	Mission.US.HQsSouth = {}
		table.insert(Mission.US.HQsSouth, FindEntity("Escort - US CC 01"))
		table.insert(Mission.US.HQsSouth, FindEntity("Escort - US CC 02"))
		table.insert(Mission.US.HQsSouth, FindEntity("Escort - US CC 03"))
	Mission.US.SYsSouth = {}
		table.insert(Mission.US.SYsSouth, FindEntity("Comp - South CC 1 Hangar Entity"))
		table.insert(Mission.US.SYsSouth, FindEntity("Comp - South CC 2 Hangar Entity"))
		table.insert(Mission.US.SYsSouth, FindEntity("Comp - South CC 3 Hangar Entity"))
	Mission.US.SYsBuildingSouth = {}
		table.insert(Mission.US.SYsBuildingSouth, FindEntity("Comp - South CC 1 Hangar Building"))
		table.insert(Mission.US.SYsBuildingSouth, FindEntity("Comp - South CC 2 Hangar Building"))
		table.insert(Mission.US.SYsBuildingSouth, FindEntity("Comp - South CC 3 Hangar Building"))
	Mission.US.CCLandfortsSouth = {}
	Mission.US.CCLandfortsSouth[1] = {}
	Mission.US.CCLandfortsSouth[2] = {}
	Mission.US.CCLandfortsSouth[3] = {}
		--1
		table.insert(Mission.US.CCLandfortsSouth[1], FindEntity("Escort - US CC 1 HAA 1"))
		table.insert(Mission.US.CCLandfortsSouth[1], FindEntity("Escort - US CC 1 HAA 2"))
		table.insert(Mission.US.CCLandfortsSouth[1], FindEntity("Escort - US CC 1 HAA 3"))
		table.insert(Mission.US.CCLandfortsSouth[1], FindEntity("Escort - US CC 1 CG 1"))
		table.insert(Mission.US.CCLandfortsSouth[1], FindEntity("Escort - US CC 1 CG 2"))
		table.insert(Mission.US.CCLandfortsSouth[1], FindEntity("Escort - US CC 1 CG 3"))
		table.insert(Mission.US.CCLandfortsSouth[1], FindEntity("Escort - US CC 1 F 1"))
		table.insert(Mission.US.CCLandfortsSouth[1], FindEntity("Escort - US CC 1 F 2"))
		table.insert(Mission.US.CCLandfortsSouth[1], FindEntity("Escort - US CC 1 HAA 4"))
		table.insert(Mission.US.CCLandfortsSouth[1], FindEntity("Escort - US CC 1 HAA 5"))
		table.insert(Mission.US.CCLandfortsSouth[1], FindEntity("Escort - US CC 1 HAA 6"))
		table.insert(Mission.US.CCLandfortsSouth[1], FindEntity("Escort - US CC 1 CG 4"))
		table.insert(Mission.US.CCLandfortsSouth[1], FindEntity("Escort - US CC 1 CG 5"))
		table.insert(Mission.US.CCLandfortsSouth[1], FindEntity("Escort - US CC 1 CG 6"))
		--2
		table.insert(Mission.US.CCLandfortsSouth[2], FindEntity("Escort - US CC 2 HAA 1"))
		table.insert(Mission.US.CCLandfortsSouth[2], FindEntity("Escort - US CC 2 HAA 2"))
		table.insert(Mission.US.CCLandfortsSouth[2], FindEntity("Escort - US CC 2 HAA 3"))
		table.insert(Mission.US.CCLandfortsSouth[2], FindEntity("Escort - US CC 2 CG 1"))
		table.insert(Mission.US.CCLandfortsSouth[2], FindEntity("Escort - US CC 2 CG 2"))
		table.insert(Mission.US.CCLandfortsSouth[2], FindEntity("Escort - US CC 2 CG 3"))
		table.insert(Mission.US.CCLandfortsSouth[2], FindEntity("Escort - US CC 2 F 1"))
		table.insert(Mission.US.CCLandfortsSouth[2], FindEntity("Escort - US CC 2 HAA 4"))
		table.insert(Mission.US.CCLandfortsSouth[2], FindEntity("Escort - US CC 2 HAA 5"))
		table.insert(Mission.US.CCLandfortsSouth[2], FindEntity("Escort - US CC 2 HAA 6"))
		table.insert(Mission.US.CCLandfortsSouth[2], FindEntity("Escort - US CC 2 CG 4"))
		table.insert(Mission.US.CCLandfortsSouth[2], FindEntity("Escort - US CC 2 CG 5"))
		table.insert(Mission.US.CCLandfortsSouth[2], FindEntity("Escort - US CC 2 CG 6"))
		--3
		table.insert(Mission.US.CCLandfortsSouth[3], FindEntity("Escort - US CC 3 HAA 1"))
		table.insert(Mission.US.CCLandfortsSouth[3], FindEntity("Escort - US CC 3 HAA 2"))
		table.insert(Mission.US.CCLandfortsSouth[3], FindEntity("Escort - US CC 3 HAA 3"))
		table.insert(Mission.US.CCLandfortsSouth[3], FindEntity("Escort - US CC 3 CG 1"))
		table.insert(Mission.US.CCLandfortsSouth[3], FindEntity("Escort - US CC 3 CG 2"))
		table.insert(Mission.US.CCLandfortsSouth[3], FindEntity("Escort - US CC 3 CG 3"))
		table.insert(Mission.US.CCLandfortsSouth[3], FindEntity("Escort - US CC 3 F 1"))
		table.insert(Mission.US.CCLandfortsSouth[3], FindEntity("Escort - US CC 3 HAA 4"))
		table.insert(Mission.US.CCLandfortsSouth[3], FindEntity("Escort - US CC 3 HAA 5"))
		table.insert(Mission.US.CCLandfortsSouth[3], FindEntity("Escort - US CC 3 HAA 6"))
		table.insert(Mission.US.CCLandfortsSouth[3], FindEntity("Escort - US CC 3 CG 4"))
		table.insert(Mission.US.CCLandfortsSouth[3], FindEntity("Escort - US CC 3 CG 5"))
		table.insert(Mission.US.CCLandfortsSouth[3], FindEntity("Escort - US CC 3 CG 6"))

	Mission.US.HQsNorth = {}
		table.insert(Mission.US.HQsNorth, FindEntity("Comp - US CC 06"))
		table.insert(Mission.US.HQsNorth, FindEntity("Comp - US CC 05"))
		table.insert(Mission.US.HQsNorth, FindEntity("Comp - US CC 04"))
	Mission.US.SYsNorth = {}
		table.insert(Mission.US.SYsNorth, FindEntity("Comp - North CC 1 Hangar Entity"))
		table.insert(Mission.US.SYsNorth, FindEntity("Comp - North CC 2 Hangar Entity"))
		table.insert(Mission.US.SYsNorth, FindEntity("Comp - North CC 3 Hangar Entity"))
	Mission.US.SYsBuildingNorth = {}
		table.insert(Mission.US.SYsBuildingNorth, FindEntity("Comp - North CC 1 Hangar Building"))
		table.insert(Mission.US.SYsBuildingNorth, FindEntity("Comp - North CC 2 Hangar Building"))
		table.insert(Mission.US.SYsBuildingNorth, FindEntity("Comp - North CC 3 Hangar Building"))
	Mission.US.CCLandfortsNorth = {}
	Mission.US.CCLandfortsNorth[1] = {}
	Mission.US.CCLandfortsNorth[2] = {}
	Mission.US.CCLandfortsNorth[3] = {}
		--1
		table.insert(Mission.US.CCLandfortsNorth[1], FindEntity("Comp - US CC 1 HAA 01"))
		table.insert(Mission.US.CCLandfortsNorth[1], FindEntity("Comp - US CC 1 HAA 02"))
		table.insert(Mission.US.CCLandfortsNorth[1], FindEntity("Comp - US CC 1 HAA 03"))
		table.insert(Mission.US.CCLandfortsNorth[1], FindEntity("Comp - US CC 1 CG 01"))
		table.insert(Mission.US.CCLandfortsNorth[1], FindEntity("Comp - US CC 1 CG 02"))
		table.insert(Mission.US.CCLandfortsNorth[1], FindEntity("Comp - US CC 1 CG 03"))
		table.insert(Mission.US.CCLandfortsNorth[1], FindEntity("Comp - US CC 1 F 01"))
		table.insert(Mission.US.CCLandfortsNorth[1], FindEntity("Comp - US CC 1 F 02"))
		table.insert(Mission.US.CCLandfortsNorth[1], FindEntity("Comp - US CC 1 HAA 04"))
		table.insert(Mission.US.CCLandfortsNorth[1], FindEntity("Comp - US CC 1 HAA 05"))
		table.insert(Mission.US.CCLandfortsNorth[1], FindEntity("Comp - US CC 1 HAA 06"))
		table.insert(Mission.US.CCLandfortsNorth[1], FindEntity("Comp - US CC 1 CG 04"))
		table.insert(Mission.US.CCLandfortsNorth[1], FindEntity("Comp - US CC 1 CG 05"))
		table.insert(Mission.US.CCLandfortsNorth[1], FindEntity("Comp - US CC 1 CG 06"))
		--2
		table.insert(Mission.US.CCLandfortsNorth[2], FindEntity("Comp - US CC 2 HAA 01"))
		table.insert(Mission.US.CCLandfortsNorth[2], FindEntity("Comp - US CC 2 HAA 02"))
		table.insert(Mission.US.CCLandfortsNorth[2], FindEntity("Comp - US CC 2 HAA 03"))
		table.insert(Mission.US.CCLandfortsNorth[2], FindEntity("Comp - US CC 2 CG 01"))
		table.insert(Mission.US.CCLandfortsNorth[2], FindEntity("Comp - US CC 2 CG 02"))
		table.insert(Mission.US.CCLandfortsNorth[2], FindEntity("Comp - US CC 2 CG 03"))
		table.insert(Mission.US.CCLandfortsNorth[2], FindEntity("Comp - US CC 2 F 01"))
		table.insert(Mission.US.CCLandfortsNorth[2], FindEntity("Comp - US CC 2 HAA 04"))
		table.insert(Mission.US.CCLandfortsNorth[2], FindEntity("Comp - US CC 2 HAA 05"))
		table.insert(Mission.US.CCLandfortsNorth[2], FindEntity("Comp - US CC 2 HAA 06"))
		table.insert(Mission.US.CCLandfortsNorth[2], FindEntity("Comp - US CC 2 CG 04"))
		table.insert(Mission.US.CCLandfortsNorth[2], FindEntity("Comp - US CC 2 CG 05"))
		table.insert(Mission.US.CCLandfortsNorth[2], FindEntity("Comp - US CC 2 CG 06"))
		--3
		table.insert(Mission.US.CCLandfortsNorth[3], FindEntity("Comp - US CC 3 HAA 01"))
		table.insert(Mission.US.CCLandfortsNorth[3], FindEntity("Comp - US CC 3 HAA 02"))
		table.insert(Mission.US.CCLandfortsNorth[3], FindEntity("Comp - US CC 3 HAA 03"))
		table.insert(Mission.US.CCLandfortsNorth[3], FindEntity("Comp - US CC 3 CG 01"))
		table.insert(Mission.US.CCLandfortsNorth[3], FindEntity("Comp - US CC 3 CG 02"))
		table.insert(Mission.US.CCLandfortsNorth[3], FindEntity("Comp - US CC 3 CG 03"))
		table.insert(Mission.US.CCLandfortsNorth[3], FindEntity("Comp - US CC 3 HAA 04"))
		table.insert(Mission.US.CCLandfortsNorth[3], FindEntity("Comp - US CC 3 HAA 05"))
		table.insert(Mission.US.CCLandfortsNorth[3], FindEntity("Comp - US CC 3 HAA 06"))
		table.insert(Mission.US.CCLandfortsNorth[3], FindEntity("Comp - US CC 3 CG 04"))
		table.insert(Mission.US.CCLandfortsNorth[3], FindEntity("Comp - US CC 3 CG 05"))
		table.insert(Mission.US.CCLandfortsNorth[3], FindEntity("Comp - US CC 3 CG 06"))
		table.insert(Mission.US.CCLandfortsNorth[3], FindEntity("Comp - US CC 3 F 01"))

--[[
	local buildingNumbers = {}
	buildingNumbers.HQsNorthNumber = table.getn(Mission.US.HQsNorth)
	buildingNumbers.CC1LFNorthNumber = table.getn(Mission.US.CCLandfortsNorth[1])
	buildingNumbers.CC2LFNorthNumber = table.getn(Mission.US.CCLandfortsNorth[2])
	buildingNumbers.CC3LFNorthNumber = table.getn(Mission.US.CCLandfortsNorth[3])
	local maxNumber = 0
	for index, value in pairs (buildingNumbers) do
		if value > maxNumber then
			maxNumber = value
		end
	end
	for i = 1, maxNumber do
		if i <= buildingNumbers.HQsNorthNumber then
			SetParty(Mission.US.HQsNorth[i], PARTY_ALLIED)
			SetRoleAvailable(Mission.US.HQsNorth[i], EROLF_ALL, PLAYER_AI)
		end
		if i <= buildingNumbers.CC1LFNorthNumber then
			SetParty(Mission.US.CCLandfortsNorth[1][i], PARTY_ALLIED)
			SetRoleAvailable(Mission.US.CCLandfortsNorth[1][i], EROLF_ALL, PLAYER_AI)
		end
		if i <= buildingNumbers.CC2LFNorthNumber then
			SetParty(Mission.US.CCLandfortsNorth[2][i], PARTY_ALLIED)
			SetRoleAvailable(Mission.US.CCLandfortsNorth[2][i], EROLF_ALL, PLAYER_AI)
		end
		if i <= buildingNumbers.CC3LFNorthNumber then
			SetParty(Mission.US.CCLandfortsNorth[3][i], PARTY_ALLIED)
			SetRoleAvailable(Mission.US.CCLandfortsNorth[3][i], EROLF_ALL, PLAYER_AI)
		end
	end
]]
	Mission.US.UnitType = {}
	Mission.US.UnitName = {}
	Mission.US.UnitType.DD = 25
	Mission.US.UnitName.DD = "globals.unitclass_clemson"
	Mission.US.UnitType.PT = 27
	Mission.US.UnitName.PT = "globals.unitclass_elco"
	Mission.US.UnitType.TB = 112
	Mission.US.UnitName.TB = "globals.unitclass_devastator"
	Mission.US.UnitType.DB = 108
	Mission.US.UnitName.DB = "globals.unitclass_dauntless"
	Mission.US.UnitType.F = 134
	Mission.US.UnitName.F = "globals.unitclass_hurricane"

	Mission.US.UnitTemplate = {}
	Mission.US.UnitTemplate.DD = {["Type"] = Mission.US.UnitType.DD, ["Name"] = Mission.US.UnitName.DD, ["Crew"] = 1, ["Race"] = USA, ["OwnerPlayer"] = PLAYER_AI,}
	Mission.US.UnitTemplate.PT = {["Type"] = Mission.US.UnitType.PT, ["Name"] = Mission.US.UnitName.PT, ["Crew"] = 1, ["Race"] = USA, ["OwnerPlayer"] = PLAYER_AI,}
	Mission.US.UnitTemplate.TB = {["Type"] = Mission.US.UnitType.TB, ["Name"] = Mission.US.UnitName.TB, ["Crew"] = 1, ["Race"] = USA, ["WingCount"] = 3, ["Equipment"] = 1, ["OwnerPlayer"] = PLAYER_AI,}
	Mission.US.UnitTemplate.DB = {["Type"] = Mission.US.UnitType.DB, ["Name"] = Mission.US.UnitName.DB, ["Crew"] = 1, ["Race"] = USA, ["WingCount"] = 3, ["Equipment"] = 1, ["OwnerPlayer"] = PLAYER_AI,}
	Mission.US.UnitTemplate.F = {["Type"] = Mission.US.UnitType.F, ["Name"] = Mission.US.UnitName.F, ["Crew"] = 1, ["Race"] = USA, ["WingCount"] = 3, ["Equipment"] = 0, ["OwnerPlayer"] = PLAYER_AI,}

	Mission.US.EntryPointsNorth = {}
		table.insert(Mission.US.EntryPointsNorth, GetPosition(FindEntity("Comp - USNorthEnrtyPoint 1")))
		table.insert(Mission.US.EntryPointsNorth, GetPosition(FindEntity("Comp - USNorthEnrtyPoint 2")))
		table.insert(Mission.US.EntryPointsNorth, GetPosition(FindEntity("Comp - USNorthEnrtyPoint 3")))
		table.insert(Mission.US.EntryPointsNorth, GetPosition(FindEntity("Comp - USNorthEnrtyPoint 4")))
	Mission.US.EntryPointsSouth = {}
		table.insert(Mission.US.EntryPointsSouth, GetPosition(FindEntity("Comp - USSouthEnrtyPoint 1")))
		table.insert(Mission.US.EntryPointsSouth, GetPosition(FindEntity("Comp - USSouthEnrtyPoint 2")))
		table.insert(Mission.US.EntryPointsSouth, GetPosition(FindEntity("Comp - USSouthEnrtyPoint 3")))
		table.insert(Mission.US.EntryPointsSouth, GetPosition(FindEntity("Comp - USSouthEnrtyPoint 4")))

	Mission.US.AttackerGroupNorth1 = {}
	Mission.US.AttackerGroupNorth2 = {}
	Mission.US.AttackerGroupNorth3 = {}
	Mission.US.AttackerGroupNorth4 = {}
	Mission.US.AttackerGroupSouth1 = {}
	Mission.US.AttackerGroupSouth2 = {}
	Mission.US.AttackerGroupSouth3 = {}
	Mission.US.AttackerGroupSouth4 = {}
	Mission.US.NonCarrierPlanes = {}

	-- japan objektumok
	Mission.Jap.Carriers = {}
		table.insert(Mission.Jap.Carriers, FindEntity("Comp - Hiryu"))
		table.insert(Mission.Jap.Carriers, FindEntity("Comp - Soryu"))

	-- utvonalak, navpontok
	Mission.Jap.CarrierPaths = {}
		table.insert(Mission.Jap.CarrierPaths, FindEntity("Comp - HiryuPath"))
		table.insert(Mission.Jap.CarrierPaths, FindEntity("Comp - SoryuPath"))

	-- egyeb
	Mission.Jap.Listener = {}
	Mission.Jap.Listener.Ranges = {}
	Mission.Jap.Listener.KillScore = {}
	Mission.Jap.Listener.Ranges.Ship = 15000
	Mission.Jap.Listener.Ranges.Plane = 15000
	Mission.Jap.Listener.KillScore.Ship = 175
	Mission.Jap.Listener.KillScore.Plane = 100

	Mission.US.GroupNorth1SpawnTime = 0
	Mission.US.GroupNorth2SpawnTime = 0
	Mission.US.GroupNorth3SpawnTime = 0
	Mission.US.GroupNorth4SpawnTime = 0
	Mission.US.GroupSouth1SpawnTime = 0
	Mission.US.GroupSouth2SpawnTime = 0
	Mission.US.GroupSouth3SpawnTime = 0
	Mission.US.GroupSouth4SpawnTime = 0
	Mission.US.GroupNorth1SpawnFlag = true
	Mission.US.GroupNorth2SpawnFlag = true
	Mission.US.GroupNorth3SpawnFlag = true
	Mission.US.GroupNorth4SpawnFlag = true
	Mission.US.GroupSouth1SpawnFlag = true
	Mission.US.GroupSouth2SpawnFlag = true
	Mission.US.GroupSouth3SpawnFlag = true
	Mission.US.GroupSouth4SpawnFlag = true

	-- jatekosok
-- RELEASE_LOGOFF  	luaLog("-- PLAYERS START --")
	Mission.Players = 0
	local players = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog(players)
-- RELEASE_LOGOFF  	luaLog("-- PLAYERS END --")
	for index, value in pairs (players) do
		if index == 0 then
			Mission.Player1 = true
		elseif index == 1 then
			Mission.Player2 = true
		elseif index == 2 then
			Mission.Player3 = true
		elseif index == 3 then
			Mission.Player4 = true
		elseif index == 4 then
			Mission.Player5 = true
		elseif index == 5 then
			Mission.Player6 = true
		elseif index == 6 then
			Mission.Player7 = true
		elseif index == 7 then
			Mission.Player8 = true
		end
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)
	if Mission.Players <= 2 then
		Mission.US.UnitTemplate.DDMin = 1
		Mission.US.UnitTemplate.DDMax = 1
		Mission.US.UnitTemplate.PTMin = 2
		Mission.US.UnitTemplate.PTMax = 2
		Mission.US.UnitTemplate.TBMin = 1
		Mission.US.UnitTemplate.TBMax = 2
		Mission.US.UnitTemplate.DBMin = 1
		Mission.US.UnitTemplate.DBMax = 2
		Mission.US.UnitTemplate.FMin = 1
		Mission.US.UnitTemplate.FMax = 2
	elseif Mission.Players == 3 then
		Mission.US.UnitTemplate.DDMin = 1
		Mission.US.UnitTemplate.DDMax = 1
		Mission.US.UnitTemplate.PTMin = 2
		Mission.US.UnitTemplate.PTMax = 2
		Mission.US.UnitTemplate.TBMin = 1
		Mission.US.UnitTemplate.TBMax = 2
		Mission.US.UnitTemplate.DBMin = 1
		Mission.US.UnitTemplate.DBMax = 2
		Mission.US.UnitTemplate.FMin = 1
		Mission.US.UnitTemplate.FMax = 2
	elseif Mission.Players == 4 then
		Mission.US.UnitTemplate.DDMin = 1
		Mission.US.UnitTemplate.DDMax = 2
		Mission.US.UnitTemplate.PTMin = 2
		Mission.US.UnitTemplate.PTMax = 3
		Mission.US.UnitTemplate.TBMin = 2
		Mission.US.UnitTemplate.TBMax = 2
		Mission.US.UnitTemplate.DBMin = 2
		Mission.US.UnitTemplate.DBMax = 2
		Mission.US.UnitTemplate.FMin = 2
		Mission.US.UnitTemplate.FMax = 2
	elseif Mission.Players == 5 then
		Mission.US.UnitTemplate.DDMin = 1
		Mission.US.UnitTemplate.DDMax = 2
		Mission.US.UnitTemplate.PTMin = 2
		Mission.US.UnitTemplate.PTMax = 3
		Mission.US.UnitTemplate.TBMin = 2
		Mission.US.UnitTemplate.TBMax = 2
		Mission.US.UnitTemplate.DBMin = 2
		Mission.US.UnitTemplate.DBMax = 2
		Mission.US.UnitTemplate.FMin = 2
		Mission.US.UnitTemplate.FMax = 2
	elseif Mission.Players == 6 then
		Mission.US.UnitTemplate.DDMin = 2
		Mission.US.UnitTemplate.DDMax = 2
		Mission.US.UnitTemplate.PTMin = 2
		Mission.US.UnitTemplate.PTMax = 3
		Mission.US.UnitTemplate.TBMin = 2
		Mission.US.UnitTemplate.TBMax = 3
		Mission.US.UnitTemplate.DBMin = 2
		Mission.US.UnitTemplate.DBMax = 3
		Mission.US.UnitTemplate.FMin = 2
		Mission.US.UnitTemplate.FMax = 3
	elseif Mission.Players == 7 then
		Mission.US.UnitTemplate.DDMin = 2
		Mission.US.UnitTemplate.DDMax = 2
		Mission.US.UnitTemplate.PTMin = 2
		Mission.US.UnitTemplate.PTMax = 3
		Mission.US.UnitTemplate.TBMin = 2
		Mission.US.UnitTemplate.TBMax = 3
		Mission.US.UnitTemplate.DBMin = 2
		Mission.US.UnitTemplate.DBMax = 3
		Mission.US.UnitTemplate.FMin = 2
		Mission.US.UnitTemplate.FMax = 3
	elseif Mission.Players == 8 then
		Mission.US.UnitTemplate.DDMin = 2
		Mission.US.UnitTemplate.DDMax = 2
		Mission.US.UnitTemplate.PTMin = 2
		Mission.US.UnitTemplate.PTMax = 3
		Mission.US.UnitTemplate.TBMin = 2
		Mission.US.UnitTemplate.TBMax = 3
		Mission.US.UnitTemplate.DBMin = 2
		Mission.US.UnitTemplate.DBMax = 3
		Mission.US.UnitTemplate.FMin = 2
		Mission.US.UnitTemplate.FMax = 3
	end

	if Mission.Players <= 2 then
		Mission.US.CV1PlaneNumber = 1
		Mission.US.CV2PlaneNumber = 1
	elseif Mission.Players == 3 then
		Mission.US.CV1PlaneNumber = 2
		Mission.US.CV2PlaneNumber = 1
	elseif Mission.Players == 4 then
		Mission.US.CV1PlaneNumber = 2
		Mission.US.CV2PlaneNumber = 2
	elseif Mission.Players == 5 then
		Mission.US.CV1PlaneNumber = 3
		Mission.US.CV2PlaneNumber = 2
	elseif Mission.Players == 6 then
		Mission.US.CV1PlaneNumber = 3
		Mission.US.CV2PlaneNumber = 3
	elseif Mission.Players == 7 then
		Mission.US.CV1PlaneNumber = 4
		Mission.US.CV2PlaneNumber = 3
	elseif Mission.Players == 8 then
		Mission.US.CV1PlaneNumber = 4
		Mission.US.CV2PlaneNumber = 4
	end

	if Mission.Players <= 2 then
		Mission.SecondWaveTimer = 150
		Mission.ThirdWaveTimer = 400
		Mission.FourthWaveTimer = 260
		Mission.RespawnTimer = 45
	elseif Mission.Players <= 4 then
		Mission.SecondWaveTimer = 130
		Mission.ThirdWaveTimer = 370
		Mission.FourthWaveTimer = 230
		Mission.RespawnTimer = 40
	elseif Mission.Players <= 6 then
		Mission.SecondWaveTimer = 110
		Mission.ThirdWaveTimer = 340
		Mission.FourthWaveTimer = 200
		Mission.RespawnTimer = 35
	else
		Mission.SecondWaveTimer = 100
		Mission.ThirdWaveTimer = 320
		Mission.FourthWaveTimer = 180
		Mission.RespawnTimer = 30
	end

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_JAPANESE,
				["PlayerIndex"] = 0,
				["ID"] = "us_obj_primary_1_player_1",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["PlayerIndex"] = 1,
				["ID"] = "us_obj_primary_1_player_2",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[3] = {
				["Party"] = PARTY_JAPANESE,
				["PlayerIndex"] = 2,
				["ID"] = "us_obj_primary_1_player_3",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_JAPANESE,
				["PlayerIndex"] = 3,
				["ID"] = "us_obj_primary_1_player_4",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[5] = {
				["Party"] = PARTY_JAPANESE,
				["PlayerIndex"] = 4,
				["ID"] = "us_obj_primary_1_player_5",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[6] = {
				["Party"] = PARTY_JAPANESE,
				["PlayerIndex"] = 5,
				["ID"] = "us_obj_primary_1_player_6",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[7] = {
				["Party"] = PARTY_JAPANESE,
				["PlayerIndex"] = 6,
				["ID"] = "us_obj_primary_1_player_7",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[8] = {
				["Party"] = PARTY_JAPANESE,
				["PlayerIndex"] = 7,
				["ID"] = "us_obj_primary_1_player_8",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[9] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "us_obj_primary_2",
				["Text"] = "mp13.obj_comp_p2_text",
				["TextCompleted"] = "mp13.obj_comp_p2_comp",
				["TextFailed"] = "mp13.obj_comp_p2_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] =	{
			[1] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "us_obj_secondary_1",
				["Text"] = "mp13.obj_comp_s1_text",
				["TextCompleted"] = "mp13.obj_comp_s1_comp",
				["TextFailed"] = "mp13.obj_comp_s1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "us_obj_secondary_2",
				["Text"] = "mp13.obj_comp_s2_text",
				["TextCompleted"] = "mp13.obj_comp_s2_comp",
				["TextFailed"] = "mp13.obj_comp_s2_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,
				["ScoreFailed"] = 0
			},
		},
		["hidden"] = {
		}
	}
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	Mission.Digit4 = 8888

	MultiScore =	{
		[0]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
			[8] = 100,
			[9] = 100,
		},
		[1]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
			[8] = 100,
			[9] = 100,
		},
		[2]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
			[8] = 100,
			[9] = 100,
		},
		[3]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
			[8] = 100,
			[9] = 100,
		},
		[4]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
			[8] = 100,
			[9] = 100,
		},
		[5]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
			[8] = 100,
			[9] = 100,
		},
		[6]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
			[8] = 100,
			[9] = 100,
		},
		[7]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
			[8] = 100,
			[9] = 100,
		},
	}

	if Mission.PointLimit == 0 then
		DisplayScores(1, 0, "mp01.score_comp_your".."| #MultiScore.0.1#", "mp01.score_comp_high".."| #MultiScore.0.5#")
		DisplayScores(1, 1, "mp01.score_comp_your".."| #MultiScore.1.1#", "mp01.score_comp_high".."| #MultiScore.1.5#")
		DisplayScores(1, 2, "mp01.score_comp_your".."| #MultiScore.2.1#", "mp01.score_comp_high".."| #MultiScore.2.5#")
		DisplayScores(1, 3, "mp01.score_comp_your".."| #MultiScore.3.1#", "mp01.score_comp_high".."| #MultiScore.3.5#")
		DisplayScores(1, 4, "mp01.score_comp_your".."| #MultiScore.4.1#", "mp01.score_comp_high".."| #MultiScore.4.5#")
		DisplayScores(1, 5, "mp01.score_comp_your".."| #MultiScore.5.1#", "mp01.score_comp_high".."| #MultiScore.5.5#")
		DisplayScores(1, 6, "mp01.score_comp_your".."| #MultiScore.6.1#", "mp01.score_comp_high".."| #MultiScore.6.5#")
		DisplayScores(1, 7, "mp01.score_comp_your".."| #MultiScore.7.1#", "mp01.score_comp_high".."| #MultiScore.7.5#")
	else
		DisplayScores(1, 0, "mp01.score_comp_your".."| #MultiScore.0.1# / #MultiScore.0.7#", "mp01.score_comp_high".."| #MultiScore.0.5# / #MultiScore.0.7#")
		DisplayScores(1, 1, "mp01.score_comp_your".."| #MultiScore.1.1# / #MultiScore.1.7#", "mp01.score_comp_high".."| #MultiScore.1.5# / #MultiScore.1.7#")
		DisplayScores(1, 2, "mp01.score_comp_your".."| #MultiScore.2.1# / #MultiScore.2.7#", "mp01.score_comp_high".."| #MultiScore.2.5# / #MultiScore.2.7#")
		DisplayScores(1, 3, "mp01.score_comp_your".."| #MultiScore.3.1# / #MultiScore.3.7#", "mp01.score_comp_high".."| #MultiScore.3.5# / #MultiScore.3.7#")
		DisplayScores(1, 4, "mp01.score_comp_your".."| #MultiScore.4.1# / #MultiScore.4.7#", "mp01.score_comp_high".."| #MultiScore.4.5# / #MultiScore.4.7#")
		DisplayScores(1, 5, "mp01.score_comp_your".."| #MultiScore.5.1# / #MultiScore.5.7#", "mp01.score_comp_high".."| #MultiScore.5.5# / #MultiScore.5.7#")
		DisplayScores(1, 6, "mp01.score_comp_your".."| #MultiScore.6.1# / #MultiScore.6.7#", "mp01.score_comp_high".."| #MultiScore.6.5# / #MultiScore.6.7#")
		DisplayScores(1, 7, "mp01.score_comp_your".."| #MultiScore.7.1# / #MultiScore.7.7#", "mp01.score_comp_high".."| #MultiScore.7.5# / #MultiScore.7.7#")
	end

	local PlayersInGame = GetPlayerDetails()
	for index, value in pairs (PlayersInGame) do
		MultiScore[index][1] = 0
		MultiScore[index][5] = 0
		if Mission.PointLimit ~= 0 then
			MultiScore[index][7] = Mission.PointLimit
		end
	end

	DisplayScores(2, 0, "mp13.score_comp_hiryu_hp".."| |#MultiScore.0.8#| |%", "mp13.score_comp_soryu_hp".."| |#MultiScore.0.9#| |%", 1, 1)
	DisplayScores(2, 1, "mp13.score_comp_hiryu_hp".."| |#MultiScore.1.8#| |%", "mp13.score_comp_soryu_hp".."| |#MultiScore.1.9#| |%", 1, 1)
	DisplayScores(2, 2, "mp13.score_comp_hiryu_hp".."| |#MultiScore.2.8#| |%", "mp13.score_comp_soryu_hp".."| |#MultiScore.2.9#| |%", 1, 1)
	DisplayScores(2, 3, "mp13.score_comp_hiryu_hp".."| |#MultiScore.3.8#| |%", "mp13.score_comp_soryu_hp".."| |#MultiScore.3.9#| |%", 1, 1)
	DisplayScores(2, 4, "mp13.score_comp_hiryu_hp".."| |#MultiScore.4.8#| |%", "mp13.score_comp_soryu_hp".."| |#MultiScore.4.9#| |%", 1, 1)
	DisplayScores(2, 5, "mp13.score_comp_hiryu_hp".."| |#MultiScore.5.8#| |%", "mp13.score_comp_soryu_hp".."| |#MultiScore.5.9#| |%", 1, 1)
	DisplayScores(2, 6, "mp13.score_comp_hiryu_hp".."| |#MultiScore.6.8#| |%", "mp13.score_comp_soryu_hp".."| |#MultiScore.6.9#| |%", 1, 1)
	DisplayScores(2, 7, "mp13.score_comp_hiryu_hp".."| |#MultiScore.7.8#| |%", "mp13.score_comp_soryu_hp".."| |#MultiScore.7.9#| |%", 1, 1)

	SetRocketAirGroundTypeDifferent(false)

	AISetSpawnSceneUnitsWeightMul(0)

	luaInitNewSystems()

    SetThink(this, "luaQAC13Mission_think")
end

function luaQAC13Mission_think(this, msg)
	this.ElapsedTime = math.floor(GameTime())
	this.ThinkCounter = this.ThinkCounter + 1
-- RELEASE_LOGOFF  	luaLog("- Think "..this.ThinkCounter.." started | Elapsed time: "..this.ElapsedTime.."s -")

	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	if Mission.Completed or Mission.MissionEnd then
		return
	end

	if Mission.Started then
		luaQACCheckListeners()
		luaQAC13CheckJapForces()
		luaQAC13CheckMissionEnd()
		luaQAC13CheckUSForces()

	elseif not Mission.Started then
		luaQAC13StartMission()
		luaUpdateCounters()
		luaQAC13CheckLandforts()
	end
end

function luaQAC13StartMission()
-- RELEASE_LOGOFF  	luaLog("  Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()
	
	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	for i = 1, 8 do
		luaObj_Add("primary", i)
	end
	luaObj_Add("primary", 9)
	luaObj_AddUnit("primary", 9, Mission.Jap.Carriers[1])
	luaObj_AddUnit("primary", 9, Mission.Jap.Carriers[2])
	luaObj_Add("secondary", 1)
	--luaObj_Add("secondary", 2)

	NavigatorMoveOnPath(Mission.Jap.Carriers[1], Mission.Jap.CarrierPaths[1], PATH_FM_SIMPLE, PATH_SM_JOIN)
	local pathpoints = FillPathPoints(Mission.Jap.CarrierPaths[1])
	local pathpointsnumber = table.getn(pathpoints)
	AddProximityTrigger(Mission.Jap.Carriers[1], "HiryuTrg", "luaQAC13HiryuInPos", pathpoints[pathpointsnumber], 800)
	NavigatorMoveOnPath(Mission.Jap.Carriers[2], Mission.Jap.CarrierPaths[2], PATH_FM_SIMPLE, PATH_SM_JOIN)
	local pathpoints = FillPathPoints(Mission.Jap.CarrierPaths[2])
	local pathpointsnumber = table.getn(pathpoints)
	AddProximityTrigger(Mission.Jap.Carriers[2], "SoryuTrg", "luaQAC13SoryuInPos", pathpoints[pathpointsnumber], 800)
	NavigatorSetAvoidLandCollision(Mission.Jap.Carriers[1], false)
	NavigatorSetAvoidLandCollision(Mission.Jap.Carriers[2], false)
	SetShipMaxSpeed(Mission.Jap.Carriers[1], GetShipMaxSpeed(Mission.Jap.Carriers[1])*0.6)
	SetShipMaxSpeed(Mission.Jap.Carriers[2], GetShipMaxSpeed(Mission.Jap.Carriers[2])*0.6)
	SetSkillLevel(Mission.Jap.Carriers[1], SKILL_MPVETERAN)
	SetSkillLevel(Mission.Jap.Carriers[2], SKILL_MPVETERAN)
	
	local enemySkillLevel = nil
	if Mission.Players <= 2 then
		enemySkillLevel = SKILL_STUN
	elseif Mission.Players <= 4 then
		enemySkillLevel = SKILL_SPNORMAL
	elseif Mission.Players <= 6 then
		enemySkillLevel = SKILL_SPNORMAL
	else
		enemySkillLevel = SKILL_SPVETERAN
	end

	for index, unit in pairs (Mission.US.HQsSouth) do
		SetSkillLevel(unit, enemySkillLevel)
		luaObj_AddUnit("secondary", 1, unit)
	end
	for index, unit in pairs (Mission.US.HQsNorth) do
		SetSkillLevel(unit, enemySkillLevel)
		luaObj_AddUnit("secondary", 1, unit)
	end
	for index, unit in pairs (Mission.US.CCLandfortsSouth[1]) do
		SetSkillLevel(unit, enemySkillLevel)
		AISetHintWeight(unit, 0.1)
	end
	for index, unit in pairs (Mission.US.CCLandfortsSouth[2]) do
		SetSkillLevel(unit, enemySkillLevel)
		AISetHintWeight(unit, 0.1)
	end
	for index, unit in pairs (Mission.US.CCLandfortsSouth[3]) do
		SetSkillLevel(unit, enemySkillLevel)
		AISetHintWeight(unit, 0.1)
	end
	for index, unit in pairs (Mission.US.CCLandfortsNorth[1]) do
		SetSkillLevel(unit, enemySkillLevel)
		AISetHintWeight(unit, 0.1)
	end
	for index, unit in pairs (Mission.US.CCLandfortsNorth[2]) do
		SetSkillLevel(unit, enemySkillLevel)
		AISetHintWeight(unit, 0.1)
	end
	for index, unit in pairs (Mission.US.CCLandfortsNorth[3]) do
		SetSkillLevel(unit, enemySkillLevel)
		AISetHintWeight(unit, 0.1)
	end

	AISetHintWeight(Mission.US.HQsSouth[3], 200)
	AISetHintWeight(Mission.US.HQsSouth[2], 185)
	AISetHintWeight(Mission.US.HQsSouth[1], 170)
	AISetHintWeight(Mission.US.HQsNorth[3], 200)
	AISetHintWeight(Mission.US.HQsNorth[2], 185)
	AISetHintWeight(Mission.US.HQsNorth[1], 170)
	AISetTargetWeight(150, 27, false, 0.5) -- Zero vs PT

	if Mission.LobbyCountDown ~= 0 then
		Countdown("mp.score_comp_time_left", 0, Mission.LobbyCountDown, "luaQAC13MissionEndTimeIsUp")
	end

	luaDelay(luaQAC13AllowSecondWave, Mission.SecondWaveTimer)
	luaDelay(luaQAC13AllowThirdWave, Mission.ThirdWaveTimer)
	luaDelay(luaQAC13AllowFourthWave, Mission.FourthWaveTimer)
	Mission.Started = true
	--luaDelay(luaQAC13ManageJapSpawnPoints, 2)
end

function luaQAC13HiryuInPos()
-- RELEASE_LOGOFF  	luaLog(" The Hiryu has reached the last path point...")
	if not Mission.US.CarriersSpawned then
		Mission.US.CarriersSpawned = true
		luaQAC13SpawnUSCarriers()
	end
end

function luaQAC13SoryuInPos()
-- RELEASE_LOGOFF  	luaLog(" The Soryu has reached the last path point...")
	if not Mission.US.CarriersSpawned then
		Mission.US.CarriersSpawned = true
		luaQAC13SpawnUSCarriers()
	end
end

function luaQAC13CheckUSForces()
-- RELEASE_LOGOFF  	luaLog(" Checking US forces...")
	if not Mission.US.CarriersSpawned and  Mission.US.HQsNorth[1].Party ~= PARTY_ALLIED and Mission.US.HQsNorth[2].Party ~= PARTY_ALLIED and Mission.US.HQsNorth[3].Party ~= PARTY_ALLIED and Mission.US.HQsSouth[1].Party ~= PARTY_ALLIED and Mission.US.HQsSouth[2].Party ~= PARTY_ALLIED and Mission.US.HQsSouth[3].Party ~= PARTY_ALLIED then
		Mission.US.CarriersSpawned = true
		luaQAC13SpawnUSCarriers()
	elseif Mission.US.CarriersSpawned then
		local carriersAlive = 0
		for index, unit in pairs (Mission.US.Carriers) do
			if not unit.Dead then
				carriersAlive = carriersAlive + 1
			end
		end
		if carriersAlive == 0 then
-- RELEASE_LOGOFF  			luaLog("  the US carriers are down, ending mission...")
			Mission.MissionEndCalled = true
			ForceMultiScoreSend()
			CountdownCancel()
			if luaObj_IsActive("primary", 9) and luaObj_GetSuccess("primary", 9) == nil then
				luaObj_Completed("primary", 9)
			end
			local highestindex, highestplayerscore = luaQAC13CheckHighestScore()
			local PlayersInGame = GetPlayerDetails()
			local playerwhowon = PlayersInGame[highestindex]
			for index, value in pairs (PlayersInGame) do
				if playerwhowon.playerName ~= "" then
					MultiScore[index][4] = playerwhowon.playerName
					Mission.WinnerPlayer = playerwhowon.playerName
				else
					Mission.WinnerPlayer = "mp.nar_comp_skirmish_ai"
					Mission.WinnerPlayerAILevel = playerwhowon.ailevel
					if playerwhowon.ailevel == 3 then
						MultiScore[index][4] = "FE.easy"
					elseif playerwhowon.ailevel == 4 then
						MultiScore[index][4] = "FE.normal"
					elseif playerwhowon.ailevel == 5 then
						MultiScore[index][4] = "FE.hard"
					end
				end
			end
			luaDelay(luaQAC13MissionEnd, 5)
		end
	end

	Mission.US.AttackerGroupNorth1 = luaRemoveDeadsFromTable(Mission.US.AttackerGroupNorth1)
	if not Mission.MissionFailed and table.getn(Mission.US.AttackerGroupNorth1) == 0 and Mission.US.HQsNorth[3].Party == PARTY_ALLIED and not Mission.US.SYsNorth[3].Dead and not Mission.US.GroupNorth1SpawnFlag then
-- RELEASE_LOGOFF  		luaLog("  queueing AttackerGroupNorth1 spawn request...")
		Mission.US.GroupNorth1SpawnTime = GameTime() + Mission.RespawnTimer
		Mission.US.GroupNorth1SpawnFlag = true
	elseif Mission.US.GroupNorth1SpawnFlag and Mission.US.GroupNorth1SpawnTime < GameTime() and not Mission.MissionFailed and Mission.US.HQsNorth[3].Party == PARTY_ALLIED and not Mission.US.SYsNorth[3].Dead then
-- RELEASE_LOGOFF  		luaLog("  spawning units into AttackerGroupNorth1...")
		local grouptable = {}
		local randomshiptype = 1
		--local randomshiptype = luaRnd(1, 2)
		local randomshipnumber = 1
		local template = nil
		if randomshiptype == 1 then
			template = Mission.US.UnitTemplate.PT
			randomshipnumber = luaRnd(Mission.US.UnitTemplate.PTMin, Mission.US.UnitTemplate.PTMax)
--[[
		elseif randomshiptype == 2 then
			template = Mission.US.UnitTemplate.DD
			randomshipnumber = luaRnd(Mission.US.UnitTemplate.DDMin, Mission.US.UnitTemplate.DDMax)
]]
		end
		for i = 1, randomshipnumber do
			table.insert(grouptable, template)
		end
		local lookatpos = {["x"] = Mission.US.EntryPointsNorth[1].x - 200, ["y"] = Mission.US.EntryPointsNorth[1].y, ["z"] = Mission.US.EntryPointsNorth[1].z + 200}
		SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = grouptable,
			["area"] = {["refPos"] = Mission.US.EntryPointsNorth[1], ["angleRange"] = { 1, -1 }, ["lookAt"] = lookatpos,},
			["callback"] = "luaQAC13AttackerGroupNorth1Spawned",
			["excludeRadiusOverride"] = {["ownHorizontal"] = 133, ["enemyHorizontal"] = 133, ["ownVertical"] = 133, ["formationHorizontal"] = 133, ["enemyVertical"] = 133, ["enemyHorizontal"] = 133,},
		})
		Mission.US.GroupNorth1SpawnFlag = false
	else
		for index, unit in pairs (Mission.US.AttackerGroupNorth1) do
			if UnitGetAttackTarget(unit) == nil then
				if not Mission.Jap.Carriers[1].Dead then
					NavigatorAttackMove(unit, Mission.Jap.Carriers[1], {})
				elseif not Mission.Jap.Carriers[2].Dead then
					NavigatorAttackMove(unit, Mission.Jap.Carriers[2], {})
				end
			end
		end
	end

	if Mission.SecondWave then
		Mission.US.AttackerGroupNorth2 = luaRemoveDeadsFromTable(Mission.US.AttackerGroupNorth2)
		if not Mission.MissionFailed and table.getn(Mission.US.AttackerGroupNorth2) == 0 and Mission.US.HQsNorth[2].Party == PARTY_ALLIED and not Mission.US.SYsNorth[2].Dead and not Mission.US.GroupNorth2SpawnFlag then
-- RELEASE_LOGOFF  			luaLog("  queueing AttackerGroupNorth2 spawn request...")
			Mission.US.GroupNorth2SpawnTime = GameTime() + Mission.RespawnTimer
			Mission.US.GroupNorth2SpawnFlag = true
		elseif Mission.US.GroupNorth2SpawnFlag and Mission.US.GroupNorth2SpawnTime < GameTime() and not Mission.MissionFailed and Mission.US.HQsNorth[2].Party == PARTY_ALLIED and not Mission.US.SYsNorth[2].Dead then
-- RELEASE_LOGOFF  			luaLog("  spawning units into AttackerGroupNorth2...")
			local grouptable = {}
			local randomshiptype = 1
			--local randomshiptype = luaRnd(1, 2)
			local randomshipnumber = 1
			local template = nil
			if randomshiptype == 1 then
				template = Mission.US.UnitTemplate.PT
				randomshipnumber = luaRnd(Mission.US.UnitTemplate.PTMin, Mission.US.UnitTemplate.PTMax)
--[[
			elseif randomshiptype == 2 then
				template = Mission.US.UnitTemplate.DD
				randomshipnumber = luaRnd(Mission.US.UnitTemplate.DDMin, Mission.US.UnitTemplate.DDMax)
]]
			end
			for i = 1, randomshipnumber do
				table.insert(grouptable, template)
			end
			local lookatpos = {["x"] = Mission.US.EntryPointsNorth[2].x - 200, ["y"] = Mission.US.EntryPointsNorth[2].y, ["z"] = Mission.US.EntryPointsNorth[2].z + 200}
			SpawnNew({
				["party"] = PARTY_ALLIED,
				["groupMembers"] = grouptable,
				["area"] = {["refPos"] = Mission.US.EntryPointsNorth[2], ["angleRange"] = { 1, -1 }, ["lookAt"] = lookatpos,},
				["callback"] = "luaQAC13AttackerGroupNorth2Spawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 133, ["enemyHorizontal"] = 133, ["ownVertical"] = 133, ["formationHorizontal"] = 133, ["enemyVertical"] = 133, ["enemyHorizontal"] = 133,},
			})
			Mission.US.GroupNorth2SpawnFlag = false
		else
			for index, unit in pairs (Mission.US.AttackerGroupNorth2) do
				if UnitGetAttackTarget(unit) == nil then
					if not Mission.Jap.Carriers[1].Dead then
						NavigatorAttackMove(unit, Mission.Jap.Carriers[1], {})
					elseif not Mission.Jap.Carriers[2].Dead then
						NavigatorAttackMove(unit, Mission.Jap.Carriers[2], {})
					end
				end
			end
		end
	end

	if Mission.ThirdWave then
		Mission.US.AttackerGroupNorth3 = luaRemoveDeadsFromTable(Mission.US.AttackerGroupNorth3)
		if not Mission.MissionFailed and table.getn(Mission.US.AttackerGroupNorth3) == 0 and Mission.US.HQsNorth[1].Party == PARTY_ALLIED and not Mission.US.SYsNorth[1].Dead and not Mission.US.GroupNorth3SpawnFlag then
-- RELEASE_LOGOFF  			luaLog("  queueing AttackerGroupNorth3 spawn request...")
			Mission.US.GroupNorth3SpawnTime = GameTime() + Mission.RespawnTimer
			Mission.US.GroupNorth3SpawnFlag = true
		elseif Mission.US.GroupNorth3SpawnFlag and Mission.US.GroupNorth3SpawnTime < GameTime() and not Mission.MissionFailed and Mission.US.HQsNorth[1].Party == PARTY_ALLIED and not Mission.US.SYsNorth[1].Dead then
-- RELEASE_LOGOFF  			luaLog("  spawning units into AttackerGroupNorth3...")
			local grouptable = {}
			local randomshiptype = luaRnd(1, 2)
			local randomshipnumber = 1
			local template = nil
			if randomshiptype == 1 then
				template = Mission.US.UnitTemplate.PT
				randomshipnumber = luaRnd(Mission.US.UnitTemplate.PTMin, Mission.US.UnitTemplate.PTMax)
			elseif randomshiptype == 2 then
				template = Mission.US.UnitTemplate.DD
				randomshipnumber = luaRnd(Mission.US.UnitTemplate.DDMin, Mission.US.UnitTemplate.DDMax)
			end
			for i = 1, randomshipnumber do
				table.insert(grouptable, template)
			end
			local lookatpos = {["x"] = Mission.US.EntryPointsNorth[3].x - 200, ["y"] = Mission.US.EntryPointsNorth[3].y, ["z"] = Mission.US.EntryPointsNorth[3].z + 200}
			SpawnNew({
				["party"] = PARTY_ALLIED,
				["groupMembers"] = grouptable,
				["area"] = {["refPos"] = Mission.US.EntryPointsNorth[3], ["angleRange"] = { 1, -1 }, ["lookAt"] = lookatpos,},
				["callback"] = "luaQAC13AttackerGroupNorth3Spawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 133, ["enemyHorizontal"] = 133, ["ownVertical"] = 133, ["formationHorizontal"] = 133, ["enemyVertical"] = 133, ["enemyHorizontal"] = 133,},
			})
			Mission.US.GroupNorth3SpawnFlag = false
		else
			for index, unit in pairs (Mission.US.AttackerGroupNorth3) do
				if UnitGetAttackTarget(unit) == nil then
					if not Mission.Jap.Carriers[1].Dead then
						NavigatorAttackMove(unit, Mission.Jap.Carriers[1], {})
					elseif not Mission.Jap.Carriers[2].Dead then
						NavigatorAttackMove(unit, Mission.Jap.Carriers[2], {})
					end
				end
			end
		end
	end

	if Mission.FourthWave then
		Mission.US.AttackerGroupNorth4 = luaRemoveDeadsFromTable(Mission.US.AttackerGroupNorth4)
		if not Mission.MissionFailed and table.getn(Mission.US.AttackerGroupNorth4) == 0 and not Mission.CarrierSpawnManager and not Mission.US.GroupNorth4SpawnFlag then
-- RELEASE_LOGOFF  			luaLog("  queueing AttackerGroupNorth4 spawn request...")
			Mission.US.GroupNorth4SpawnTime = GameTime() + Mission.RespawnTimer
			Mission.US.GroupNorth4SpawnFlag = true
		elseif Mission.US.GroupNorth4SpawnFlag and Mission.US.GroupNorth4SpawnTime < GameTime() and not Mission.CarrierSpawnManager then
-- RELEASE_LOGOFF  			luaLog("  spawning units into AttackerGroupNorth4...")
			local grouptable = {}
			local randomplanetype = luaRnd(1, 3)
			local randomplanenumber = 1
			local template = nil
			if randomplanetype == 1 then
				template = Mission.US.UnitTemplate.TB
				randomplanenumber = luaRnd(Mission.US.UnitTemplate.TBMin, Mission.US.UnitTemplate.TBMax)
				elseif randomplanetype == 2 then
				template = Mission.US.UnitTemplate.DB
				randomplanenumber = luaRnd(Mission.US.UnitTemplate.DBMin, Mission.US.UnitTemplate.DBMax)
			elseif randomplanetype == 3 then
				template = Mission.US.UnitTemplate.F
				randomplanenumber = luaRnd(Mission.US.UnitTemplate.FMin, Mission.US.UnitTemplate.FMax)
			end
			for i = 1, randomplanenumber do
				table.insert(grouptable, template)
			end
			local lookatpos = {["x"] = Mission.US.EntryPointsNorth[4].x - 200, ["y"] = Mission.US.EntryPointsNorth[4].y, ["z"] = Mission.US.EntryPointsNorth[4].z - 200}
			SpawnNew({
				["party"] = PARTY_ALLIED,
				["groupMembers"] = grouptable,
				["area"] = {["refPos"] = Mission.US.EntryPointsNorth[4], ["angleRange"] = { 1, -1 }, ["lookAt"] = lookatpos,},
				["callback"] = "luaQAC13AttackerGroupNorth4Spawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 166, ["enemyHorizontal"] = 166, ["ownVertical"] = 166, ["formationHorizontal"] = 166, ["enemyVertical"] = 166, ["enemyHorizontal"] = 166,},
			})
			Mission.US.GroupNorth4SpawnFlag = false
		elseif Mission.CarrierSpawnManager and not Mission.US.Carriers[2].Dead and table.getn(Mission.US.AttackerGroupNorth4) == 0 then
-- RELEASE_LOGOFF  			luaLog("  spawning units into AttackerGroupNorth4 for the carrier...")
			local grouptable = {}
			local randomplanetype = luaRnd(1, 3)
			local template = nil
			if randomplanetype == 1 then
				template = Mission.US.UnitTemplate.TB
			elseif randomplanetype == 2 then
				template = Mission.US.UnitTemplate.DB
			elseif randomplanetype == 3 then
				template = Mission.US.UnitTemplate.F
			end
			if Mission.US.UnitsInGrpN4 ~= nil then
				local planesToSpawn = Mission.US.CV1PlaneNumber - Mission.US.UnitsInGrpN4
				if planesToSpawn > 0 then
					for i = 1, planesToSpawn do
						table.insert(grouptable, template)
					end
				end
				Mission.US.UnitsInGrpN4 = nil
			else
				for i = 1, Mission.US.CV1PlaneNumber do
					table.insert(grouptable, template)
				end
			end
			if table.getn(grouptable) ~= 0 then
				local CV2Pos = GetPosition(Mission.US.Carriers[2])
				local refPos = {["x"] = CV2Pos.x, ["y"] = CV2Pos.y + 200, ["z"] = CV2Pos.z}
				local lookatpos = {["x"] = CV2Pos.x - 200, ["y"] = CV2Pos.y + 200, ["z"] = CV2Pos.z}
				SpawnNew({
					["party"] = PARTY_ALLIED,
					["groupMembers"] = grouptable,
					["area"] = {["refPos"] = refPos, ["angleRange"] = { 1, -1 }, ["lookAt"] = lookatpos,},
					["callback"] = "luaQAC13AttackerGroupNorth4Spawned",
					["excludeRadiusOverride"] = {["ownHorizontal"] = 50, ["enemyHorizontal"] = 166, ["ownVertical"] = 166, ["formationHorizontal"] = 166, ["enemyVertical"] = 166, ["enemyHorizontal"] = 166,},
				})
			end
		else
			for index, unit in pairs (Mission.US.AttackerGroupNorth4) do
				if UnitGetAttackTarget(unit) == nil then
					luaQAC13SetPlaneTarget(unit, "n")
				end
			end
		end
	end

	Mission.US.AttackerGroupSouth1 = luaRemoveDeadsFromTable(Mission.US.AttackerGroupSouth1)
	if not Mission.MissionFailed and table.getn(Mission.US.AttackerGroupSouth1) == 0 and Mission.US.HQsSouth[3].Party == PARTY_ALLIED and not Mission.US.SYsSouth[3].Dead and not Mission.US.GroupSouth1SpawnFlag then
-- RELEASE_LOGOFF  			luaLog("  queueing AttackerGroupSouth1 spawn request...")
			Mission.US.GroupSouth1SpawnTime = GameTime() + Mission.RespawnTimer
			Mission.US.GroupSouth1SpawnFlag = true
		elseif Mission.US.GroupSouth1SpawnFlag and Mission.US.GroupSouth1SpawnTime < GameTime() and not Mission.MissionFailed and Mission.US.HQsSouth[3].Party == PARTY_ALLIED and not Mission.US.SYsSouth[3].Dead then
-- RELEASE_LOGOFF  		luaLog("  spawning units into AttackerGroupSouth1...")
		local grouptable = {}
		local randomshiptype = 1
		--local randomshiptype = luaRnd(1, 2)
		local randomshipnumber = 1
		local template = nil
		if randomshiptype == 1 then
			template = Mission.US.UnitTemplate.PT
			randomshipnumber = luaRnd(Mission.US.UnitTemplate.PTMin, Mission.US.UnitTemplate.PTMax)
--[[
		elseif randomshiptype == 2 then
			template = Mission.US.UnitTemplate.DD
			randomshipnumber = luaRnd(Mission.US.UnitTemplate.DDMin, Mission.US.UnitTemplate.DDMax)
]]
		end
		for i = 1, randomshipnumber do
			table.insert(grouptable, template)
		end
		local lookatpos = {["x"] = Mission.US.EntryPointsSouth[1].x - 200, ["y"] = Mission.US.EntryPointsSouth[1].y, ["z"] = Mission.US.EntryPointsSouth[1].z - 200}
		SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = grouptable,
			["area"] = {["refPos"] = Mission.US.EntryPointsSouth[1], ["angleRange"] = { 1, -1 }, ["lookAt"] = lookatpos,},
			["callback"] = "luaQAC13AttackerGroupSouth1Spawned",
			["excludeRadiusOverride"] = {["ownHorizontal"] = 133, ["enemyHorizontal"] = 133, ["ownVertical"] = 133, ["formationHorizontal"] = 133, ["enemyVertical"] = 133, ["enemyHorizontal"] = 133,},
		})
		Mission.US.GroupSouth1SpawnFlag = false
	else
		for index, unit in pairs (Mission.US.AttackerGroupSouth1) do
			if UnitGetAttackTarget(unit) == nil then
				if not Mission.Jap.Carriers[2].Dead then
					NavigatorAttackMove(unit, Mission.Jap.Carriers[2], {})
				elseif not Mission.Jap.Carriers[1].Dead then
					NavigatorAttackMove(unit, Mission.Jap.Carriers[1], {})
				end
			end
		end
	end

	if Mission.SecondWave then
		Mission.US.AttackerGroupSouth2 = luaRemoveDeadsFromTable(Mission.US.AttackerGroupSouth2)
		if not Mission.MissionFailed and table.getn(Mission.US.AttackerGroupSouth2) == 0 and Mission.US.HQsSouth[2].Party == PARTY_ALLIED and not Mission.US.SYsSouth[2].Dead and not Mission.US.GroupSouth2SpawnFlag then
-- RELEASE_LOGOFF  			luaLog("  queueing AttackerGroupSouth2 spawn request...")
			Mission.US.GroupSouth2SpawnTime = GameTime() + Mission.RespawnTimer
			Mission.US.GroupSouth2SpawnFlag = true
		elseif Mission.US.GroupSouth2SpawnFlag and Mission.US.GroupSouth2SpawnTime < GameTime() and not Mission.MissionFailed and Mission.US.HQsSouth[2].Party == PARTY_ALLIED and not Mission.US.SYsSouth[2].Dead then
-- RELEASE_LOGOFF  			luaLog("  spawning units into AttackerGroupSouth2...")
			local grouptable = {}
			local randomshiptype = 1
			--local randomshiptype = luaRnd(1, 2)
			local randomshipnumber = 1
			local template = nil
			if randomshiptype == 1 then
				template = Mission.US.UnitTemplate.PT
				randomshipnumber = luaRnd(Mission.US.UnitTemplate.PTMin, Mission.US.UnitTemplate.PTMax)
--[[
			elseif randomshiptype == 2 then
				template = Mission.US.UnitTemplate.DD
				randomshipnumber = luaRnd(Mission.US.UnitTemplate.DDMin, Mission.US.UnitTemplate.DDMax)
]]
			end
			for i = 1, randomshipnumber do
				table.insert(grouptable, template)
			end
			local lookatpos = {["x"] = Mission.US.EntryPointsSouth[2].x - 200, ["y"] = Mission.US.EntryPointsSouth[2].y, ["z"] = Mission.US.EntryPointsSouth[2].z - 200}
			SpawnNew({
				["party"] = PARTY_ALLIED,
				["groupMembers"] = grouptable,
				["area"] = {["refPos"] = Mission.US.EntryPointsSouth[2], ["angleRange"] = { 1, -1 }, ["lookAt"] = lookatpos,},
				["callback"] = "luaQAC13AttackerGroupSouth2Spawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 133, ["enemyHorizontal"] = 133, ["ownVertical"] = 133, ["formationHorizontal"] = 133, ["enemyVertical"] = 133, ["enemyHorizontal"] = 133,},
			})
			Mission.US.GroupSouth2SpawnFlag = false
		else
			for index, unit in pairs (Mission.US.AttackerGroupSouth2) do
				if UnitGetAttackTarget(unit) == nil then
					if not Mission.Jap.Carriers[2].Dead then
						NavigatorAttackMove(unit, Mission.Jap.Carriers[2], {})
					elseif not Mission.Jap.Carriers[1].Dead then
						NavigatorAttackMove(unit, Mission.Jap.Carriers[1], {})
					end
				end
			end
		end
	end

	if Mission.ThirdWave then
		Mission.US.AttackerGroupSouth3 = luaRemoveDeadsFromTable(Mission.US.AttackerGroupSouth3)
		if not Mission.MissionFailed and table.getn(Mission.US.AttackerGroupSouth3) == 0 and Mission.US.HQsSouth[1].Party == PARTY_ALLIED and not Mission.US.SYsSouth[1].Dead and not Mission.US.GroupSouth3SpawnFlag then
-- RELEASE_LOGOFF  			luaLog("  queueing AttackerGroupSouth3 spawn request...")
			Mission.US.GroupSouth3SpawnTime = GameTime() + Mission.RespawnTimer
			Mission.US.GroupSouth3SpawnFlag = true
		elseif Mission.US.GroupSouth3SpawnFlag and Mission.US.GroupSouth3SpawnTime < GameTime() and not Mission.MissionFailed and Mission.US.HQsSouth[1].Party == PARTY_ALLIED and not Mission.US.SYsSouth[1].Dead then
-- RELEASE_LOGOFF  			luaLog("  spawning units into AttackerGroupSouth3...")
			local grouptable = {}
			local randomshiptype = luaRnd(1, 2)
			local randomshipnumber = 1
			local template = nil
			if randomshiptype == 1 then
				template = Mission.US.UnitTemplate.PT
				randomshipnumber = luaRnd(Mission.US.UnitTemplate.PTMin, Mission.US.UnitTemplate.PTMax)
			elseif randomshiptype == 2 then
				template = Mission.US.UnitTemplate.DD
				randomshipnumber = luaRnd(Mission.US.UnitTemplate.DDMin, Mission.US.UnitTemplate.DDMax)
			end
			for i = 1, randomshipnumber do
				table.insert(grouptable, template)
			end
			local lookatpos = {["x"] = Mission.US.EntryPointsSouth[3].x - 200, ["y"] = Mission.US.EntryPointsSouth[3].y, ["z"] = Mission.US.EntryPointsSouth[3].z - 200}
			SpawnNew({
				["party"] = PARTY_ALLIED,
				["groupMembers"] = grouptable,
				["area"] = {["refPos"] = Mission.US.EntryPointsSouth[3], ["angleRange"] = { 1, -1 }, ["lookAt"] = lookatpos,},
				["callback"] = "luaQAC13AttackerGroupSouth3Spawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 133, ["enemyHorizontal"] = 133, ["ownVertical"] = 133, ["formationHorizontal"] = 133, ["enemyVertical"] = 133, ["enemyHorizontal"] = 133,},
			})
			Mission.US.GroupSouth3SpawnFlag = false
		else
			for index, unit in pairs (Mission.US.AttackerGroupSouth3) do
				if UnitGetAttackTarget(unit) == nil then
					if not Mission.Jap.Carriers[2].Dead then
						NavigatorAttackMove(unit, Mission.Jap.Carriers[2], {})
					elseif not Mission.Jap.Carriers[1].Dead then
						NavigatorAttackMove(unit, Mission.Jap.Carriers[1], {})
					end
				end
			end
		end
	end

	if Mission.FourthWave then
		Mission.US.AttackerGroupSouth4 = luaRemoveDeadsFromTable(Mission.US.AttackerGroupSouth4)
		if not Mission.MissionFailed and table.getn(Mission.US.AttackerGroupSouth4) == 0 and not Mission.CarrierSpawnManager and not Mission.US.GroupSouth4SpawnFlag then
-- RELEASE_LOGOFF  			luaLog("  queueing AttackerGroupSouth4 spawn request...")
			Mission.US.GroupSouth4SpawnTime = GameTime() + Mission.RespawnTimer
			Mission.US.GroupSouth4SpawnFlag = true
		elseif Mission.US.GroupSouth4SpawnFlag and Mission.US.GroupSouth4SpawnTime < GameTime() and not Mission.CarrierSpawnManager then
-- RELEASE_LOGOFF  			luaLog("  spawning units into AttackerGroupSouth4...")
			local grouptable = {}
			local randomplanetype = luaRnd(1, 3)
			local randomplanenumber = 1
			local template = nil
			if randomplanetype == 1 then
				template = Mission.US.UnitTemplate.TB
				randomplanenumber = luaRnd(Mission.US.UnitTemplate.TBMin, Mission.US.UnitTemplate.TBMax)
				elseif randomplanetype == 2 then
				template = Mission.US.UnitTemplate.DB
				randomplanenumber = luaRnd(Mission.US.UnitTemplate.DBMin, Mission.US.UnitTemplate.DBMax)
			elseif randomplanetype == 3 then
				template = Mission.US.UnitTemplate.F
				randomplanenumber = luaRnd(Mission.US.UnitTemplate.FMin, Mission.US.UnitTemplate.FMax)
			end
			for i = 1, randomplanenumber do
				table.insert(grouptable, template)
			end
			local lookatpos = {["x"] = Mission.US.EntryPointsSouth[4].x - 200, ["y"] = Mission.US.EntryPointsSouth[4].y, ["z"] = Mission.US.EntryPointsSouth[4].z + 200}
			SpawnNew({
				["party"] = PARTY_ALLIED,
				["groupMembers"] = grouptable,
				["area"] = {["refPos"] = Mission.US.EntryPointsSouth[4], ["angleRange"] = { 1, -1 }, ["lookAt"] = lookatpos,},
				["callback"] = "luaQAC13AttackerGroupSouth4Spawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 133, ["enemyHorizontal"] = 133, ["ownVertical"] = 133, ["formationHorizontal"] = 133, ["enemyVertical"] = 133, ["enemyHorizontal"] = 133,},
			})
			Mission.US.GroupSouth4SpawnFlag = false
		elseif Mission.CarrierSpawnManager and not Mission.US.Carriers[1].Dead and table.getn(Mission.US.AttackerGroupSouth4) == 0 then
-- RELEASE_LOGOFF  			luaLog("  spawning units into AttackerGroupSouth4 for the carrier...")
			local grouptable = {}
			local randomplanetype = luaRnd(1, 3)
			local template = nil
			if randomplanetype == 1 then
				template = Mission.US.UnitTemplate.TB
			elseif randomplanetype == 2 then
				template = Mission.US.UnitTemplate.DB
			elseif randomplanetype == 3 then
				template = Mission.US.UnitTemplate.F
			end
			if Mission.US.UnitsInGrpS4 ~= nil then
				local planesToSpawn = Mission.US.CV2PlaneNumber - Mission.US.UnitsInGrpS4
				if planesToSpawn > 0 then
					for i = 1, planesToSpawn do
						table.insert(grouptable, template)
					end
				end
				Mission.US.UnitsInGrpS4 = nil
			else
				for i = 1, Mission.US.CV2PlaneNumber do
					table.insert(grouptable, template)
				end
			end
			if table.getn(grouptable) ~= 0 then
				local CV1Pos = GetPosition(Mission.US.Carriers[1])
				local refPos = {["x"] = CV1Pos.x, ["y"] = CV1Pos.y + 200, ["z"] = CV1Pos.z}
				local lookatpos = {["x"] = CV1Pos.x - 200, ["y"] = CV1Pos.y + 200, ["z"] = CV1Pos.z}
				SpawnNew({
					["party"] = PARTY_ALLIED,
					["groupMembers"] = grouptable,
					["area"] = {["refPos"] = refPos, ["angleRange"] = { 1, -1 }, ["lookAt"] = lookatpos,},
					["callback"] = "luaQAC13AttackerGroupSouth4Spawned",
					["excludeRadiusOverride"] = {["ownHorizontal"] = 133, ["enemyHorizontal"] = 133, ["ownVertical"] = 133, ["formationHorizontal"] = 133, ["enemyVertical"] = 133, ["enemyHorizontal"] = 133,},
				})
			end
		else
			for index, unit in pairs (Mission.US.AttackerGroupSouth4) do
				if UnitGetAttackTarget(unit) == nil then
					luaQAC13SetPlaneTarget(unit, "s")
				end
			end
		end
	end

	Mission.US.NonCarrierPlanes = luaRemoveDeadsFromTable(Mission.US.NonCarrierPlanes)
	if table.getn(Mission.US.NonCarrierPlanes) ~= 0 then
		for index, unit in pairs (Mission.US.NonCarrierPlanes) do
			if UnitGetAttackTarget(unit) == nil then
				luaQAC13SetPlaneTarget(unit, "s")
			end
		end
	end
end

function luaQAC13SetPlaneTarget(unit, pos)
	if unit.Class.Type ~= "Fighter" then
		if pos == "n" then
			if not Mission.Jap.Carriers[1].Dead then
				PilotSetTarget(unit, Mission.Jap.Carriers[1])
			elseif not Mission.Jap.Carriers[2].Dead then
				PilotSetTarget(unit, Mission.Jap.Carriers[2])
			end
		else
			if not Mission.Jap.Carriers[2].Dead then
				PilotSetTarget(unit, Mission.Jap.Carriers[2])
			elseif not Mission.Jap.Carriers[1].Dead then
				PilotSetTarget(unit, Mission.Jap.Carriers[1])
			end
		end
	else
		local targetTable = {}
		local FTarget = luaGetNearestEnemy(unit, "fighter")
		local TBTarget = luaGetNearestEnemy(unit, "torpedobomber")
		local DBTarget = luaGetNearestEnemy(unit, "divebomber")
		if FTarget ~= nil then
			table.insert(targetTable, FTarget)
		end
		if TBTarget ~= nil then
			table.insert(targetTable, TBTarget)
		end
		if DBTarget ~= nil then
			table.insert(targetTable, DBTarget)
		end
		if table.getn(targetTable) ~= 0 then
			PilotSetTarget(unit, luaPickRnd(targetTable))
		end
	end
end

function luaQAC13SpawnUSCarriers()
-- RELEASE_LOGOFF  	luaLog(" Spawning US carriers...")
	local randomPos = luaRnd(1, 2)
	Mission.US.Carriers[1] = GenerateObject(Mission.US.Carriers[1].Name, Mission.US.CV1EntryPoints[randomPos])
	Mission.US.Carriers[2] = GenerateObject(Mission.US.Carriers[2].Name, Mission.US.CV2EntryPoints[randomPos])
	EntityTurnToEntity(Mission.US.Carriers[1], Mission.US.HQsSouth[1])
	EntityTurnToEntity(Mission.US.Carriers[2], Mission.US.HQsNorth[1])
	NavigatorMoveOnPath(Mission.US.Carriers[1], Mission.US.CarrierPaths[1], PATH_FM_CIRCLE, PATH_SM_BEGIN)
	NavigatorMoveOnPath(Mission.US.Carriers[2], Mission.US.CarrierPaths[2], PATH_FM_CIRCLE, PATH_SM_BEGIN)
	Mission.CarrierSpawnManager = true
	Mission.US.GroupSouth4SpawnFlag = true
	Mission.US.GroupNorth4SpawnFlag = true
	AISetHintWeight(Mission.US.Carriers[1], 100)
	AISetHintWeight(Mission.US.Carriers[2], 100)
	AddListener("recon", "Listener_CarrierSpotted", {["callback"] = "luaQAC13CarrierSpotted",	["entity"] = Mission.US.Carriers,	["oldLevel"] = {}, ["newLevel"] = {2}, ["party"] = { PARTY_JAPANESE },})
	local index = table.getn(Mission.US.AttackerGroupNorth4)
	Mission.US.UnitsInGrpN4 = index
	while index > 0 do
		table.insert(Mission.US.NonCarrierPlanes, Mission.US.AttackerGroupNorth4[index])
		table.remove(Mission.US.AttackerGroupNorth4, index)
		index = index - 1
	end
	local index = table.getn(Mission.US.AttackerGroupSouth4)
	Mission.US.UnitsInGrpS4 = index
	while index > 0 do
		table.insert(Mission.US.NonCarrierPlanes, Mission.US.AttackerGroupSouth4[index])
		table.remove(Mission.US.AttackerGroupSouth4, index)
		index = index - 1
	end
	Mission.US.AttackerGroupNorth4 = {}
	Mission.US.AttackerGroupSouth4 = {}
end

function luaQAC13CheckJapForces()
-- RELEASE_LOGOFF  	luaLog(" Checking Japanese forces...")
	local PlayersInGame = GetPlayerDetails()
	if not Mission.Jap.Carriers10 then
		if Mission.Jap.Carriers[1].Dead then
-- RELEASE_LOGOFF  			luaLog("  the Hiryu is sinking")
			for index, value in pairs (PlayersInGame) do
				MultiScore[index][8] = 0
			end
			Mission.Jap.Carriers10 = true
		else
			local unitHP = GetHpPercentage(Mission.Jap.Carriers[1]) * 100
			unitHP = luaRound(unitHP)
-- RELEASE_LOGOFF  			luaLog("  the Hiryu is on "..tostring(unitHP).."% HP")
			for index, value in pairs (PlayersInGame) do
				MultiScore[index][8] = unitHP
			end
		end
	end
	if not Mission.Jap.Carriers20 then
		if Mission.Jap.Carriers[2].Dead then
-- RELEASE_LOGOFF  			luaLog("  the Soryu is sinking")
			for index, value in pairs (PlayersInGame) do
				MultiScore[index][9] = 0
			end
			Mission.Jap.Carriers20 = true
		else
			local unitHP = GetHpPercentage(Mission.Jap.Carriers[2]) * 100
			unitHP = luaRound(unitHP)
-- RELEASE_LOGOFF  			luaLog("  the Soryu on "..tostring(unitHP).."% HP")
			for index, value in pairs (PlayersInGame) do
				MultiScore[index][9] = unitHP
			end
		end
	end

	local carriersAlive = 0
	for index, unit in pairs (Mission.Jap.Carriers) do
		if not unit.Dead then
			carriersAlive = carriersAlive + 1
		end
	end

	if carriersAlive == 0 and luaObj_IsActive("primary", 9) and luaObj_GetSuccess("primary", 9) == nil then
		Mission.MissionEndCalled = true
		Mission.MissionFailed = true
		luaObj_Failed("primary", 9)
		ForceMultiScoreSend()
		CountdownCancel()
		luaQAC13MissionEnd()
	end
end

function luaQAC13AttackerGroupNorth1Spawned(unit1, unit2, unit3, unit4)
-- RELEASE_LOGOFF  	luaLog("  units spawned for GroupNorth1")
	if unit1 ~= nil then
		table.insert(Mission.US.AttackerGroupNorth1, unit1)
	end
	if unit2 ~= nil then
		table.insert(Mission.US.AttackerGroupNorth1, unit2)
	end
	if unit3 ~= nil then
		table.insert(Mission.US.AttackerGroupNorth1, unit3)
	end
	if unit4 ~= nil then
		table.insert(Mission.US.AttackerGroupNorth1, unit4)
	end

	local enemySkillLevel = nil
	if Mission.Players <= 3 then
		enemySkillLevel = SKILL_STUN
	else
		enemySkillLevel = SKILL_SPNORMAL
	end
	for index, unit in pairs (Mission.US.AttackerGroupNorth1) do
		SetSkillLevel(unit, enemySkillLevel)
	end
end

function luaQAC13AttackerGroupNorth2Spawned(unit1, unit2, unit3, unit4)
-- RELEASE_LOGOFF  	luaLog("  units spawned for GroupNorth2")
	if unit1 ~= nil then
		table.insert(Mission.US.AttackerGroupNorth2, unit1)
	end
	if unit2 ~= nil then
		table.insert(Mission.US.AttackerGroupNorth2, unit2)
	end
		if unit3 ~= nil then
		table.insert(Mission.US.AttackerGroupNorth2, unit3)
	end
	if unit4 ~= nil then
		table.insert(Mission.US.AttackerGroupNorth2, unit4)
	end

	local enemySkillLevel = nil
	if Mission.Players <= 3 then
		enemySkillLevel = SKILL_STUN
	else
		enemySkillLevel = SKILL_SPNORMAL
	end
	for index, unit in pairs (Mission.US.AttackerGroupNorth2) do
		SetSkillLevel(unit, enemySkillLevel)
	end
end

function luaQAC13AttackerGroupNorth3Spawned(unit1, unit2, unit3, unit4)
-- RELEASE_LOGOFF  	luaLog("  units spawned for GroupNorth3")
	if unit1 ~= nil then
		table.insert(Mission.US.AttackerGroupNorth3, unit1)
	end
	if unit2 ~= nil then
		table.insert(Mission.US.AttackerGroupNorth3, unit2)
	end
	if unit3 ~= nil then
		table.insert(Mission.US.AttackerGroupNorth3, unit3)
	end
	if unit4 ~= nil then
		table.insert(Mission.US.AttackerGroupNorth3, unit4)
	end

	for index, unit in pairs (Mission.US.AttackerGroupNorth3) do
		local randomSkill = luaRnd(1, 2)
		if randomSkill == 1 then
			SetSkillLevel(unit, SKILL_SPNORMAL)
		else
			SetSkillLevel(unit, SKILL_STUN)
		end
	end
end

function luaQAC13AttackerGroupNorth4Spawned(unit1, unit2, unit3, unit4)
-- RELEASE_LOGOFF  	luaLog("  units spawned for GroupNorth4")
	if unit1 ~= nil then
-- RELEASE_LOGOFF  		luaLog(GetPosition(unit1))
		table.insert(Mission.US.AttackerGroupNorth4, unit1)
	end
	if unit2 ~= nil then
-- RELEASE_LOGOFF  		luaLog(GetPosition(unit2))
		table.insert(Mission.US.AttackerGroupNorth4, unit2)
	end
	if unit3 ~= nil then
-- RELEASE_LOGOFF  		luaLog(GetPosition(unit3))
		table.insert(Mission.US.AttackerGroupNorth4, unit3)
	end
	if unit4 ~= nil then
-- RELEASE_LOGOFF  		luaLog(GetPosition(unit4))
		table.insert(Mission.US.AttackerGroupNorth4, unit4)
	end
	for index, unit in pairs (Mission.US.AttackerGroupNorth4) do
		if Mission.CarrierSpawnManager then
			SetSkillLevel(unit, SKILL_MPVETERAN)
		else
			local randomSkill = luaRnd(1, 2)
			if randomSkill == 1 then
				SetSkillLevel(unit, SKILL_SPNORMAL)
			else
				SetSkillLevel(unit, SKILL_STUN)
			end
		end
	end
end

function luaQAC13AttackerGroupSouth1Spawned(unit1, unit2, unit3, unit4)
-- RELEASE_LOGOFF  	luaLog("  units spawned for GroupSouth1")
	if unit1 ~= nil then
		table.insert(Mission.US.AttackerGroupSouth1, unit1)
	end
	if unit2 ~= nil then
		table.insert(Mission.US.AttackerGroupSouth1, unit2)
	end
	if unit3 ~= nil then
		table.insert(Mission.US.AttackerGroupSouth1, unit3)
	end
	if unit4 ~= nil then
		table.insert(Mission.US.AttackerGroupSouth1, unit4)
	end

	local enemySkillLevel = nil
	if Mission.Players <= 3 then
		enemySkillLevel = SKILL_STUN
	else
		enemySkillLevel = SKILL_SPNORMAL
	end
	for index, unit in pairs (Mission.US.AttackerGroupSouth1) do
		SetSkillLevel(unit, enemySkillLevel)
	end
end

function luaQAC13AttackerGroupSouth2Spawned(unit1, unit2, unit3, unit4)
-- RELEASE_LOGOFF  	luaLog("  units spawned for GroupSouth2")
	if unit1 ~= nil then
		table.insert(Mission.US.AttackerGroupSouth2, unit1)
	end
	if unit2 ~= nil then
		table.insert(Mission.US.AttackerGroupSouth2, unit2)
	end
		if unit3 ~= nil then
		table.insert(Mission.US.AttackerGroupSouth2, unit3)
	end
	if unit4 ~= nil then
		table.insert(Mission.US.AttackerGroupSouth2, unit4)
	end

	local enemySkillLevel = nil
	if Mission.Players <= 3 then
		enemySkillLevel = SKILL_STUN
	else
		enemySkillLevel = SKILL_SPNORMAL
	end
	for index, unit in pairs (Mission.US.AttackerGroupSouth2) do
		SetSkillLevel(unit, enemySkillLevel)
	end
end

function luaQAC13AttackerGroupSouth3Spawned(unit1, unit2, unit3, unit4)
-- RELEASE_LOGOFF  	luaLog("  units spawned for GroupSouth3")
	if unit1 ~= nil then
		table.insert(Mission.US.AttackerGroupSouth3, unit1)
	end
	if unit2 ~= nil then
		table.insert(Mission.US.AttackerGroupSouth3, unit2)
	end
	if unit3 ~= nil then
		table.insert(Mission.US.AttackerGroupSouth3, unit3)
	end
	if unit4 ~= nil then
		table.insert(Mission.US.AttackerGroupSouth3, unit4)
	end
	for index, unit in pairs (Mission.US.AttackerGroupSouth3) do
		local randomSkill = luaRnd(1, 2)
		if randomSkill == 1 then
			SetSkillLevel(unit, SKILL_SPNORMAL)
		else
			SetSkillLevel(unit, SKILL_STUN)
		end
	end
end

function luaQAC13AttackerGroupSouth4Spawned(unit1, unit2, unit3, unit4)
-- RELEASE_LOGOFF  	luaLog("  units spawned for GroupSouth4")
	if unit1 ~= nil then
-- RELEASE_LOGOFF  		luaLog(GetPosition(unit1))
		table.insert(Mission.US.AttackerGroupSouth4, unit1)
	end
	if unit2 ~= nil then
-- RELEASE_LOGOFF  		luaLog(GetPosition(unit2))
		table.insert(Mission.US.AttackerGroupSouth4, unit2)
	end
	if unit3 ~= nil then
-- RELEASE_LOGOFF  		luaLog(GetPosition(unit3))
		table.insert(Mission.US.AttackerGroupSouth4, unit3)
	end
	if unit4 ~= nil then
-- RELEASE_LOGOFF  		luaLog(GetPosition(unit4))
		table.insert(Mission.US.AttackerGroupSouth4, unit4)
	end
	for index, unit in pairs (Mission.US.AttackerGroupSouth4) do
		if Mission.CarrierSpawnManager then
			SetSkillLevel(unit, SKILL_MPVETERAN)
		else
			local randomSkill = luaRnd(1, 2)
			if randomSkill == 1 then
				SetSkillLevel(unit, SKILL_SPNORMAL)
			else
				SetSkillLevel(unit, SKILL_STUN)
			end
		end
	end
end

function luaQAC13CheckMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Checking mission ending conditions...")
	if Mission.PointLimit ~= 0 then
		local highestindex, highestplayerscore = luaQAC13CheckHighestScore()
		if highestplayerscore >= Mission.PointLimit and not Mission.MissionEndCalled then
			--luaLog(" playerindex: "..highestindex.." | score: "..highestplayerscore.." | calling mission end")
			local PlayersInGame = GetPlayerDetails()
			local playerwhowon = PlayersInGame[highestindex]
			for index, value in pairs (PlayersInGame) do
				if playerwhowon.playerName ~= "" then
					MultiScore[index][4] = playerwhowon.playerName
					Mission.WinnerPlayer = playerwhowon.playerName
				else
					Mission.WinnerPlayer = "mp.nar_comp_skirmish_ai"
					Mission.WinnerPlayerAILevel = playerwhowon.ailevel
					if playerwhowon.ailevel == 3 then
						MultiScore[index][4] = "FE.easy"
					elseif playerwhowon.ailevel == 4 then
						MultiScore[index][4] = "FE.normal"
					elseif playerwhowon.ailevel == 5 then
						MultiScore[index][4] = "FE.hard"
					end
				end
			end
			Mission.MissionEndCalled = true
			Mission.PointLimitReached = true
			CountdownCancel()
			ForceMultiScoreSend()
			luaDelay(luaQAC13MissionEnd, 0.1)
		end
	end
end

function luaQAC13CheckHighestScore()
	local MPlayers = GetPlayerDetails()
	local actplayerscore = 0
	local highestplayerscore = 0
	local highestindex = 0
	for slotID, value in pairs (MPlayers) do
		actplayerscore = Scoring_GetTotalMissionScore(slotID)
		if actplayerscore > highestplayerscore then
			highestplayerscore = actplayerscore
			highestindex = slotID
		end
	end
	return highestindex, highestplayerscore
end

function luaQAC13MissionEndTimeIsUp()
	MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_time_up")
	local highestindex, highestplayerscore = luaQAC13CheckHighestScore()
	local PlayersInGame = GetPlayerDetails()
	local playerwhowon = PlayersInGame[highestindex]
	for index, value in pairs (PlayersInGame) do
		if playerwhowon.playerName ~= "" then
			MultiScore[index][4] = playerwhowon.playerName
			Mission.WinnerPlayer = playerwhowon.playerName
		else
			Mission.WinnerPlayer = "mp.nar_comp_skirmish_ai"
			Mission.WinnerPlayerAILevel = playerwhowon.ailevel
			if playerwhowon.ailevel == 3 then
				MultiScore[index][4] = "FE.easy"
			elseif playerwhowon.ailevel == 4 then
				MultiScore[index][4] = "FE.normal"
			elseif playerwhowon.ailevel == 5 then
				MultiScore[index][4] = "FE.hard"
			end
		end
	end
	Mission.MissionEndCalled = true
	Mission.TimeIsUp = true
	ForceMultiScoreSend()
	luaDelay(luaQAC13MissionEnd, 0.1)
end

function luaQAC13MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	if not Mission.Completed then
		Mission.Completed = true
		if luaObj_IsActive("primary", 9) and luaObj_GetSuccess("primary", 9) == nil then
			luaObj_Completed("primary", 9)
		end

		if luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary", 1) == nil then
			local activeHQs = 0
			for index, unit in pairs (Mission.US.HQsSouth) do
				if unit.Party == PARTY_ALLIED then
					activeHQs = activeHQs + 1
				end
			end
			for index, unit in pairs (Mission.US.HQsNorth) do
				if unit.Party == PARTY_ALLIED then
					activeHQs = activeHQs + 1
				end
			end
			if activeHQs == 0 then
				luaObj_Completed("secondary", 1)
			else
				luaObj_Failed("secondary", 1)
			end
		end

		if luaObj_IsActive("secondary", 2) and luaObj_GetSuccess("secondary", 2) == nil then
			local activeUSCVs = 0
			for index, unit in pairs (Mission.US.Carriers) do
				if not unit.Dead then
					activeUSCVs = activeUSCVs + 1
				end
			end
			if activeUSCVs == 0 then
				luaObj_Completed("secondary", 2)
			else
				luaObj_Failed("secondary", 2)
			end
		end

		local highestindex, highestplayerscore = luaQAC13CheckHighestScore()
-- RELEASE_LOGOFF  		luaLog(" player "..highestindex.." won")
		local objindex = highestindex + 1
		luaObj_Completed("primary", objindex)
		for i = 1, 8 do
			if i ~= objindex then
				luaObj_Failed("primary", i)
			end
		end

		luaQAC13DelayedMissionComplete()
	end
end

function luaQAC13DelayedMissionComplete()
	if not Mission.MissionEnd then
		Scoring_RealPlayTimeRunning(false)
		if Mission.MissionLost then
			local sinkingShip = nil
			for index, unit in pairs (Mission.Jap.Carriers) do
				if TrulyDead(unit) then
					sinkingShip = unit
				end
			end
			if sinkingShip ~= nil then
				luaMissionCompletedNew(sinkingShip, "", nil, nil, nil, PARTY_ALLIED)
			else
				local japaneseunits = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
				local alliedunits = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
				if alliedunits ~= nil then
					luaMissionCompletedNew(luaPickRnd(alliedunits), "", nil, nil, nil, PARTY_ALLIED)
				elseif japaneseunits ~= nil then
					luaMissionCompletedNew(luaPickRnd(japaneseunits), "", nil, nil, nil, PARTY_ALLIED)
				else
					luaMissionCompletedNew(luaPickRnd(Mission.US.HQsNorth), "", nil, nil, nil, PARTY_ALLIED)
				end
			end
		else
			local endUnit = nil
			for index, unit in pairs (Mission.Jap.Carriers) do
				if not unit.Dead then
					endUnit = unit
				end
			end
			if endUnit ~= nil then
				luaMissionCompletedNew(endUnit, "", nil, nil, nil, PARTY_JAPANESE)
			else
				local japaneseunits = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
				local alliedunits = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
				if japaneseunits ~= nil then
					luaMissionCompletedNew(luaPickRnd(japaneseunits), "", nil, nil, nil, PARTY_JAPANESE)
				elseif alliedunits ~= nil then
					luaMissionCompletedNew(luaPickRnd(alliedunits), "", nil, nil, nil, PARTY_JAPANESE)
				else
					luaMissionCompletedNew(luaPickRnd(Mission.US.HQsSouth), "", nil, nil, nil, PARTY_JAPANESE)
				end
			end
		end
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Competitive13")
end

function luaUpdateCounters()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Updating counters...")
		if MultiScore ~= nil then
			if table.getn(MultiScore) ~= 0 then
				local PlayersInGame = GetPlayerDetails()
				local highestindex, highestplayerscore = luaQAC13CheckHighestScore()
				for index, value in pairs (PlayersInGame) do
					MultiScore[index][1] = Scoring_GetTotalMissionScore(index)
					MultiScore[index][5] = highestplayerscore
				end
			end
		end
	
		luaDelay(luaUpdateCounters, 0.7)
	end
end

function luaQACCheckListeners()
-- RELEASE_LOGOFF  	luaLog(" Checking Listeners...")
	if not Mission.ListenerTimerSet then
-- RELEASE_LOGOFF  		luaLog("  setting listener timer")
		Mission.ListenerTimerSet = true
		Mission.ListenerTimer = 40
		Mission.ReminderTimer = 0
	end

	if GameTime() > Mission.ListenerTimer and not Mission.ListenerActive then
-- RELEASE_LOGOFF  		luaLog("  checking possible targets")
		local randomtime = luaRnd(80, 120)
		Mission.ListenerTimer = GameTime() + randomtime
		Mission.ReminderTimer = GameTime() + 14
		local possibleshiptargets = nil
		local possibleplanetargets = nil
		if not Mission.Jap.Carriers[1].Dead then
-- RELEASE_LOGOFF  			luaLog("  possible targets found 1")
			possibleshiptargets = luaGetShipsAround(Mission.Jap.Carriers[1], Mission.Jap.Listener.Ranges.Ship, "enemy")
			possibleplanetargets = luaGetPlanesAround(Mission.Jap.Carriers[1], Mission.Jap.Listener.Ranges.Plane, "enemy")
		elseif not Mission.Jap.Carriers[2].Dead then
-- RELEASE_LOGOFF  			luaLog("  possible targets found 2")
			possibleshiptargets = luaGetShipsAround(Mission.Jap.Carriers[2], Mission.Jap.Listener.Ranges.Ship, "enemy")
			possibleplanetargets = luaGetPlanesAround(Mission.Jap.Carriers[2], Mission.Jap.Listener.Ranges.Plane, "enemy")
		end
		if possibleshiptargets ~= nil and possibleplanetargets ~= nil then
			local index = table.getn(possibleshiptargets)
			while index > 0 do
				local unit = possibleshiptargets[index]
				if unit.Class.Type == "MotherShip" then
-- RELEASE_LOGOFF  					luaLog("  carrier found in possible targets table")
					table.remove(possibleshiptargets, index)
				end
				index = index - 1
			end
			if table.getn(possibleshiptargets) == 0 then
				Mission.RandomListener = 2
			else
				Mission.RandomListener = luaRnd(1, 2)
			end
			if Mission.RandomListener == 1 then
				Mission.RandomTarget = luaPickRnd(possibleshiptargets)
			elseif Mission.RandomListener == 2 then
				Mission.RandomTarget = luaPickRnd(possibleplanetargets)
			end
-- RELEASE_LOGOFF  			luaLog(Mission.RandomTarget.Name)
			MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_bonus_kill")
			for i = 1, 8 do
				luaObj_AddUnit("primary", i, Mission.RandomTarget)
			end
			if Mission.RandomListener ~= 2 then
				--AISetHintWeight(Mission.RandomTarget, 100)
			end
			luaQACRandomTargetKillListener(Mission.RandomTarget)
		elseif possibleshiptargets ~= nil then
			local index = table.getn(possibleshiptargets)
			while index > 0 do
				local unit = possibleshiptargets[index]
				if unit.Class.Type == "MotherShip" then
-- RELEASE_LOGOFF  					luaLog("  carrier found in possible targets table")
					table.remove(possibleshiptargets, index)
				end
				index = index - 1
			end
			if table.getn(possibleshiptargets) ~= 0 then
				Mission.RandomListener = 1
				Mission.RandomTarget = luaPickRnd(possibleshiptargets)
				--luaLog(Mission.RandomTarget.Name)
				MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_bonus_kill")
				for i = 1, 8 do
					luaObj_AddUnit("primary", i, Mission.RandomTarget)
				end
				if Mission.RandomListener ~= 2 then
					--AISetHintWeight(Mission.RandomTarget, 100)
				end
				luaQACRandomTargetKillListener(Mission.RandomTarget)
			end
		elseif possibleplanetargets ~= nil then
			Mission.RandomListener = 2
			Mission.RandomTarget = luaPickRnd(possibleplanetargets)
-- RELEASE_LOGOFF  			luaLog(Mission.RandomTarget.Name)
			MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_bonus_kill")
			for i = 1, 8 do
				luaObj_AddUnit("primary", i, Mission.RandomTarget)
			end
			if Mission.RandomListener ~= 2 then
				--AISetHintWeight(Mission.RandomTarget, 100)
			end
			luaQACRandomTargetKillListener(Mission.RandomTarget)
		end
	elseif GameTime() > Mission.ReminderTimer and Mission.ListenerActive then
		Mission.ReminderTimer = GameTime() + 22
		if not Mission.RandomTarget.Dead then
			MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_bonus_kill")
		else
-- RELEASE_LOGOFF  			luaLog("  ERROR!!! Mission.ListenerActive was wrong")
			Mission.ListenerActive = false
			if IsListenerActive("kill", "TargetKill") then
				RemoveListener("kill", "TargetKill")
			end
		end
	end
end

function luaQACRandomTargetKillListener(target)
	if target ~= nil then
-- RELEASE_LOGOFF  		luaLog(" LISTENER: Activating kill listener on "..target.Name)
		AddListener("kill", "TargetKill", {
			["callback"] = "luaQACTargetKill",
			["entity"] = {target},
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {},
		})
		Mission.ListenerActive = true
	else
-- RELEASE_LOGOFF  		luaLog(" LISTENER: listener activation failed, got nil for target")
	end
end

function luaQACTargetKill(target, lastAttacker, lastAttackerPlayerIndex)
-- RELEASE_LOGOFF  	luaLog(" luaQACTargetKill")
	--luaLog(target)
	--luaLog(lastAttacker)
	--luaLog(lastAttackerPlayerIndex)
	if lastAttacker ~= nil then
		if not lastAttacker.Dead then
			lastAttackerPlayerIndex = GetRoleAvailable(lastAttacker)[1]
		end
-- RELEASE_LOGOFF  		luaLog(lastAttackerPlayerIndex)
-- RELEASE_LOGOFF  		luaLog(" LISTENER: target killed by player "..lastAttackerPlayerIndex)
		if lastAttackerPlayerIndex >= 0 and lastAttackerPlayerIndex <= 7 then
			if Mission.RandomListener == 1 then
				Scoring_AddCommandScore(lastAttackerPlayerIndex, "mp01.nar_comp_bonus_kill", Mission.Jap.Listener.KillScore.Ship)
			elseif Mission.RandomListener == 2 then
				Scoring_AddCommandScore(lastAttackerPlayerIndex, "mp01.nar_comp_bonus_kill", Mission.Jap.Listener.KillScore.Plane)
			end
			for i = 1, 8 do
				--luaLog("i = "..i)
				local y = i - 1
				--luaLog("y = "..y)
				--luaLog(" lastAttackerPlayerIndex = "..lastAttackerPlayerIndex)
				if y == lastAttackerPlayerIndex then
					MissionNarrativePlayer(y, "mp01.nar_comp_kill")
				else
					MissionNarrativePlayer(y, "mp01.nar_comp_kill_fail")
				end
			end
		else
-- RELEASE_LOGOFF  			luaLog(" FAIL!!! lastAttackerPlayerIndex")
			for i = 0, 7 do
				MissionNarrativePlayer(i, "mp01.nar_comp_kill_fail")
			end
		end
	else
-- RELEASE_LOGOFF  		luaLog(" FAIL!!! lastAttacker")
	end
	RemoveListener("kill", "TargetKill")
	Mission.ListenerActive = false
	if GameTime() > Mission.ListenerTimer then
-- RELEASE_LOGOFF  		luaLog("  ListenerTimer needs to be modified")
		local randomtime = luaRnd(15, 30)
		Mission.ListenerTimer = GameTime() + randomtime
	end
end

function luaQAC13CheckLandforts()
	if not Mission.MissionEnd then
		local activeHQs = 0
		for index, unit in pairs (Mission.US.HQsSouth) do
			if unit.Party ~= PARTY_ALLIED and not unit.landfortsOff then
-- RELEASE_LOGOFF  				luaLog(" Neutralizing landforts of US CB South "..tostring(index))
				Mission.US.CCLandfortsSouth[index] = luaRemoveDeadsFromTable(Mission.US.CCLandfortsSouth[index])
				for index2, unit2 in pairs (Mission.US.CCLandfortsSouth[index]) do
					SetParty(unit2, PARTY_NEUTRAL)
				end
				if not Mission.US.SYsSouth[index].Dead and not Mission.US.SYsBuildingSouth[index].Dead then
					SetParty(Mission.US.SYsSouth[index], PARTY_NEUTRAL)
					SetParty(Mission.US.SYsBuildingSouth[index], PARTY_NEUTRAL)
				end
				unit.landfortsOff = true
				luaObj_RemoveUnit("secondary", 1, unit)
			elseif unit.Party == PARTY_ALLIED then
				activeHQs = activeHQs + 1
			end
		end
		for index, unit in pairs (Mission.US.HQsNorth) do
			if unit.Party ~= PARTY_ALLIED and not unit.landfortsOff then
-- RELEASE_LOGOFF  				luaLog(" Neutralizing landforts of US CB North "..tostring(index))
				Mission.US.CCLandfortsNorth[index] = luaRemoveDeadsFromTable(Mission.US.CCLandfortsNorth[index])
				for index2, unit2 in pairs (Mission.US.CCLandfortsNorth[index]) do
					SetParty(unit2, PARTY_NEUTRAL)
				end
				if not Mission.US.SYsNorth[index].Dead and not Mission.US.SYsBuildingNorth[index].Dead then
					SetParty(Mission.US.SYsNorth[index], PARTY_NEUTRAL)
					SetParty(Mission.US.SYsBuildingNorth[index], PARTY_NEUTRAL)
				end
				unit.landfortsOff = true
				luaObj_RemoveUnit("secondary", 1, unit)
			elseif unit.Party == PARTY_ALLIED then
				activeHQs = activeHQs + 1
			end
		end
		if activeHQs == 0 then
			luaObj_Completed("secondary", 1)
		else
			luaDelay(luaQAC13CheckLandforts, 0.8)
		end
	end
end

function luaQAC13AllowSecondWave()
-- RELEASE_LOGOFF  	luaLog(" Allowing second wave...")
	Mission.SecondWave = true
end

function luaQAC13AllowThirdWave()
-- RELEASE_LOGOFF  	luaLog(" Allowing third wave...")
	Mission.ThirdWave = true
end

function luaQAC13AllowFourthWave()
-- RELEASE_LOGOFF  	luaLog(" Allowing fourth wave...")
	Mission.FourthWave = true
end

function luaQAC13CarrierSpotted()
-- RELEASE_LOGOFF  	luaLog(" Carriers spotted by the players")
	if IsListenerActive("recon", "Listener_CarrierSpotted") then
		RemoveListener("recon", "Listener_CarrierSpotted")
	end
	MissionNarrativeParty(PARTY_JAPANESE, "mp13.nar_comp_carrierspotted")
	luaDelay(luaQAC13Secondary2Add, 7)
end

function luaQAC13Secondary2Add()
	luaObj_Add("secondary", 2)
	if not Mission.US.Carriers[1].Dead then
		luaObj_AddUnit("secondary", 2, Mission.US.Carriers[1])
	end
	if not Mission.US.Carriers[2].Dead then
		luaObj_AddUnit("secondary", 2, Mission.US.Carriers[2])
	end
end