--SceneFile="Missions\Multi\Scene4.scn"

function luaPrecacheUnits()
	--PrepareClass(41) -- Landing Ship
	--PrepareClass(45) -- Kamikaze Zero
	--PrepareClass(32) -- Betty - Ohka
	PrepareClass(154) -- Oscar
	PrepareClass(158) -- Val
	PrepareClass(7) -- South Dakota
	PrepareClass(9) -- King George
	PrepareClass(15) -- Iowa
	PrepareClass(23) -- Fletcher
	PrepareClass(25) -- Clemson
	PrepareClass(73) -- Fubuki
	PrepareClass(75) -- Minekaze
	PrepareClass(21) -- York
	PrepareClass(68) -- Tone
	PrepareClass(69) -- Takao
	PrepareClass(316) -- Cleveland
	PrepareClass(70) -- Kuma
	PrepareClass(13) -- New York
	PrepareClass(60) -- Kongo
	PrepareClass(61) -- Fuso
	PrepareClass(27) -- Elco
	PrepareClass(77) -- Jap PT
	--PrepareClass(87) -- Jap Cargo
	--PrepareClass(154) -- Watermine
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAC4Mission")
end

function luaInitQAC4Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Comp4"..dateandtime

	Mission.HelperLog = false
	Mission.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.."!")
	
	-- lokalizacios feltoltesek
	--AddLockitPathToSelection("missionglobals")
	--LoadSelectedPaths()

	-- globalban hasznalando
	this.Multiplayer = true
	this.ThinkCounter = 0
	Mission.MultiplayerType = "Competitive"
	--Mission.SpecialType = "PTBoatRace"
	Mission.MultiplayerNumber = 4
	Mission.CompetitiveParty = PARTY_ALLIED

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

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

	if Mission.LobbyCountDown == 0 then
		Mission.FirstWarningDone = true
		Mission.SecondWarningDone = true
		Mission.ThirdWarningDone = true
		Mission.FourthWarningDone = true
	elseif Mission.LobbyCountDown <= 900 and Mission.LobbyCountDown >= 601 then
		Mission.FirstWarningDone = true
	elseif Mission.LobbyCountDown <= 600 and Mission.LobbyCountDown >= 301 then
		Mission.FirstWarningDone = true
		Mission.SecondWarningDone = true
	elseif Mission.LobbyCountDown <= 300 then
		Mission.FirstWarningDone = true
		Mission.SecondWarningDone = true
		Mission.ThirdWarningDone = true
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

	-- mission tablak, valtozok
	Mission.CenterPoint = {["x"] = 0, ["y"] = 0, ["z"] = 0}
--[[
	Mission.USPTBoats = {}
		table.insert(Mission.USPTBoats, "fake")
		table.insert(Mission.USPTBoats, "fake")
		table.insert(Mission.USPTBoats, "fake")
		table.insert(Mission.USPTBoats, "fake")
		table.insert(Mission.USPTBoats, "fake")
		table.insert(Mission.USPTBoats, "fake")
		table.insert(Mission.USPTBoats, "fake")
		table.insert(Mission.USPTBoats, "fake")
	Mission.PlayersActualCheckPoint = {}
		table.insert(Mission.PlayersActualCheckPoint, 1)
		table.insert(Mission.PlayersActualCheckPoint, 1)
		table.insert(Mission.PlayersActualCheckPoint, 1)
		table.insert(Mission.PlayersActualCheckPoint, 1)
		table.insert(Mission.PlayersActualCheckPoint, 1)
		table.insert(Mission.PlayersActualCheckPoint, 1)
		table.insert(Mission.PlayersActualCheckPoint, 1)
		table.insert(Mission.PlayersActualCheckPoint, 1)
	Mission.Player1SecObjectives = {}
		table.insert(Mission.Player1SecObjectives, 1)
		table.insert(Mission.Player1SecObjectives, 9)
		table.insert(Mission.Player1SecObjectives, 17)
		table.insert(Mission.Player1SecObjectives, 25)
		table.insert(Mission.Player1SecObjectives, 33)
		table.insert(Mission.Player1SecObjectives, 41)
		table.insert(Mission.Player1SecObjectives, 49)
		table.insert(Mission.Player1SecObjectives, 57)
		table.insert(Mission.Player1SecObjectives, 65)
		table.insert(Mission.Player1SecObjectives, 73)
	Mission.Player2SecObjectives = {}
		table.insert(Mission.Player2SecObjectives, 2)
		table.insert(Mission.Player2SecObjectives, 10)
		table.insert(Mission.Player2SecObjectives, 18)
		table.insert(Mission.Player2SecObjectives, 26)
		table.insert(Mission.Player2SecObjectives, 34)
		table.insert(Mission.Player2SecObjectives, 42)
		table.insert(Mission.Player2SecObjectives, 50)
		table.insert(Mission.Player2SecObjectives, 58)
		table.insert(Mission.Player2SecObjectives, 66)
		table.insert(Mission.Player2SecObjectives, 74)
	Mission.Player3SecObjectives = {}
		table.insert(Mission.Player3SecObjectives, 3)
		table.insert(Mission.Player3SecObjectives, 11)
		table.insert(Mission.Player3SecObjectives, 19)
		table.insert(Mission.Player3SecObjectives, 27)
		table.insert(Mission.Player3SecObjectives, 35)
		table.insert(Mission.Player3SecObjectives, 43)
		table.insert(Mission.Player3SecObjectives, 51)
		table.insert(Mission.Player3SecObjectives, 59)
		table.insert(Mission.Player3SecObjectives, 67)
		table.insert(Mission.Player3SecObjectives, 75)
	Mission.Player4SecObjectives = {}
		table.insert(Mission.Player4SecObjectives, 4)
		table.insert(Mission.Player4SecObjectives, 12)
		table.insert(Mission.Player4SecObjectives, 20)
		table.insert(Mission.Player4SecObjectives, 28)
		table.insert(Mission.Player4SecObjectives, 36)
		table.insert(Mission.Player4SecObjectives, 44)
		table.insert(Mission.Player4SecObjectives, 52)
		table.insert(Mission.Player4SecObjectives, 60)
		table.insert(Mission.Player4SecObjectives, 68)
		table.insert(Mission.Player4SecObjectives, 76)
	Mission.Player5SecObjectives = {}
		table.insert(Mission.Player5SecObjectives, 5)
		table.insert(Mission.Player5SecObjectives, 13)
		table.insert(Mission.Player5SecObjectives, 21)
		table.insert(Mission.Player5SecObjectives, 29)
		table.insert(Mission.Player5SecObjectives, 37)
		table.insert(Mission.Player5SecObjectives, 45)
		table.insert(Mission.Player5SecObjectives, 53)
		table.insert(Mission.Player5SecObjectives, 61)
		table.insert(Mission.Player5SecObjectives, 69)
		table.insert(Mission.Player5SecObjectives, 77)
	Mission.Player6SecObjectives = {}
		table.insert(Mission.Player6SecObjectives, 6)
		table.insert(Mission.Player6SecObjectives, 14)
		table.insert(Mission.Player6SecObjectives, 22)
		table.insert(Mission.Player6SecObjectives, 30)
		table.insert(Mission.Player6SecObjectives, 38)
		table.insert(Mission.Player6SecObjectives, 46)
		table.insert(Mission.Player6SecObjectives, 54)
		table.insert(Mission.Player6SecObjectives, 62)
		table.insert(Mission.Player6SecObjectives, 70)
		table.insert(Mission.Player6SecObjectives, 78)
	Mission.Player7SecObjectives = {}
		table.insert(Mission.Player7SecObjectives, 7)
		table.insert(Mission.Player7SecObjectives, 15)
		table.insert(Mission.Player7SecObjectives, 23)
		table.insert(Mission.Player7SecObjectives, 31)
		table.insert(Mission.Player7SecObjectives, 39)
		table.insert(Mission.Player7SecObjectives, 47)
		table.insert(Mission.Player7SecObjectives, 55)
		table.insert(Mission.Player7SecObjectives, 63)
		table.insert(Mission.Player7SecObjectives, 71)
		table.insert(Mission.Player7SecObjectives, 79)
	Mission.Player8SecObjectives = {}
		table.insert(Mission.Player8SecObjectives, 8)
		table.insert(Mission.Player8SecObjectives, 16)
		table.insert(Mission.Player8SecObjectives, 24)
		table.insert(Mission.Player8SecObjectives, 32)
		table.insert(Mission.Player8SecObjectives, 40)
		table.insert(Mission.Player8SecObjectives, 48)
		table.insert(Mission.Player8SecObjectives, 56)
		table.insert(Mission.Player8SecObjectives, 64)
		table.insert(Mission.Player8SecObjectives, 72)
		table.insert(Mission.Player8SecObjectives, 80)
]]
	-- amerikai objektumok
	Mission.Yorktown = FindEntity("Comp - Yorktown")
	Mission.Lexington = FindEntity("Comp - Lexington")
	Mission.SuicideFletcher = FindEntity("Comp - Fletcher Suicide")

--[[
	Mission.CP1Siege = {}
		table.insert(Mission.CP1Siege, FindEntity("Comp - LST1 1"))
		table.insert(Mission.CP1Siege, FindEntity("Comp - LST1 2"))
		table.insert(Mission.CP1Siege, FindEntity("Comp - LST1 3"))
	Mission.CP2Siege = {}
	Mission.CPxSiegeTMPL = {}
		table.insert(Mission.CPxSiegeTMPL, luaFindHidden("Comp - LST TMPL 1"))
		table.insert(Mission.CPxSiegeTMPL, luaFindHidden("Comp - LST TMPL 2"))
		table.insert(Mission.CPxSiegeTMPL, luaFindHidden("Comp - LST TMPL 3"))
	Mission.CP3Siege = {}
	Mission.CP3Positions = {}
		table.insert(Mission.CP3Positions, GetPosition(FindEntity("Comp - Navpoint3 1")))
		table.insert(Mission.CP3Positions, GetPosition(FindEntity("Comp - Navpoint3 2")))
		table.insert(Mission.CP3Positions, GetPosition(FindEntity("Comp - Navpoint3 3")))
	Mission.CP4Siege = {}
	Mission.CP4Positions = {}
		table.insert(Mission.CP4Positions, GetPosition(FindEntity("Comp - Navpoint4 1")))
		table.insert(Mission.CP4Positions, GetPosition(FindEntity("Comp - Navpoint4 2")))
		table.insert(Mission.CP4Positions, GetPosition(FindEntity("Comp - Navpoint4 3")))
	Mission.CP5Siege = {}
	Mission.CP5Positions = {}
		table.insert(Mission.CP5Positions, GetPosition(FindEntity("Comp - Navpoint5 1")))
		table.insert(Mission.CP5Positions, GetPosition(FindEntity("Comp - Navpoint5 2")))
		table.insert(Mission.CP5Positions, GetPosition(FindEntity("Comp - Navpoint5 3")))
	Mission.CP6Siege = {}
	Mission.CP6Positions = {}
		table.insert(Mission.CP6Positions, GetPosition(FindEntity("Comp - Navpoint6 1")))
		table.insert(Mission.CP6Positions, GetPosition(FindEntity("Comp - Navpoint6 2")))
		table.insert(Mission.CP6Positions, GetPosition(FindEntity("Comp - Navpoint6 3")))
]]
	Mission.USSpawnPoints = {}
		--table.insert(Mission.USSpawnPoints, FindEntity("Comp - SpawnPoint 01"))
		--table.insert(Mission.USSpawnPoints, FindEntity("Comp - SpawnPoint 02"))
		table.insert(Mission.USSpawnPoints, FindEntity("Comp - SpawnPoint 03"))
		table.insert(Mission.USSpawnPoints, FindEntity("Comp - SpawnPoint 04"))
		table.insert(Mission.USSpawnPoints, FindEntity("Comp - SpawnPoint 05"))
		table.insert(Mission.USSpawnPoints, FindEntity("Comp - SpawnPoint 06"))
--[[
		table.insert(Mission.USSpawnPoints, FindEntity("Comp - SpawnPoint 07"))
		table.insert(Mission.USSpawnPoints, FindEntity("Comp - SpawnPoint 08"))
		table.insert(Mission.USSpawnPoints, FindEntity("Comp - SpawnPoint 09"))
		table.insert(Mission.USSpawnPoints, FindEntity("Comp - SpawnPoint 10"))
		table.insert(Mission.USSpawnPoints, FindEntity("Comp - SpawnPoint 11"))
]]
	--for i = 2, 6 do
	--for i = 2, 11 do
	for i = 2, 3 do
		for i2 = 1, 8 do
			local i2mod = i2 - 1
			DeactivateSpawnpoint(Mission.USSpawnPoints[i], i2mod)
		end
	end
--[[
	Mission.USCheckPoints01 = {}
		table.insert(Mission.USCheckPoints01, GetPosition(FindEntity("Comp - Navpoint 01")))
		table.insert(Mission.USCheckPoints01, GetPosition(FindEntity("Comp - Navpoint 01b")))
		table.insert(Mission.USCheckPoints01, GetPosition(FindEntity("Comp - Navpoint 01c")))
		table.insert(Mission.USCheckPoints01, GetPosition(FindEntity("Comp - Navpoint 01d")))
		table.insert(Mission.USCheckPoints01, GetPosition(FindEntity("Comp - Navpoint 01e")))
		table.insert(Mission.USCheckPoints01, GetPosition(FindEntity("Comp - Navpoint 01f")))
	Mission.USCheckPoints02 = {}
		table.insert(Mission.USCheckPoints02, GetPosition(FindEntity("Comp - Navpoint 02")))
		table.insert(Mission.USCheckPoints02, GetPosition(FindEntity("Comp - Navpoint 02b")))
		table.insert(Mission.USCheckPoints02, GetPosition(FindEntity("Comp - Navpoint 02c")))
		table.insert(Mission.USCheckPoints02, GetPosition(FindEntity("Comp - Navpoint 02d")))
		table.insert(Mission.USCheckPoints02, GetPosition(FindEntity("Comp - Navpoint 02e")))
		table.insert(Mission.USCheckPoints02, GetPosition(FindEntity("Comp - Navpoint 02f")))
	Mission.USCheckPoints03 = {}
		table.insert(Mission.USCheckPoints03, GetPosition(FindEntity("Comp - Navpoint 03")))
		table.insert(Mission.USCheckPoints03, GetPosition(FindEntity("Comp - Navpoint 03b")))
		table.insert(Mission.USCheckPoints03, GetPosition(FindEntity("Comp - Navpoint 03c")))
		table.insert(Mission.USCheckPoints03, GetPosition(FindEntity("Comp - Navpoint 03d")))
		table.insert(Mission.USCheckPoints03, GetPosition(FindEntity("Comp - Navpoint 03e")))
		table.insert(Mission.USCheckPoints03, GetPosition(FindEntity("Comp - Navpoint 03f")))
	Mission.USCheckPoints04 = {}
		table.insert(Mission.USCheckPoints04, GetPosition(FindEntity("Comp - Navpoint 04")))
		table.insert(Mission.USCheckPoints04, GetPosition(FindEntity("Comp - Navpoint 04b")))
		table.insert(Mission.USCheckPoints04, GetPosition(FindEntity("Comp - Navpoint 04c")))
		table.insert(Mission.USCheckPoints04, GetPosition(FindEntity("Comp - Navpoint 04d")))
		table.insert(Mission.USCheckPoints04, GetPosition(FindEntity("Comp - Navpoint 04e")))
		table.insert(Mission.USCheckPoints04, GetPosition(FindEntity("Comp - Navpoint 04f")))
	Mission.USCheckPoints05 = {}
		table.insert(Mission.USCheckPoints05, GetPosition(FindEntity("Comp - Navpoint 05")))
		table.insert(Mission.USCheckPoints05, GetPosition(FindEntity("Comp - Navpoint 05b")))
		table.insert(Mission.USCheckPoints05, GetPosition(FindEntity("Comp - Navpoint 05c")))
		table.insert(Mission.USCheckPoints05, GetPosition(FindEntity("Comp - Navpoint 05d")))
		table.insert(Mission.USCheckPoints05, GetPosition(FindEntity("Comp - Navpoint 05e")))
		table.insert(Mission.USCheckPoints05, GetPosition(FindEntity("Comp - Navpoint 05f")))
	Mission.USCheckPoint06 = GetPosition(FindEntity("Comp - Navpoint 06"))

	local cptable = {}
	for i = 1, 6 do
		table.insert(cptable, i)
	end
	local cp1 = luaPickRnd(cptable)
	local cp2 = luaPickRnd(cptable)
	local cp3 = luaPickRnd(cptable)
	local cp4 = luaPickRnd(cptable)
	local cp5 = luaPickRnd(cptable)

	Mission.USCheckPoints = {}
		table.insert(Mission.USCheckPoints, Mission.USCheckPoints01[cp1])
		table.insert(Mission.USCheckPoints, Mission.USCheckPoints02[cp2])
		table.insert(Mission.USCheckPoints, Mission.USCheckPoints03[cp3])
		table.insert(Mission.USCheckPoints, Mission.USCheckPoints04[cp4])
		table.insert(Mission.USCheckPoints, Mission.USCheckPoints05[cp5])
		table.insert(Mission.USCheckPoints, Mission.USCheckPoint06)
]]
--[[
		table.insert(Mission.USCheckPoints, GetPosition(FindEntity("Comp - Navpoint 07")))
		table.insert(Mission.USCheckPoints, GetPosition(FindEntity("Comp - Navpoint 08")))
		table.insert(Mission.USCheckPoints, GetPosition(FindEntity("Comp - Navpoint 09")))
		table.insert(Mission.USCheckPoints, GetPosition(FindEntity("Comp - Navpoint 10")))
		table.insert(Mission.USCheckPoints, GetPosition(FindEntity("Comp - Navpoint 11")))
]]
	-- japan objektumok
	Mission.HQs = {}
		--table.insert(Mission.HQs, FindEntity("Comp - HQ 1"))
		--table.insert(Mission.HQs, FindEntity("Comp - HQ 2"))
		table.insert(Mission.HQs, FindEntity("Comp - HQ 3"))
		table.insert(Mission.HQs, FindEntity("Comp - HQ 4"))
		table.insert(Mission.HQs, FindEntity("Comp - HQ 5"))
		table.insert(Mission.HQs, FindEntity("Comp - HQ 6"))
		table.insert(Mission.HQs, FindEntity("Comp - HQ 7"))
	Mission.AttackerPlanes = {}
	Mission.BomberPlanes = {}
	Mission.AttackerPlanesHQ2 = {}
	Mission.AttackerPlanesHQ4 = {}
	Mission.OscarTMPL = luaFindHidden("Comp - Oscar TMPL")
	Mission.ValTMPL = luaFindHidden("Comp - D3A Val 01")
	--Mission.KamikazeTMPL = luaFindHidden("Comp - Kamikaze Zero TMPL")
	--Mission.BettyOhkaTMPL = luaFindHidden("Comp - Betty Ohka TMPL")
	Mission.AttackerPlaneSpawnDenied = false

	Mission.BigFleetPoint = FindEntity("Comp - BigFleetPoint")
	Mission.BigFleet = {}
	Mission.USFleetPoints = {}
		table.insert(Mission.USFleetPoints, GetPosition(FindEntity("Comp - Navpoint US Fleet 01")))
		table.insert(Mission.USFleetPoints, GetPosition(FindEntity("Comp - Navpoint US Fleet 02")))
	Mission.USFleetPaths = {}
		table.insert(Mission.USFleetPaths, FindEntity("Comp - US Fleet 1 Path"))
		table.insert(Mission.USFleetPaths, FindEntity("Comp - US Fleet 2 Path"))
	Mission.JapFleetPoints = {}
		table.insert(Mission.JapFleetPoints, GetPosition(FindEntity("Comp - Navpoint Jap Fleet 01")))
		table.insert(Mission.JapFleetPoints, GetPosition(FindEntity("Comp - Navpoint Jap Fleet 02")))
		table.insert(Mission.JapFleetPoints, GetPosition(FindEntity("Comp - Navpoint Jap Fleet 03")))
	Mission.JapFleetPaths = {}
		table.insert(Mission.JapFleetPaths, FindEntity("Comp - Jap Fleet 1 Path"))
		table.insert(Mission.JapFleetPaths, FindEntity("Comp - Jap Fleet 2 Path"))
		table.insert(Mission.JapFleetPaths, FindEntity("Comp - Jap Fleet 3 Path"))
	Mission.JapAnchoredFleetPoints = {}
		table.insert(Mission.JapAnchoredFleetPoints, GetPosition(FindEntity("Comp - Navpoint Jap Fleet Anchored 01")))
		table.insert(Mission.JapAnchoredFleetPoints, GetPosition(FindEntity("Comp - Navpoint Jap Fleet Anchored 02")))
		table.insert(Mission.JapAnchoredFleetPoints, GetPosition(FindEntity("Comp - Navpoint Jap Fleet Anchored 03")))
		table.insert(Mission.JapAnchoredFleetPoints, GetPosition(FindEntity("Comp - Navpoint Jap Fleet Anchored 04")))
		table.insert(Mission.JapAnchoredFleetPoints, GetPosition(FindEntity("Comp - Navpoint Jap Fleet Anchored 05")))
		table.insert(Mission.JapAnchoredFleetPoints, GetPosition(FindEntity("Comp - Navpoint Jap Fleet Anchored 06")))
		table.insert(Mission.JapAnchoredFleetPoints, GetPosition(FindEntity("Comp - Navpoint Jap Fleet Anchored 07")))
		table.insert(Mission.JapAnchoredFleetPoints, GetPosition(FindEntity("Comp - Navpoint Jap Fleet Anchored 08")))
	Mission.MineField1 = {}
		table.insert(Mission.MineField1, GetPosition(FindEntity("Comp - Navpoint Mines 01a")))
		table.insert(Mission.MineField1, GetPosition(FindEntity("Comp - Navpoint Mines 01b")))
	Mission.MineField2 = {}
		table.insert(Mission.MineField2, GetPosition(FindEntity("Comp - Navpoint Mines 02a")))
		table.insert(Mission.MineField2, GetPosition(FindEntity("Comp - Navpoint Mines 02b")))
	Mission.Mine = luaFindHidden("Comp - WaterMine")

	Mission.USFleet1 = {}
	Mission.USFleet2 = {}
	Mission.JapFleet1 = {}
	Mission.JapFleet2 = {}
	Mission.JapFleet3 = {}
	Mission.JapFleet4 = {}
	Mission.JapCargos = {}
	Mission.JapPTBoats = {}
	Mission.Mines1 = {}
	Mission.Mines2 = {}
	Mission.MinesInMinefield1 = 50
	Mission.MinesInMinefield2 = 50

	Mission.RespawnTime = 30

	Mission.USBigShipIDsFleet1 = {}
		table.insert(Mission.USBigShipIDsFleet1, 7)
		table.insert(Mission.USBigShipIDsFleet1, 9)
	Mission.USBigShipIDsFleet2 = {}
		table.insert(Mission.USBigShipIDsFleet2, 13)
		table.insert(Mission.USBigShipIDsFleet2, 15)
	Mission.USMediumShipIDs = {}
		table.insert(Mission.USMediumShipIDs, 316)
		table.insert(Mission.USMediumShipIDs, 21)
	Mission.USSmallShipIDs = {}
		table.insert(Mission.USSmallShipIDs, 23)
		table.insert(Mission.USSmallShipIDs, 25)
	Mission.JapBigShipIDs = {}
		table.insert(Mission.JapBigShipIDs, 60)
		table.insert(Mission.JapBigShipIDs, 61)
	Mission.JapMediumShipIDs = {}
		table.insert(Mission.JapMediumShipIDs, 68)
		table.insert(Mission.JapMediumShipIDs, 69)
		table.insert(Mission.JapMediumShipIDs, 70)
	Mission.JapSmallShipIDs = {}
		table.insert(Mission.JapSmallShipIDs, 73)
		table.insert(Mission.JapSmallShipIDs, 75)
	Mission.JapCargoID = 87
	Mission.JapPTID = 77
	Mission.USBigShipNamesFleet1 = {}
		table.insert(Mission.USBigShipNamesFleet1, "globals.unitclass_southdakota")
		table.insert(Mission.USBigShipNamesFleet1, "globals.unitclass_kinggeorge")
	Mission.USBigShipNamesFleet2 = {}
		table.insert(Mission.USBigShipNamesFleet2, "globals.unitclass_newyork")
		table.insert(Mission.USBigShipNamesFleet2, "globals.unitclass_iowa")
	Mission.USMediumShipNames = {}
		table.insert(Mission.USMediumShipNames, "globals.unitclass_cleveland")
		table.insert(Mission.USMediumShipNames, "globals.unitclass_york")
	Mission.USSmallShipNames = {}
		table.insert(Mission.USSmallShipNames, "globals.unitclass_fletcher")
		table.insert(Mission.USSmallShipNames, "globals.unitclass_clemson")
	Mission.JapBigShipNames = {}
		table.insert(Mission.JapBigShipNames, "globals.unitclass_kongo")
		table.insert(Mission.JapBigShipNames, "globals.unitclass_fuso")
	Mission.JapMediumShipNames = {}
		table.insert(Mission.JapMediumShipNames, "globals.unitclass_tone")
		table.insert(Mission.JapMediumShipNames, "globals.unitclass_takao")
		table.insert(Mission.JapMediumShipNames, "globals.unitclass_kuma")
	Mission.JapSmallShipNames = {}
		table.insert(Mission.JapSmallShipNames, "globals.unitclass_fubuki")
		table.insert(Mission.JapSmallShipNames, "globals.unitclass_minekaze")
	Mission.JapCargoName = "globals.unitclass_japcargotransporter"
	Mission.JapPTName = "globals.unitclass_japanesept"

	Mission.ExitingUnits = {}
		table.insert(Mission.ExitingUnits, FindEntity("Comp - US Cargo Transport 01"))
		table.insert(Mission.ExitingUnits, FindEntity("Comp - US Cargo Transport 02"))
		table.insert(Mission.ExitingUnits, FindEntity("Comp - US Cargo Transport 03"))
		table.insert(Mission.ExitingUnits, FindEntity("Comp - Fletcher-class 01"))
	Mission.ExitingUnitsPath = FindEntity("Comp - Fleet Exiting Path")
	Mission.ExitingUnitsPathPoints = FillPathPoints(Mission.ExitingUnitsPath)
	Mission.ExitingPursuers = {}
		table.insert(Mission.ExitingPursuers, FindEntity("Comp - Tone-class 01"))
		table.insert(Mission.ExitingPursuers, FindEntity("Comp - Tone-class 02"))

	Mission.KillScoreShip = 175
	Mission.KillScorePlane = 100

	-- jatekosok
	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog("-- playertable --")
-- RELEASE_LOGOFF  	luaLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	luaLog("-----------------")
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)

	-- lefigyelesek

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
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
				["Party"] = PARTY_ALLIED,
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
				["Party"] = PARTY_ALLIED,
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
				["Party"] = PARTY_ALLIED,
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
				["Party"] = PARTY_ALLIED,
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
				["Party"] = PARTY_ALLIED,
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
				["Party"] = PARTY_ALLIED,
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
				["Party"] = PARTY_ALLIED,
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
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_primary_2",
				["Text"] = "mp04.obj_comp_p2_text",
				["TextCompleted"] = "mp04.obj_comp_p2_comp",
				["TextFailed"] = "mp04.obj_comp_p2_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] =	{
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_secondary_1",
				["Text"] = "mp05.obj_comp_p2_text",
				["TextCompleted"] = "mp05.obj_comp_p2_comp",
				["TextFailed"] = "mp05.obj_comp_p2_fail",
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
		},
		[1]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[2]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[3]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[4]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[5]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[6]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
		},
		[7]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = Mission.Digit4,
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

	SetRocketAirGroundTypeDifferent(false)

	--AISetSpawnSceneUnitsWeightMul(0)

	luaInitNewSystems()

    SetThink(this, "luaQAC4Mission_think")
end

function luaQAC4Mission_think(this, msg)
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
		--luaQAC4CheckGameTime()
		--luaQAC4CheckCheckPoints()
		luaQAC4ManageFleets()
		--luaQAC4CheckHQDistances()
		luaQAC4CheckAttackerPlanes()
		luaQAC4CheckMissionEnd()
		luaQAC4HintManager()

	elseif not Mission.Started then
		luaQAC4StartMission()
		luaUpdateCounters()
		--luaDelay(luaQAC4UpdateCounters, 1)
		--luaQAC4HQHack()		
	end
end

function luaQAC4StartMission()
-- RELEASE_LOGOFF  	luaLog(" Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()

	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	if Mission.LobbyCountDown ~= 0 then
		Countdown("mp.score_comp_time_left", 0, Mission.LobbyCountDown, "luaQAC4MissionEndTimeIsUp")
	end

	for i = 1, 8 do
		luaObj_Add("primary", i)
	end

	luaObj_Add("primary", 9)
	luaObj_AddUnit("primary", 9, Mission.HQs[1])
	luaObj_AddUnit("primary", 9, Mission.HQs[5])
	luaObj_Add("secondary", 1)
	luaObj_AddUnit("secondary", 1, Mission.Yorktown)
	luaObj_AddUnit("secondary", 1, Mission.Lexington)
	SetSkillLevel(Mission.Yorktown, SKILL_MPVETERAN)
	SetSkillLevel(Mission.Lexington, SKILL_MPVETERAN)

--[[
	for i = 1, 8 do
		luaObj_Add("secondary", i, Mission.USCheckPoints[1])
	end
]]
--[[
	for index, unit in pairs (Mission.CP1Siege) do
		SetShipSpeed(unit, GetShipMaxSpeed(unit)*0.75)
		StartLanding2(unit)
		AAEnable(unit, false)
		--ArtilleryEnable(unit, false)
	end
]]
	if Mission.Players <= 2 then
		Mission.MaxAttackerPlanes = 2
		Mission.MaxAttackerPTs = 1
		Mission.BigFleetShipsNumber = 3
		Mission.MediumFleetsShipNumber = 2
--[[
		Mission.MaxAttackerPlanes = 2
		Mission.MaxAttackerPTs = 2
]]
	elseif Mission.Players == 3 then
		Mission.MaxAttackerPlanes = 2
		Mission.MaxAttackerPTs = 1
		Mission.BigFleetShipsNumber = 4
		Mission.MediumFleetsShipNumber = 2
--[[
		Mission.MaxAttackerPlanes = 2
		Mission.MaxAttackerPTs = 2
]]
	elseif Mission.Players == 4 then
		Mission.MaxAttackerPlanes = 2
		Mission.MaxAttackerPTs = 2
		Mission.BigFleetShipsNumber = 4
		Mission.MediumFleetsShipNumber = 2
--[[
		Mission.MaxAttackerPlanes = 2
		Mission.MaxAttackerPTs = 3
]]
	elseif Mission.Players == 5 then
		Mission.MaxAttackerPlanes = 4
		Mission.MaxAttackerPTs = 2
		Mission.BigFleetShipsNumber = 5
		Mission.MediumFleetsShipNumber = 3
--[[
		Mission.MaxAttackerPlanes = 2
		Mission.MaxAttackerPTs = 3
]]
	elseif Mission.Players == 6 then
		Mission.MaxAttackerPlanes = 4
		Mission.MaxAttackerPTs = 3
		Mission.BigFleetShipsNumber = 5
		Mission.MediumFleetsShipNumber = 3
--[[
		Mission.MaxAttackerPlanes = 4
		Mission.MaxAttackerPTs = 4
]]
	elseif Mission.Players == 7 then
		Mission.MaxAttackerPlanes = 4
		Mission.MaxAttackerPTs = 3
		Mission.BigFleetShipsNumber = 6
		Mission.MediumFleetsShipNumber = 3
--[[
		Mission.MaxAttackerPlanes = 4
		Mission.MaxAttackerPTs = 4
]]
	elseif Mission.Players == 8 then
		Mission.MaxAttackerPlanes = 4
		Mission.MaxAttackerPTs = 4
		Mission.BigFleetShipsNumber = 6
		Mission.MediumFleetsShipNumber = 3
--[[
		Mission.MaxAttackerPlanes = 4
		Mission.MaxAttackerPTs = 4
]]
	end

	Mission.JapPTTable = {}
	for i = 1, Mission.MaxAttackerPTs do
		table.insert(Mission.JapPTTable, {["Type"] = Mission.JapPTID, ["Name"] = Mission.JapPTName, ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,})
	end

	if Mission.MaxAttackerPlanes ~= nil then
		local half = Mission.MaxAttackerPlanes / 2
		for i = 1, half do
			local pos = GetPosition(Mission.HQs[4])
			local modi = i * 100
			local posmod = {["x"] = pos["x"] - modi, ["y"] = 150, ["z"] = pos["z"] - modi}
			local oscar = GenerateObject(Mission.OscarTMPL.Name, posmod)
			--AISetHintWeight(oscar, 3)
			SetSkillLevel(oscar, SKILL_SPNORMAL)
			table.insert(Mission.AttackerPlanesHQ4, oscar)
			table.insert(Mission.AttackerPlanes, oscar)
		end
		for i = 1, half do
			local pos = GetPosition(Mission.HQs[2])
			local modi = i * 100
			local posmod = {["x"] = pos["x"] - modi, ["y"] = 150, ["z"] = pos["z"] - modi}
			local oscar = GenerateObject(Mission.OscarTMPL.Name, posmod)
			--AISetHintWeight(oscar, 3)
			SetSkillLevel(oscar, SKILL_SPNORMAL)
			table.insert(Mission.AttackerPlanesHQ2, oscar)
			table.insert(Mission.AttackerPlanes, oscar)
		end
	end

	for i = 1, 2 do
		local pos = GetPosition(Mission.HQs[3])
		local modi = i * 100
		local posmod = {["x"] = pos["x"] - modi, ["y"] = 150, ["z"] = pos["z"] - modi}
		local val = GenerateObject(Mission.ValTMPL.Name, posmod)
		--AISetHintWeight(val, 7)
		SetSkillLevel(val, SKILL_SPNORMAL)
		table.insert(Mission.BomberPlanes, val)
	end

	for index, unit in pairs (Mission.ExitingUnits) do
		if index == 1 then
			NavigatorMoveOnPath(unit, Mission.ExitingUnitsPath)
		else
			JoinFormation(unit, Mission.ExitingUnits[1])
		end
		NavigatorSetAvoidLandCollision(unit, false)
		NavigatorSetAvoidShipCollision(unit, false)
		NavigatorSetTorpedoEvasion(unit, false)
		AAEnable(unit, false)
		ArtilleryEnable(unit, false)
	end
	
	for index, unit in pairs (Mission.ExitingPursuers) do
		if index == 1 then
			NavigatorMoveOnPath(unit, Mission.ExitingUnitsPath)
		else
			JoinFormation(unit, Mission.ExitingPursuers[1])
		end
		AISetHintWeight(unit, 50)
		SetSkillLevel(unit, SKILL_SPNORMAL)
		NavigatorSetAvoidLandCollision(unit, false)
		NavigatorSetAvoidShipCollision(unit, false)
		NavigatorSetTorpedoEvasion(unit, false)
	end

	luaDelay(luaQAC4ManageExiting, 5)
	--luaDelay(luaQAC4SpawnCargos, 300)
	luaDelay(luaQAC4SpawnPTs, 250)
	luaDelay(luaQAC4SpawnPTs, 550)
	luaDelay(luaQAC4SpawnPTs, 850)
	luaDelay(luaQAC4SpawnPTs, 1150)
	luaDelay(luaQAC4SpawnPTs, 1450)
	luaDelay(luaQAC4SpawnPTs, 1750)
	luaDelay(luaQAC4ManageBigFleet, 800)
	--luaDelay(luaQAC4GenerateMinefield1, 20)
	--luaDelay(luaQAC4GenerateMinefield2, 400)

	Mission.Started = true
end

function luaQAC4ManageExiting()
-- RELEASE_LOGOFF  	luaLog(" Managing exiting units...")
	Mission.ExitingUnits = luaRemoveDeadsFromTable(Mission.ExitingUnits)
	if table.getn(Mission.ExitingUnits) ~= 0 then
		for index, unit in pairs (Mission.ExitingUnits) do
			if luaGetDistance(unit, Mission.ExitingUnitsPathPoints[table.getn(Mission.ExitingUnitsPathPoints)]) < 400 then
				Mission.ExitingKillIsNecessary = true
			end
		end
		if Mission.ExitingKillIsNecessary then
			for index, unit in pairs (Mission.ExitingUnits) do
				Kill(unit, true)
			end
			Mission.ExitingKillIsNecessary = false
		end
	end

	Mission.ExitingPursuers = luaRemoveDeadsFromTable(Mission.ExitingPursuers)
	if table.getn(Mission.ExitingUnits) == 0 and Mission.HQs[1].Party == PARTY_ALLIED then
		for index, unit in pairs (Mission.ExitingPursuers) do
			NavigatorAttackMove(unit, Mission.HQs[1], {})
			NavigatorSetAvoidLandCollision(unit, true)
		end
	end
--[[
	if table.getn(Mission.ExitingPursuers) ~= 0 then
		for index, unit in pairs (Mission.ExitingPursuers) do
			if luaGetDistance(unit, Mission.ExitingUnitsPathPoints[table.getn(Mission.ExitingUnitsPathPoints)]) < 400 then
				Mission.ExitingKillIsNecessary2 = true
			end
		end
		if Mission.ExitingKillIsNecessary2 then
			for index, unit in pairs (Mission.ExitingPursuers) do
				Kill(unit, true)
			end
			Mission.ExitingKillIsNecessary2 = false
		end
	end
]]
	if table.getn(Mission.ExitingUnits) == 0 and table.getn(Mission.ExitingPursuers) == 0 then
-- RELEASE_LOGOFF  		luaLog("  no more exiting units in the scene!")
	else
		luaDelay(luaQAC4ManageExiting, 5)
	end
end

function luaQAC4SpawnCargos()
-- RELEASE_LOGOFF  	luaLog(" Spawning cargos...")
	for i = 1, 8 do
		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = Mission.JapCargoID,
					["Name"] = Mission.JapCargoName,
					["Crew"] = 1,
					["Race"] = JAPANESE,
					["OwnerPlayer"] = PLAYER_AI,
				},
			},
			["area"] = {
				["refPos"] = Mission.JapAnchoredFleetPoints[i],
				["angleRange"] = { DEG(180), DEG(185) },
			},
			["callback"] = "luaQAC4JapCargoSpawned",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 125,
				["enemyHorizontal"] = 125,
				["ownVertical"] = 125,
				["enemyVertical"] = 125,
				["formationHorizontal"] = 125,
			},
		})
	end
end

function luaQAC4JapCargoSpawned(unit)
	NavigatorSetAvoidLandCollision(unit, false)
	NavigatorSetAvoidShipCollision(unit, false)
	NavigatorEnable(unit, false)
	NavigatorSetTorpedoEvasion(unit, false)
	AAEnable(unit, false)
	ArtilleryEnable(unit, false)
	local unitpos = GetPosition(unit)
	local turntopos = {["x"] = unitpos.x - 200, ["y"] = 0, ["z"] = unitpos.z + 125}
	EntityTurnToPosition(unit, turntopos)
	table.insert(Mission.JapCargos, unit)
end

function luaQAC4SpawnPTs()
	if Mission.HQs[3].Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  		luaLog(" Spawning Japanese PTs...")
		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = Mission.JapPTTable,
			["area"] = {
				["refPos"] = Mission.JapFleetPoints[1],
				["angleRange"] = { DEG(180), DEG(185) },
			},
			["callback"] = "luaQAC4JapPTsSpawned",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 125,
				["enemyHorizontal"] = 125,
				["ownVertical"] = 125,
				["enemyVertical"] = 125,
				["formationHorizontal"] = 125,
			},
		})
	end
end

function luaQAC4JapPTsSpawned(unit1, unit2, unit3, unit4, unit5, unit6, unit7, unit8)
	if unit1 ~= nil then
		EntityTurnToEntity(unit1, Mission.HQs[2])
		table.insert(Mission.JapPTBoats, unit1)
	end
	if unit2 ~= nil then
		EntityTurnToEntity(unit2, Mission.HQs[2])
		table.insert(Mission.JapPTBoats, unit2)
	end
	if unit3 ~= nil then
		EntityTurnToEntity(unit3, Mission.HQs[2])
		table.insert(Mission.JapPTBoats, unit3)
	end
	if unit4 ~= nil then
		EntityTurnToEntity(unit4, Mission.HQs[2])
		table.insert(Mission.JapPTBoats, unit4)
	end
	if unit5 ~= nil then
		EntityTurnToEntity(unit5, Mission.HQs[2])
		table.insert(Mission.JapPTBoats, unit5)
	end
	if unit6 ~= nil then
		EntityTurnToEntity(unit6, Mission.HQs[2])
		table.insert(Mission.JapPTBoats, unit6)
	end
	if unit7 ~= nil then
		EntityTurnToEntity(unit7, Mission.HQs[2])
		table.insert(Mission.JapPTBoats, unit7)
	end
	if unit8 ~= nil then
		EntityTurnToEntity(unit8, Mission.HQs[2])
		table.insert(Mission.JapPTBoats, unit8)
	end
	
	Mission.JapPTBoats = luaRemoveDeadsFromTable(Mission.JapPTBoats)
	for index, unit in pairs (Mission.JapPTBoats) do
		SetSkillLevel(unit, SKILL_SPNORMAL)
		TorpedoEnable(unit, true)
		local randomtarget = nil
		Mission.USFleet1 = luaRemoveDeadsFromTable(Mission.USFleet1)
		Mission.USFleet2 = luaRemoveDeadsFromTable(Mission.USFleet2)
		if index == 1 or index == 3 or index == 5 or index == 7 or index == 9 or index == 11 or index == 13 or index == 15 then
		  if table.getn(Mission.USFleet1) ~= 0 then
				randomtarget = luaPickRnd(Mission.USFleet1)
			elseif not Mission.Yorktown.Dead then
				randomtarget = Mission.Yorktown
			elseif table.getn(Mission.USFleet2) ~= 0 then
				randomtarget = luaPickRnd(Mission.USFleet2)
			elseif not Mission.Lexington.Dead then
				randomtarget = Mission.Lexington
			else
				randomtarget = luaGetNearestEnemy(unit, "torpedoboat")
			end
		elseif index == 2 or index == 4 or index == 6 or index == 8 or index == 10 or index == 12 or index == 14 or index == 16 then
		  if table.getn(Mission.USFleet2) ~= 0 then
				randomtarget = luaPickRnd(Mission.USFleet2)
			elseif not Mission.Lexington.Dead then
				randomtarget = Mission.Lexington
			elseif table.getn(Mission.USFleet1) ~= 0 then
				randomtarget = luaPickRnd(Mission.USFleet1)
			elseif not Mission.Yorktown.Dead then
				randomtarget = Mission.Yorktown
			else
				randomtarget = luaGetNearestEnemy(unit, "torpedoboat")
			end
		end
		if randomtarget ~= nil then
			NavigatorAttackMove(unit, randomtarget, {})
		end
	end
	if not Mission.PTManagerInitiated then
		luaDelay(luaQAC4JapPTManager, 3)
		Mission.PTManagerInitiated = true
	end
end

function luaQAC4JapPTManager()
	Mission.JapPTBoats = luaRemoveDeadsFromTable(Mission.JapPTBoats)
	for index, unit in pairs (Mission.JapPTBoats) do
		if UnitGetAttackTarget(unit) == nil then
			local randomtarget = nil
			Mission.USFleet1 = luaRemoveDeadsFromTable(Mission.USFleet1)
			Mission.USFleet2 = luaRemoveDeadsFromTable(Mission.USFleet2)
			if index == 1 or index == 3 or index == 5 or index == 7 or index == 9 or index == 11 or index == 13 or index == 15 then
			  if table.getn(Mission.USFleet1) ~= 0 then
					randomtarget = luaPickRnd(Mission.USFleet1)
				elseif table.getn(Mission.USFleet2) ~= 0 then
					randomtarget = luaPickRnd(Mission.USFleet2)
				else
					randomtarget = luaGetNearestEnemy(unit, "torpedoboat")
				end
			elseif index == 2 or index == 4 or index == 6 or index == 8 or index == 10 or index == 12 or index == 14 or index == 16 then
			  if table.getn(Mission.USFleet2) ~= 0 then
					randomtarget = luaPickRnd(Mission.USFleet2)
				elseif table.getn(Mission.USFleet1) ~= 0 then
					randomtarget = luaPickRnd(Mission.USFleet1)
				else
					randomtarget = luaGetNearestEnemy(unit, "torpedoboat")
				end
			end
			if randomtarget ~= nil then
				NavigatorAttackMove(unit, randomtarget, {})
			end
		end
	end

	if table.getn(Mission.JapPTBoats) ~= 0 then
		luaDelay(luaQAC4JapPTManager, 3)
	else
		Mission.PTManagerInitiated = false
	end
end

function luaQAC4GenerateMinefield1()
-- RELEASE_LOGOFF  	luaLog(" Generating minefield 1...")
	for i = 1, Mission.MinesInMinefield1 do
		local coordinateX
		local coordinateZ
		if Mission.MineField1[1].x < Mission.MineField1[2].x then
			coordinateX = luaRnd(Mission.MineField1[1].x, Mission.MineField1[2].x)
		else
			coordinateX = luaRnd(Mission.MineField1[2].x, Mission.MineField1[1].x)
		end
		if Mission.MineField1[1].z < Mission.MineField1[2].z then
			coordinateZ = luaRnd(Mission.MineField1[1].z, Mission.MineField1[2].z)
		else
			coordinateZ = luaRnd(Mission.MineField1[2].z, Mission.MineField1[1].z)
		end
		local mine = GenerateObject(Mission.Mine.Name, {["x"] = coordinateX, ["y"] = 0.5, ["z"] = coordinateZ})
		table.insert(Mission.Mines1, mine)
	end
-- RELEASE_LOGOFF  	luaLog("  there are "..table.getn(Mission.Mines1).." mines in mines1 table")
end

function luaQAC4GenerateMinefield2()
-- RELEASE_LOGOFF  	luaLog(" Generating minefield 2...")
	for i = 1, Mission.MinesInMinefield2 do
		local coordinateX
		local coordinateZ
		if Mission.MineField2[1].x < Mission.MineField2[2].x then
			coordinateX = luaRnd(Mission.MineField2[1].x, Mission.MineField2[2].x)
		else
			coordinateX = luaRnd(Mission.MineField2[2].x, Mission.MineField2[1].x)
		end
		if Mission.MineField2[1].z < Mission.MineField2[2].z then
			coordinateZ = luaRnd(Mission.MineField2[1].z, Mission.MineField2[2].z)
		else
			coordinateZ = luaRnd(Mission.MineField2[2].z, Mission.MineField2[1].z)
		end
		local mine = GenerateObject(Mission.Mine.Name, {["x"] = coordinateX, ["y"] = 0.5, ["z"] = coordinateZ})
		table.insert(Mission.Mines2, mine)
	end
-- RELEASE_LOGOFF  	luaLog("  there are "..table.getn(Mission.Mines2).." mines in mines2 table")
end

function luaQAC4HQHack()
	if not Mission.Completed and not Mission.MissionEnd then
		if Mission.HQs[1].Party == PARTY_ALLIED and not Mission.HQ1AIControlSet then
			Mission.HQ1AIControlSet = true
			SetRoleAvailable(Mission.HQs[1], EROLF_ALL, PLAYER_AI)
		end
		if Mission.HQs[2].Party == PARTY_ALLIED and not Mission.HQ2AIControlSet then
			Mission.HQ2AIControlSet = true
			SetRoleAvailable(Mission.HQs[2], EROLF_ALL, PLAYER_AI)
		end
		if Mission.HQs[3].Party == PARTY_ALLIED and not Mission.HQ3AIControlSet then
			Mission.HQ3AIControlSet = true
			SetRoleAvailable(Mission.HQs[3], EROLF_ALL, PLAYER_AI)
		end
		if Mission.HQs[4].Party == PARTY_ALLIED and not Mission.HQ4AIControlSet then
			Mission.HQ4AIControlSet = true
			SetRoleAvailable(Mission.HQs[4], EROLF_ALL, PLAYER_AI)
		end
		if Mission.HQs[5].Party == PARTY_ALLIED and not Mission.HQ5AIControlSet then
			Mission.HQ5AIControlSet = true
			SetRoleAvailable(Mission.HQs[5], EROLF_ALL, PLAYER_AI)
		end
		if Mission.HQs[6].Party == PARTY_ALLIED and not Mission.HQ6AIControlSet then
			Mission.HQ6AIControlSet = true
			SetRoleAvailable(Mission.HQs[6], EROLF_ALL, PLAYER_AI)
		end
		if Mission.HQs[7].Party == PARTY_ALLIED and not Mission.HQ7AIControlSet then
			Mission.HQ7AIControlSet = true
			SetRoleAvailable(Mission.HQs[7], EROLF_ALL, PLAYER_AI)
		end
		luaDelay(luaQAC4HQHack, 1)
	end
end

function luaQAC4CheckCheckPoints()
-- RELEASE_LOGOFF  	luaLog(" Checking checkpoints...")
	local usshipsinscene = luaGetShipsAroundCoordinate(Mission.CenterPoint, 100000, PARTY_ALLIED, "own")
	if usshipsinscene ~= nil then
		for index, unit in pairs (usshipsinscene) do
			if unit.Class.ID == 242 then
				local unitroles = GetRoleAvailable(unit)
				local ownerplayer = unitroles[1]
-- RELEASE_LOGOFF  				luaLog(" ship found for ownerplayer "..ownerplayer)
				local ownerfortable = ownerplayer + 1
				Mission.USPTBoats[ownerfortable] = unit
			end
		end
	end

	for index, unit in pairs (Mission.USPTBoats) do
		if unit ~= "fake" then
			if not unit.Dead then
				if Mission.PlayersActualCheckPoint[index] == 6 and luaGetDistance(unit, Mission.USCheckPoints[6]) < 150 then
					luaQAC4MissionEnd(index)
				elseif luaGetDistance(unit, Mission.USCheckPoints[Mission.PlayersActualCheckPoint[index]]) < 150 then
					luaQAC4GiveNewCheckPoint(index, Mission.PlayersActualCheckPoint[index])
				end
			end
		end
	end
end

function luaQAC4GiveNewCheckPoint(index, cp)
-- RELEASE_LOGOFF  	luaLog("  giving new cp to player "..index.." after cp "..cp)
	if index == 1 then
		local currentIndex = Mission.Player1SecObjectives[Mission.PlayersActualCheckPoint[index]]
		luaObj_Completed("secondary", currentIndex)
		Mission.PlayersActualCheckPoint[index] = Mission.PlayersActualCheckPoint[index] + 1
		if Mission.PlayersActualCheckPoint[index] <= 5 then
			local nextIndex = Mission.Player1SecObjectives[Mission.PlayersActualCheckPoint[index]]
			luaObj_Add("secondary", nextIndex, Mission.USCheckPoints[Mission.PlayersActualCheckPoint[index]])
		else
			luaObj_AddUnit("primary", 1, Mission.USCheckPoints[6])
		end
	elseif index == 2 then
		local currentIndex = Mission.Player2SecObjectives[Mission.PlayersActualCheckPoint[index]]
		luaObj_Completed("secondary", currentIndex)
		Mission.PlayersActualCheckPoint[index] = Mission.PlayersActualCheckPoint[index] + 1
		if Mission.PlayersActualCheckPoint[index] <= 5 then
			local nextIndex = Mission.Player2SecObjectives[Mission.PlayersActualCheckPoint[index]]
			luaObj_Add("secondary", nextIndex, Mission.USCheckPoints[Mission.PlayersActualCheckPoint[index]])
		else
			luaObj_AddUnit("primary", 2, Mission.USCheckPoints[6])
		end
	elseif index == 3 then
		local currentIndex = Mission.Player3SecObjectives[Mission.PlayersActualCheckPoint[index]]
		luaObj_Completed("secondary", currentIndex)
		Mission.PlayersActualCheckPoint[index] = Mission.PlayersActualCheckPoint[index] + 1
		if Mission.PlayersActualCheckPoint[index] <= 5 then
			local nextIndex = Mission.Player3SecObjectives[Mission.PlayersActualCheckPoint[index]]
			luaObj_Add("secondary", nextIndex, Mission.USCheckPoints[Mission.PlayersActualCheckPoint[index]])
		else
			luaObj_AddUnit("primary", 3, Mission.USCheckPoints[6])
		end
	elseif index == 4 then
		local currentIndex = Mission.Player4SecObjectives[Mission.PlayersActualCheckPoint[index]]
		luaObj_Completed("secondary", currentIndex)
		Mission.PlayersActualCheckPoint[index] = Mission.PlayersActualCheckPoint[index] + 1
		if Mission.PlayersActualCheckPoint[index] <= 5 then
			local nextIndex = Mission.Player4SecObjectives[Mission.PlayersActualCheckPoint[index]]
			luaObj_Add("secondary", nextIndex, Mission.USCheckPoints[Mission.PlayersActualCheckPoint[index]])
		else
			luaObj_AddUnit("primary", 4, Mission.USCheckPoints[6])
		end
	elseif index == 5 then
		local currentIndex = Mission.Player5SecObjectives[Mission.PlayersActualCheckPoint[index]]
		luaObj_Completed("secondary", currentIndex)
		Mission.PlayersActualCheckPoint[index] = Mission.PlayersActualCheckPoint[index] + 1
		if Mission.PlayersActualCheckPoint[index] <= 5 then
			local nextIndex = Mission.Player5SecObjectives[Mission.PlayersActualCheckPoint[index]]
			luaObj_Add("secondary", nextIndex, Mission.USCheckPoints[Mission.PlayersActualCheckPoint[index]])
		else
			luaObj_AddUnit("primary", 5, Mission.USCheckPoints[6])
		end
	elseif index == 6 then
		local currentIndex = Mission.Player6SecObjectives[Mission.PlayersActualCheckPoint[index]]
		luaObj_Completed("secondary", currentIndex)
		Mission.PlayersActualCheckPoint[index] = Mission.PlayersActualCheckPoint[index] + 1
		if Mission.PlayersActualCheckPoint[index] <= 5 then
			local nextIndex = Mission.Player6SecObjectives[Mission.PlayersActualCheckPoint[index]]
			luaObj_Add("secondary", nextIndex, Mission.USCheckPoints[Mission.PlayersActualCheckPoint[index]])
		else
			luaObj_AddUnit("primary", 6, Mission.USCheckPoints[6])
		end
	elseif index == 7 then
		local currentIndex = Mission.Player7SecObjectives[Mission.PlayersActualCheckPoint[index]]
		luaObj_Completed("secondary", currentIndex)
		Mission.PlayersActualCheckPoint[index] = Mission.PlayersActualCheckPoint[index] + 1
		if Mission.PlayersActualCheckPoint[index] <= 5 then
			local nextIndex = Mission.Player7SecObjectives[Mission.PlayersActualCheckPoint[index]]
			luaObj_Add("secondary", nextIndex, Mission.USCheckPoints[Mission.PlayersActualCheckPoint[index]])
		else
			luaObj_AddUnit("primary", 7, Mission.USCheckPoints[6])
		end
	elseif index == 8 then
		local currentIndex = Mission.Player8SecObjectives[Mission.PlayersActualCheckPoint[index]]
		luaObj_Completed("secondary", currentIndex)
		Mission.PlayersActualCheckPoint[index] = Mission.PlayersActualCheckPoint[index] + 1
		if Mission.PlayersActualCheckPoint[index] <= 5 then
			local nextIndex = Mission.Player8SecObjectives[Mission.PlayersActualCheckPoint[index]]
			luaObj_Add("secondary", nextIndex, Mission.USCheckPoints[Mission.PlayersActualCheckPoint[index]])
		else
			luaObj_AddUnit("primary", 8, Mission.USCheckPoints[6])
		end
	end

	if cp < 6 then
		local playerindex = index - 1
		local nextcp = cp + 1
-- RELEASE_LOGOFF  		luaLog("  deactivating sp "..cp.." for player "..playerindex.." | activating sp "..nextcp.." instead")
		DeactivateSpawnpoint(Mission.USSpawnPoints[cp], playerindex)
		ActivateSpawnpoint(Mission.USSpawnPoints[nextcp], playerindex)
	end
end

function luaQAC4CheckGameTime()
-- RELEASE_LOGOFF  	luaLog(" Checking gametime...")
	if CountdownTimeLeft() <= 900 and not Mission.FirstWarningDone then
-- RELEASE_LOGOFF  		luaLog(" 15 minutes warining")
		Mission.FirstWarningDone = true
		MissionNarrativeParty(1, "15 minutes left!")
	elseif CountdownTimeLeft() <= 600 and not Mission.SecondWarningDone then
-- RELEASE_LOGOFF  		luaLog(" 10 minutes warining")
		Mission.SecondWarningDone = true
		MissionNarrativeParty(1, "10 minutes left!")
	elseif CountdownTimeLeft() <= 300 and not Mission.ThirdWarningDone then
-- RELEASE_LOGOFF  		luaLog(" 5 minutes warining")
		Mission.ThirdWarningDone = true
		MissionNarrativeParty(1, "5 minutes left!")
	elseif CountdownTimeLeft() <= 60 and not Mission.FourthWarningDone then
-- RELEASE_LOGOFF  		luaLog(" 1 minutes warining")
		Mission.FourthWarningDone = true
		MissionNarrativeParty(1, "1 minute left!")
	end
end

function luaQAC4ManageFleets()
-- RELEASE_LOGOFF  	luaLog(" Managing fleets...")
	if not Mission.USFleet1Spawned then
-- RELEASE_LOGOFF  		luaLog("  spawning US Fleet 1")
		local ship1 = luaRnd(1, 2)
		local ship2 = luaRnd(1, 2)
		SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
				{["Type"] = Mission.USBigShipIDsFleet1[ship1], ["Name"] = Mission.USBigShipNamesFleet1[ship1], ["Crew"] = 1, ["Race"] = USA, ["OwnerPlayer"] = PLAYER_AI,},
			},
			["area"] = {["refPos"] = Mission.USFleetPoints[1], ["angleRange"] = { DEG(170), DEG(180) },},
			["callback"] = "luaQAC4USFleet1Spawned",
			["excludeRadiusOverride"] = {["ownHorizontal"] = 125,	["enemyHorizontal"] = 125, ["ownVertical"] = 125,	["enemyVertical"] = 125, ["formationHorizontal"] = 125,},
		})
		Mission.USFleet1Spawned = true
	end

	if not Mission.USFleet2Spawned then
-- RELEASE_LOGOFF  		luaLog("  spawning US Fleet 2")
		local ship1 = luaRnd(1, 2)
		local ship2 = luaRnd(1, 2)
		SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
				{["Type"] = Mission.USBigShipIDsFleet2[ship1], ["Name"] = Mission.USBigShipNamesFleet2[ship1], ["Crew"] = 1, ["Race"] = USA, ["OwnerPlayer"] = PLAYER_AI,},
				{["Type"] = Mission.USMediumShipIDs[ship2],	["Name"] = Mission.USMediumShipNames[ship2], ["Crew"] = 1, ["Race"] = USA, ["OwnerPlayer"] = PLAYER_AI,},
			},
			["area"] = {["refPos"] = Mission.USFleetPoints[2], ["angleRange"] = { DEG(230), DEG(250) },},
			["callback"] = "luaQAC4USFleet2Spawned",
			["excludeRadiusOverride"] = {["ownHorizontal"] = 125,	["enemyHorizontal"] = 125, ["ownVertical"] = 125, ["enemyVertical"] = 125, ["formationHorizontal"] = 125,},
		})
		Mission.USFleet2Spawned = true
	elseif table.getn(Mission.JapFleet2) == 0 and table.getn(Mission.JapFleet3) == 0 and not Mission.BigFleetCalled then
		Mission.USFleet2 = luaRemoveDeadsFromTable(Mission.USFleet2)
		if table.getn(Mission.USFleet2) ~= 0 then
			if Mission.HQs[4].Party == PARTY_JAPANESE and not Mission.US2HQ4 then
				Mission.US2HQ4 = true
				NavigatorAttackMove(Mission.USFleet2[1], Mission.HQs[4])
			elseif Mission.HQs[4].Party ~= PARTY_JAPANESE and Mission.HQs[3].Party == PARTY_JAPANESE and not Mission.US2HQ3 then
				Mission.US2HQ3 = true
				NavigatorAttackMove(Mission.USFleet2[1], Mission.HQs[3])
			elseif Mission.HQs[4].Party ~= PARTY_JAPANESE and Mission.HQs[3].Party ~= PARTY_JAPANESE and Mission.HQs[2].Party == PARTY_JAPANESE and not Mission.US2HQ2 then
				Mission.US2HQ2 = true
				NavigatorAttackMove(Mission.USFleet2[1], Mission.HQs[2])
			end
		end
	end

	if not Mission.JapFleet1Spawned then
-- RELEASE_LOGOFF  		luaLog("  spawning Jap Fleet 1")
		local ship1 = luaRnd(1, 3)
		local ship2 = luaRnd(1, 3)
		local ship3 = luaRnd(1, 3)
		if Mission.MediumFleetsShipNumber == 2 then
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{["Type"] = Mission.JapMediumShipIDs[ship1], ["Name"] = Mission.JapMediumShipNames[ship1], ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,},
					{["Type"] = Mission.JapMediumShipIDs[ship2], ["Name"] = Mission.JapMediumShipNames[ship2], ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,},
				},
				["area"] = {["refPos"] = Mission.JapFleetPoints[1],	["angleRange"] = { DEG(170), DEG(190) },},
				["callback"] = "luaQAC4JapFleet1Spawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 125,	["enemyHorizontal"] = 125, ["ownVertical"] = 125,	["enemyVertical"] = 125, ["formationHorizontal"] = 125,},
			})
		elseif Mission.MediumFleetsShipNumber == 3 then
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{["Type"] = Mission.JapMediumShipIDs[ship1], ["Name"] = Mission.JapMediumShipNames[ship1], ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,},
					{["Type"] = Mission.JapMediumShipIDs[ship2], ["Name"] = Mission.JapMediumShipNames[ship2], ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,},
					{["Type"] = Mission.JapMediumShipIDs[ship3], ["Name"] = Mission.JapMediumShipNames[ship3], ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,},
				},
				["area"] = {["refPos"] = Mission.JapFleetPoints[1],	["angleRange"] = { DEG(170), DEG(190) },},
				["callback"] = "luaQAC4JapFleet1Spawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 125,	["enemyHorizontal"] = 125, ["ownVertical"] = 125,	["enemyVertical"] = 125, ["formationHorizontal"] = 125,},
			})
		end
		Mission.JapFleet1Spawned = true
	elseif not Mission.TonesAgainstHQ1 then
		Mission.USFleet1 = luaRemoveDeadsFromTable(Mission.USFleet1)
		Mission.JapFleet1 = luaRemoveDeadsFromTable(Mission.JapFleet1)
		if table.getn(Mission.USFleet1) == 0 and table.getn(Mission.JapFleet1) ~= 0 and Mission.Yorktown.Dead and Mission.HQs[1].Party == PARTY_ALLIED then
			Mission.TonesAgainstHQ1 = true
			for index, unit in pairs (Mission.JapFleet1) do
				NavigatorAttackMove(unit, Mission.HQs[1], {})
			end
		end
	end

	if GameTime() > 160 and not Mission.JapFleet4Spawned then
-- RELEASE_LOGOFF  		luaLog("  spawning Jap Fleet 4")
		local ship1 = luaRnd(1, 3)
		local ship2 = luaRnd(1, 3)
		local ship3 = luaRnd(1, 3)
		if Mission.MediumFleetsShipNumber == 2 then
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{["Type"] = Mission.JapMediumShipIDs[ship1], ["Name"] = Mission.JapMediumShipNames[ship1], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI,},
					{["Type"] = Mission.JapMediumShipIDs[ship2], ["Name"] = Mission.JapMediumShipNames[ship2], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI,},
				},
				["area"] = {["refPos"] = Mission.JapFleetPoints[1], ["angleRange"] = { DEG(170), DEG(190) },},
				["callback"] = "luaQAC4JapFleet4Spawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 125,	["enemyHorizontal"] = 125, ["ownVertical"] = 125, ["enemyVertical"] = 125, ["formationHorizontal"] = 125,},
			})
		elseif Mission.MediumFleetsShipNumber == 3 then
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{["Type"] = Mission.JapMediumShipIDs[ship1], ["Name"] = Mission.JapMediumShipNames[ship1], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI,},
					{["Type"] = Mission.JapMediumShipIDs[ship2], ["Name"] = Mission.JapMediumShipNames[ship2], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI,},
					{["Type"] = Mission.JapMediumShipIDs[ship3], ["Name"] = Mission.JapMediumShipNames[ship3], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI,},
				},
				["area"] = {["refPos"] = Mission.JapFleetPoints[1], ["angleRange"] = { DEG(170), DEG(190) },},
				["callback"] = "luaQAC4JapFleet4Spawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 125,	["enemyHorizontal"] = 125, ["ownVertical"] = 125, ["enemyVertical"] = 125, ["formationHorizontal"] = 125,},
			})
		end
		Mission.JapFleet4Spawned = true
	elseif not Mission.Tones2AgainstHQ1 then
		Mission.USFleet1 = luaRemoveDeadsFromTable(Mission.USFleet1)
		Mission.JapFleet4 = luaRemoveDeadsFromTable(Mission.JapFleet4)
		if table.getn(Mission.USFleet1) == 0 and table.getn(Mission.JapFleet4) ~= 0 and Mission.Yorktown.Dead and Mission.HQs[1].Party == PARTY_ALLIED then
			Mission.Tones2AgainstHQ1 = true
			for index, unit in pairs (Mission.JapFleet4) do
				NavigatorAttackMove(unit, Mission.HQs[1], {})
			end
		end
	end

	if not Mission.JapFleet2Spawned then
-- RELEASE_LOGOFF  		luaLog("  spawning Jap Fleet 2")
		local ship1 = luaRnd(1, 2)
		local ship2 = luaRnd(1, 2)
		local ship3 = luaRnd(1, 3)
		if Mission.MediumFleetsShipNumber == 2 then
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{["Type"] = Mission.JapBigShipIDs[ship1], ["Name"] = Mission.JapBigShipNames[ship1], ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,},
					{["Type"] = Mission.JapMediumShipIDs[ship3], ["Name"] = Mission.JapMediumShipNames[ship3], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI,},
				},
				["area"] = {["refPos"] = Mission.JapFleetPoints[2], ["angleRange"] = { DEG(170), DEG(190) },},
				["callback"] = "luaQAC4JapFleet2Spawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 125,	["enemyHorizontal"] = 125, ["ownVertical"] = 125, ["enemyVertical"] = 125, ["formationHorizontal"] = 125,},
			})
		elseif Mission.MediumFleetsShipNumber == 3 then
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{["Type"] = Mission.JapBigShipIDs[ship1], ["Name"] = Mission.JapBigShipNames[ship1], ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,},
					{["Type"] = Mission.JapBigShipIDs[ship2], ["Name"] = Mission.JapBigShipNames[ship2], ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,},
					{["Type"] = Mission.JapMediumShipIDs[ship3], ["Name"] = Mission.JapMediumShipNames[ship3], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI,},
				},
				["area"] = {["refPos"] = Mission.JapFleetPoints[2], ["angleRange"] = { DEG(170), DEG(190) },},
				["callback"] = "luaQAC4JapFleet2Spawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 125,	["enemyHorizontal"] = 125, ["ownVertical"] = 125, ["enemyVertical"] = 125, ["formationHorizontal"] = 125,},
			})
		end
		Mission.JapFleet2Spawned = true
	end

	if not Mission.JapFleet3Spawned then
-- RELEASE_LOGOFF  		luaLog("  spawning Jap Fleet 3")
		local ship1 = luaRnd(1, 2)
		local ship2 = luaRnd(1, 2)
		local ship3 = luaRnd(1, 2)
		if Mission.MediumFleetsShipNumber == 2 then
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{["Type"] = Mission.JapBigShipIDs[ship1], ["Name"] = Mission.JapBigShipNames[ship1], ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,},
					{["Type"] = Mission.JapMediumShipIDs[ship2], ["Name"] = Mission.JapMediumShipNames[ship2], ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,},
				},
				["area"] = {["refPos"] = Mission.JapFleetPoints[3], ["angleRange"] = { DEG(90), DEG(110) },},
				["callback"] = "luaQAC4JapFleet3Spawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 125,	["enemyHorizontal"] = 125, ["ownVertical"] = 125, ["enemyVertical"] = 125, ["formationHorizontal"] = 125,},
			})
		elseif Mission.MediumFleetsShipNumber == 3 then
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{["Type"] = Mission.JapBigShipIDs[ship1], ["Name"] = Mission.JapBigShipNames[ship1], ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,},
					{["Type"] = Mission.JapMediumShipIDs[ship2], ["Name"] = Mission.JapMediumShipNames[ship2], ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,},
					{["Type"] = Mission.JapMediumShipIDs[ship3], ["Name"] = Mission.JapMediumShipNames[ship3], ["Crew"] = 1, ["Race"] = JAPANESE, ["OwnerPlayer"] = PLAYER_AI,},
				},
				["area"] = {["refPos"] = Mission.JapFleetPoints[3], ["angleRange"] = { DEG(90), DEG(110) },},
				["callback"] = "luaQAC4JapFleet3Spawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 125,	["enemyHorizontal"] = 125, ["ownVertical"] = 125, ["enemyVertical"] = 125, ["formationHorizontal"] = 125,},
			})
		end
		Mission.JapFleet3Spawned = true
	end

	if not Mission.PermitFleetCheckInit then
		Mission.PermitFleetCheckInit = true
		luaDelay(luaQAC4PermitFleetCheck, 7)
	end
	
	Mission.JapFleet1 = luaRemoveDeadsFromTable(Mission.JapFleet1)
	Mission.JapFleet2 = luaRemoveDeadsFromTable(Mission.JapFleet2)
	Mission.JapFleet3 = luaRemoveDeadsFromTable(Mission.JapFleet3)
	Mission.JapFleet4 = luaRemoveDeadsFromTable(Mission.JapFleet4)
	if table.getn(Mission.JapFleet3) == 0 and table.getn(Mission.JapFleet2) ~= 0 then
		for index, unit in pairs (Mission.JapFleet2) do
			AISetHintWeight(unit, 400)
		end
	end
	if Mission.HQs[2].Party ~= PARTY_JAPANESE and Mission.HQs[3].Party ~= PARTY_JAPANESE and Mission.HQs[4].Party ~= PARTY_JAPANESE and not Mission.BigFleetCalled and Mission.PermitFleetCheck then
		Mission.BigFleetCalled = true
		luaQAC4ManageBigFleet()
	elseif Mission.JapFleet1Spawned and Mission.JapFleet2Spawned and Mission.JapFleet3Spawned then
		if table.getn(Mission.JapFleet1) == 0 and table.getn(Mission.JapFleet2) == 0 and table.getn(Mission.JapFleet3) == 0 and table.getn(Mission.JapFleet4) == 0 and not Mission.BigFleetCalled and Mission.PermitFleetCheck then
			Mission.BigFleetCalled = true
			luaQAC4ManageBigFleet()
		end
	end
end

function luaQAC4ManageBigFleet()
-- RELEASE_LOGOFF  	luaLog(" Managing big fleet...")
	if not Mission.BigFleetCalled then
		Mission.BigFleetCalled = true
	end
	if not Mission.BigFleetSpawned then
-- RELEASE_LOGOFF  		luaLog("  spawning Big Fleet")
		local ship1 = luaRnd(1, 2)
		local ship2 = luaRnd(1, 2)
		local ship3 = luaRnd(1, 2)
		local ship4 = luaRnd(1, 2)
		local ship5 = luaRnd(1, 2)
		local ship6 = luaRnd(1, 2)
		if Mission.BigFleetShipsNumber == 3 then
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{["Type"] = Mission.JapBigShipIDs[ship1],	["Name"] = Mission.JapBigShipNames[ship1], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
					{["Type"] = Mission.JapBigShipIDs[ship2],	["Name"] = Mission.JapBigShipNames[ship2], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
					{["Type"] = Mission.JapMediumShipIDs[ship4], ["Name"] = Mission.JapMediumShipNames[ship4], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
				},
				["area"] = {["refPos"] = Mission.BigFleetPoint,	["angleRange"] = { DEG(-20), DEG(20) },},
				["callback"] = "luaQAC4BigFleetSpawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 200,	["enemyHorizontal"] = 200, ["ownVertical"] = 200,	["enemyVertical"] = 200, ["formationHorizontal"] = 200},
			})
		elseif Mission.BigFleetShipsNumber == 4 then
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{["Type"] = Mission.JapBigShipIDs[ship1],	["Name"] = Mission.JapBigShipNames[ship1], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
					{["Type"] = Mission.JapBigShipIDs[ship2],	["Name"] = Mission.JapBigShipNames[ship2], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
					{["Type"] = Mission.JapMediumShipIDs[ship4], ["Name"] = Mission.JapMediumShipNames[ship4], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
					{["Type"] = Mission.JapMediumShipIDs[ship5], ["Name"] = Mission.JapMediumShipNames[ship5], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
				},
				["area"] = {["refPos"] = Mission.BigFleetPoint,	["angleRange"] = { DEG(-20), DEG(20) },},
				["callback"] = "luaQAC4BigFleetSpawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 200,	["enemyHorizontal"] = 200, ["ownVertical"] = 200,	["enemyVertical"] = 200, ["formationHorizontal"] = 200},
			})
		elseif Mission.BigFleetShipsNumber == 5 then
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{["Type"] = Mission.JapBigShipIDs[ship1],	["Name"] = Mission.JapBigShipNames[ship1], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
					{["Type"] = Mission.JapBigShipIDs[ship2],	["Name"] = Mission.JapBigShipNames[ship2], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
					{["Type"] = Mission.JapBigShipIDs[ship3],	["Name"] = Mission.JapBigShipNames[ship3], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
					{["Type"] = Mission.JapMediumShipIDs[ship4], ["Name"] = Mission.JapMediumShipNames[ship4], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
					{["Type"] = Mission.JapMediumShipIDs[ship5], ["Name"] = Mission.JapMediumShipNames[ship5], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
				},
				["area"] = {["refPos"] = Mission.BigFleetPoint,	["angleRange"] = { DEG(-20), DEG(20) },},
				["callback"] = "luaQAC4BigFleetSpawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 200,	["enemyHorizontal"] = 200, ["ownVertical"] = 200,	["enemyVertical"] = 200, ["formationHorizontal"] = 200},
			})
		elseif Mission.BigFleetShipsNumber == 6 then
			SpawnNew({
				["party"] = PARTY_JAPANESE,
				["groupMembers"] = {
					{["Type"] = Mission.JapBigShipIDs[ship1],	["Name"] = Mission.JapBigShipNames[ship1], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
					{["Type"] = Mission.JapBigShipIDs[ship2],	["Name"] = Mission.JapBigShipNames[ship2], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
					{["Type"] = Mission.JapBigShipIDs[ship3],	["Name"] = Mission.JapBigShipNames[ship3], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
					{["Type"] = Mission.JapMediumShipIDs[ship4], ["Name"] = Mission.JapMediumShipNames[ship4], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
					{["Type"] = Mission.JapMediumShipIDs[ship5], ["Name"] = Mission.JapMediumShipNames[ship5], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
					{["Type"] = Mission.JapMediumShipIDs[ship6], ["Name"] = Mission.JapMediumShipNames[ship6], ["Crew"] = 1, ["Race"] = JAPANESE,	["OwnerPlayer"] = PLAYER_AI},
				},
				["area"] = {["refPos"] = Mission.BigFleetPoint,	["angleRange"] = { DEG(-20), DEG(20) },},
				["callback"] = "luaQAC4BigFleetSpawned",
				["excludeRadiusOverride"] = {["ownHorizontal"] = 200,	["enemyHorizontal"] = 200, ["ownVertical"] = 200,	["enemyVertical"] = 200, ["formationHorizontal"] = 200},
			})
		end
		Mission.BigFleetSpawned = true
		MissionNarrativeParty(PARTY_ALLIED, "mp04.nar_comp_bigfleet")
		luaDelay(luaQAC4PermitBigFleetCheck, 7)
	end

	Mission.BigFleet = luaRemoveDeadsFromTable(Mission.BigFleet)
	if table.getn(Mission.BigFleet) ~= 0 then
		for index, unit in pairs (Mission.BigFleet) do
			if Mission.Randomize == 1 then
				if Mission.Lexington.Dead and Mission.HQs[5].Party == PARTY_ALLIED then
					NavigatorAttackMove(unit, Mission.HQs[5], {})
				end
			else
				if Mission.Yorktown.Dead and Mission.HQs[1].Party == PARTY_ALLIED then
					NavigatorAttackMove(unit, Mission.HQs[1], {})
				end
			end
		end
	elseif table.getn(Mission.BigFleet) == 0 and Mission.PermitBigFleetCheck and not Mission.MissionEndCalled then
		Mission.MissionEndCalled = true
		Mission.PermitBigFleetCheck = false
		local PlayersInGame = GetPlayerDetails()
		local highestindex, highestplayerscore = luaQAC4CheckHighestScore()
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
		CountdownCancel()
		ForceMultiScoreSend()
		luaDelay(luaQAC4MissionEnd, 0.1)
	end

	if not Mission.Completed and not Mission.MissionEndCalled then
		luaDelay(luaQAC4ManageBigFleet, 5)
	end
end

function luaQAC4BigFleetSpawned(unit1, unit2, unit3, unit4, unit5, unit6, unit7, unit8, unit9)
	table.insert(Mission.BigFleet, unit1)
	table.insert(Mission.BigFleet, unit2)
	table.insert(Mission.BigFleet, unit3)
	if unit4 ~= nil then
		table.insert(Mission.BigFleet, unit4)
	end
	if unit5 ~= nil then
		table.insert(Mission.BigFleet, unit5)
	end
	if unit6 ~= nil then
		table.insert(Mission.BigFleet, unit6)
	end
--[[
	table.insert(Mission.BigFleet, unit7)
	table.insert(Mission.BigFleet, unit8)
	table.insert(Mission.BigFleet, unit9)
]]
	Mission.Randomize = luaRnd(1, 2)
	for index, unit in pairs (Mission.BigFleet) do
		SetSkillLevel(unit, SKILL_SPNORMAL)
		AISetHintWeight(unit, 500)
		NavigatorSetTorpedoEvasion(unit, false)
		--if index == 1 then
			if Mission.Randomize == 1 then
				EntityTurnToEntity(unit, Mission.HQs[5])
				if not Mission.Lexington.Dead then
					NavigatorAttackMove(unit, Mission.Lexington, {})
				elseif Mission.HQs[5].Party == PARTY_ALLIED then
					NavigatorAttackMove(unit, Mission.HQs[5], {})
				end
			else
				EntityTurnToEntity(unit, Mission.HQs[1])
				if not Mission.Yorktown.Dead then
					NavigatorAttackMove(unit, Mission.Yorktown, {})
				elseif Mission.HQs[1].Party == PARTY_ALLIED then
					NavigatorAttackMove(unit, Mission.HQs[1], {})
				end
			end
--[[
		else
			if Mission.Randomize == 1 then
				EntityTurnToEntity(unit, Mission.HQs[5])
			else
				EntityTurnToEntity(unit, Mission.HQs[1])
			end
			--JoinFormation(unit, Mission.BigFleet[1])
		end
]]
		TorpedoEnable(unit, true)
	end
end

function luaQAC4PermitBigFleetCheck()
	Mission.PermitBigFleetCheck = true
	Mission.USFleet1 = luaRemoveDeadsFromTable(Mission.USFleet1)
	Mission.USFleet2 = luaRemoveDeadsFromTable(Mission.USFleet2)
	Mission.BigFleet = luaRemoveDeadsFromTable(Mission.BigFleet)
	if table.getn(Mission.USFleet1) ~= 0 then
		for index, unit in pairs (Mission.USFleet1) do
			NavigatorAttackMove(unit, Mission.BigFleet[1], {})
		end
	end
	if table.getn(Mission.USFleet2) ~= 0 then
		for index, unit in pairs (Mission.USFleet2) do
			NavigatorAttackMove(unit, Mission.BigFleet[1], {})
		end
	end
end

function luaQAC4PermitFleetCheck()
	Mission.PermitFleetCheck = true
end

function luaQAC4CheckHQDistances()
	if not Mission.CP2SiegeStarted then
		local triggertable = luaGetShipsAroundCoordinate(GetPosition(Mission.HQs[3]), 2250, PARTY_ALLIED, "own")
		if triggertable ~= nil then
			Mission.CP2SiegeStarted = true
-- RELEASE_LOGOFF  			luaLog("  starting CP2Siege")
			luaCPxSiegeStart(2)
		end
	end

	if not Mission.CP3SiegeStarted then
		local triggertable = luaGetShipsAroundCoordinate(GetPosition(Mission.HQs[4]), 2250, PARTY_ALLIED, "own")
		if triggertable ~= nil then
			Mission.CP3SiegeStarted = true
-- RELEASE_LOGOFF  			luaLog("  starting CP3Siege")
			luaCPxSiegeStart(3)
		end
	end

	if not Mission.CP4SiegeStarted then
		local triggertable = luaGetShipsAroundCoordinate(GetPosition(Mission.HQs[5]), 2250, PARTY_ALLIED, "own")
		if triggertable ~= nil then
			Mission.CP4SiegeStarted = true
-- RELEASE_LOGOFF  			luaLog("  starting CP4Siege")
			luaCPxSiegeStart(4)
		end
	end

	if not Mission.CP5SiegeStarted then
		local triggertable = luaGetShipsAroundCoordinate(GetPosition(Mission.HQs[6]), 2250, PARTY_ALLIED, "own")
		if triggertable ~= nil then
			Mission.CP5SiegeStarted = true
-- RELEASE_LOGOFF  			luaLog("  starting CP5Siege")
			luaCPxSiegeStart(5)
		end
	end

	if not Mission.CP6SiegeStarted then
		local triggertable = luaGetShipsAroundCoordinate(GetPosition(Mission.HQs[7]), 2250, PARTY_ALLIED, "own")
		if triggertable ~= nil then
			Mission.CP6SiegeStarted = true
-- RELEASE_LOGOFF  			luaLog("  starting CP6Siege")
			luaCPxSiegeStart(3)
		end
	end
end

function luaCPxSiegeStart(index)
	local hqindex = index + 1
	if index == 2 then
		for i = 1, 3 do
			local siegeunit = GenerateObject(Mission.CPxSiegeTMPL[i].Name)
			EntityTurnToEntity(siegeunit, Mission.HQs[hqindex])
			StartLanding2(siegeunit)
			SetShipSpeed(siegeunit, GetShipMaxSpeed(siegeunit)*0.75)
			AAEnable(siegeunit, false)
			table.insert(Mission.CP2Siege, siegeunit)
		end
	elseif index == 3 then
		for i = 1, 3 do
			local siegeunit = GenerateObject(Mission.CPxSiegeTMPL[i].Name, Mission.CP3Positions[i])
			--PutTo(siegeunit, Mission.CP3Positions[i])
			EntityTurnToEntity(siegeunit, Mission.HQs[hqindex])
			StartLanding2(siegeunit)
			SetShipSpeed(siegeunit, GetShipMaxSpeed(siegeunit)*0.75)
			AAEnable(siegeunit, false)
			table.insert(Mission.CP3Siege, siegeunit)
		end
	elseif index == 4 then
		for i = 1, 3 do
			local siegeunit = GenerateObject(Mission.CPxSiegeTMPL[i].Name, Mission.CP4Positions[i])
			--PutTo(siegeunit, Mission.CP4Positions[i])
			EntityTurnToEntity(siegeunit, Mission.HQs[hqindex])
			StartLanding2(siegeunit)
			SetShipSpeed(siegeunit, GetShipMaxSpeed(siegeunit)*0.75)
			AAEnable(siegeunit, false)
			table.insert(Mission.CP4Siege, siegeunit)
		end
	elseif index == 5 then
		for i = 1, 3 do
			local siegeunit = GenerateObject(Mission.CPxSiegeTMPL[i].Name, Mission.CP5Positions[i])
			--PutTo(siegeunit, Mission.CP5Positions[i])
			EntityTurnToEntity(siegeunit, Mission.HQs[hqindex])
			StartLanding2(siegeunit)
			SetShipSpeed(siegeunit, GetShipMaxSpeed(siegeunit)*0.75)
			AAEnable(siegeunit, false)
			table.insert(Mission.CP5Siege, siegeunit)
		end
	elseif index == 6 then
		for i = 1, 3 do
			local siegeunit = GenerateObject(Mission.CPxSiegeTMPL[i].Name, Mission.CP6Positions[i])
			--PutTo(siegeunit, Mission.CP6Positions[i])
			EntityTurnToEntity(siegeunit, Mission.HQs[hqindex])
			StartLanding2(siegeunit)
			SetShipSpeed(siegeunit, GetShipMaxSpeed(siegeunit)*0.75)
			AAEnable(siegeunit, false)
			table.insert(Mission.CP6Siege, siegeunit)
		end
	end
end

function luaQAC4CheckAttackerPlanes()
-- RELEASE_LOGOFF  	luaLog(" Checking Attacker planes...")
--[[
	Mission.CurrentSpawnPosition = 0
	local posset = false
	for index, unit in pairs (Mission.HQs) do
		if unit.Party == PARTY_JAPANESE and not posset then
			posset = true
			Mission.CurrentSpawnPosition = index
			Mission.CurrentSpawnCoordinates = GetPosition(unit)
		end
	end

	if Mission.CurrentSpawnPosition == 0 and not Mission.AttackerPlaneSpawnDenied then
		Mission.AttackerPlaneSpawnDenied = true
	else
		Mission.CurrentTemplate = Mission.OscarTMPL
	end
	elseif Mission.CurrentSpawnPosition <= 3 then
		Mission.CurrentTemplate = Mission.OscarTMPL
	elseif Mission.CurrentSpawnPosition <= 7 then
		Mission.CurrentTemplate = Mission.KamikazeTMPL
--	elseif Mission.CurrentSpawnPosition <= 7 then
--		Mission.CurrentTemplate = Mission.BettyOhkaTMPL
	end
]]
	if Mission.HQs[2].Party == PARTY_JAPANESE then
		for index, unit in pairs (Mission.AttackerPlanesHQ2) do
			if unit.Dead and unit.respawntime == nil then
				unit.respawntime = GameTime() + Mission.RespawnTime
			elseif unit.Dead and unit.respawntime ~= nil then
			 	if unit.respawntime > GameTime() then
					local pos = GetPosition(Mission.HQs[2])
					local modi = index * 100
					local posmod = {["x"] = pos["x"] - modi, ["y"] = 150, ["z"] = pos["z"] - modi}
					Mission.AttackerPlanesHQ2[index] = GenerateObject(Mission.OscarTMPL.Name, posmod)
					--AISetHintWeight(Mission.AttackerPlanesHQ2[index], 3)
					SetSkillLevel(Mission.AttackerPlanesHQ2[index], SKILL_SPNORMAL)
					table.insert(Mission.AttackerPlanes, Mission.AttackerPlanesHQ2[index])
				end
			end
		end
	end

	if Mission.HQs[3].Party == PARTY_JAPANESE then
		for index, unit in pairs (Mission.BomberPlanes) do
			if unit.Dead and unit.respawntime == nil then
				unit.respawntime = GameTime() + Mission.RespawnTime
			elseif unit.Dead and unit.respawntime ~= nil then
			 	if unit.respawntime > GameTime() then
					local pos = GetPosition(Mission.HQs[3])
					local modi = index * 100
					local posmod = {["x"] = pos["x"] - modi, ["y"] = 150, ["z"] = pos["z"] - modi}
					Mission.BomberPlanes[index] = GenerateObject(Mission.ValTMPL.Name, posmod)
					--AISetHintWeight(Mission.BomberPlanes[index], 7)
					SetSkillLevel(Mission.BomberPlanes[index], SKILL_SPNORMAL)
				end
			end
		end
	end

	if Mission.HQs[4].Party == PARTY_JAPANESE then
		for index, unit in pairs (Mission.AttackerPlanesHQ4) do
			if unit.Dead and unit.respawntime == nil then
				unit.respawntime = GameTime() + Mission.RespawnTime
			elseif unit.Dead and unit.respawntime ~= nil then
			 	if unit.respawntime > GameTime() then
					local pos = GetPosition(Mission.HQs[4])
					local modi = index * 100
					local posmod = {["x"] = pos["x"] - modi, ["y"] = 150, ["z"] = pos["z"] - modi}
					Mission.AttackerPlanesHQ4[index] = GenerateObject(Mission.OscarTMPL.Name, posmod)
					--AISetHintWeight(Mission.AttackerPlanesHQ4[index], 3)
					SetSkillLevel(Mission.AttackerPlanesHQ4[index], SKILL_SPNORMAL)
					table.insert(Mission.AttackerPlanes, Mission.AttackerPlanesHQ4[index])
				end
			end
		end
	end
--[[
	Mission.AttackerPlanes = luaRemoveDeadsFromTable(Mission.AttackerPlanes)
	if table.getn(Mission.AttackerPlanes) ~= Mission.MaxAttackerPlanes and not Mission.AttackerPlaneSpawnDenied then
		local planesneeded = Mission.MaxAttackerPlanes - table.getn(Mission.AttackerPlanes)
-- RELEASE_LOGOFF  		luaLog(" planesneeded: "..planesneeded)
		for i = 1, planesneeded do
			local modi = i * 150
			local pos = {["x"] = Mission.CurrentSpawnCoordinates["x"] - modi, ["y"] = 350, ["z"] = Mission.CurrentSpawnCoordinates["z"] - modi}
			local plane = GenerateObject(Mission.CurrentTemplate.Name, pos)
			--PutTo(plane, pos)
			SetSkillLevel(plane, SKILL_MPNORMAL)
			table.insert(Mission.AttackerPlanes, plane)
		end
	end
]]
	Mission.BomberPlanes = luaRemoveDeadsFromTable(Mission.BomberPlanes)
	if table.getn(Mission.BomberPlanes) ~= 0 then
		for index, unit in pairs (Mission.BomberPlanes) do
			if UnitGetAttackTarget(unit) == nil then
				local possibletargets = {}
				if not Mission.Yorktown.Dead then
					table.insert(possibletargets, Mission.Yorktown)
				end
				if not Mission.Lexington.Dead then
					table.insert(possibletargets, Mission.Lexington)
				end
				if Mission.HQs[1].Party == PARTY_ALLIED then
					table.insert(possibletargets, Mission.HQs[1])
				end
				if Mission.HQs[5].Party == PARTY_ALLIED then
					table.insert(possibletargets, Mission.HQs[5])
				end
				local target = luaPickRnd(possibletargets)
				if table.getn(possibletargets) ~= 0 then
					PilotSetTarget(unit, target)
				end
			end
		end
	end

	Mission.AttackerPlanes = luaRemoveDeadsFromTable(Mission.AttackerPlanes)
	if table.getn(Mission.AttackerPlanes) ~= 0 then
		for index, unit in pairs (Mission.AttackerPlanes) do
			if UnitGetAttackTarget(unit) == nil then
				local nearestPT = luaGetNearestEnemy(unit ,"TorpedoBoat")
				local distPT = nil
				local nearestBomber = luaGetNearestEnemy(unit ,"DiveBomber")
				local distBomber = nil
				if nearestPT ~= nil then
					distPT = luaGetDistance(unit, nearestPT)
				end
				if nearestPT ~= nil then
					distBomber = luaGetDistance(unit, nearestBomber)
				end
				if distPT ~= nil and distBomber ~= nil then
					if distPT < distBomber then
						PilotSetTarget(unit, nearestPT)
-- RELEASE_LOGOFF  						luaLog("  ordering zero to attack "..nearestPT.Name)
					elseif distPT >= distBomber then
						PilotSetTarget(unit, nearestBomber)
-- RELEASE_LOGOFF  						luaLog("  ordering zero to attack "..nearestBomber.Name)
					end
				elseif distPT ~= nil and distBomber == nil then
					PilotSetTarget(unit, nearestPT)
-- RELEASE_LOGOFF  					luaLog("  ordering zero to attack "..nearestPT.Name)
				elseif distPT == nil and distBomber ~= nil then
					PilotSetTarget(unit, nearestBomber)
-- RELEASE_LOGOFF  					luaLog("  ordering zero to attack "..nearestBomber.Name)
				else
-- RELEASE_LOGOFF  					luaLog("  target not found for zero")
				end
			end
		end
	end
end

function luaUpdateCounters()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Updating counters...")
		if MultiScore ~= nil then
			if table.getn(MultiScore) ~= 0 then
				local PlayersInGame = GetPlayerDetails()
				local highestindex, highestplayerscore = luaQAC4CheckHighestScore()
				for index, value in pairs (PlayersInGame) do
					MultiScore[index][1] = Scoring_GetTotalMissionScore(index)
					MultiScore[index][5] = highestplayerscore
				end
			end
		end
	
		luaDelay(luaUpdateCounters, 0.7)
	end
end

function luaQAC4UpdateCounters()
-- RELEASE_LOGOFF  	luaLog(" Updating counters...")
	for index, unit in pairs (Mission.USPTBoats) do
		if unit ~= "fake" then
			Mission.USPTFound = true
			if not unit.Dead then
				if Mission.PlayersActualCheckPoint[index] == 6 then
					Mission.PlayerDistances[index] = luaGetDistance(unit, Mission.USCheckPoints[Mission.PlayersActualCheckPoint[index]])
				elseif Mission.PlayersActualCheckPoint[index] == 5 then
					local modifier = Mission.Dist6
					Mission.PlayerDistances[index] = luaGetDistance(unit, Mission.USCheckPoints[Mission.PlayersActualCheckPoint[index]]) + modifier
				elseif Mission.PlayersActualCheckPoint[index] == 4 then
					local modifier = Mission.Dist6 + Mission.Dist5
					Mission.PlayerDistances[index] = luaGetDistance(unit, Mission.USCheckPoints[Mission.PlayersActualCheckPoint[index]]) + modifier
				elseif Mission.PlayersActualCheckPoint[index] == 3 then
					local modifier = Mission.Dist6 + Mission.Dist5 + Mission.Dist4
					Mission.PlayerDistances[index] = luaGetDistance(unit, Mission.USCheckPoints[Mission.PlayersActualCheckPoint[index]]) + modifier
				elseif Mission.PlayersActualCheckPoint[index] == 2 then
					local modifier = Mission.Dist6 + Mission.Dist5 + Mission.Dist4 + Mission.Dist3
					Mission.PlayerDistances[index] = luaGetDistance(unit, Mission.USCheckPoints[Mission.PlayersActualCheckPoint[index]]) + modifier
				elseif Mission.PlayersActualCheckPoint[index] == 1 then
					local modifier = Mission.Dist6 + Mission.Dist5 + Mission.Dist4 + Mission.Dist3 + Mission.Dist2
					Mission.PlayerDistances[index] = luaGetDistance(unit, Mission.USCheckPoints[Mission.PlayersActualCheckPoint[index]]) + modifier
				end
			else
-- RELEASE_LOGOFF  				luaLog("  dead unit found, need to keep it's position")
			end
		end
	end

	if Mission.USPTFound then
		local tablechecker = {}
		local sortedtable = {}
		Mission.LowestSet = false
		Mission.Lowest = 1337
		local lowestintable = 1000000
		local lowestindex = 0
		for index, value in pairs (Mission.PlayerDistances) do
			--luaLog(" inserting "..value.." into tablechecker")
			table.insert(tablechecker, value)
		end

		if table.getn(tablechecker) ~= 0 then
			repeat
				for index, value in pairs(tablechecker) do
					--luaLog(" tablechecker "..index.."'s value: "..value)
					if value < lowestintable then
						lowestintable = value
						lowestindex = index
					end
				end
				--luaLog(" lowestintable "..lowestintable.." index: "..lowestindex)
				if not Mission.LowestSet then
					Mission.Lowest = lowestindex - 1
					Mission.LowestSet = true
				end
				table.insert(sortedtable, lowestintable)
				table.remove(tablechecker, lowestindex)
				lowestintable = 1000001
			until table.getn(tablechecker) == 0
--[[
			for index, value in pairs (sortedtable) do
-- RELEASE_LOGOFF  				luaLog(" sortedtable "..tostring(index).."'s value: "..tostring(value))
			end
]]
			for index, value in pairs (Mission.PlayerDistances) do
				--luaLog(" Mission.PlayerDistances.index: "..tostring(index).." Mission.PlayerDistances.value: "..tostring(value))
				for index2, value2 in pairs (sortedtable) do
					--luaLog(" sortedtable.index2: "..tostring(index2).." sortedtable.value2: "..tostring(value2))
					if value == value2 then
						--luaLog(" Mission.PlayerPlaces["..tostring(index).."] = "..tostring(index2))
						Mission.PlayerPlaces[index] = index2
					end
				end
			end
--[[
			for index, value in pairs (Mission.PlayerPlaces) do
-- RELEASE_LOGOFF  				luaLog(" player "..tostring(index).."'s place: "..tostring(value))
			end
]]
			--luaLog("  player "..tostring(Mission.Lowest).." leads")
			local leaderdetails = GetPlayerDetails()[Mission.Lowest]
			if leaderdetails ~= nil then
				local leadername = leaderdetails.playerName
				local PlayersInGame = GetPlayerDetails()
				for index, value in pairs (PlayersInGame) do
					local luaindex = index + 1
					local place = Mission.PlayerPlaces[luaindex]
					MultiScore[index][1] = place
					MultiScore[index][3] = leadername
				end
			else
-- RELEASE_LOGOFF  				luaLog(" FAIL! the leader left the game...")
			end
		end
	end
	luaDelay(luaQAC4UpdateCounters, 3)
end

------ megirni ------

function luaQAC4CheckMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Checking mission ending conditions...")
	if Mission.Yorktown.Dead and Mission.Lexington.Dead then
		luaObj_Failed("secondary", 1)
		Mission.ObjSec1Failed = true
	end

	if Mission.HQs[1].Party ~= PARTY_ALLIED or Mission.HQs[5].Party ~= PARTY_ALLIED then
-- RELEASE_LOGOFF  		luaLog("  one of the HQs has been neutralized, mission failed")
		Mission.MissionEndCalled = true
		Mission.MissionFailed = true
		local PlayersInGame = GetPlayerDetails()
		local highestindex, highestplayerscore = luaQAC4CheckHighestScore()
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
		CountdownCancel()
		local highestindex, highestplayerscore = luaQAC4CheckHighestScore()
		ForceMultiScoreSend()
		luaDelay(luaQAC4MissionEnd, 0.1)
		--luaQAC4MissionEnd(highestindex)
	end

	if Mission.PointLimit ~= 0 then
		local highestindex, highestplayerscore = luaQAC4CheckHighestScore()
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
			luaDelay(luaQAC4MissionEnd, 0.1)
		end
	end
end

function luaQAC4CheckHighestScore()
	local MPlayers = GetPlayerDetails()
	local actplayerscore = 0
	local highestplayerscore = 0
	local highestindex = 0
	for slotID, value in pairs (MPlayers) do
		actplayerscore = Scoring_GetTotalMissionScore(slotID)
		--luaLog(" playerindex: "..slotID.." | score: "..actplayerscore)
		if actplayerscore > highestplayerscore then
			highestplayerscore = actplayerscore
			highestindex = slotID
		end
	end
	return highestindex, highestplayerscore
end

function luaQAC4MissionEndTimeIsUp()
	MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_time_up")
	local PlayersInGame = GetPlayerDetails()
	local highestindex, highestplayerscore = luaQAC4CheckHighestScore()
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
	CountdownCancel()
	ForceMultiScoreSend()
	luaDelay(luaQAC4MissionEnd, 0.1)
end

function luaQAC4MissionEnd(index)
	if not Mission.Completed then
--[[
		if not Mission.TimeIsUp and not Mission.MissionFailed then
			MissionNarrativePlayer(0, "#MultiScore.0.4# |".."mp01.nar_comp_player_won")
			MissionNarrativePlayer(1, "#MultiScore.1.4# |".."mp01.nar_comp_player_won")
			MissionNarrativePlayer(2, "#MultiScore.2.4# |".."mp01.nar_comp_player_won")
			MissionNarrativePlayer(3, "#MultiScore.3.4# |".."mp01.nar_comp_player_won")
			MissionNarrativePlayer(4, "#MultiScore.4.4# |".."mp01.nar_comp_player_won")
			MissionNarrativePlayer(5, "#MultiScore.5.4# |".."mp01.nar_comp_player_won")
			MissionNarrativePlayer(6, "#MultiScore.6.4# |".."mp01.nar_comp_player_won")
			MissionNarrativePlayer(7, "#MultiScore.7.4# |".."mp01.nar_comp_player_won")
		end
]]
		local highestindex, highestplayerscore = luaQAC4CheckHighestScore()
-- RELEASE_LOGOFF  		luaLog(" player "..highestindex.." won")
		local objindex = highestindex + 1
		luaObj_Completed("primary", objindex)
		for i = 1, 8 do
			if i ~= objindex then
				luaObj_Failed("primary", i)
			end
		end
		if not Mission.Yorktown.Dead or not Mission.Lexington.Dead then
			luaObj_Completed("secondary", 1)
		elseif not Mission.ObjSec1Failed then
			luaObj_Failed("secondary", 1)
		end
		Scoring_RealPlayTimeRunning(false)
		Mission.Completed = true
		if Mission.MissionFailed then
			luaObj_Failed("primary", 9)
			luaMissionCompletedNew(luaPickRnd(Mission.HQs), "", nil, nil, nil, PARTY_JAPANESE)
		else
			luaObj_Completed("primary", 9)
			luaMissionCompletedNew(luaPickRnd(Mission.HQs), "", nil, nil, nil, PARTY_ALLIED)
		end
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Competitive04")
	-- mode description hint overlay
end

function luaQAC4USFleet1Spawned(unit1)
	table.insert(Mission.USFleet1, unit1)
	local pathpoints = FillPathPoints(Mission.USFleetPaths[1])
	for index, unit in pairs (Mission.USFleet1) do
		SetSkillLevel(unit, SKILL_SPNORMAL)
		EntityTurnToPosition(unit, pathpoints[1])
		if index == 1 then
			NavigatorMoveOnPath(Mission.USFleet1[1], Mission.USFleetPaths[1], PATH_FM_CIRCLE, PATH_SM_JOIN)
			JoinFormation(Mission.Yorktown, Mission.USFleet1[1])
		else
			JoinFormation(unit, Mission.USFleet1[1])
		end
		NavigatorSetAvoidLandCollision(unit, false)
		NavigatorSetTorpedoEvasion(unit, false)
		TorpedoEnable(unit, true)
	end
end

function luaQAC4USFleet2Spawned(unit1, unit2, unit3)
	table.insert(Mission.USFleet2, unit1)
	table.insert(Mission.USFleet2, unit2)
	local pathpoints = FillPathPoints(Mission.USFleetPaths[2])
	for index, unit in pairs (Mission.USFleet2) do
		SetSkillLevel(unit, SKILL_SPNORMAL)
		EntityTurnToPosition(unit, pathpoints[1])
		if index == 1 then
			NavigatorMoveOnPath(Mission.USFleet2[1], Mission.USFleetPaths[2], PATH_FM_CIRCLE, PATH_SM_JOIN)
		else
			JoinFormation(unit, Mission.USFleet2[1])
		end
		NavigatorSetAvoidLandCollision(unit, false)
		NavigatorSetTorpedoEvasion(unit, false)
		TorpedoEnable(unit, true)
	end
end

function luaQAC4JapFleet1Spawned(unit1, unit2, unit3)
	table.insert(Mission.JapFleet1, unit1)
	table.insert(Mission.JapFleet1, unit2)
	if unit3 ~= nil then
		table.insert(Mission.JapFleet1, unit3)
	end
	local pathpoints = FillPathPoints(Mission.JapFleetPaths[1])
	for index, unit in pairs (Mission.JapFleet1) do
		SetSkillLevel(unit, SKILL_SPNORMAL)
		EntityTurnToEntity(unit, Mission.HQs[1])
		--EntityTurnToPosition(unit, pathpoints[1])
		if index == 1 then
			NavigatorMoveOnPath(Mission.JapFleet1[1], Mission.JapFleetPaths[1], PATH_FM_CIRCLE, PATH_SM_JOIN)
		else
			JoinFormation(unit, Mission.JapFleet1[1])
		end
		AISetHintWeight(unit, 50)
		NavigatorSetTorpedoEvasion(unit, false)
		--NavigatorSetAvoidLandCollision(unit, false)
		TorpedoEnable(unit, true)
	end
	PutFormationTo(Mission.JapFleet1[1], GetPosition(Mission.JapFleet1[1]), 2)
end

function luaQAC4JapFleet4Spawned(unit1, unit2, unit3)
	table.insert(Mission.JapFleet4, unit1)
	table.insert(Mission.JapFleet4, unit2)
	if unit3 ~= nil then
		table.insert(Mission.JapFleet4, unit3)
	end
	local pathpoints = FillPathPoints(Mission.JapFleetPaths[1])
	for index, unit in pairs (Mission.JapFleet4) do
		SetSkillLevel(unit, SKILL_SPNORMAL)
		EntityTurnToEntity(unit, Mission.HQs[1])
		--EntityTurnToPosition(unit, pathpoints[1])
		if index == 1 then
			NavigatorMoveOnPath(Mission.JapFleet4[1], Mission.JapFleetPaths[1], PATH_FM_CIRCLE, PATH_SM_JOIN)
		else
			JoinFormation(unit, Mission.JapFleet4[1])
		end
		AISetHintWeight(unit, 50)
		NavigatorSetTorpedoEvasion(unit, false)
		--NavigatorSetAvoidLandCollision(unit, false)
		TorpedoEnable(unit, true)
	end
	PutFormationTo(Mission.JapFleet4[1], GetPosition(Mission.JapFleet4[1]), 2)
end

function luaQAC4JapFleet2Spawned(unit1, unit2, unit3, unit4)
	table.insert(Mission.JapFleet2, unit1)
	table.insert(Mission.JapFleet2, unit2)
	if unit3 ~= nil then
		table.insert(Mission.JapFleet2, unit3)
	end
	local pathpoints = FillPathPoints(Mission.JapFleetPaths[2])
	for index, unit in pairs (Mission.JapFleet2) do
		SetSkillLevel(unit, SKILL_SPNORMAL)
		EntityTurnToPosition(unit, pathpoints[1])
		if index == 1 then
			NavigatorMoveOnPath(Mission.JapFleet2[1], Mission.JapFleetPaths[2], PATH_FM_CIRCLE, PATH_SM_JOIN)
		else
			JoinFormation(unit, Mission.JapFleet2[1])
		end
		--AISetHintWeight(unit, 200)
		NavigatorSetAvoidLandCollision(unit, false)
		NavigatorSetTorpedoEvasion(unit, false)
		TorpedoEnable(unit, true)
	end
	PutFormationTo(Mission.JapFleet2[1], GetPosition(Mission.JapFleet2[1]), 1)
end

function luaQAC4JapFleet3Spawned(unit1, unit2, unit3)
	table.insert(Mission.JapFleet3, unit1)
	table.insert(Mission.JapFleet3, unit2)
	if unit3 ~= nil then
		table.insert(Mission.JapFleet3, unit3)
	end
	local pathpoints = FillPathPoints(Mission.JapFleetPaths[3])
	for index, unit in pairs (Mission.JapFleet3) do
		SetSkillLevel(unit, SKILL_SPNORMAL)
		EntityTurnToPosition(unit, pathpoints[1])
		if index == 1 then
			NavigatorMoveOnPath(Mission.JapFleet3[1], Mission.JapFleetPaths[3], PATH_FM_CIRCLE, PATH_SM_JOIN)
		else
			JoinFormation(unit, Mission.JapFleet3[1])
		end
		AISetHintWeight(unit, 300)
		NavigatorSetAvoidLandCollision(unit, false)
		NavigatorSetTorpedoEvasion(unit, false)
		TorpedoEnable(unit, true)
	end
	NavigatorAttackMove(Mission.SuicideFletcher, Mission.JapFleet3[1], {})
	PutFormationTo(Mission.JapFleet3[1], GetPosition(Mission.JapFleet3[1]), 1)
end

function luaQAC4HintManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 30 and not Mission.Hint1Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint1Shown")
			ShowHint("ID_Hint_Competitive04_divide")
			Mission.Hint1Shown = true
		elseif GameTime() > 60 and not Mission.Hint2Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint2Shown")
			ShowHint("ID_Hint_Competitive04_targets")
			Mission.Hint2Shown = true
		elseif GameTime() > 90 and not Mission.Hint3Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint3Shown")
			ShowHint("ID_Hint_Competitive04_units")
			Mission.Hint3Shown = true
		end
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
		local randomtime = luaRnd(80, 120)
		Mission.ListenerTimer = GameTime() + randomtime
		Mission.ReminderTimer = GameTime() + 14
		Mission.AttackerShipsX = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 20000, PARTY_JAPANESE, "own")
		Mission.AttackerPlanesX = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 20000, PARTY_JAPANESE, "own")
		if Mission.AttackerShipsX == nil then
			Mission.AttackerShipsX = {}
		end
		if Mission.AttackerPlanesX == nil then
			Mission.AttackerPlanesX = {}
		end
		if table.getn(Mission.AttackerShipsX) ~= 0 or table.getn(Mission.AttackerPlanesX) ~= 0 then
			Mission.RandomListener = luaRnd(1, 2)
			if Mission.RandomListener == 1 and table.getn(Mission.AttackerShipsX) ~= 0 then
				Mission.RandomTarget = luaPickRnd(Mission.AttackerShipsX)
			elseif Mission.RandomListener == 2 and table.getn(Mission.AttackerPlanesX) ~= 0 then
				Mission.RandomTarget = luaPickRnd(Mission.AttackerPlanesX)
			else
				Mission.RandomTarget = nil
			end
			if Mission.RandomTarget ~= nil then
				MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_bonus_kill")
				for i = 1, 8 do
					luaObj_AddUnit("primary", i, Mission.RandomTarget)
				end
				--AISetHintWeight(Mission.RandomTarget, 50)
				luaQACRandomTargetKillListener(Mission.RandomTarget)
			end
		end
	elseif GameTime() > Mission.ReminderTimer and Mission.ListenerActive then
		Mission.ReminderTimer = GameTime() + 22
		if not Mission.RandomTarget.Dead then
			MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_bonus_kill")
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
-- RELEASE_LOGOFF  	luaLog(target)
-- RELEASE_LOGOFF  	luaLog(lastAttacker)
-- RELEASE_LOGOFF  	luaLog(lastAttackerPlayerIndex)
	if lastAttacker ~= nil then
		if not lastAttacker.Dead then
			lastAttackerPlayerIndex = GetRoleAvailable(lastAttacker)[1]
		end
-- RELEASE_LOGOFF  		luaLog(lastAttackerPlayerIndex)
-- RELEASE_LOGOFF  		luaLog(" LISTENER: target killed by player "..lastAttackerPlayerIndex)
		if lastAttackerPlayerIndex >= 0 and lastAttackerPlayerIndex <= 7 then
			if Mission.RandomListener == 1 then
				Scoring_AddCommandScore(lastAttackerPlayerIndex, "mp01.nar_comp_bonus_kill", Mission.KillScoreShip)
			elseif Mission.RandomListener == 2 then
				Scoring_AddCommandScore(lastAttackerPlayerIndex, "mp01.nar_comp_bonus_kill", Mission.KillScorePlane)
			end
			for i = 1, 8 do
-- RELEASE_LOGOFF  				luaLog("i = "..i)
				local y = i - 1
-- RELEASE_LOGOFF  				luaLog("y = "..y)
-- RELEASE_LOGOFF  				luaLog("lastAttackerPlayerIndex = "..lastAttackerPlayerIndex)
				if y == lastAttackerPlayerIndex then
					MissionNarrativePlayer(y, "mp01.nar_comp_kill")
				else
					MissionNarrativePlayer(y, "mp01.nar_comp_kill_fail")
				end
--[[
					local playerwhoscored = GetPlayerDetails()[y]
-- RELEASE_LOGOFF  					luaLog(playerwhoscored)
-- RELEASE_LOGOFF  					luaLog(playerwhoscored.playerName)
					Mission.MultiScoreAILevel = 33
					for z = 1, 8 do
						local x = z - 1
						if playerwhoscored.playerName == "" and playerwhoscored.ailevel == 3 then
							Mission.MultiScoreAILevel = 3
						elseif playerwhoscored.playerName == "" and playerwhoscored.ailevel == 4 then
							Mission.MultiScoreAILevel = 4
						elseif playerwhoscored.playerName == "" and playerwhoscored.ailevel == 5 then
							Mission.MultiScoreAILevel = 5
						end
						MultiScore[x][6] = playerwhoscored.playerName
					end
				end
]]
			end
			--luaDelay(luaKillNarrative, 2, "ai", Mission.MultiScoreAILevel)
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

function luaKillNarrative(timerthis)
	if timerthis.ParamTable.ai == 33 then
		MissionNarrativePlayer(0, "mp01.nar_comp_kill".."| #MultiScore.0.6#")
		MissionNarrativePlayer(1, "mp01.nar_comp_kill".."| #MultiScore.1.6#")
		MissionNarrativePlayer(2, "mp01.nar_comp_kill".."| #MultiScore.2.6#")
		MissionNarrativePlayer(3, "mp01.nar_comp_kill".."| #MultiScore.3.6#")
		MissionNarrativePlayer(4, "mp01.nar_comp_kill".."| #MultiScore.4.6#")
		MissionNarrativePlayer(5, "mp01.nar_comp_kill".."| #MultiScore.5.6#")
		MissionNarrativePlayer(6, "mp01.nar_comp_kill".."| #MultiScore.6.6#")
		MissionNarrativePlayer(7, "mp01.nar_comp_kill".."| #MultiScore.7.6#")
	elseif timerthis.ParamTable.ai == 3 then
		MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_kill".."| |FE.easy")
	elseif timerthis.ParamTable.ai == 4 then
		MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_kill".."| |FE.normal")
	elseif timerthis.ParamTable.ai == 5 then
		MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_kill".."| |FE.hard")
	end
end