--SceneFile="Missions\Multi\Scene6.scn"

function luaPrecacheUnits()
	PrepareClass(97) -- HQ
	PrepareClass(224) -- Japanese Troop Transport
	PrepareClass(73) -- Fubuki
	PrepareClass(75) -- Minekaze
	PrepareClass(70) -- Kuma
	PrepareClass(68) -- Tone
	PrepareClass(71) -- Agano
	PrepareClass(67) -- Mogami
	PrepareClass(77) -- Japanese PT
	PrepareClass(60) -- Kongo
	PrepareClass(61) -- Fuso
	PrepareClass(59) -- Yamato
	PrepareClass(150) -- Zero
	PrepareClass(158) -- Val
	PrepareClass(159) -- Judy
	--PrepareClass(32) -- Betty - Ohka
	PrepareClass(46) -- Kamikaze Val
	PrepareClass(64) -- Medium Fort
	PrepareClass(66) -- Medium Fort
	PrepareClass(84) -- Left Fort
	PrepareClass(89) -- Right Fort
	PrepareClass(76) -- Blended Fort
	PrepareClass(101) -- Wildcat
	PrepareClass(108) -- Dauntless
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAC6Mission")
end

function luaInitQAC6Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Comp6"..dateandtime 

	Mission.HelperLog = false
	Mission.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.."!")
	
	-- lokalizacios feltoltesek
	--AddLockitPathToSelection("missionglobals")
	--LoadSelectedPaths()

	-- precache

	-- lobby
-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")

	SetDeviceReloadEnabled(false) -- kikapcs, ha be lenne kapcsolva

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

	-- globalban hasznalando
	this.Multiplayer = true
	this.ThinkCounter = 0
	Mission.MultiplayerType = "Competitive"
	Mission.MultiplayerNumber = 6
	Mission.CompetitiveParty = PARTY_ALLIED

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- mission tablak, valtozok
	Mission.PlayerLevels = {}
		table.insert(Mission.PlayerLevels, 1)
		table.insert(Mission.PlayerLevels, 1)
		table.insert(Mission.PlayerLevels, 1)
		table.insert(Mission.PlayerLevels, 1)
		table.insert(Mission.PlayerLevels, 1)
		table.insert(Mission.PlayerLevels, 1)
		table.insert(Mission.PlayerLevels, 1)
		table.insert(Mission.PlayerLevels, 1)
	Mission.PointsToLevel = {}
		table.insert(Mission.PointsToLevel, 250)
		table.insert(Mission.PointsToLevel, 750)
		table.insert(Mission.PointsToLevel, 1250)
		table.insert(Mission.PointsToLevel, 1750)
		table.insert(Mission.PointsToLevel, 2250)
	Mission.SupplyTimer = {}
		table.insert(Mission.SupplyTimer, 300)
		table.insert(Mission.SupplyTimer, 500)
		table.insert(Mission.SupplyTimer, 700)
		table.insert(Mission.SupplyTimer, 800)
		table.insert(Mission.SupplyTimer, 900)
	Mission.HQLevels = {}
		table.insert(Mission.HQLevels, 1)
		table.insert(Mission.HQLevels, 1)
		table.insert(Mission.HQLevels, 1)
		table.insert(Mission.HQLevels, 1)
		table.insert(Mission.HQLevels, 1)
		table.insert(Mission.HQLevels, 1)
		table.insert(Mission.HQLevels, 1)
		table.insert(Mission.HQLevels, 1)
	Mission.Player1LiveLandforts = {}
	Mission.Player2LiveLandforts = {}
	Mission.Player3LiveLandforts = {}
	Mission.Player4LiveLandforts = {}
	Mission.Player5LiveLandforts = {}
	Mission.Player6LiveLandforts = {}
	Mission.Player7LiveLandforts = {}
	Mission.Player8LiveLandforts = {}

	-- amerikai objektumok
--[[
	Mission.HeadquarterTMPLs = {}
		table.insert(Mission.HeadquarterTMPLs, luaFindHidden("Comp - Headquarter 1"))
		table.insert(Mission.HeadquarterTMPLs, luaFindHidden("Comp - Headquarter 2"))
		table.insert(Mission.HeadquarterTMPLs, luaFindHidden("Comp - Headquarter 3"))
		table.insert(Mission.HeadquarterTMPLs, luaFindHidden("Comp - Headquarter 4"))
		table.insert(Mission.HeadquarterTMPLs, luaFindHidden("Comp - Headquarter 5"))
		table.insert(Mission.HeadquarterTMPLs, luaFindHidden("Comp - Headquarter 6"))
		table.insert(Mission.HeadquarterTMPLs, luaFindHidden("Comp - Headquarter 7"))
		table.insert(Mission.HeadquarterTMPLs, luaFindHidden("Comp - Headquarter 8"))
]]
	Mission.HQ1 = FindEntity("Comp - Headquarter 1")
	Mission.HQ1L1Units = {}
		table.insert(Mission.HQ1L1Units, FindEntity("Comp - Landfort P1 L1 1"))
		table.insert(Mission.HQ1L1Units, FindEntity("Comp - Landfort P1 L1 2"))
		table.insert(Mission.HQ1L1Units, FindEntity("Comp - Landfort P1 L1 3"))
	Mission.HQ2 = FindEntity("Comp - Headquarter 2")
	Mission.HQ2L1Units = {}
		table.insert(Mission.HQ2L1Units, FindEntity("Comp - Landfort P2 L1 1"))
		table.insert(Mission.HQ2L1Units, FindEntity("Comp - Landfort P2 L1 2"))
		table.insert(Mission.HQ2L1Units, FindEntity("Comp - Landfort P2 L1 3"))
	Mission.HQ3 = FindEntity("Comp - Headquarter 3")
	Mission.HQ3L1Units = {}
		table.insert(Mission.HQ3L1Units, FindEntity("Comp - Landfort P3 L1 1"))
		table.insert(Mission.HQ3L1Units, FindEntity("Comp - Landfort P3 L1 2"))
		table.insert(Mission.HQ3L1Units, FindEntity("Comp - Landfort P3 L1 3"))
	Mission.HQ4 = FindEntity("Comp - Headquarter 4")
	Mission.HQ4L1Units = {}
		table.insert(Mission.HQ4L1Units, FindEntity("Comp - Landfort P4 L1 1"))
		table.insert(Mission.HQ4L1Units, FindEntity("Comp - Landfort P4 L1 2"))
		table.insert(Mission.HQ4L1Units, FindEntity("Comp - Landfort P4 L1 3"))
	Mission.HQ5 = FindEntity("Comp - Headquarter 5")
	Mission.HQ5L1Units = {}
		table.insert(Mission.HQ5L1Units, FindEntity("Comp - Landfort P5 L1 1"))
		table.insert(Mission.HQ5L1Units, FindEntity("Comp - Landfort P5 L1 2"))
		table.insert(Mission.HQ5L1Units, FindEntity("Comp - Landfort P5 L1 3"))
	Mission.HQ6 = FindEntity("Comp - Headquarter 6")
	Mission.HQ6L1Units = {}
		table.insert(Mission.HQ6L1Units, FindEntity("Comp - Landfort P6 L1 1"))
		table.insert(Mission.HQ6L1Units, FindEntity("Comp - Landfort P6 L1 2"))
		table.insert(Mission.HQ6L1Units, FindEntity("Comp - Landfort P6 L1 3"))
	Mission.HQ7 = FindEntity("Comp - Headquarter 7")
	Mission.HQ7L1Units = {}
		table.insert(Mission.HQ7L1Units, FindEntity("Comp - Landfort P7 L1 1"))
		table.insert(Mission.HQ7L1Units, FindEntity("Comp - Landfort P7 L1 2"))
		table.insert(Mission.HQ7L1Units, FindEntity("Comp - Landfort P7 L1 3"))
	Mission.HQ8 = FindEntity("Comp - Headquarter 8")
	Mission.HQ8L1Units = {}
		table.insert(Mission.HQ8L1Units, FindEntity("Comp - Landfort P8 L1 1"))
		table.insert(Mission.HQ8L1Units, FindEntity("Comp - Landfort P8 L1 2"))
		table.insert(Mission.HQ8L1Units, FindEntity("Comp - Landfort P8 L1 3"))
--[[
	Mission.Player1Landforts = {}
		table.insert(Mission.Player1Landforts, luaFindHidden("Comp - Landfort P1 L2 1"))
		table.insert(Mission.Player1Landforts, luaFindHidden("Comp - Landfort P1 L2 2"))
		table.insert(Mission.Player1Landforts, luaFindHidden("Comp - Landfort P1 L3 1"))
		table.insert(Mission.Player1Landforts, luaFindHidden("Comp - Landfort P1 L3 2"))
		table.insert(Mission.Player1Landforts, luaFindHidden("Comp - Landfort P1 L4 1"))
		table.insert(Mission.Player1Landforts, luaFindHidden("Comp - Landfort P1 L4 2"))
		table.insert(Mission.Player1Landforts, luaFindHidden("Comp - Landfort P1 L5 1"))
	Mission.Player2Landforts = {}
		table.insert(Mission.Player2Landforts, luaFindHidden("Comp - Landfort P2 L2 1"))
		table.insert(Mission.Player2Landforts, luaFindHidden("Comp - Landfort P2 L2 2"))
		table.insert(Mission.Player2Landforts, luaFindHidden("Comp - Landfort P2 L3 1"))
		table.insert(Mission.Player2Landforts, luaFindHidden("Comp - Landfort P2 L3 2"))
		table.insert(Mission.Player2Landforts, luaFindHidden("Comp - Landfort P2 L4 1"))
		table.insert(Mission.Player2Landforts, luaFindHidden("Comp - Landfort P2 L4 2"))
		table.insert(Mission.Player2Landforts, luaFindHidden("Comp - Landfort P2 L5 1"))
	Mission.Player3Landforts = {}
		table.insert(Mission.Player3Landforts, luaFindHidden("Comp - Landfort P3 L2 1"))
		table.insert(Mission.Player3Landforts, luaFindHidden("Comp - Landfort P3 L2 2"))
		table.insert(Mission.Player3Landforts, luaFindHidden("Comp - Landfort P3 L3 1"))
		table.insert(Mission.Player3Landforts, luaFindHidden("Comp - Landfort P3 L3 2"))
		table.insert(Mission.Player3Landforts, luaFindHidden("Comp - Landfort P3 L4 1"))
		table.insert(Mission.Player3Landforts, luaFindHidden("Comp - Landfort P3 L4 2"))
		table.insert(Mission.Player3Landforts, luaFindHidden("Comp - Landfort P3 L5 1"))
	Mission.Player4Landforts = {}
		table.insert(Mission.Player4Landforts, luaFindHidden("Comp - Landfort P4 L2 1"))
		table.insert(Mission.Player4Landforts, luaFindHidden("Comp - Landfort P4 L2 2"))
		table.insert(Mission.Player4Landforts, luaFindHidden("Comp - Landfort P4 L3 1"))
		table.insert(Mission.Player4Landforts, luaFindHidden("Comp - Landfort P4 L3 2"))
		table.insert(Mission.Player4Landforts, luaFindHidden("Comp - Landfort P4 L4 1"))
		table.insert(Mission.Player4Landforts, luaFindHidden("Comp - Landfort P4 L4 2"))
		table.insert(Mission.Player4Landforts, luaFindHidden("Comp - Landfort P4 L5 1"))
	Mission.Player5Landforts = {}
		table.insert(Mission.Player5Landforts, luaFindHidden("Comp - Landfort P5 L2 1"))
		table.insert(Mission.Player5Landforts, luaFindHidden("Comp - Landfort P5 L2 2"))
		table.insert(Mission.Player5Landforts, luaFindHidden("Comp - Landfort P5 L3 1"))
		table.insert(Mission.Player5Landforts, luaFindHidden("Comp - Landfort P5 L3 2"))
		table.insert(Mission.Player5Landforts, luaFindHidden("Comp - Landfort P5 L4 1"))
		table.insert(Mission.Player5Landforts, luaFindHidden("Comp - Landfort P5 L4 2"))
		table.insert(Mission.Player5Landforts, luaFindHidden("Comp - Landfort P5 L5 1"))
	Mission.Player6Landforts = {}
		table.insert(Mission.Player6Landforts, luaFindHidden("Comp - Landfort P6 L2 1"))
		table.insert(Mission.Player6Landforts, luaFindHidden("Comp - Landfort P6 L2 2"))
		table.insert(Mission.Player6Landforts, luaFindHidden("Comp - Landfort P6 L3 1"))
		table.insert(Mission.Player6Landforts, luaFindHidden("Comp - Landfort P6 L3 2"))
		table.insert(Mission.Player6Landforts, luaFindHidden("Comp - Landfort P6 L4 1"))
		table.insert(Mission.Player6Landforts, luaFindHidden("Comp - Landfort P6 L4 2"))
		table.insert(Mission.Player6Landforts, luaFindHidden("Comp - Landfort P6 L5 1"))
	Mission.Player7Landforts = {}
		table.insert(Mission.Player7Landforts, luaFindHidden("Comp - Landfort P7 L2 1"))
		table.insert(Mission.Player7Landforts, luaFindHidden("Comp - Landfort P7 L2 2"))
		table.insert(Mission.Player7Landforts, luaFindHidden("Comp - Landfort P7 L3 1"))
		table.insert(Mission.Player7Landforts, luaFindHidden("Comp - Landfort P7 L3 2"))
		table.insert(Mission.Player7Landforts, luaFindHidden("Comp - Landfort P7 L4 1"))
		table.insert(Mission.Player7Landforts, luaFindHidden("Comp - Landfort P7 L4 2"))
		table.insert(Mission.Player7Landforts, luaFindHidden("Comp - Landfort P7 L5 1"))
	Mission.Player8Landforts = {}
		table.insert(Mission.Player8Landforts, luaFindHidden("Comp - Landfort P8 L2 1"))
		table.insert(Mission.Player8Landforts, luaFindHidden("Comp - Landfort P8 L2 2"))
		table.insert(Mission.Player8Landforts, luaFindHidden("Comp - Landfort P8 L3 1"))
		table.insert(Mission.Player8Landforts, luaFindHidden("Comp - Landfort P8 L3 2"))
		table.insert(Mission.Player8Landforts, luaFindHidden("Comp - Landfort P8 L4 1"))
		table.insert(Mission.Player8Landforts, luaFindHidden("Comp - Landfort P8 L4 2"))
		table.insert(Mission.Player8Landforts, luaFindHidden("Comp - Landfort P8 L5 1"))
]]
	-- japan objektumok
	Mission.P1AttackerPoints = {}
		--table.insert(Mission.P1AttackerPoints, GetPosition(FindEntity("Comp - P1 AttackPoint 1")))
		table.insert(Mission.P1AttackerPoints, GetPosition(FindEntity("Comp - P1 AttackPoint 2")))
		table.insert(Mission.P1AttackerPoints, GetPosition(FindEntity("Comp - P1 AttackPoint 3")))
		table.insert(Mission.P1AttackerPoints, GetPosition(FindEntity("Comp - P1 AttackPoint 4")))
		table.insert(Mission.P1AttackerPoints, GetPosition(FindEntity("Comp - P1 AttackPoint 5")))
		table.insert(Mission.P1AttackerPoints, GetPosition(FindEntity("Comp - P1 AttackPoint 6")))
	Mission.P1AttackerPaths = {}
		--table.insert(Mission.P1AttackerPaths, FindEntity("Comp - P1 AttackPath 1"))
		table.insert(Mission.P1AttackerPaths, FindEntity("Comp - P1 AttackPath 2"))
		table.insert(Mission.P1AttackerPaths, FindEntity("Comp - P1 AttackPath 3"))
		table.insert(Mission.P1AttackerPaths, FindEntity("Comp - P1 AttackPath 4"))
		table.insert(Mission.P1AttackerPaths, FindEntity("Comp - P1 AttackPath 5"))
		table.insert(Mission.P1AttackerPaths, FindEntity("Comp - P1 AttackPath 6"))
	Mission.P2AttackerPoints = {}
		--table.insert(Mission.P2AttackerPoints, GetPosition(FindEntity("Comp - P2 AttackPoint 1")))
		table.insert(Mission.P2AttackerPoints, GetPosition(FindEntity("Comp - P2 AttackPoint 2")))
		table.insert(Mission.P2AttackerPoints, GetPosition(FindEntity("Comp - P2 AttackPoint 3")))
		table.insert(Mission.P2AttackerPoints, GetPosition(FindEntity("Comp - P2 AttackPoint 4")))
		table.insert(Mission.P2AttackerPoints, GetPosition(FindEntity("Comp - P2 AttackPoint 5")))
		table.insert(Mission.P2AttackerPoints, GetPosition(FindEntity("Comp - P2 AttackPoint 6")))
	Mission.P2AttackerPaths = {}
		--table.insert(Mission.P2AttackerPaths, FindEntity("Comp - P2 AttackPath 1"))
		table.insert(Mission.P2AttackerPaths, FindEntity("Comp - P2 AttackPath 2"))
		table.insert(Mission.P2AttackerPaths, FindEntity("Comp - P2 AttackPath 3"))
		table.insert(Mission.P2AttackerPaths, FindEntity("Comp - P2 AttackPath 4"))
		table.insert(Mission.P2AttackerPaths, FindEntity("Comp - P2 AttackPath 5"))
		table.insert(Mission.P2AttackerPaths, FindEntity("Comp - P2 AttackPath 6"))
	Mission.P3AttackerPoints = {}
		--table.insert(Mission.P3AttackerPoints, GetPosition(FindEntity("Comp - P3 AttackPoint 1")))
		table.insert(Mission.P3AttackerPoints, GetPosition(FindEntity("Comp - P3 AttackPoint 2")))
		table.insert(Mission.P3AttackerPoints, GetPosition(FindEntity("Comp - P3 AttackPoint 3")))
		table.insert(Mission.P3AttackerPoints, GetPosition(FindEntity("Comp - P3 AttackPoint 4")))
		table.insert(Mission.P3AttackerPoints, GetPosition(FindEntity("Comp - P3 AttackPoint 5")))
		table.insert(Mission.P3AttackerPoints, GetPosition(FindEntity("Comp - P3 AttackPoint 6")))
	Mission.P3AttackerPaths = {}
		--table.insert(Mission.P3AttackerPaths, FindEntity("Comp - P3 AttackPath 1"))
		table.insert(Mission.P3AttackerPaths, FindEntity("Comp - P3 AttackPath 2"))
		table.insert(Mission.P3AttackerPaths, FindEntity("Comp - P3 AttackPath 3"))
		table.insert(Mission.P3AttackerPaths, FindEntity("Comp - P3 AttackPath 4"))
		table.insert(Mission.P3AttackerPaths, FindEntity("Comp - P3 AttackPath 5"))
		table.insert(Mission.P3AttackerPaths, FindEntity("Comp - P3 AttackPath 6"))
	Mission.P4AttackerPoints = {}
		--table.insert(Mission.P4AttackerPoints, GetPosition(FindEntity("Comp - P4 AttackPoint 1")))
		table.insert(Mission.P4AttackerPoints, GetPosition(FindEntity("Comp - P4 AttackPoint 2")))
		table.insert(Mission.P4AttackerPoints, GetPosition(FindEntity("Comp - P4 AttackPoint 3")))
		table.insert(Mission.P4AttackerPoints, GetPosition(FindEntity("Comp - P4 AttackPoint 4")))
		table.insert(Mission.P4AttackerPoints, GetPosition(FindEntity("Comp - P4 AttackPoint 5")))
		table.insert(Mission.P4AttackerPoints, GetPosition(FindEntity("Comp - P4 AttackPoint 6")))
	Mission.P4AttackerPaths = {}
		--table.insert(Mission.P4AttackerPaths, FindEntity("Comp - P4 AttackPath 1"))
		table.insert(Mission.P4AttackerPaths, FindEntity("Comp - P4 AttackPath 2"))
		table.insert(Mission.P4AttackerPaths, FindEntity("Comp - P4 AttackPath 3"))
		table.insert(Mission.P4AttackerPaths, FindEntity("Comp - P4 AttackPath 4"))
		table.insert(Mission.P4AttackerPaths, FindEntity("Comp - P4 AttackPath 5"))
		table.insert(Mission.P4AttackerPaths, FindEntity("Comp - P4 AttackPath 6"))
	Mission.P5AttackerPoints = {}
		--table.insert(Mission.P5AttackerPoints, GetPosition(FindEntity("Comp - P5 AttackPoint 1")))
		table.insert(Mission.P5AttackerPoints, GetPosition(FindEntity("Comp - P5 AttackPoint 2")))
		table.insert(Mission.P5AttackerPoints, GetPosition(FindEntity("Comp - P5 AttackPoint 3")))
		table.insert(Mission.P5AttackerPoints, GetPosition(FindEntity("Comp - P5 AttackPoint 4")))
		table.insert(Mission.P5AttackerPoints, GetPosition(FindEntity("Comp - P5 AttackPoint 5")))
		table.insert(Mission.P5AttackerPoints, GetPosition(FindEntity("Comp - P5 AttackPoint 6")))
	Mission.P5AttackerPaths = {}
		--table.insert(Mission.P5AttackerPaths, FindEntity("Comp - P5 AttackPath 1"))
		table.insert(Mission.P5AttackerPaths, FindEntity("Comp - P5 AttackPath 2"))
		table.insert(Mission.P5AttackerPaths, FindEntity("Comp - P5 AttackPath 3"))
		table.insert(Mission.P5AttackerPaths, FindEntity("Comp - P5 AttackPath 4"))
		table.insert(Mission.P5AttackerPaths, FindEntity("Comp - P5 AttackPath 5"))
		table.insert(Mission.P5AttackerPaths, FindEntity("Comp - P5 AttackPath 6"))
	Mission.P6AttackerPoints = {}
		--table.insert(Mission.P6AttackerPoints, GetPosition(FindEntity("Comp - P6 AttackPoint 1")))
		table.insert(Mission.P6AttackerPoints, GetPosition(FindEntity("Comp - P6 AttackPoint 2")))
		table.insert(Mission.P6AttackerPoints, GetPosition(FindEntity("Comp - P6 AttackPoint 3")))
		table.insert(Mission.P6AttackerPoints, GetPosition(FindEntity("Comp - P6 AttackPoint 4")))
		table.insert(Mission.P6AttackerPoints, GetPosition(FindEntity("Comp - P6 AttackPoint 5")))
		table.insert(Mission.P6AttackerPoints, GetPosition(FindEntity("Comp - P6 AttackPoint 6")))
	Mission.P6AttackerPaths = {}
		--table.insert(Mission.P6AttackerPaths, FindEntity("Comp - P6 AttackPath 1"))
		table.insert(Mission.P6AttackerPaths, FindEntity("Comp - P6 AttackPath 2"))
		table.insert(Mission.P6AttackerPaths, FindEntity("Comp - P6 AttackPath 3"))
		table.insert(Mission.P6AttackerPaths, FindEntity("Comp - P6 AttackPath 4"))
		table.insert(Mission.P6AttackerPaths, FindEntity("Comp - P6 AttackPath 5"))
		table.insert(Mission.P6AttackerPaths, FindEntity("Comp - P6 AttackPath 6"))
	Mission.P7AttackerPoints = {}
		--table.insert(Mission.P7AttackerPoints, GetPosition(FindEntity("Comp - P7 AttackPoint 1")))
		table.insert(Mission.P7AttackerPoints, GetPosition(FindEntity("Comp - P7 AttackPoint 2")))
		table.insert(Mission.P7AttackerPoints, GetPosition(FindEntity("Comp - P7 AttackPoint 3")))
		table.insert(Mission.P7AttackerPoints, GetPosition(FindEntity("Comp - P7 AttackPoint 4")))
		table.insert(Mission.P7AttackerPoints, GetPosition(FindEntity("Comp - P7 AttackPoint 5")))
		table.insert(Mission.P7AttackerPoints, GetPosition(FindEntity("Comp - P7 AttackPoint 6")))
	Mission.P7AttackerPaths = {}
		--table.insert(Mission.P7AttackerPaths, FindEntity("Comp - P7 AttackPath 1"))
		table.insert(Mission.P7AttackerPaths, FindEntity("Comp - P7 AttackPath 2"))
		table.insert(Mission.P7AttackerPaths, FindEntity("Comp - P7 AttackPath 3"))
		table.insert(Mission.P7AttackerPaths, FindEntity("Comp - P7 AttackPath 4"))
		table.insert(Mission.P7AttackerPaths, FindEntity("Comp - P7 AttackPath 5"))
		table.insert(Mission.P7AttackerPaths, FindEntity("Comp - P7 AttackPath 6"))
	Mission.P8AttackerPoints = {}
		--table.insert(Mission.P8AttackerPoints, GetPosition(FindEntity("Comp - P8 AttackPoint 1")))
		table.insert(Mission.P8AttackerPoints, GetPosition(FindEntity("Comp - P8 AttackPoint 2")))
		table.insert(Mission.P8AttackerPoints, GetPosition(FindEntity("Comp - P8 AttackPoint 3")))
		table.insert(Mission.P8AttackerPoints, GetPosition(FindEntity("Comp - P8 AttackPoint 4")))
		table.insert(Mission.P8AttackerPoints, GetPosition(FindEntity("Comp - P8 AttackPoint 5")))
		table.insert(Mission.P8AttackerPoints, GetPosition(FindEntity("Comp - P8 AttackPoint 6")))
	Mission.P8AttackerPaths = {}
		--table.insert(Mission.P8AttackerPaths, FindEntity("Comp - P8 AttackPath 1"))
		table.insert(Mission.P8AttackerPaths, FindEntity("Comp - P8 AttackPath 2"))
		table.insert(Mission.P8AttackerPaths, FindEntity("Comp - P8 AttackPath 3"))
		table.insert(Mission.P8AttackerPaths, FindEntity("Comp - P8 AttackPath 4"))
		table.insert(Mission.P8AttackerPaths, FindEntity("Comp - P8 AttackPath 5"))
		table.insert(Mission.P8AttackerPaths, FindEntity("Comp - P8 AttackPath 6"))

	Mission.P1AttackerUnits = {}
	Mission.P2AttackerUnits = {}
	Mission.P3AttackerUnits = {}
	Mission.P4AttackerUnits = {}
	Mission.P5AttackerUnits = {}
	Mission.P6AttackerUnits = {}
	Mission.P7AttackerUnits = {}
	Mission.P8AttackerUnits = {}

	Mission.JapTankerTMPL = luaFindHidden("Comp - Jap Troop TMPL")

	Mission.Level1UnitIDs = {}
		table.insert(Mission.Level1UnitIDs, 224) -- Japanese Tanker
	Mission.Level2UnitIDs = {}
	Mission.Level3UnitIDs = {}
	Mission.Level4UnitIDs = {}
	Mission.Level5UnitIDs = {}
	Mission.Level6UnitIDs = {}
	Mission.Level7UnitIDs = {}
	Mission.Level8UnitIDs = {}
	Mission.Level9UnitIDs = {}
	Mission.Level10UnitIDs = {}
	Mission.Level11UnitIDs = {}

	Mission.Level1UnitNames = {}
		table.insert(Mission.Level1UnitNames, "globals.unitclass_japtrooptransporter") -- Japanese Tanker
	Mission.Level2UnitNames = {}
	Mission.Level3UnitNames = {}
	Mission.Level4UnitNames = {}
	Mission.Level5UnitNames = {}
	Mission.Level6UnitNames = {}
	Mission.Level7UnitNames = {}
	Mission.Level8UnitNames = {}
	Mission.Level9UnitNames = {}
	Mission.Level10UnitNames = {}
	Mission.Level11UnitNames = {}

--[[
	Mission.Level1UnitIDsNumber = 6
	Mission.Level2UnitIDsNumber = 6
	Mission.Level3UnitIDsNumber = 5
	Mission.Level4UnitIDsNumber = 3
	Mission.Level5UnitIDsNumber = 4
	Mission.Level6UnitIDsNumber = 4
	Mission.Level7UnitIDsNumber = 3
	Mission.Level8UnitIDsNumber = 3
	Mission.Level9UnitIDsNumber = 3
	Mission.Level10UnitIDsNumber = 2
	Mission.Level11UnitIDsNumber = 2
]]
	Mission.Level1UnitIDsNumber = 3
	Mission.Level2UnitIDsNumber = 3
	Mission.Level3UnitIDsNumber = 3
	Mission.Level4UnitIDsNumber = 3
	Mission.Level5UnitIDsNumber = 3
	Mission.Level6UnitIDsNumber = 3
	Mission.Level7UnitIDsNumber = 2
	Mission.Level8UnitIDsNumber = 2
	Mission.Level9UnitIDsNumber = 2
	Mission.Level10UnitIDsNumber = 1
	Mission.Level11UnitIDsNumber = 1
	--Mission.Level12UnitIDsNumber = 4
	--Mission.Level13UnitIDsNumber = 4

	Mission.SpawnEnabled = {}
		table.insert(Mission.SpawnEnabled, true)
		table.insert(Mission.SpawnEnabled, true)
		table.insert(Mission.SpawnEnabled, true)
		table.insert(Mission.SpawnEnabled, true)
		table.insert(Mission.SpawnEnabled, true)
		table.insert(Mission.SpawnEnabled, true)
		table.insert(Mission.SpawnEnabled, true)
		table.insert(Mission.SpawnEnabled, true)

	-- jatekosok
-- RELEASE_LOGOFF  	luaLog("-- PLAYERS START --")
	Mission.Players = 0
	local players = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog(players)
-- RELEASE_LOGOFF  	luaLog("-- PLAYERS END --")
	for index, value in pairs (players) do
		if index == 0 then
			Mission.Player1 = true
			if value.ai then
-- RELEASE_LOGOFF  				luaLog("  player 1 is AI")
				SetInvincible(Mission.HQ1, 0.1)
				if value.ailevel > 3 then
					SetSkillLevel(Mission.HQ1, SKILL_ELITE)
				else
					SetSkillLevel(Mission.HQ1, SKILL_MPVETERAN)
				end
			end
			--UpdateInferiorsInRange(Mission.HQ1)
		elseif index == 1 then
			Mission.Player2 = true
			if value.ai then
-- RELEASE_LOGOFF  				luaLog("  player 2 is AI")
				SetInvincible(Mission.HQ2, 0.1)
				if value.ailevel > 3 then
					SetSkillLevel(Mission.HQ2, SKILL_ELITE)
				else
					SetSkillLevel(Mission.HQ2, SKILL_MPVETERAN)
				end
			end
			--UpdateInferiorsInRange(Mission.HQ2)
		elseif index == 2 then
			Mission.Player3 = true
			if value.ai then
-- RELEASE_LOGOFF  				luaLog("  player 3 is AI")
				SetInvincible(Mission.HQ3, 0.1)
				if value.ailevel > 3 then
					SetSkillLevel(Mission.HQ3, SKILL_ELITE)
				else
					SetSkillLevel(Mission.HQ3, SKILL_MPVETERAN)
				end
			end
			--UpdateInferiorsInRange(Mission.HQ3)
		elseif index == 3 then
			Mission.Player4 = true
			if value.ai then
-- RELEASE_LOGOFF  				luaLog("  player 4 is AI")
				SetInvincible(Mission.HQ4, 0.1)
				if value.ailevel > 3 then
					SetSkillLevel(Mission.HQ4, SKILL_ELITE)
				else
					SetSkillLevel(Mission.HQ4, SKILL_MPVETERAN)
				end
			end
			--UpdateInferiorsInRange(Mission.HQ4)
		elseif index == 4 then
			Mission.Player5 = true
			if value.ai then
-- RELEASE_LOGOFF  				luaLog("  player 5 is AI")
				SetInvincible(Mission.HQ5, 0.1)
				SetSkillLevel(Mission.HQ5, SKILL_ELITE)
			end
			--UpdateInferiorsInRange(Mission.HQ5)
		elseif index == 5 then
			Mission.Player6 = true
			if value.ai then
-- RELEASE_LOGOFF  				luaLog("  player 6 is AI")
				SetInvincible(Mission.HQ6, 0.1)
				if value.ailevel > 3 then
					SetSkillLevel(Mission.HQ6, SKILL_ELITE)
				else
					SetSkillLevel(Mission.HQ6, SKILL_MPVETERAN)
				end
			end
			--UpdateInferiorsInRange(Mission.HQ6)
		elseif index == 6 then
			Mission.Player7 = true
			if value.ai then
-- RELEASE_LOGOFF  				luaLog("  player 7 is AI")
				SetInvincible(Mission.HQ7, 0.1)
				if value.ailevel > 3 then
					SetSkillLevel(Mission.HQ7, SKILL_ELITE)
				else
					SetSkillLevel(Mission.HQ7, SKILL_MPVETERAN)
				end
			end
			--UpdateInferiorsInRange(Mission.HQ7)
		elseif index == 7 then
			Mission.Player8 = true
			if value.ai then
-- RELEASE_LOGOFF  				luaLog("  player 8 is AI")
				SetInvincible(Mission.HQ8, 0.1)
				if value.ailevel > 3 then
					SetSkillLevel(Mission.HQ8, SKILL_ELITE)
				else
					SetSkillLevel(Mission.HQ8, SKILL_MPVETERAN)
				end
			end
			--UpdateInferiorsInRange(Mission.HQ8)
		end
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)

	if not Mission.Player1 then
		SetParty(Mission.HQ1, PARTY_NEUTRAL)
		for index, unit in pairs (Mission.HQ1L1Units) do
			SetParty(unit, PARTY_NEUTRAL)
		end
	end
	if not Mission.Player2 then
		SetParty(Mission.HQ2, PARTY_NEUTRAL)
		for index, unit in pairs (Mission.HQ2L1Units) do
			SetParty(unit, PARTY_NEUTRAL)
		end
	end
	if not Mission.Player3 then
		SetParty(Mission.HQ3, PARTY_NEUTRAL)
		for index, unit in pairs (Mission.HQ3L1Units) do
			SetParty(unit, PARTY_NEUTRAL)
		end
	end
	if not Mission.Player4 then
		SetParty(Mission.HQ4, PARTY_NEUTRAL)
		for index, unit in pairs (Mission.HQ4L1Units) do
			SetParty(unit, PARTY_NEUTRAL)
		end
	end
	if not Mission.Player5 then
		SetParty(Mission.HQ5, PARTY_NEUTRAL)
		for index, unit in pairs (Mission.HQ5L1Units) do
			SetParty(unit, PARTY_NEUTRAL)
		end
	end
	if not Mission.Player6 then
		SetParty(Mission.HQ6, PARTY_NEUTRAL)
		for index, unit in pairs (Mission.HQ6L1Units) do
			SetParty(unit, PARTY_NEUTRAL)
		end
	end
	if not Mission.Player7 then
		SetParty(Mission.HQ7, PARTY_NEUTRAL)
		for index, unit in pairs (Mission.HQ7L1Units) do
			SetParty(unit, PARTY_NEUTRAL)
		end
	end
	if not Mission.Player8 then
		SetParty(Mission.HQ8, PARTY_NEUTRAL)
		for index, unit in pairs (Mission.HQ8L1Units) do
			SetParty(unit, PARTY_NEUTRAL)
		end
	end

	-- lefigyelesek

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua") -- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
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
				["ID"] = "us_obj_primary_2_player_all",
				["Text"] = "mp06.obj_comp_p2_text",
				["TextCompleted"] = "mp06.obj_comp_p2_comp",
				["TextFailed"] = "mp06.obj_comp_p2_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] =	{
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

	AISetSpawnSceneUnitsWeightMul(0)

	luaInitNewSystems()

    SetThink(this, "luaQAC6Mission_think")
end

function luaQAC6Mission_think(this, msg)
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
		--luaQAC6CheckGameTime()
		luaQAC6CheckMissionEnd()
		luaQAC6CheckPlayerLevels()
		luaQAC6CheckHQLevelUps()
		luaQAC6CheckAttacerUnits()
		luaQAC6CheckHQs()
		luaQAC6HintManager()

	elseif not Mission.Started then
		luaHQDebugger()
		luaQAC6StartMission()
		luaUpdateCounters()
		luaQAC6CheckPlayers()
	end
end

function luaHQDebugger()
	if not Mission.Player1 then
		SetParty(Mission.HQ1, PARTY_NEUTRAL)
		for index, unit in pairs (Mission.HQ1L1Units) do
			SetParty(unit, PARTY_NEUTRAL)
		end
	end
	if not Mission.Player2 then
		SetParty(Mission.HQ2, PARTY_NEUTRAL)
		for index, unit in pairs (Mission.HQ2L1Units) do
			SetParty(unit, PARTY_NEUTRAL)
		end
	end
	if not Mission.Player3 then
		SetParty(Mission.HQ3, PARTY_NEUTRAL)
		for index, unit in pairs (Mission.HQ3L1Units) do
			SetParty(unit, PARTY_NEUTRAL)
		end
	end
	if not Mission.Player4 then
		SetParty(Mission.HQ4, PARTY_NEUTRAL)
		for index, unit in pairs (Mission.HQ4L1Units) do
			SetParty(unit, PARTY_NEUTRAL)
		end
	end
	if not Mission.Player5 then
		SetParty(Mission.HQ5, PARTY_NEUTRAL)
		for index, unit in pairs (Mission.HQ5L1Units) do
			SetParty(unit, PARTY_NEUTRAL)
		end
	end
	if not Mission.Player6 then
		SetParty(Mission.HQ6, PARTY_NEUTRAL)
		for index, unit in pairs (Mission.HQ6L1Units) do
			SetParty(unit, PARTY_NEUTRAL)
		end
	end
	if not Mission.Player7 then
		SetParty(Mission.HQ7, PARTY_NEUTRAL)
		for index, unit in pairs (Mission.HQ7L1Units) do
			SetParty(unit, PARTY_NEUTRAL)
		end
	end
	if not Mission.Player8 then
		SetParty(Mission.HQ8, PARTY_NEUTRAL)
		for index, unit in pairs (Mission.HQ8L1Units) do
			SetParty(unit, PARTY_NEUTRAL)
		end
	end
	if GameTime() < 10 then
		luaDelay(luaHQDebugger, 1)
	end
end

function luaQAC6StartMission()
-- RELEASE_LOGOFF  	luaLog("  Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()			
	
	for i = 1, 8 do
		luaObj_Add("primary", i)
	end
	luaObj_Add("primary", 9)

	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	if Mission.LobbyCountDown ~= 0 then
		Countdown("mp.score_comp_time_left", 0, Mission.LobbyCountDown, "luaQAC6MissionEndTimeIsUp")
	end

	Mission.Started = true
end

function luaQAC6Randomize()
	if not Mission.Randomized then
-- RELEASE_LOGOFF  		luaLog(" Randomizing tables...")
		Mission.Randomized = true
		Mission.Random2 = luaRnd(1, 3)
		if Mission.Random2 == 1 then
			table.insert(Mission.Level2UnitNames, "globals.unitclass_val") -- Val
			table.insert(Mission.Level2UnitIDs, 158) -- Val
		elseif Mission.Random2 == 2 then
			table.insert(Mission.Level2UnitNames, "globals.unitclass_fubuki") -- Fubuki
			table.insert(Mission.Level2UnitIDs, 73) -- Fubuki
		elseif Mission.Random2 == 3 then
			table.insert(Mission.Level2UnitNames, "globals.unitclass_minekaze") -- Minekaze
			table.insert(Mission.Level2UnitIDs, 75) -- Minekaze
		end
		Mission.Random3 = luaRnd(1, 3)
		if Mission.Random3 == 1 then
			table.insert(Mission.Level3UnitNames, "globals.unitclass_judy") -- Judy
			table.insert(Mission.Level3UnitIDs, 159) -- Judy
		elseif Mission.Random3 == 2 then
			table.insert(Mission.Level3UnitNames, "globals.unitclass_fubuki") -- Fubuki
			table.insert(Mission.Level3UnitIDs, 73) -- Fubuki
		elseif Mission.Random3 == 3 then
			table.insert(Mission.Level3UnitNames, "globals.unitclass_minekaze") -- Minekaze
			table.insert(Mission.Level3UnitIDs, 75) -- Minekaze
		end
		Mission.Random4 = luaRnd(1, 3)
		if Mission.Random4 == 1 then
			table.insert(Mission.Level4UnitNames, "globals.unitclass_val") -- Val
			table.insert(Mission.Level4UnitIDs, 158) -- Val
		elseif Mission.Random4 == 2 then
			table.insert(Mission.Level4UnitNames, "globals.unitclass_judy") -- Judy
			table.insert(Mission.Level4UnitIDs, 159) -- Judy
		elseif Mission.Random4 == 3 then
			table.insert(Mission.Level4UnitNames, "globals.unitclass_fubuki") -- Fubuki
			table.insert(Mission.Level4UnitIDs, 73) -- Fubuki
		end
		Mission.Random5 = luaRnd(1, 3)
		if Mission.Random5 == 1 then
			table.insert(Mission.Level5UnitNames, "globals.unitclass_kamikazeval") -- Kamikaze Val
			table.insert(Mission.Level5UnitIDs, 46) -- Kamikaze Val
		elseif Mission.Random5 == 2 then
			table.insert(Mission.Level5UnitNames, "globals.unitclass_kuma") -- Kuma
			table.insert(Mission.Level5UnitIDs, 70) -- Kuma
		elseif Mission.Random5 == 3 then
			table.insert(Mission.Level5UnitNames, "globals.unitclass_agano") -- Agano
			table.insert(Mission.Level5UnitIDs, 71) -- Agano
		end
		Mission.Random6 = luaRnd(1, 3)
		if Mission.Random6 == 1 then
			table.insert(Mission.Level6UnitNames, "globals.unitclass_kamikazeval") -- Kamikaze Val
			table.insert(Mission.Level6UnitIDs, 46) -- Kamikaze Val
		elseif Mission.Random6 == 2 then
			table.insert(Mission.Level6UnitNames, "globals.unitclass_kuma") -- Kuma
			table.insert(Mission.Level6UnitIDs, 70) -- Kuma
		elseif Mission.Random6 == 3 then
			table.insert(Mission.Level6UnitNames, "globals.unitclass_agano") -- Agano
			table.insert(Mission.Level6UnitIDs, 71) -- Agano
		end
		Mission.Random7 = luaRnd(1, 3)
		if Mission.Random7 == 1 then
			table.insert(Mission.Level7UnitNames, "globals.unitclass_mogami") -- Mogami
			table.insert(Mission.Level7UnitIDs, 67) -- Mogami
		elseif Mission.Random7 == 2 then
			table.insert(Mission.Level7UnitNames, "globals.unitclass_kuma") -- Kuma
			table.insert(Mission.Level7UnitIDs, 70) -- Kuma
		elseif Mission.Random7 == 3 then
			table.insert(Mission.Level7UnitNames, "globals.unitclass_agano") -- Agano
			table.insert(Mission.Level7UnitIDs, 71) -- Agano
		end
		Mission.Random8 = luaRnd(1, 3)
		if Mission.Random8 == 1 then
			table.insert(Mission.Level8UnitNames, "globals.unitclass_mogami") -- Mogami
			table.insert(Mission.Level8UnitIDs, 67) -- Mogami
		elseif Mission.Random8 == 2 then
			table.insert(Mission.Level8UnitNames, "globals.unitclass_tone") -- Tone
			table.insert(Mission.Level8UnitIDs, 68) -- Tone
		elseif Mission.Random8 == 3 then
			table.insert(Mission.Level8UnitNames, "globals.unitclass_agano") -- Agano
			table.insert(Mission.Level8UnitIDs, 71) -- Agano
		end
		Mission.Random9 = luaRnd(1, 3)
		if Mission.Random9 == 1 then
			table.insert(Mission.Level9UnitNames, "globals.unitclass_mogami") -- Mogami
			table.insert(Mission.Level9UnitIDs, 67) -- Mogami
		elseif Mission.Random9 == 2 then
			table.insert(Mission.Level9UnitNames, "globals.unitclass_tone") -- Tone
			table.insert(Mission.Level9UnitIDs, 68) -- Tone
		elseif Mission.Random9 == 3 then
			table.insert(Mission.Level9UnitNames, "globals.unitclass_agano") -- Agano
			table.insert(Mission.Level9UnitIDs, 71) -- Agano
		end
		Mission.Random10 = luaRnd(1, 3)
		if Mission.Random10 == 1 then
			table.insert(Mission.Level10UnitNames, "globals.unitclass_kongo") -- Kongo
			table.insert(Mission.Level10UnitIDs, 60) -- Kongo
		elseif Mission.Random10 == 2 then
			table.insert(Mission.Level10UnitNames, "globals.unitclass_fuso") -- Fuso
			table.insert(Mission.Level10UnitIDs, 61) -- Fuso
		elseif Mission.Random10 == 3 then
			table.insert(Mission.Level10UnitNames, "globals.unitclass_yamato") -- Fuso
			table.insert(Mission.Level10UnitIDs, 59) -- Yamato
		end
		Mission.Random11 = luaRnd(1, 3)
		if Mission.Random11 == 1 then
			table.insert(Mission.Level11UnitNames, "globals.unitclass_kongo") -- Kongo
			table.insert(Mission.Level11UnitIDs, 60) -- Kongo
		elseif Mission.Random11 == 2 then
			table.insert(Mission.Level11UnitNames, "globals.unitclass_fuso") -- Fuso
			table.insert(Mission.Level11UnitIDs, 61) -- Fuso
		elseif Mission.Random11 == 3 then
			table.insert(Mission.Level11UnitNames, "globals.unitclass_yamato") -- Fuso
			table.insert(Mission.Level11UnitIDs, 59) -- Yamato
		end
-- RELEASE_LOGOFF  		luaLog(" R2:"..tostring(Mission.Random2).." R3:"..tostring(Mission.Random3).." R4:"..tostring(Mission.Random4).." R5:"..tostring(Mission.Random5).." R6:"..tostring(Mission.Random6).." R7:"..tostring(Mission.Random7).." R8:"..tostring(Mission.Random8).." R9:"..tostring(Mission.Random9).." R10:"..tostring(Mission.Random10).." R11:"..tostring(Mission.Random11))
	
		if Mission.Random5 == 1 then
-- RELEASE_LOGOFF  			luaLog("  modifying Mission.Level5UnitIDsNumber")
			Mission.Level5UnitIDsNumber = 4
		end
		if Mission.Random6 == 1 then
-- RELEASE_LOGOFF  			luaLog("  modifying Mission.Level6UnitIDsNumber")
			Mission.Level6UnitIDsNumber = 4
		end
		if Mission.Random9 == 3 then
-- RELEASE_LOGOFF  			luaLog("  modifying Mission.Level9UnitIDsNumber")
			Mission.Level9UnitIDsNumber = 1
		end
	end
end

function luaQAC6CheckPlayerLevels()
-- RELEASE_LOGOFF  	luaLog(" Checking player levels...")
	if Mission.Player1 then
		--luaLog("  player 1 present")
		Mission.P1AttackerUnits = luaRemoveDeadsFromTable(Mission.P1AttackerUnits)
		if table.getn(Mission.P1AttackerUnits) == 0 and Mission.HQ1.Party == PARTY_ALLIED and Mission.SpawnEnabled[1] then
			luaQAC6Randomize()
			MissionNarrativePlayer(0, "mp06.nar_comp_incoming")
			if Mission.PlayerLevels[1] == 1 then
				for i = 1, Mission.Level1UnitIDsNumber do
					local tanker = GenerateObject(Mission.JapTankerTMPL.Name, Mission.P1AttackerPoints[i])
					luaQAC6UnitSpawnedP1(tanker)
					--luaQAC6SpawnUnitP1(Mission.P1AttackerPoints[i], Mission.Level1UnitIDs[1], Mission.Level1UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[1] == 2 then
				for i = 1, Mission.Level2UnitIDsNumber do
					luaQAC6SpawnUnitP1(Mission.P1AttackerPoints[i], Mission.Level2UnitIDs[1], Mission.Level2UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[1] == 3 then
				for i = 1, Mission.Level3UnitIDsNumber do
					luaQAC6SpawnUnitP1(Mission.P1AttackerPoints[i], Mission.Level3UnitIDs[1], Mission.Level3UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[1] == 4 then
				for i = 1, Mission.Level4UnitIDsNumber do
					luaQAC6SpawnUnitP1(Mission.P1AttackerPoints[i], Mission.Level4UnitIDs[1], Mission.Level4UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[1] == 5 then
				for i = 1, Mission.Level5UnitIDsNumber do
					luaQAC6SpawnUnitP1(Mission.P1AttackerPoints[i], Mission.Level5UnitIDs[1], Mission.Level5UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[1] == 6 then
				for i = 1, Mission.Level6UnitIDsNumber do
					luaQAC6SpawnUnitP1(Mission.P1AttackerPoints[i], Mission.Level6UnitIDs[1], Mission.Level6UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[1] == 7 then
				for i = 1, Mission.Level7UnitIDsNumber do
					luaQAC6SpawnUnitP1(Mission.P1AttackerPoints[i], Mission.Level7UnitIDs[1], Mission.Level7UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[1] == 8 then
				for i = 1, Mission.Level8UnitIDsNumber do
					luaQAC6SpawnUnitP1(Mission.P1AttackerPoints[i], Mission.Level8UnitIDs[1], Mission.Level8UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[1] == 9 then
				for i = 1, Mission.Level9UnitIDsNumber do
					luaQAC6SpawnUnitP1(Mission.P1AttackerPoints[i], Mission.Level9UnitIDs[1], Mission.Level9UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[1] == 10 then
				for i = 1, Mission.Level10UnitIDsNumber do
					luaQAC6SpawnUnitP1(Mission.P1AttackerPoints[i], Mission.Level10UnitIDs[1], Mission.Level10UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[1] == 11 then
				for i = 1, Mission.Level11UnitIDsNumber do
					luaQAC6SpawnUnitP1(Mission.P1AttackerPoints[i], Mission.Level11UnitIDs[1], Mission.Level11UnitNames[1], 1, 1)
				end
--[[
			elseif Mission.PlayerLevels[1] == 12 then
				for i = 1, Mission.Level12UnitIDsNumber do
					luaQAC6SpawnUnitP1(Mission.P1AttackerPoints[i], Mission.Level12UnitIDs[1], Mission.Level12UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[1] == 13 then

			elseif Mission.PlayerLevels[1] == 12 then
				Mission.PlayerLevels[1] = 9
]]
			end
			if Mission.PlayerLevels[1] == 11 then
				Mission.PlayerLevels[1] = 4
			else
				Mission.PlayerLevels[1] = Mission.PlayerLevels[1] + 1
			end
-- RELEASE_LOGOFF  			luaLog("  spawning finished for P1, next level: "..tostring(Mission.PlayerLevels[1]))
			Mission.SpawnEnabled[1] = false
			luaDelay(luaQAC6EnableSpawn1, 25)
		end
	end

	if Mission.Player2 then
		--luaLog("  player 2 present")
		Mission.P2AttackerUnits = luaRemoveDeadsFromTable(Mission.P2AttackerUnits)
		if table.getn(Mission.P2AttackerUnits) == 0 and Mission.HQ2.Party == PARTY_ALLIED and Mission.SpawnEnabled[2] then
			luaQAC6Randomize()
			MissionNarrativePlayer(1, "mp06.nar_comp_incoming")
			if Mission.PlayerLevels[2] == 1 then
				for i = 1, Mission.Level1UnitIDsNumber do
					local tanker = GenerateObject(Mission.JapTankerTMPL.Name, Mission.P2AttackerPoints[i])
					luaQAC6UnitSpawnedP2(tanker)
					--luaQAC6SpawnUnitP2(Mission.P2AttackerPoints[i], Mission.Level1UnitIDs[1], Mission.Level1UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[2] == 2 then
				for i = 1, Mission.Level2UnitIDsNumber do
					luaQAC6SpawnUnitP2(Mission.P2AttackerPoints[i], Mission.Level2UnitIDs[1], Mission.Level2UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[2] == 3 then
				for i = 1, Mission.Level3UnitIDsNumber do
					luaQAC6SpawnUnitP2(Mission.P2AttackerPoints[i], Mission.Level3UnitIDs[1], Mission.Level3UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[2] == 4 then
				for i = 1, Mission.Level4UnitIDsNumber do
					luaQAC6SpawnUnitP2(Mission.P2AttackerPoints[i], Mission.Level4UnitIDs[1], Mission.Level4UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[2] == 5 then
				for i = 1, Mission.Level5UnitIDsNumber do
					luaQAC6SpawnUnitP2(Mission.P2AttackerPoints[i], Mission.Level5UnitIDs[1], Mission.Level5UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[2] == 6 then
				for i = 1, Mission.Level6UnitIDsNumber do
					luaQAC6SpawnUnitP2(Mission.P2AttackerPoints[i], Mission.Level6UnitIDs[1], Mission.Level6UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[2] == 7 then
				for i = 1, Mission.Level7UnitIDsNumber do
					luaQAC6SpawnUnitP2(Mission.P2AttackerPoints[i], Mission.Level7UnitIDs[1], Mission.Level7UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[2] == 8 then
				for i = 1, Mission.Level8UnitIDsNumber do
					luaQAC6SpawnUnitP2(Mission.P2AttackerPoints[i], Mission.Level8UnitIDs[1], Mission.Level8UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[2] == 9 then
				for i = 1, Mission.Level9UnitIDsNumber do
					luaQAC6SpawnUnitP2(Mission.P2AttackerPoints[i], Mission.Level9UnitIDs[1], Mission.Level9UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[2] == 10 then
				for i = 1, Mission.Level10UnitIDsNumber do
					luaQAC6SpawnUnitP2(Mission.P2AttackerPoints[i], Mission.Level10UnitIDs[1], Mission.Level10UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[2] == 11 then
				for i = 1, Mission.Level11UnitIDsNumber do
					luaQAC6SpawnUnitP2(Mission.P2AttackerPoints[i], Mission.Level11UnitIDs[1], Mission.Level11UnitNames[1], 1, 1)
				end
--[[
			elseif Mission.PlayerLevels[2] == 12 then
				for i = 1, Mission.Level12UnitIDsNumber do
					luaQAC6SpawnUnitP2(Mission.P2AttackerPoints[i], Mission.Level12UnitIDs[1], Mission.Level12UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[2] == 13 then

			elseif Mission.PlayerLevels[2] == 12 then
				Mission.PlayerLevels[2] = 9
]]
			end
			if Mission.PlayerLevels[2] == 11 then
				Mission.PlayerLevels[2] = 4
			else
				Mission.PlayerLevels[2] = Mission.PlayerLevels[2] + 1
			end
-- RELEASE_LOGOFF  			luaLog("  spawning finished for P2, next level: "..tostring(Mission.PlayerLevels[2]))
			Mission.SpawnEnabled[2] = false
			luaDelay(luaQAC6EnableSpawn2, 25)
		end
	end

	if Mission.Player3 then
		--luaLog("  player 3 present")
		Mission.P3AttackerUnits = luaRemoveDeadsFromTable(Mission.P3AttackerUnits)
		if table.getn(Mission.P3AttackerUnits) == 0 and Mission.HQ3.Party == PARTY_ALLIED and Mission.SpawnEnabled[3] then
			luaQAC6Randomize()
			MissionNarrativePlayer(2, "mp06.nar_comp_incoming")
			if Mission.PlayerLevels[3] == 1 then
				for i = 1, Mission.Level1UnitIDsNumber do
					local tanker = GenerateObject(Mission.JapTankerTMPL.Name, Mission.P3AttackerPoints[i])
					luaQAC6UnitSpawnedP3(tanker)
					--luaQAC6SpawnUnitP3(Mission.P3AttackerPoints[i], Mission.Level1UnitIDs[1], Mission.Level1UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[3] == 2 then
				for i = 1, Mission.Level2UnitIDsNumber do
					luaQAC6SpawnUnitP3(Mission.P3AttackerPoints[i], Mission.Level2UnitIDs[1], Mission.Level2UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[3] == 3 then
				for i = 1, Mission.Level3UnitIDsNumber do
					luaQAC6SpawnUnitP3(Mission.P3AttackerPoints[i], Mission.Level3UnitIDs[1], Mission.Level3UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[3] == 4 then
				for i = 1, Mission.Level4UnitIDsNumber do
					luaQAC6SpawnUnitP3(Mission.P3AttackerPoints[i], Mission.Level4UnitIDs[1], Mission.Level4UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[3] == 5 then
				for i = 1, Mission.Level5UnitIDsNumber do
					luaQAC6SpawnUnitP3(Mission.P3AttackerPoints[i], Mission.Level5UnitIDs[1], Mission.Level5UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[3] == 6 then
				for i = 1, Mission.Level6UnitIDsNumber do
					luaQAC6SpawnUnitP3(Mission.P3AttackerPoints[i], Mission.Level6UnitIDs[1], Mission.Level6UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[3] == 7 then
				for i = 1, Mission.Level7UnitIDsNumber do
					luaQAC6SpawnUnitP3(Mission.P3AttackerPoints[i], Mission.Level7UnitIDs[1], Mission.Level7UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[3] == 8 then
				for i = 1, Mission.Level8UnitIDsNumber do
					luaQAC6SpawnUnitP3(Mission.P3AttackerPoints[i], Mission.Level8UnitIDs[1], Mission.Level8UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[3] == 9 then
				for i = 1, Mission.Level9UnitIDsNumber do
					luaQAC6SpawnUnitP3(Mission.P3AttackerPoints[i], Mission.Level9UnitIDs[1], Mission.Level9UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[3] == 10 then
				for i = 1, Mission.Level10UnitIDsNumber do
					luaQAC6SpawnUnitP3(Mission.P3AttackerPoints[i], Mission.Level10UnitIDs[1], Mission.Level10UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[3] == 11 then
				for i = 1, Mission.Level11UnitIDsNumber do
					luaQAC6SpawnUnitP3(Mission.P3AttackerPoints[i], Mission.Level11UnitIDs[1], Mission.Level11UnitNames[1], 1, 1)
				end
--[[
			elseif Mission.PlayerLevels[3] == 12 then
				for i = 1, Mission.Level12UnitIDsNumber do
					luaQAC6SpawnUnitP3(Mission.P3AttackerPoints[i], Mission.Level12UnitIDs[1], Mission.Level12UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[3] == 13 then

			elseif Mission.PlayerLevels[3] == 12 then
				Mission.PlayerLevels[3] = 9
]]
			end
			if Mission.PlayerLevels[3] == 11 then
				Mission.PlayerLevels[3] = 4
			else
				Mission.PlayerLevels[3] = Mission.PlayerLevels[3] + 1
			end
-- RELEASE_LOGOFF  			luaLog("  spawning finished for P3, next level: "..tostring(Mission.PlayerLevels[3]))
			Mission.SpawnEnabled[3] = false
			luaDelay(luaQAC6EnableSpawn3, 25)
		end
	end

	if Mission.Player4 then
		--luaLog("  player 4 present")
		Mission.P4AttackerUnits = luaRemoveDeadsFromTable(Mission.P4AttackerUnits)
		if table.getn(Mission.P4AttackerUnits) == 0 and Mission.HQ4.Party == PARTY_ALLIED and Mission.SpawnEnabled[4] then
			luaQAC6Randomize()
			MissionNarrativePlayer(3, "mp06.nar_comp_incoming")
			if Mission.PlayerLevels[4] == 1 then
				for i = 1, Mission.Level1UnitIDsNumber do
					local tanker = GenerateObject(Mission.JapTankerTMPL.Name, Mission.P4AttackerPoints[i])
					luaQAC6UnitSpawnedP4(tanker)
					--luaQAC6SpawnUnitP4(Mission.P4AttackerPoints[i], Mission.Level1UnitIDs[1], Mission.Level1UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[4] == 2 then
				for i = 1, Mission.Level2UnitIDsNumber do
					luaQAC6SpawnUnitP4(Mission.P4AttackerPoints[i], Mission.Level2UnitIDs[1], Mission.Level2UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[4] == 3 then
				for i = 1, Mission.Level3UnitIDsNumber do
					luaQAC6SpawnUnitP4(Mission.P4AttackerPoints[i], Mission.Level3UnitIDs[1], Mission.Level3UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[4] == 4 then
				for i = 1, Mission.Level4UnitIDsNumber do
					luaQAC6SpawnUnitP4(Mission.P4AttackerPoints[i], Mission.Level4UnitIDs[1], Mission.Level4UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[4] == 5 then
				for i = 1, Mission.Level5UnitIDsNumber do
					luaQAC6SpawnUnitP4(Mission.P4AttackerPoints[i], Mission.Level5UnitIDs[1], Mission.Level5UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[4] == 6 then
				for i = 1, Mission.Level6UnitIDsNumber do
					luaQAC6SpawnUnitP4(Mission.P4AttackerPoints[i], Mission.Level6UnitIDs[1], Mission.Level6UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[4] == 7 then
				for i = 1, Mission.Level7UnitIDsNumber do
					luaQAC6SpawnUnitP4(Mission.P4AttackerPoints[i], Mission.Level7UnitIDs[1], Mission.Level7UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[4] == 8 then
				for i = 1, Mission.Level8UnitIDsNumber do
					luaQAC6SpawnUnitP4(Mission.P4AttackerPoints[i], Mission.Level8UnitIDs[1], Mission.Level8UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[4] == 9 then
				for i = 1, Mission.Level9UnitIDsNumber do
					luaQAC6SpawnUnitP4(Mission.P4AttackerPoints[i], Mission.Level9UnitIDs[1], Mission.Level9UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[4] == 10 then
				for i = 1, Mission.Level10UnitIDsNumber do
					luaQAC6SpawnUnitP4(Mission.P4AttackerPoints[i], Mission.Level10UnitIDs[1], Mission.Level10UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[4] == 11 then
				for i = 1, Mission.Level11UnitIDsNumber do
					luaQAC6SpawnUnitP4(Mission.P4AttackerPoints[i], Mission.Level11UnitIDs[1], Mission.Level11UnitNames[1], 1, 1)
				end
--[[
			elseif Mission.PlayerLevels[4] == 12 then
				for i = 1, Mission.Level12UnitIDsNumber do
					luaQAC6SpawnUnitP4(Mission.P4AttackerPoints[i], Mission.Level12UnitIDs[1], Mission.Level12UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[4] == 13 then

			elseif Mission.PlayerLevels[4] == 12 then
				Mission.PlayerLevels[4] = 9
]]
			end
			if Mission.PlayerLevels[4] == 11 then
				Mission.PlayerLevels[4] = 4
			else
				Mission.PlayerLevels[4] = Mission.PlayerLevels[4] + 1
			end
-- RELEASE_LOGOFF  			luaLog("  spawning finished for P4, next level: "..tostring(Mission.PlayerLevels[4]))
			Mission.SpawnEnabled[4] = false
			luaDelay(luaQAC6EnableSpawn4, 25)
		end
	end

	if Mission.Player5 then
		--luaLog("  player 5 present")
		Mission.P5AttackerUnits = luaRemoveDeadsFromTable(Mission.P5AttackerUnits)
		if table.getn(Mission.P5AttackerUnits) == 0 and Mission.HQ5.Party == PARTY_ALLIED and Mission.SpawnEnabled[5] then
			luaQAC6Randomize()
			MissionNarrativePlayer(4, "mp06.nar_comp_incoming")
			if Mission.PlayerLevels[5] == 1 then
				for i = 1, Mission.Level1UnitIDsNumber do
					local tanker = GenerateObject(Mission.JapTankerTMPL.Name, Mission.P5AttackerPoints[i])
					luaQAC6UnitSpawnedP5(tanker)
					--luaQAC6SpawnUnitP5(Mission.P5AttackerPoints[i], Mission.Level1UnitIDs[1], Mission.Level1UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[5] == 2 then
				for i = 1, Mission.Level2UnitIDsNumber do
					luaQAC6SpawnUnitP5(Mission.P5AttackerPoints[i], Mission.Level2UnitIDs[1], Mission.Level2UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[5] == 3 then
				for i = 1, Mission.Level3UnitIDsNumber do
					luaQAC6SpawnUnitP5(Mission.P5AttackerPoints[i], Mission.Level3UnitIDs[1], Mission.Level3UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[5] == 4 then
				for i = 1, Mission.Level4UnitIDsNumber do
					luaQAC6SpawnUnitP5(Mission.P5AttackerPoints[i], Mission.Level4UnitIDs[1], Mission.Level4UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[5] == 5 then
				for i = 1, Mission.Level5UnitIDsNumber do
					luaQAC6SpawnUnitP5(Mission.P5AttackerPoints[i], Mission.Level5UnitIDs[1], Mission.Level5UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[5] == 6 then
				for i = 1, Mission.Level6UnitIDsNumber do
					luaQAC6SpawnUnitP5(Mission.P5AttackerPoints[i], Mission.Level6UnitIDs[1], Mission.Level6UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[5] == 7 then
				for i = 1, Mission.Level7UnitIDsNumber do
					luaQAC6SpawnUnitP5(Mission.P5AttackerPoints[i], Mission.Level7UnitIDs[1], Mission.Level7UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[5] == 8 then
				for i = 1, Mission.Level8UnitIDsNumber do
					luaQAC6SpawnUnitP5(Mission.P5AttackerPoints[i], Mission.Level8UnitIDs[1], Mission.Level8UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[5] == 9 then
				for i = 1, Mission.Level9UnitIDsNumber do
					luaQAC6SpawnUnitP5(Mission.P5AttackerPoints[i], Mission.Level9UnitIDs[1], Mission.Level9UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[5] == 10 then
				for i = 1, Mission.Level10UnitIDsNumber do
					luaQAC6SpawnUnitP5(Mission.P5AttackerPoints[i], Mission.Level10UnitIDs[1], Mission.Level10UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[5] == 11 then
				for i = 1, Mission.Level11UnitIDsNumber do
					luaQAC6SpawnUnitP5(Mission.P5AttackerPoints[i], Mission.Level11UnitIDs[1], Mission.Level11UnitNames[1], 1, 1)
				end
--[[
			elseif Mission.PlayerLevels[5] == 12 then
				for i = 1, Mission.Level12UnitIDsNumber do
					luaQAC6SpawnUnitP5(Mission.P5AttackerPoints[i], Mission.Level12UnitIDs[1], Mission.Level12UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[5] == 13 then

			elseif Mission.PlayerLevels[5] == 12 then
				Mission.PlayerLevels[5] = 9
]]
			end
			if Mission.PlayerLevels[5] == 11 then
				Mission.PlayerLevels[5] = 4
			else
				Mission.PlayerLevels[5] = Mission.PlayerLevels[5] + 1
			end
-- RELEASE_LOGOFF  			luaLog("  spawning finished for P5, next level: "..tostring(Mission.PlayerLevels[5]))
			Mission.SpawnEnabled[5] = false
			luaDelay(luaQAC6EnableSpawn5, 25)
		end
	end

	if Mission.Player6 then
		--luaLog("  player 6 present")
		Mission.P6AttackerUnits = luaRemoveDeadsFromTable(Mission.P6AttackerUnits)
		if table.getn(Mission.P6AttackerUnits) == 0 and Mission.HQ6.Party == PARTY_ALLIED and Mission.SpawnEnabled[6] then
			luaQAC6Randomize()
			MissionNarrativePlayer(5, "mp06.nar_comp_incoming")
			if Mission.PlayerLevels[6] == 1 then
				for i = 1, Mission.Level1UnitIDsNumber do
					local tanker = GenerateObject(Mission.JapTankerTMPL.Name, Mission.P6AttackerPoints[i])
					luaQAC6UnitSpawnedP6(tanker)
					--luaQAC6SpawnUnitP6(Mission.P6AttackerPoints[i], Mission.Level1UnitIDs[1], Mission.Level1UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[6] == 2 then
				for i = 1, Mission.Level2UnitIDsNumber do
					luaQAC6SpawnUnitP6(Mission.P6AttackerPoints[i], Mission.Level2UnitIDs[1], Mission.Level2UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[6] == 3 then
				for i = 1, Mission.Level3UnitIDsNumber do
					luaQAC6SpawnUnitP6(Mission.P6AttackerPoints[i], Mission.Level3UnitIDs[1], Mission.Level3UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[6] == 4 then
				for i = 1, Mission.Level4UnitIDsNumber do
					luaQAC6SpawnUnitP6(Mission.P6AttackerPoints[i], Mission.Level4UnitIDs[1], Mission.Level4UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[6] == 5 then
				for i = 1, Mission.Level5UnitIDsNumber do
					luaQAC6SpawnUnitP6(Mission.P6AttackerPoints[i], Mission.Level5UnitIDs[1], Mission.Level5UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[6] == 6 then
				for i = 1, Mission.Level6UnitIDsNumber do
					luaQAC6SpawnUnitP6(Mission.P6AttackerPoints[i], Mission.Level6UnitIDs[1], Mission.Level6UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[6] == 7 then
				for i = 1, Mission.Level7UnitIDsNumber do
					luaQAC6SpawnUnitP6(Mission.P6AttackerPoints[i], Mission.Level7UnitIDs[1], Mission.Level7UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[6] == 8 then
				for i = 1, Mission.Level8UnitIDsNumber do
					luaQAC6SpawnUnitP6(Mission.P6AttackerPoints[i], Mission.Level8UnitIDs[1], Mission.Level8UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[6] == 9 then
				for i = 1, Mission.Level9UnitIDsNumber do
					luaQAC6SpawnUnitP6(Mission.P6AttackerPoints[i], Mission.Level9UnitIDs[1], Mission.Level9UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[6] == 10 then
				for i = 1, Mission.Level10UnitIDsNumber do
					luaQAC6SpawnUnitP6(Mission.P6AttackerPoints[i], Mission.Level10UnitIDs[1], Mission.Level10UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[6] == 11 then
				for i = 1, Mission.Level11UnitIDsNumber do
					luaQAC6SpawnUnitP6(Mission.P6AttackerPoints[i], Mission.Level11UnitIDs[1], Mission.Level11UnitNames[1], 1, 1)
				end
--[[
			elseif Mission.PlayerLevels[6] == 12 then
				for i = 1, Mission.Level12UnitIDsNumber do
					luaQAC6SpawnUnitP6(Mission.P6AttackerPoints[i], Mission.Level12UnitIDs[1], Mission.Level12UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[6] == 13 then

			elseif Mission.PlayerLevels[6] == 12 then
				Mission.PlayerLevels[6] = 9
]]
			end
			if Mission.PlayerLevels[6] == 11 then
				Mission.PlayerLevels[6] = 4
			else
				Mission.PlayerLevels[6] = Mission.PlayerLevels[6] + 1
			end
-- RELEASE_LOGOFF  			luaLog("  spawning finished for P6, next level: "..tostring(Mission.PlayerLevels[6]))
			Mission.SpawnEnabled[6] = false
			luaDelay(luaQAC6EnableSpawn6, 25)
		end
	end

	if Mission.Player7 then
		--luaLog("  player 7 present")
		Mission.P7AttackerUnits = luaRemoveDeadsFromTable(Mission.P7AttackerUnits)
		if table.getn(Mission.P7AttackerUnits) == 0 and Mission.HQ7.Party == PARTY_ALLIED and Mission.SpawnEnabled[7] then
			luaQAC6Randomize()
			MissionNarrativePlayer(6, "mp06.nar_comp_incoming")
			if Mission.PlayerLevels[7] == 1 then
				for i = 1, Mission.Level1UnitIDsNumber do
					local tanker = GenerateObject(Mission.JapTankerTMPL.Name, Mission.P7AttackerPoints[i])
					luaQAC6UnitSpawnedP7(tanker)
					--luaQAC6SpawnUnitP7(Mission.P7AttackerPoints[i], Mission.Level1UnitIDs[1], Mission.Level1UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[7] == 2 then
				for i = 1, Mission.Level2UnitIDsNumber do
					luaQAC6SpawnUnitP7(Mission.P7AttackerPoints[i], Mission.Level2UnitIDs[1], Mission.Level2UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[7] == 3 then
				for i = 1, Mission.Level3UnitIDsNumber do
					luaQAC6SpawnUnitP7(Mission.P7AttackerPoints[i], Mission.Level3UnitIDs[1], Mission.Level3UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[7] == 4 then
				for i = 1, Mission.Level4UnitIDsNumber do
					luaQAC6SpawnUnitP7(Mission.P7AttackerPoints[i], Mission.Level4UnitIDs[1], Mission.Level4UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[7] == 5 then
				for i = 1, Mission.Level5UnitIDsNumber do
					luaQAC6SpawnUnitP7(Mission.P7AttackerPoints[i], Mission.Level5UnitIDs[1], Mission.Level5UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[7] == 6 then
				for i = 1, Mission.Level6UnitIDsNumber do
					luaQAC6SpawnUnitP7(Mission.P7AttackerPoints[i], Mission.Level6UnitIDs[1], Mission.Level6UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[7] == 7 then
				for i = 1, Mission.Level7UnitIDsNumber do
					luaQAC6SpawnUnitP7(Mission.P7AttackerPoints[i], Mission.Level7UnitIDs[1], Mission.Level7UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[7] == 8 then
				for i = 1, Mission.Level8UnitIDsNumber do
					luaQAC6SpawnUnitP7(Mission.P7AttackerPoints[i], Mission.Level8UnitIDs[1], Mission.Level8UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[7] == 9 then
				for i = 1, Mission.Level9UnitIDsNumber do
					luaQAC6SpawnUnitP7(Mission.P7AttackerPoints[i], Mission.Level9UnitIDs[1], Mission.Level9UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[7] == 10 then
				for i = 1, Mission.Level10UnitIDsNumber do
					luaQAC6SpawnUnitP7(Mission.P7AttackerPoints[i], Mission.Level10UnitIDs[1], Mission.Level10UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[7] == 11 then
				for i = 1, Mission.Level11UnitIDsNumber do
					luaQAC6SpawnUnitP7(Mission.P7AttackerPoints[i], Mission.Level11UnitIDs[1], Mission.Level11UnitNames[1], 1, 1)
				end
--[[
			elseif Mission.PlayerLevels[7] == 12 then
				for i = 1, Mission.Level12UnitIDsNumber do
					luaQAC6SpawnUnitP7(Mission.P7AttackerPoints[i], Mission.Level12UnitIDs[1], Mission.Level12UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[7] == 13 then

			elseif Mission.PlayerLevels[7] == 12 then
				Mission.PlayerLevels[7] = 9
]]
			end
			if Mission.PlayerLevels[7] == 11 then
				Mission.PlayerLevels[7] = 4
			else
				Mission.PlayerLevels[7] = Mission.PlayerLevels[7] + 1
			end
-- RELEASE_LOGOFF  			luaLog("  spawning finished for P7, next level: "..tostring(Mission.PlayerLevels[7]))
			Mission.SpawnEnabled[7] = false
			luaDelay(luaQAC6EnableSpawn7, 25)
		end
	end

	if Mission.Player8 then
		--luaLog("  player 8 present")
		Mission.P8AttackerUnits = luaRemoveDeadsFromTable(Mission.P8AttackerUnits)
		if table.getn(Mission.P8AttackerUnits) == 0 and Mission.HQ8.Party == PARTY_ALLIED and Mission.SpawnEnabled[8] then
			luaQAC6Randomize()
			MissionNarrativePlayer(7, "mp06.nar_comp_incoming")
			if Mission.PlayerLevels[8] == 1 then
				for i = 1, Mission.Level1UnitIDsNumber do
					local tanker = GenerateObject(Mission.JapTankerTMPL.Name, Mission.P8AttackerPoints[i])
					luaQAC6UnitSpawnedP8(tanker)
					--luaQAC6SpawnUnitP8(Mission.P8AttackerPoints[i], Mission.Level1UnitIDs[1], Mission.Level1UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[8] == 2 then
				for i = 1, Mission.Level2UnitIDsNumber do
					luaQAC6SpawnUnitP8(Mission.P8AttackerPoints[i], Mission.Level2UnitIDs[1], Mission.Level2UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[8] == 3 then
				for i = 1, Mission.Level3UnitIDsNumber do
					luaQAC6SpawnUnitP8(Mission.P8AttackerPoints[i], Mission.Level3UnitIDs[1], Mission.Level3UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[8] == 4 then
				for i = 1, Mission.Level4UnitIDsNumber do
					luaQAC6SpawnUnitP8(Mission.P8AttackerPoints[i], Mission.Level4UnitIDs[1], Mission.Level4UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[8] == 5 then
				for i = 1, Mission.Level5UnitIDsNumber do
					luaQAC6SpawnUnitP8(Mission.P8AttackerPoints[i], Mission.Level5UnitIDs[1], Mission.Level5UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[8] == 6 then
				for i = 1, Mission.Level6UnitIDsNumber do
					luaQAC6SpawnUnitP8(Mission.P8AttackerPoints[i], Mission.Level6UnitIDs[1], Mission.Level6UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[8] == 7 then
				for i = 1, Mission.Level7UnitIDsNumber do
					luaQAC6SpawnUnitP8(Mission.P8AttackerPoints[i], Mission.Level7UnitIDs[1], Mission.Level7UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[8] == 8 then
				for i = 1, Mission.Level8UnitIDsNumber do
					luaQAC6SpawnUnitP8(Mission.P8AttackerPoints[i], Mission.Level8UnitIDs[1], Mission.Level8UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[8] == 9 then
				for i = 1, Mission.Level9UnitIDsNumber do
					luaQAC6SpawnUnitP8(Mission.P8AttackerPoints[i], Mission.Level9UnitIDs[1], Mission.Level9UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[8] == 10 then
				for i = 1, Mission.Level10UnitIDsNumber do
					luaQAC6SpawnUnitP8(Mission.P8AttackerPoints[i], Mission.Level10UnitIDs[1], Mission.Level10UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[8] == 11 then
				for i = 1, Mission.Level11UnitIDsNumber do
					luaQAC6SpawnUnitP8(Mission.P8AttackerPoints[i], Mission.Level11UnitIDs[1], Mission.Level11UnitNames[1], 1, 1)
				end
--[[
			elseif Mission.PlayerLevels[8] == 12 then
				for i = 1, Mission.Level12UnitIDsNumber do
					luaQAC6SpawnUnitP8(Mission.P8AttackerPoints[i], Mission.Level12UnitIDs[1], Mission.Level12UnitNames[1], 1, 1)
				end
			elseif Mission.PlayerLevels[8] == 13 then

			elseif Mission.PlayerLevels[8] == 12 then
				Mission.PlayerLevels[8] = 9
]]
			end
			if Mission.PlayerLevels[8] == 11 then
				Mission.PlayerLevels[8] = 4
			else
				Mission.PlayerLevels[8] = Mission.PlayerLevels[8] + 1
			end
-- RELEASE_LOGOFF  			luaLog("  spawning finished for P8, next level: "..tostring(Mission.PlayerLevels[8]))
			Mission.SpawnEnabled[8] = false
			luaDelay(luaQAC6EnableSpawn8, 25)
		end
	end
end

function luaQAC6SpawnUnitP1(position, unittype, unitname, wingcount, eqindex)
	if unittype == 46 then
		eqindex = 0
	elseif unittype == 158 or unittype == 159 then
		wingcount = 3
	end

	if unittype ~= nil and unitname ~= nil then
		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = unittype,
					["Name"] = unitname,
					["Crew"] = 1,
					["Race"] = JAPAN,
					["WingCount"] = wingcount,
					["Equipment"] = eqindex,
					["OwnerPlayer"] = PLAYER_AI,
				},
			},
			["area"] = {
				["refPos"] = position,
				["angleRange"] = { DEG(180), DEG(185) },
			},
			["callback"] = "luaQAC6UnitSpawnedP1",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 50,
				["ownVertical"] = 50,
				["formationHorizontal"] = 50,
				["enemyVertical"] = 50,
				["enemyHorizontal"] = 50,
			},
		})
	end
end

function luaQAC6UnitSpawnedP1(unit)
	EntityTurnToEntity(unit, Mission.HQ1)
	if unit.Class.Type == "DiveBomber" or unit.Class.Type == "LevelBomber" or unit.Class.Type == "Kamikaze" then
		PilotSetTarget(unit, Mission.HQ1)
		SquadronSetAttackAlt(unit, 200)
		SquadronSetTravelAlt(unit, 200)
	else
		local pathindex = 0
		local closestdist = 10000
		for i, value in pairs (Mission.P1AttackerPaths) do
			local pathpoints = FillPathPoints(value)
			local distance = luaGetDistance(unit, pathpoints[1])
			--luaLog(" path "..tostring(i).." distance: "..tostring(distance))
			if distance < closestdist then
				pathindex = i
				closestdist = distance
			end
		end
		--luaLog(" path selected: "..pathindex)
		NavigatorMoveOnPath(unit, Mission.P1AttackerPaths[pathindex], PATH_FM_CIRCLE, PATH_SM_BEGIN)
		if unit.Class.ID == 77 then
			NavigatorSetAvoidLandCollision(unit, false)
			NavigatorSetAvoidShipCollision(unit, false)
		end
	end
	local randomskill = luaRnd(1, 4)
	if randomskill <= 3 then
		SetSkillLevel(unit, SKILL_SPNORMAL)
	elseif randomskill == 4 then
		SetSkillLevel(unit, SKILL_STUN)
	end
	table.insert(Mission.P1AttackerUnits, unit)
end

function luaQAC6SpawnUnitP2(position, unittype, unitname, wingcount, eqindex)
	if unittype == 46 then
		eqindex = 0
	elseif unittype == 158 or unittype == 159 then
		wingcount = 3
	end

	if unittype ~= nil and unitname ~= nil then
		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = unittype,
					["Name"] = unitname,
					["Crew"] = 1,
					["Race"] = JAPAN,
					["WingCount"] = wingcount,
					["Equipment"] = eqindex,
					["OwnerPlayer"] = PLAYER_AI,
				},
			},
			["area"] = {
				["refPos"] = position,
				["angleRange"] = { DEG(180), DEG(185) },
			},
			["callback"] = "luaQAC6UnitSpawnedP2",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 50,
				["ownVertical"] = 50,
				["formationHorizontal"] = 50,
				["enemyVertical"] = 50,
				["enemyHorizontal"] = 50,
			},
		})
	end
end

function luaQAC6UnitSpawnedP2(unit)
	EntityTurnToEntity(unit, Mission.HQ2)
	if unit.Class.Type == "DiveBomber" or unit.Class.Type == "LevelBomber" or unit.Class.Type == "Kamikaze" then
		PilotSetTarget(unit, Mission.HQ2)
		SquadronSetAttackAlt(unit, 200)
		SquadronSetTravelAlt(unit, 200)
	else
		local pathindex = 0
		local closestdist = 10000
		for i, value in pairs (Mission.P2AttackerPaths) do
			local pathpoints = FillPathPoints(value)
			local distance = luaGetDistance(unit, pathpoints[1])
			--luaLog(" path "..tostring(i).." distance: "..tostring(distance))
			if distance < closestdist then
				pathindex = i
				closestdist = distance
			end
		end
		--luaLog(" path selected: "..pathindex)
		NavigatorMoveOnPath(unit, Mission.P2AttackerPaths[pathindex], PATH_FM_CIRCLE, PATH_SM_BEGIN)
		if unit.Class.ID == 77 then
			NavigatorSetAvoidLandCollision(unit, false)
			NavigatorSetAvoidShipCollision(unit, false)
		end
	end
	local randomskill = luaRnd(1, 4)
	if randomskill <= 3 then
		SetSkillLevel(unit, SKILL_SPNORMAL)
	elseif randomskill == 4 then
		SetSkillLevel(unit, SKILL_STUN)
	end
	table.insert(Mission.P2AttackerUnits, unit)
end

function luaQAC6SpawnUnitP3(position, unittype, unitname, wingcount, eqindex)
	if unittype == 46 then
		eqindex = 0
	elseif unittype == 158 or unittype == 159 then
		wingcount = 3
	end

	if unittype ~= nil and unitname ~= nil then
		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = unittype,
					["Name"] = unitname,
					["Crew"] = 1,
					["Race"] = JAPAN,
					["WingCount"] = wingcount,
					["Equipment"] = eqindex,
					["OwnerPlayer"] = PLAYER_AI,
				},
			},
			["area"] = {
				["refPos"] = position,
				["angleRange"] = { DEG(180), DEG(185) },
			},
			["callback"] = "luaQAC6UnitSpawnedP3",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 50,
				["ownVertical"] = 50,
				["formationHorizontal"] = 50,
				["enemyVertical"] = 50,
				["enemyHorizontal"] = 50,
			},
		})
	end
end

function luaQAC6UnitSpawnedP3(unit)
	EntityTurnToEntity(unit, Mission.HQ3)
	if unit.Class.Type == "DiveBomber" or unit.Class.Type == "LevelBomber" or unit.Class.Type == "Kamikaze" then
		PilotSetTarget(unit, Mission.HQ3)
		SquadronSetAttackAlt(unit, 200)
		SquadronSetTravelAlt(unit, 200)
	else
		local pathindex = 0
		local closestdist = 10000
		for i, value in pairs (Mission.P3AttackerPaths) do
			local pathpoints = FillPathPoints(value)
			local distance = luaGetDistance(unit, pathpoints[1])
			--luaLog(" path "..tostring(i).." distance: "..tostring(distance))
			if distance < closestdist then
				pathindex = i
				closestdist = distance
			end
		end
		--luaLog(" path selected: "..pathindex)
		NavigatorMoveOnPath(unit, Mission.P3AttackerPaths[pathindex], PATH_FM_CIRCLE, PATH_SM_BEGIN)
		if unit.Class.ID == 77 then
			NavigatorSetAvoidLandCollision(unit, false)
			NavigatorSetAvoidShipCollision(unit, false)
		end
	end
	local randomskill = luaRnd(1, 4)
	if randomskill <= 3 then
		SetSkillLevel(unit, SKILL_SPNORMAL)
	elseif randomskill == 4 then
		SetSkillLevel(unit, SKILL_STUN)
	end
	table.insert(Mission.P3AttackerUnits, unit)
end

function luaQAC6SpawnUnitP4(position, unittype, unitname, wingcount, eqindex)
	if unittype == 46 then
		eqindex = 0
	elseif unittype == 158 or unittype == 159 then
		wingcount = 3
	end

	if unittype ~= nil and unitname ~= nil then
		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = unittype,
					["Name"] = unitname,
					["Crew"] = 1,
					["Race"] = JAPAN,
					["WingCount"] = wingcount,
					["Equipment"] = eqindex,
					["OwnerPlayer"] = PLAYER_AI,
				},
			},
			["area"] = {
				["refPos"] = position,
				["angleRange"] = { DEG(180), DEG(185) },
			},
			["callback"] = "luaQAC6UnitSpawnedP4",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 50,
				["ownVertical"] = 50,
				["formationHorizontal"] = 50,
				["enemyVertical"] = 50,
				["enemyHorizontal"] = 50,
			},
		})
	end
end

function luaQAC6UnitSpawnedP4(unit)
	EntityTurnToEntity(unit, Mission.HQ4)
	if unit.Class.Type == "DiveBomber" or unit.Class.Type == "LevelBomber" or unit.Class.Type == "Kamikaze" then
		PilotSetTarget(unit, Mission.HQ4)
		SquadronSetAttackAlt(unit, 200)
		SquadronSetTravelAlt(unit, 200)
	else
		local pathindex = 0
		local closestdist = 10000
		for i, value in pairs (Mission.P4AttackerPaths) do
			local pathpoints = FillPathPoints(value)
			local distance = luaGetDistance(unit, pathpoints[1])
			--luaLog(" path "..tostring(i).." distance: "..tostring(distance))
			if distance < closestdist then
				pathindex = i
				closestdist = distance
			end
		end
		--luaLog(" path selected: "..pathindex)
		NavigatorMoveOnPath(unit, Mission.P4AttackerPaths[pathindex], PATH_FM_CIRCLE, PATH_SM_BEGIN)
		if unit.Class.ID == 77 then
			NavigatorSetAvoidLandCollision(unit, false)
			NavigatorSetAvoidShipCollision(unit, false)
		end
	end
	local randomskill = luaRnd(1, 4)
	if randomskill <= 3 then
		SetSkillLevel(unit, SKILL_SPNORMAL)
	elseif randomskill == 4 then
		SetSkillLevel(unit, SKILL_STUN)
	end
	table.insert(Mission.P4AttackerUnits, unit)
end

function luaQAC6SpawnUnitP5(position, unittype, unitname, wingcount, eqindex)
	if unittype == 46 then
		eqindex = 0
	elseif unittype == 158 or unittype == 159 then
		wingcount = 3
	end

	if unittype ~= nil and unitname ~= nil then
		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = unittype,
					["Name"] = unitname,
					["Crew"] = 1,
					["Race"] = JAPAN,
					["WingCount"] = wingcount,
					["Equipment"] = eqindex,
					["OwnerPlayer"] = PLAYER_AI,
				},
			},
			["area"] = {
				["refPos"] = position,
				["angleRange"] = { DEG(180), DEG(185) },
			},
			["callback"] = "luaQAC6UnitSpawnedP5",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 50,
				["ownVertical"] = 50,
				["formationHorizontal"] = 50,
				["enemyVertical"] = 50,
				["enemyHorizontal"] = 50,
			},
		})
	end
end

function luaQAC6UnitSpawnedP5(unit)
	EntityTurnToEntity(unit, Mission.HQ5)
	if unit.Class.Type == "DiveBomber" or unit.Class.Type == "LevelBomber" or unit.Class.Type == "Kamikaze" then
		PilotSetTarget(unit, Mission.HQ5)
		SquadronSetAttackAlt(unit, 200)
		SquadronSetTravelAlt(unit, 200)
	else
		local pathindex = 0
		local closestdist = 10000
		for i, value in pairs (Mission.P5AttackerPaths) do
			local pathpoints = FillPathPoints(value)
			local distance = luaGetDistance(unit, pathpoints[1])
			--luaLog(" path "..tostring(i).." distance: "..tostring(distance))
			if distance < closestdist then
				pathindex = i
				closestdist = distance
			end
		end
		--luaLog(" path selected: "..pathindex)
		NavigatorMoveOnPath(unit, Mission.P5AttackerPaths[pathindex], PATH_FM_CIRCLE, PATH_SM_BEGIN)
		if unit.Class.ID == 77 then
			NavigatorSetAvoidLandCollision(unit, false)
			NavigatorSetAvoidShipCollision(unit, false)
		end
	end
	local randomskill = luaRnd(1, 4)
	if randomskill <= 3 then
		SetSkillLevel(unit, SKILL_SPNORMAL)
	elseif randomskill == 4 then
		SetSkillLevel(unit, SKILL_STUN)
	end
	table.insert(Mission.P5AttackerUnits, unit)
end

function luaQAC6SpawnUnitP6(position, unittype, unitname, wingcount, eqindex)
	if unittype == 46 then
		eqindex = 0
	elseif unittype == 158 or unittype == 159 then
		wingcount = 3
	end

	if unittype ~= nil and unitname ~= nil then
		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = unittype,
					["Name"] = unitname,
					["Crew"] = 1,
					["Race"] = JAPAN,
					["WingCount"] = wingcount,
					["Equipment"] = eqindex,
					["OwnerPlayer"] = PLAYER_AI,
				},
			},
			["area"] = {
				["refPos"] = position,
				["angleRange"] = { DEG(180), DEG(185) },
			},
			["callback"] = "luaQAC6UnitSpawnedP6",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 50,
				["ownVertical"] = 50,
				["formationHorizontal"] = 50,
				["enemyVertical"] = 50,
				["enemyHorizontal"] = 50,
			},
		})
	end
end

function luaQAC6UnitSpawnedP6(unit)
	EntityTurnToEntity(unit, Mission.HQ6)
	if unit.Class.Type == "DiveBomber" or unit.Class.Type == "LevelBomber" or unit.Class.Type == "Kamikaze" then
		PilotSetTarget(unit, Mission.HQ6)
		SquadronSetAttackAlt(unit, 200)
		SquadronSetTravelAlt(unit, 200)
	else
		local pathindex = 0
		local closestdist = 10000
		for i, value in pairs (Mission.P6AttackerPaths) do
			local pathpoints = FillPathPoints(value)
			local distance = luaGetDistance(unit, pathpoints[1])
			--luaLog(" path "..tostring(i).." distance: "..tostring(distance))
			if distance < closestdist then
				pathindex = i
				closestdist = distance
			end
		end
		--luaLog(" path selected: "..pathindex)
		NavigatorMoveOnPath(unit, Mission.P6AttackerPaths[pathindex], PATH_FM_CIRCLE, PATH_SM_BEGIN)
		if unit.Class.ID == 77 then
			NavigatorSetAvoidLandCollision(unit, false)
			NavigatorSetAvoidShipCollision(unit, false)
		end
	end
	local randomskill = luaRnd(1, 4)
	if randomskill <= 3 then
		SetSkillLevel(unit, SKILL_SPNORMAL)
	elseif randomskill == 4 then
		SetSkillLevel(unit, SKILL_STUN)
	end
	table.insert(Mission.P6AttackerUnits, unit)
end

function luaQAC6SpawnUnitP7(position, unittype, unitname, wingcount, eqindex)
	if unittype == 46 then
		eqindex = 0
	elseif unittype == 158 or unittype == 159 then
		wingcount = 3
	end

	if unittype ~= nil and unitname ~= nil then
		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = unittype,
					["Name"] = unitname,
					["Crew"] = 1,
					["Race"] = JAPAN,
					["WingCount"] = wingcount,
					["Equipment"] = eqindex,
					["OwnerPlayer"] = PLAYER_AI,
				},
			},
			["area"] = {
				["refPos"] = position,
				["angleRange"] = { DEG(180), DEG(185) },
			},
			["callback"] = "luaQAC6UnitSpawnedP7",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 50,
				["ownVertical"] = 50,
				["formationHorizontal"] = 50,
				["enemyVertical"] = 50,
				["enemyHorizontal"] = 50,
			},
		})
	end
end

function luaQAC6UnitSpawnedP7(unit)
	EntityTurnToEntity(unit, Mission.HQ7)
	if unit.Class.Type == "DiveBomber" or unit.Class.Type == "LevelBomber" or unit.Class.Type == "Kamikaze" then
		PilotSetTarget(unit, Mission.HQ7)
		SquadronSetAttackAlt(unit, 200)
		SquadronSetTravelAlt(unit, 200)
	else
		local pathindex = 0
		local closestdist = 10000
		for i, value in pairs (Mission.P7AttackerPaths) do
			local pathpoints = FillPathPoints(value)
			local distance = luaGetDistance(unit, pathpoints[1])
			--luaLog(" path "..tostring(i).." distance: "..tostring(distance))
			if distance < closestdist then
				pathindex = i
				closestdist = distance
			end
		end
		--luaLog(" path selected: "..pathindex)
		NavigatorMoveOnPath(unit, Mission.P7AttackerPaths[pathindex], PATH_FM_CIRCLE, PATH_SM_BEGIN)
		if unit.Class.ID == 77 then
			NavigatorSetAvoidLandCollision(unit, false)
			NavigatorSetAvoidShipCollision(unit, false)
		end
	end
	local randomskill = luaRnd(1, 4)
	if randomskill <= 3 then
		SetSkillLevel(unit, SKILL_SPNORMAL)
	elseif randomskill == 4 then
		SetSkillLevel(unit, SKILL_STUN)
	end
	table.insert(Mission.P7AttackerUnits, unit)
end

function luaQAC6SpawnUnitP8(position, unittype, unitname, wingcount, eqindex)
	if unittype == 46 then
		eqindex = 0
	elseif unittype == 158 or unittype == 159 then
		wingcount = 3
	end

	if unittype ~= nil and unitname ~= nil then
		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = unittype,
					["Name"] = unitname,
					["Crew"] = 1,
					["Race"] = JAPAN,
					["WingCount"] = wingcount,
					["Equipment"] = eqindex,
					["OwnerPlayer"] = PLAYER_AI,
				},
			},
			["area"] = {
				["refPos"] = position,
				["angleRange"] = { DEG(180), DEG(185) },
			},
			["callback"] = "luaQAC6UnitSpawnedP8",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 50,
				["ownVertical"] = 50,
				["formationHorizontal"] = 50,
				["enemyVertical"] = 50,
				["enemyHorizontal"] = 50,
			},
		})
	end
end

function luaQAC6UnitSpawnedP8(unit)
	EntityTurnToEntity(unit, Mission.HQ8)
	if unit.Class.Type == "DiveBomber" or unit.Class.Type == "LevelBomber" or unit.Class.Type == "Kamikaze" then
		PilotSetTarget(unit, Mission.HQ8)
		SquadronSetAttackAlt(unit, 200)
		SquadronSetTravelAlt(unit, 200)
	else
		local pathindex = 0
		local closestdist = 10000
		for i, value in pairs (Mission.P8AttackerPaths) do
			local pathpoints = FillPathPoints(value)
			local distance = luaGetDistance(unit, pathpoints[1])
			--luaLog(" path "..tostring(i).." distance: "..tostring(distance))
			if distance < closestdist then
				pathindex = i
				closestdist = distance
			end
		end
		--luaLog(" path selected: "..pathindex)
		NavigatorMoveOnPath(unit, Mission.P8AttackerPaths[pathindex], PATH_FM_CIRCLE, PATH_SM_BEGIN)
		if unit.Class.ID == 77 then
			NavigatorSetAvoidLandCollision(unit, false)
			NavigatorSetAvoidShipCollision(unit, false)
		end
	end
	local randomskill = luaRnd(1, 4)
	if randomskill <= 3 then
		SetSkillLevel(unit, SKILL_SPNORMAL)
	elseif randomskill == 4 then
		SetSkillLevel(unit, SKILL_STUN)
	end
	table.insert(Mission.P8AttackerUnits, unit)
end

function luaQAC6CheckHQLevelUps()
-- RELEASE_LOGOFF  	luaLog(" Checking HQ level ups...")
	if Mission.Player1 then
		luaQAC6CheckUpgrade(1)
	end
	if Mission.Player2 then
		luaQAC6CheckUpgrade(2)
	end
	if Mission.Player3 then
		luaQAC6CheckUpgrade(3)
	end
	if Mission.Player4 then
		luaQAC6CheckUpgrade(4)
	end
	if Mission.Player5 then
		luaQAC6CheckUpgrade(5)
	end
	if Mission.Player6 then
		luaQAC6CheckUpgrade(6)
	end
	if Mission.Player7 then
		luaQAC6CheckUpgrade(7)
	end
	if Mission.Player8 then
		luaQAC6CheckUpgrade(8)
	end
end

function luaQAC6CheckUpgrade(index)
	local indexminusone = index - 1
	local playerpoint = luaQAC6CheckScore(indexminusone)
	local actuallevel = Mission.HQLevels[index]
	local nextlevel = Mission.HQLevels[index] + 1
	local possiblelevels = table.getn(Mission.PointsToLevel)
	--luaLog("  player "..tostring(index).." has "..tostring(playerpoint).." points and is on level "..tostring(actuallevel))
	if actuallevel <= possiblelevels then
		if playerpoint >= Mission.PointsToLevel[actuallevel] and Mission.HQLevels[index] == actuallevel then
-- RELEASE_LOGOFF  			luaLog("  player "..tostring(index).." reached level "..tostring(nextlevel))
			luaQAC6UpgradeIsland(index)
		end
	end
end

function luaQAC6UpgradeIsland(index)
-- RELEASE_LOGOFF  	luaLog("   upgrading "..tostring(index).."'s island")
	if index == 1 and Mission.HQ1.Party == PARTY_ALLIED then
		if Mission.HQLevels[index] <= 5 then
			Mission.HQLevels[index] = Mission.HQLevels[index] + 1
			SetCommandBuildingLevel(Mission.HQ1, 4, Mission.HQLevels[index])
			local slotID = GetRoleAvailable(Mission.HQ1)[1]
			local playerID = GetPlayerDetails()[slotID].playerindex
			luaQAC6NarrativesAndSupplies(index, playerID, slotID)
		end
--[[
		if Mission.HQLevels[index] < 4 then
			local firstfort = Mission.HQLevels[index] * 2
			local secondfort = firstfort - 1
			local landfort = GenerateObject(Mission.Player1Landforts[firstfort].Name)
-- RELEASE_LOGOFF  			luaLog(landfort.Name.." generated")
			local landfort2 = GenerateObject(Mission.Player1Landforts[secondfort].Name)
-- RELEASE_LOGOFF  			luaLog(landfort2.Name.." generated")
			table.insert(Mission.Player1LiveLandforts, landfort)
			table.insert(Mission.Player1LiveLandforts, landfort2)
		elseif Mission.HQLevels[index] == 5 then
			local landfort = GenerateObject(Mission.Player1Landforts[7].Name)
-- RELEASE_LOGOFF  			luaLog(landfort.Name.." generated")
			table.insert(Mission.Player1LiveLandforts, landfort)
		end
		Mission.HQLevels[index] = Mission.HQLevels[index] + 1
		luaDelay(luaQC6UpdateInferiors, 6, "index", index)
]]
	elseif index == 2 and Mission.HQ2.Party == PARTY_ALLIED then
		if Mission.HQLevels[index] <= 5 then
			Mission.HQLevels[index] = Mission.HQLevels[index] + 1
			SetCommandBuildingLevel(Mission.HQ2, 4, Mission.HQLevels[index])
			local slotID = GetRoleAvailable(Mission.HQ2)[1]
			local playerID = GetPlayerDetails()[slotID].playerindex
			luaQAC6NarrativesAndSupplies(index, playerID, slotID)
		end
--[[
		if Mission.HQLevels[index] < 4 then
			local firstfort = Mission.HQLevels[index] * 2
			local secondfort = firstfort - 1
			local landfort = GenerateObject(Mission.Player2Landforts[firstfort].Name)
-- RELEASE_LOGOFF  			luaLog(landfort.Name.." generated")
			local landfort2 = GenerateObject(Mission.Player2Landforts[secondfort].Name)
-- RELEASE_LOGOFF  			luaLog(landfort2.Name.." generated")
			table.insert(Mission.Player2LiveLandforts, landfort)
			table.insert(Mission.Player2LiveLandforts, landfort2)
		elseif Mission.HQLevels[index] == 6 then
			local landfort = GenerateObject(Mission.Player2Landforts[7].Name)
-- RELEASE_LOGOFF  			luaLog(landfort.Name.." generated")
			table.insert(Mission.Player2LiveLandforts, landfort)
		end
		Mission.HQLevels[index] = Mission.HQLevels[index] + 1
		luaDelay(luaQC6UpdateInferiors, 6, "index", index)
]]
	elseif index == 3 and Mission.HQ3.Party == PARTY_ALLIED then
		if Mission.HQLevels[index] <= 5 then
			Mission.HQLevels[index] = Mission.HQLevels[index] + 1
			SetCommandBuildingLevel(Mission.HQ3, 4, Mission.HQLevels[index])
			local slotID = GetRoleAvailable(Mission.HQ3)[1]
			local playerID = GetPlayerDetails()[slotID].playerindex
			luaQAC6NarrativesAndSupplies(index, playerID, slotID)
		end
--[[
		if Mission.HQLevels[index] < 4 then
			local firstfort = Mission.HQLevels[index] * 2
			local secondfort = firstfort - 1
			local landfort = GenerateObject(Mission.Player3Landforts[firstfort].Name)
-- RELEASE_LOGOFF  			luaLog(landfort.Name.." generated")
			local landfort2 = GenerateObject(Mission.Player3Landforts[secondfort].Name)
-- RELEASE_LOGOFF  			luaLog(landfort2.Name.." generated")
			table.insert(Mission.Player3LiveLandforts, landfort)
			table.insert(Mission.Player3LiveLandforts, landfort2)
		elseif Mission.HQLevels[index] == 6 then
			local landfort = GenerateObject(Mission.Player3Landforts[7].Name)
-- RELEASE_LOGOFF  			luaLog(landfort.Name.." generated")
			table.insert(Mission.Player3LiveLandforts, landfort)
		end
		Mission.HQLevels[index] = Mission.HQLevels[index] + 1
		luaDelay(luaQC6UpdateInferiors, 6, "index", index)
]]
	elseif index == 4 and Mission.HQ4.Party == PARTY_ALLIED then
		if Mission.HQLevels[index] <= 5 then
			Mission.HQLevels[index] = Mission.HQLevels[index] + 1
			SetCommandBuildingLevel(Mission.HQ4, 4, Mission.HQLevels[index])
			local slotID = GetRoleAvailable(Mission.HQ4)[1]
			local playerID = GetPlayerDetails()[slotID].playerindex
			luaQAC6NarrativesAndSupplies(index, playerID, slotID)
		end
--[[
		if Mission.HQLevels[index] < 4 then
			local firstfort = Mission.HQLevels[index] * 2
			local secondfort = firstfort - 1
			local landfort = GenerateObject(Mission.Player4Landforts[firstfort].Name)
-- RELEASE_LOGOFF  			luaLog(landfort.Name.." generated")
			local landfort2 = GenerateObject(Mission.Player4Landforts[secondfort].Name)
-- RELEASE_LOGOFF  			luaLog(landfort2.Name.." generated")
			table.insert(Mission.Player4LiveLandforts, landfort)
			table.insert(Mission.Player4LiveLandforts, landfort2)
		elseif Mission.HQLevels[index] == 6 then
			local landfort = GenerateObject(Mission.Player4Landforts[7].Name)
-- RELEASE_LOGOFF  			luaLog(landfort.Name.." generated")
			table.insert(Mission.Player4LiveLandforts, landfort)
		end
		Mission.HQLevels[index] = Mission.HQLevels[index] + 1
		luaDelay(luaQC6UpdateInferiors, 6, "index", index)
]]
	elseif index == 5 and Mission.HQ5.Party == PARTY_ALLIED then
		if Mission.HQLevels[index] <= 5 then
			Mission.HQLevels[index] = Mission.HQLevels[index] + 1
			SetCommandBuildingLevel(Mission.HQ5, 4, Mission.HQLevels[index])
			local slotID = GetRoleAvailable(Mission.HQ5)[1]
			local playerID = GetPlayerDetails()[slotID].playerindex
			luaQAC6NarrativesAndSupplies(index, playerID, slotID)
		end
--[[
		if Mission.HQLevels[index] < 4 then
			local firstfort = Mission.HQLevels[index] * 2
			local secondfort = firstfort - 1
			local landfort = GenerateObject(Mission.Player5Landforts[firstfort].Name)
-- RELEASE_LOGOFF  			luaLog(landfort.Name.." generated")
			local landfort2 = GenerateObject(Mission.Player5Landforts[secondfort].Name)
-- RELEASE_LOGOFF  			luaLog(landfort2.Name.." generated")
			table.insert(Mission.Player5LiveLandforts, landfort)
			table.insert(Mission.Player5LiveLandforts, landfort2)
		elseif Mission.HQLevels[index] == 6 then
			local landfort = GenerateObject(Mission.Player5Landforts[7].Name)
-- RELEASE_LOGOFF  			luaLog(landfort.Name.." generated")
			table.insert(Mission.Player5LiveLandforts, landfort)
		end
		Mission.HQLevels[index] = Mission.HQLevels[index] + 1
		luaDelay(luaQC6UpdateInferiors, 6, "index", index)
]]
	elseif index == 6 and Mission.HQ6.Party == PARTY_ALLIED then
		if Mission.HQLevels[index] <= 5 then
			Mission.HQLevels[index] = Mission.HQLevels[index] + 1
			SetCommandBuildingLevel(Mission.HQ6, 4, Mission.HQLevels[index])
			local slotID = GetRoleAvailable(Mission.HQ6)[1]
			local playerID = GetPlayerDetails()[slotID].playerindex
			luaQAC6NarrativesAndSupplies(index, playerID, slotID)
		end
--[[
		if Mission.HQLevels[index] < 4 then
			local firstfort = Mission.HQLevels[index] * 2
			local secondfort = firstfort - 1
			local landfort = GenerateObject(Mission.Player6Landforts[firstfort].Name)
-- RELEASE_LOGOFF  			luaLog(landfort.Name.." generated")
			local landfort2 = GenerateObject(Mission.Player6Landforts[secondfort].Name)
-- RELEASE_LOGOFF  			luaLog(landfort2.Name.." generated")
			table.insert(Mission.Player6LiveLandforts, landfort)
			table.insert(Mission.Player6LiveLandforts, landfort2)
		elseif Mission.HQLevels[index] == 6 then
			local landfort = GenerateObject(Mission.Player6Landforts[7].Name)
-- RELEASE_LOGOFF  			luaLog(landfort.Name.." generated")
			table.insert(Mission.Player6LiveLandforts, landfort)
		end
		Mission.HQLevels[index] = Mission.HQLevels[index] + 1
		luaDelay(luaQC6UpdateInferiors, 6, "index", index)
]]
	elseif index == 7 and Mission.HQ7.Party == PARTY_ALLIED then
		if Mission.HQLevels[index] <= 5 then
			Mission.HQLevels[index] = Mission.HQLevels[index] + 1
			SetCommandBuildingLevel(Mission.HQ7, 4, Mission.HQLevels[index])
			local slotID = GetRoleAvailable(Mission.HQ7)[1]
			local playerID = GetPlayerDetails()[slotID].playerindex
			luaQAC6NarrativesAndSupplies(index, playerID, slotID)
		end
--[[
		if Mission.HQLevels[index] < 4 then
			local firstfort = Mission.HQLevels[index] * 2
			local secondfort = firstfort - 1
			local landfort = GenerateObject(Mission.Player7Landforts[firstfort].Name)
-- RELEASE_LOGOFF  			luaLog(landfort.Name.." generated")
			local landfort2 = GenerateObject(Mission.Player7Landforts[secondfort].Name)
-- RELEASE_LOGOFF  			luaLog(landfort2.Name.." generated")
			table.insert(Mission.Player7LiveLandforts, landfort)
			table.insert(Mission.Player7LiveLandforts, landfort2)
		elseif Mission.HQLevels[index] == 6 then
			local landfort = GenerateObject(Mission.Player7Landforts[7].Name)
-- RELEASE_LOGOFF  			luaLog(landfort.Name.." generated")
			table.insert(Mission.Player7LiveLandforts, landfort)
		end
		Mission.HQLevels[index] = Mission.HQLevels[index] + 1
		luaDelay(luaQC6UpdateInferiors, 6, "index", index)
]]
	elseif index == 8 and Mission.HQ8.Party == PARTY_ALLIED then
		if Mission.HQLevels[index] <= 5 then
			Mission.HQLevels[index] = Mission.HQLevels[index] + 1
			SetCommandBuildingLevel(Mission.HQ8, 4, Mission.HQLevels[index])
			local slotID = GetRoleAvailable(Mission.HQ8)[1]
			local playerID = GetPlayerDetails()[slotID].playerindex
			luaQAC6NarrativesAndSupplies(index, playerID, slotID)
		end
--[[
		if Mission.HQLevels[index] < 4 then
			local firstfort = Mission.HQLevels[index] * 2
			local secondfort = firstfort - 1
			local landfort = GenerateObject(Mission.Player8Landforts[firstfort].Name)
-- RELEASE_LOGOFF  			luaLog(landfort.Name.." generated")
			local landfort2 = GenerateObject(Mission.Player8Landforts[secondfort].Name)
-- RELEASE_LOGOFF  			luaLog(landfort2.Name.." generated")
			table.insert(Mission.Player8LiveLandforts, landfort)
			table.insert(Mission.Player8LiveLandforts, landfort2)
		elseif Mission.HQLevels[index] == 6 then
			local landfort = GenerateObject(Mission.Player8Landforts[7].Name)
-- RELEASE_LOGOFF  			luaLog(landfort.Name.." generated")
			table.insert(Mission.Player8LiveLandforts, landfort)
		end
		Mission.HQLevels[index] = Mission.HQLevels[index] + 1
		luaDelay(luaQC6UpdateInferiors, 6, "index", index)
]]
	end
end

function luaQC6UpdateInferiors(timerthis, index)
	if type(index) == "table" or index == nil then
		index = timerthis.ParamTable.index
	end
	if index == 1 then
		UpdateInferiorsInRange(Mission.HQ1)
		MissionNarrativePlayer(0, "mp06.nar_comp_upgrade")
	elseif index == 2 then
		UpdateInferiorsInRange(Mission.HQ2)
		MissionNarrativePlayer(1, "mp06.nar_comp_upgrade")
	elseif index == 3 then
		UpdateInferiorsInRange(Mission.HQ3)
		MissionNarrativePlayer(2, "mp06.nar_comp_upgrade")
	elseif index == 4 then
		UpdateInferiorsInRange(Mission.HQ4)
		MissionNarrativePlayer(3, "mp06.nar_comp_upgrade")
	elseif index == 5 then
		UpdateInferiorsInRange(Mission.HQ5)
		MissionNarrativePlayer(4, "mp06.nar_comp_upgrade")
	elseif index == 6 then
		UpdateInferiorsInRange(Mission.HQ6)
		MissionNarrativePlayer(5, "mp06.nar_comp_upgrade")
	elseif index == 7 then
		UpdateInferiorsInRange(Mission.HQ7)
		MissionNarrativePlayer(6, "mp06.nar_comp_upgrade")
	elseif index == 8 then
		UpdateInferiorsInRange(Mission.HQ8)
		MissionNarrativePlayer(7, "mp06.nar_comp_upgrade")
	end
end

function luaQAC6NarrativesAndSupplies(index, playerID, slotID)
-- RELEASE_LOGOFF  	luaLog(" luaQAC6NarrativesAndSupplies: index: "..tostring(index).." | owner: "..tostring(playerID).." |  GameTime: "..tostring(GameTime()))
	MissionNarrativePlayer(slotID, "mp06.nar_comp_upgrade")
--[[
	if Mission.HQLevels[index] == 2 then
		if GameTime() < Mission.SupplyTimer[1] then
			AddPowerup(slotID, {["classID"] = "automatic_reloader", ["useLimit"] = 1,})
			MissionNarrativePlayer(slotID, "mp06.nar_comp_supply")
		end
	elseif Mission.HQLevels[index] == 3 then
		if GameTime() < Mission.SupplyTimer[2] then
			AddPowerup(slotID, {["classID"] = "divebomb1", ["useLimit"] = 1,})
			MissionNarrativePlayer(slotID, "mp06.nar_comp_supply")
		end
	elseif Mission.HQLevels[index] == 4 then
		if GameTime() < Mission.SupplyTimer[3] then
			AddPowerup(slotID, {["classID"] = "CAP1",["useLimit"] = 1,})
			MissionNarrativePlayer(slotID, "mp06.nar_comp_supply")
		end
	elseif Mission.HQLevels[index] == 5 then
		if GameTime() < Mission.SupplyTimer[4] then
			AddPowerup(slotID, {["classID"] = "targeting_computer",["useLimit"] = 1,})
			MissionNarrativePlayer(slotID, "mp06.nar_comp_supply")
		end
---------------
	elseif Mission.HQLevels[index] == 5 then
		if GameTime() < Mission.SupplyTimer[5] then
			if index == 1 then
				SetRepairEffectivity(Mission.HQ1, 2)
			elseif index == 2 then
				SetRepairEffectivity(Mission.HQ2, 2)
			elseif index == 3 then
				SetRepairEffectivity(Mission.HQ3, 2)
			elseif index == 4 then
				SetRepairEffectivity(Mission.HQ4, 2)
			elseif index == 5 then
				SetRepairEffectivity(Mission.HQ5, 2)
			elseif index == 6 then
				SetRepairEffectivity(Mission.HQ6, 2)
			elseif index == 7 then
				SetRepairEffectivity(Mission.HQ7, 2)
			elseif index == 8 then
				SetRepairEffectivity(Mission.HQ8, 2)
			end
			MissionNarrativePlayer(playerID, "The repair effectivity of your headquarter has been upgraded!")
		end
---------------
	end
]]
end

function luaQAC6CheckPlayers()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Checking player changes...")
		local MPlayers = GetPlayerDetails()
		if Mission.Player1 then
			local playerfound = false
			for index, value in pairs (MPlayers) do
				if index == 0 then
					playerfound = true
				end
			end
			if not playerfound then
				Mission.Player1 = false
				SetParty(Mission.HQ1, PARTY_NEUTRAL)
				for index, unit in pairs (Mission.P1AttackerUnits) do
					Kill(unit, true)
				end
			end
		end

		if Mission.Player2 then
			local playerfound = false
			for index, value in pairs (MPlayers) do
				if index == 1 then
					playerfound = true
				end
			end
			if not playerfound then
				Mission.Player2 = false
				SetParty(Mission.HQ2, PARTY_NEUTRAL)
				for index, unit in pairs (Mission.P2AttackerUnits) do
					Kill(unit, true)
				end
			end
		end

		if Mission.Player3 then
			local playerfound = false
			for index, value in pairs (MPlayers) do
				if index == 2 then
					playerfound = true
				end
			end
			if not playerfound then
				Mission.Player3 = false
				SetParty(Mission.HQ3, PARTY_NEUTRAL)
				for index, unit in pairs (Mission.P3AttackerUnits) do
					Kill(unit, true)
				end
			end
		end

		if Mission.Player4 then
			local playerfound = false
			for index, value in pairs (MPlayers) do
				if index == 3 then
					playerfound = true
				end
			end
			if not playerfound then
				Mission.Player4 = false
				SetParty(Mission.HQ4, PARTY_NEUTRAL)
				for index, unit in pairs (Mission.P4AttackerUnits) do
					Kill(unit, true)
				end
			end
		end

		if Mission.Player5 then
			local playerfound = false
			for index, value in pairs (MPlayers) do
				if index == 4 then
					playerfound = true
				end
			end
			if not playerfound then
				Mission.Player5 = false
				SetParty(Mission.HQ5, PARTY_NEUTRAL)
				for index, unit in pairs (Mission.P5AttackerUnits) do
					Kill(unit, true)
				end
			end
		end

		if Mission.Player6 then
			local playerfound = false
			for index, value in pairs (MPlayers) do
				if index == 5 then
					playerfound = true
				end
			end
			if not playerfound then
				Mission.Player6 = false
				SetParty(Mission.HQ6, PARTY_NEUTRAL)
				for index, unit in pairs (Mission.P6AttackerUnits) do
					Kill(unit, true)
				end
			end
		end

		if Mission.Player7 then
			local playerfound = false
			for index, value in pairs (MPlayers) do
				if index == 6 then
					playerfound = true
				end
			end
			if not playerfound then
				Mission.Player7 = false
				SetParty(Mission.HQ7, PARTY_NEUTRAL)
				for index, unit in pairs (Mission.P7AttackerUnits) do
					Kill(unit, true)
				end
			end
		end

		if Mission.Player8 then
			local playerfound = false
			for index, value in pairs (MPlayers) do
				if index == 7 then
					playerfound = true
				end
			end
			if not playerfound then
				Mission.Player8 = false
				SetParty(Mission.HQ8, PARTY_NEUTRAL)
				for index, unit in pairs (Mission.P8AttackerUnits) do
					Kill(unit, true)
				end
			end
		end

		luaDelay(luaQAC6CheckPlayers, 1)
	end
end

function luaQAC6EnableSpawn1()
	if not Mission.Completed and not Mission.MissionEnd then
		Mission.SpawnEnabled[1] = true
	end
end

function luaQAC6EnableSpawn2()
	if not Mission.Completed and not Mission.MissionEnd then
		Mission.SpawnEnabled[2] = true
	end
end

function luaQAC6EnableSpawn3()
	if not Mission.Completed and not Mission.MissionEnd then
		Mission.SpawnEnabled[3] = true
	end
end

function luaQAC6EnableSpawn4()
	if not Mission.Completed and not Mission.MissionEnd then
		Mission.SpawnEnabled[4] = true
	end
end

function luaQAC6EnableSpawn5()
	if not Mission.Completed and not Mission.MissionEnd then
		Mission.SpawnEnabled[5] = true
	end
end

function luaQAC6EnableSpawn6()
	if not Mission.Completed and not Mission.MissionEnd then
		Mission.SpawnEnabled[6] = true
	end
end

function luaQAC6EnableSpawn7()
	if not Mission.Completed and not Mission.MissionEnd then
		Mission.SpawnEnabled[7] = true
	end
end

function luaQAC6EnableSpawn8()
	if not Mission.Completed and not Mission.MissionEnd then
		Mission.SpawnEnabled[8] = true
	end
end

function luaQAC6CheckScore(index)
	local MPlayers = GetPlayerDetails()
	local playerpoint = 0
	for slotID, value in pairs (MPlayers) do
		if slotID == index then
			playerpoint = Scoring_GetTotalMissionScore(slotID)
		end
	end
	return playerpoint
end

function luaQAC6CheckAttacerUnits()
-- RELEASE_LOGOFF  	luaLog(" Checking Attacker units...")
	Mission.P1AttackerUnits = luaRemoveDeadsFromTable(Mission.P1AttackerUnits)
	if table.getn(Mission.P1AttackerUnits) ~= 0 then
		for index, unit in pairs (Mission.P1AttackerUnits) do
			if unit.Class.Type == "DiveBomber" or unit.Class.Type == "LevelBomber" then
				--if LobbySettings.ReloadPayload == "globals.off" then
					if table.getn(GetPayloads(unit)) == 0 and not unit.reloadset then
-- RELEASE_LOGOFF  						luaLog("  reload set")
						unit.reloadset = true
						unit.reloadtimer = GameTime() + 30
					elseif unit.reloadset and GameTime() > unit.reloadtimer then
-- RELEASE_LOGOFF  						luaLog("  reload done")
						PlaneReloadBombPlatforms(unit)
						PilotSetTarget(unit, Mission.HQ1)
						SquadronSetAttackAlt(unit, 200)
						SquadronSetTravelAlt(unit, 200)
						unit.reloadset = false
					end
				--end
			end
		end
	end

	Mission.P2AttackerUnits = luaRemoveDeadsFromTable(Mission.P2AttackerUnits)
	if table.getn(Mission.P2AttackerUnits) ~= 0 then
		for index, unit in pairs (Mission.P2AttackerUnits) do
			if unit.Class.Type == "DiveBomber" or unit.Class.Type == "LevelBomber" then
				--if LobbySettings.ReloadPayload == "globals.off" then
					if table.getn(GetPayloads(unit)) == 0 and not unit.reloadset then
-- RELEASE_LOGOFF  						luaLog("  reload set")
						unit.reloadset = true
						unit.reloadtimer = GameTime() + 30
					elseif unit.reloadset and GameTime() > unit.reloadtimer then
-- RELEASE_LOGOFF  						luaLog("  reload done")
						PlaneReloadBombPlatforms(unit)
						PilotSetTarget(unit, Mission.HQ2)
						SquadronSetAttackAlt(unit, 200)
						SquadronSetTravelAlt(unit, 200)
						unit.reloadset = false
					end
				--end
			end
		end
	end

	Mission.P3AttackerUnits = luaRemoveDeadsFromTable(Mission.P3AttackerUnits)
	if table.getn(Mission.P3AttackerUnits) ~= 0 then
		for index, unit in pairs (Mission.P3AttackerUnits) do
			if unit.Class.Type == "DiveBomber" or unit.Class.Type == "LevelBomber" then
				--if LobbySettings.ReloadPayload == "globals.off" then
					if table.getn(GetPayloads(unit)) == 0 and not unit.reloadset then
-- RELEASE_LOGOFF  						luaLog("  reload set")
						unit.reloadset = true
						unit.reloadtimer = GameTime() + 30
					elseif unit.reloadset and GameTime() > unit.reloadtimer then
-- RELEASE_LOGOFF  						luaLog("  reload done")
						PlaneReloadBombPlatforms(unit)
						PilotSetTarget(unit, Mission.HQ3)
						SquadronSetAttackAlt(unit, 200)
						SquadronSetTravelAlt(unit, 200)
						unit.reloadset = false
					end
				--end
			end
		end
	end

	Mission.P4AttackerUnits = luaRemoveDeadsFromTable(Mission.P4AttackerUnits)
	if table.getn(Mission.P4AttackerUnits) ~= 0 then
		for index, unit in pairs (Mission.P4AttackerUnits) do
			if unit.Class.Type == "DiveBomber" or unit.Class.Type == "LevelBomber" then
				--if LobbySettings.ReloadPayload == "globals.off" then
					if table.getn(GetPayloads(unit)) == 0 and not unit.reloadset then
-- RELEASE_LOGOFF  						luaLog("  reload set")
						unit.reloadset = true
						unit.reloadtimer = GameTime() + 30
					elseif unit.reloadset and GameTime() > unit.reloadtimer then
-- RELEASE_LOGOFF  						luaLog("  reload done")
						PlaneReloadBombPlatforms(unit)
						PilotSetTarget(unit, Mission.HQ4)
						SquadronSetAttackAlt(unit, 200)
						SquadronSetTravelAlt(unit, 200)
						unit.reloadset = false
					end
				--end
			end
		end
	end

	Mission.P5AttackerUnits = luaRemoveDeadsFromTable(Mission.P5AttackerUnits)
	if table.getn(Mission.P5AttackerUnits) ~= 0 then
		for index, unit in pairs (Mission.P5AttackerUnits) do
			if unit.Class.Type == "DiveBomber" or unit.Class.Type == "LevelBomber" then
				--if LobbySettings.ReloadPayload == "globals.off" then
					if table.getn(GetPayloads(unit)) == 0 and not unit.reloadset then
-- RELEASE_LOGOFF  						luaLog("  reload set")
						unit.reloadset = true
						unit.reloadtimer = GameTime() + 30
					elseif unit.reloadset and GameTime() > unit.reloadtimer then
-- RELEASE_LOGOFF  						luaLog("  reload done")
						PlaneReloadBombPlatforms(unit)
						PilotSetTarget(unit, Mission.HQ5)
						SquadronSetAttackAlt(unit, 200)
						SquadronSetTravelAlt(unit, 200)
						unit.reloadset = false
					end
				--end
			end
		end
	end

	Mission.P6AttackerUnits = luaRemoveDeadsFromTable(Mission.P6AttackerUnits)
	if table.getn(Mission.P6AttackerUnits) ~= 0 then
		for index, unit in pairs (Mission.P6AttackerUnits) do
			if unit.Class.Type == "DiveBomber" or unit.Class.Type == "LevelBomber" then
				--if LobbySettings.ReloadPayload == "globals.off" then
					if table.getn(GetPayloads(unit)) == 0 and not unit.reloadset then
-- RELEASE_LOGOFF  						luaLog("  reload set")
						unit.reloadset = true
						unit.reloadtimer = GameTime() + 30
					elseif unit.reloadset and GameTime() > unit.reloadtimer then
-- RELEASE_LOGOFF  						luaLog("  reload done")
						PlaneReloadBombPlatforms(unit)
						PilotSetTarget(unit, Mission.HQ6)
						SquadronSetAttackAlt(unit, 200)
						SquadronSetTravelAlt(unit, 200)
						unit.reloadset = false
					end
				--end
			end
		end
	end

	Mission.P7AttackerUnits = luaRemoveDeadsFromTable(Mission.P7AttackerUnits)
	if table.getn(Mission.P7AttackerUnits) ~= 0 then
		for index, unit in pairs (Mission.P7AttackerUnits) do
			if unit.Class.Type == "DiveBomber" or unit.Class.Type == "LevelBomber" then
				--if LobbySettings.ReloadPayload == "globals.off" then
					if table.getn(GetPayloads(unit)) == 0 and not unit.reloadset then
-- RELEASE_LOGOFF  						luaLog("  reload set")
						unit.reloadset = true
						unit.reloadtimer = GameTime() + 30
					elseif unit.reloadset and GameTime() > unit.reloadtimer then
-- RELEASE_LOGOFF  						luaLog("  reload done")
						PlaneReloadBombPlatforms(unit)
						PilotSetTarget(unit, Mission.HQ7)
						SquadronSetAttackAlt(unit, 200)
						SquadronSetTravelAlt(unit, 200)
						unit.reloadset = false
					end
				--end
			end
		end
	end

	Mission.P8AttackerUnits = luaRemoveDeadsFromTable(Mission.P8AttackerUnits)
	if table.getn(Mission.P8AttackerUnits) ~= 0 then
		for index, unit in pairs (Mission.P8AttackerUnits) do
			if unit.Class.Type == "DiveBomber" or unit.Class.Type == "LevelBomber" then
				--if LobbySettings.ReloadPayload == "globals.off" then
					if table.getn(GetPayloads(unit)) == 0 and not unit.reloadset then
-- RELEASE_LOGOFF  						luaLog("  reload set")
						unit.reloadset = true
						unit.reloadtimer = GameTime() + 30
					elseif unit.reloadset and GameTime() > unit.reloadtimer then
-- RELEASE_LOGOFF  						luaLog("  reload done")
						PlaneReloadBombPlatforms(unit)
						PilotSetTarget(unit, Mission.HQ8)
						SquadronSetAttackAlt(unit, 200)
						SquadronSetTravelAlt(unit, 200)
						unit.reloadset = false
					end
				--end
			end
		end
	end
end

function luaQAC6CheckHQs()
-- RELEASE_LOGOFF  	luaLog(" Checking HQs...")
--[[
	local alliedhqs = 0
	if Mission.HQ1.Party == PARTY_ALLIED then
		alliedhqs = alliedhqs + 1
	elseif Mission.HQ2.Party == PARTY_ALLIED then
		alliedhqs = alliedhqs + 1
	elseif Mission.HQ3.Party == PARTY_ALLIED then
		alliedhqs = alliedhqs + 1
	elseif Mission.HQ4.Party == PARTY_ALLIED then
		alliedhqs = alliedhqs + 1
	elseif Mission.HQ5.Party == PARTY_ALLIED then
		alliedhqs = alliedhqs + 1
	elseif Mission.HQ6.Party == PARTY_ALLIED then
		alliedhqs = alliedhqs + 1
	elseif Mission.HQ7.Party == PARTY_ALLIED then
		alliedhqs = alliedhqs + 1
	elseif Mission.HQ8.Party == PARTY_ALLIED then
		alliedhqs = alliedhqs + 1
	end
	if alliedhqs == 0 and not Mission.MissionEndCalled then
]]
	if Mission.Player1 and Mission.HQ1.Party ~= PARTY_ALLIED or Mission.Player2 and Mission.HQ2.Party ~= PARTY_ALLIED or Mission.Player3 and Mission.HQ3.Party ~= PARTY_ALLIED or Mission.Player4 and Mission.HQ4.Party ~= PARTY_ALLIED or Mission.Player5 and Mission.HQ5.Party ~= PARTY_ALLIED or Mission.Player6 and Mission.HQ6.Party ~= PARTY_ALLIED or Mission.Player7 and Mission.HQ7.Party ~= PARTY_ALLIED or Mission.Player8 and Mission.HQ8.Party ~= PARTY_ALLIED then
-- RELEASE_LOGOFF  		luaLog("  Allied HQ lost")
		Mission.MissionEndCalled = true
		Mission.JapaneseVictory = true
		Mission.MissionFailed = true
		luaObj_Failed("primary", 9)
		CountdownCancel()
		luaQAC6MissionEnd()
	end
end

function luaQAC6CheckGameTime()
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

function luaQAC6CheckMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Checking mission ending conditions...")
	if Mission.PointLimit ~= 0 then
		local highestindex, highestplayerscore = luaQAC6CheckHighestScore()
		if highestplayerscore >= Mission.PointLimit and not Mission.MissionEndCalled then
-- RELEASE_LOGOFF  			luaLog(" index: "..highestindex.." | score: "..highestplayerscore.." | calling mission end")
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
			luaDelay(luaQAC6MissionEnd, 0.1)
		end
	end
end

function luaQAC6CheckHighestScore()
	local MPlayers = GetPlayerDetails()
	local actplayerscore = 0
	local highestplayerscore = 0
	local highestindex = 0
	for slotID, value in pairs (MPlayers) do
		actplayerscore = Scoring_GetTotalMissionScore(slotID)
		--luaLog(" index: "..slotID.." | score: "..actplayerscore)
		if actplayerscore > highestplayerscore then
			highestplayerscore = actplayerscore
			highestindex = slotID
		end
	end
	return highestindex, highestplayerscore
end

function luaQAC6MissionEndTimeIsUp()
	MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_time_up")
	local highestindex, highestplayerscore = luaQAC6CheckHighestScore()
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
	CountdownCancel()
	ForceMultiScoreSend()
	luaDelay(luaQAC6MissionEnd, 0.1)
end

function luaQAC6MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	if not Mission.Completed then
		Mission.Completed = true
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
		local highestindex, highestplayerscore = luaQAC6CheckHighestScore()
-- RELEASE_LOGOFF  		luaLog(" player "..highestindex.." won")
		local objindex = highestindex + 1
		luaObj_Completed("primary", objindex)
		for i = 1, 8 do
			if i ~= objindex then
				luaObj_Failed("primary", i)
			end
		end
		if not Mission.MissionFailed then
			luaObj_Completed("primary", 9)
		end
		Mission.Highest = highestindex
		luaQAC6DelayedMissionComplete()
		--luaDelay(luaQAC6DelayedMissionComplete, 4)
	end
end

function luaQAC6DelayedMissionComplete()
	if not Mission.MissionEnd then
		Scoring_RealPlayTimeRunning(false)
		if Mission.JapaneseVictory then
			luaMissionCompletedNew(Mission.HQ1, "", nil, nil, nil, PARTY_JAPANESE)
		elseif Mission.Highest == 0 then
			luaMissionCompletedNew(Mission.HQ1, "", nil, nil, nil, PARTY_ALLIED)
		elseif Mission.Highest == 1 then
			luaMissionCompletedNew(Mission.HQ2, "", nil, nil, nil, PARTY_ALLIED)
		elseif Mission.Highest == 2 then
			luaMissionCompletedNew(Mission.HQ3, "", nil, nil, nil, PARTY_ALLIED)
		elseif Mission.Highest == 3 then
			luaMissionCompletedNew(Mission.HQ4, "", nil, nil, nil, PARTY_ALLIED)
		elseif Mission.Highest == 4 then
			luaMissionCompletedNew(Mission.HQ5, "", nil, nil, nil, PARTY_ALLIED)
		elseif Mission.Highest == 5 then
			luaMissionCompletedNew(Mission.HQ6, "", nil, nil, nil, PARTY_ALLIED)
		elseif Mission.Highest == 6 then
			luaMissionCompletedNew(Mission.HQ7, "", nil, nil, nil, PARTY_ALLIED)
		elseif Mission.Highest == 7 then
			luaMissionCompletedNew(Mission.HQ8, "", nil, nil, nil, PARTY_ALLIED)
		end
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Competitive06")
	-- mode description hint overlay
end

function luaUpdateCounters()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Updating counters...")
		if MultiScore ~= nil then
			if table.getn(MultiScore) ~= 0 then
				local PlayersInGame = GetPlayerDetails()
				local highestindex, highestplayerscore = luaQAC6CheckHighestScore()
				for index, value in pairs (PlayersInGame) do
					MultiScore[index][1] = Scoring_GetTotalMissionScore(index)
					MultiScore[index][5] = highestplayerscore
				end
			end
		end
	
		luaDelay(luaUpdateCounters, 0.7)
	end
end

function luaQAC6HintManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 30 and not Mission.Hint1Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint1Shown")
			ShowHint("ID_Hint_Competitive06_level")
			Mission.Hint1Shown = true
		elseif GameTime() > 60 and not Mission.Hint2Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint2Shown")
			--ShowHint("ID_Hint_Competitive06_supply")
			Mission.Hint2Shown = true
		end
	end
end