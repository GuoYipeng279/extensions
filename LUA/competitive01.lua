--SceneFile="Missions\Multi\Scene1.scn"

function luaPrecacheUnits()
	PrepareClass(7) -- South Dakota
	PrepareClass(21) -- York
	PrepareClass(37) -- US Cargo
	--PrepareClass(101) -- Wildcat
	--PrepareClass(134) -- Hurricane 
	PrepareClass(17) -- Atlanta
	PrepareClass(25) -- Clemson
	--PrepareClass(18) -- Cleveland
	PrepareClass(20) -- DeRuyter
	PrepareClass(23) -- Fletcher
	--PrepareClass(41) -- Landin Ship
	--PrepareClass(1) -- Lexington
	PrepareClass(13) -- New York
	--PrepareClass(19) -- Northampton
	PrepareClass(27) -- PT Boat
	PrepareClass(10) -- Renown
	--PrepareClass(36) -- Troop Transport
	--PrepareClass(2) -- Yorktown
	PrepareClass(133) -- Buffalo
	PrepareClass(167) -- Betty
	PrepareClass(32) -- Betty - Ohka
	PrepareClass(68) -- Tone
	PrepareClass(61) -- Fuso
	PrepareClass(50) -- Akagi
	PrepareClass(150) -- Zero
	PrepareClass(113) -- Avenger

	-- atnezni
	--PrepareClass(68)
	--PrepareClass(61)
	--PrepareClass(50)
	--PrepareClass(101)
	--PrepareClass(108)
	--PrepareClass(150)
	--PrepareClass(162)
	--PrepareClass(158)
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAC1Mission")
end

function luaInitQAC1Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Comp1"..dateandtime

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
	Mission.MultiplayerNumber = 1
	Mission.CompetitiveParty = PARTY_JAPANESE

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
	Mission.USShips = {}
	Mission.AttackerPlanes = {}
	Mission.CenterPoint = {["x"] = 500, ["y"] = 0, ["z"] = 1600}

	-- spawn pontok
	Mission.SpawnPoints = {}
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 4"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 5"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 6"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 7"))
		table.insert(Mission.SpawnPoints, FindEntity("Comp - SP 8"))
	
	Mission.SlotIDTable = {}
		table.insert(Mission.SlotIDTable, 0)
		table.insert(Mission.SlotIDTable, 1)
		table.insert(Mission.SlotIDTable, 2)
		table.insert(Mission.SlotIDTable, 3)
		table.insert(Mission.SlotIDTable, 4)
		table.insert(Mission.SlotIDTable, 5)
		table.insert(Mission.SlotIDTable, 6)
		table.insert(Mission.SlotIDTable, 7)

-- RELEASE_LOGOFF  	luaLog("-- start of spawnpoint activation --")
	for index, entity in pairs (Mission.SpawnPoints) do
		local slotID = index - 1
		for index2, value in pairs (Mission.SlotIDTable) do
			if slotID == value then
-- RELEASE_LOGOFF  				luaLog(" activating SPID "..index.." for slotID "..value)
				ActivateSpawnpoint(entity, value)
			else
				DeactivateSpawnpoint(entity, value)
			end
		end	
	end
-- RELEASE_LOGOFF  	luaLog("-- end of spawnpoint activation --")

	-- amerikai objektumok
--[[
	Mission.USHQs = {}
		table.insert(Mission.USHQs, FindEntity("Comp - Command Post 1"))
		AISetHintWeight(Mission.USHQs[1], 25)
		table.insert(Mission.USHQs, FindEntity("Comp - Command Post 2"))
		AISetHintWeight(Mission.USHQs[2], 25)
]]
-------- uj cucc ---------
	Mission.DistanceCheckDisabled = true
	Mission.HitScore = 100
	Mission.KillScore = 200

	Mission.USShips = {}

	Mission.USBigShipID = {}
		table.insert(Mission.USBigShipID, 7)
		table.insert(Mission.USBigShipID, 10)
		--table.insert(Mission.USBigShipID, 2)

	Mission.USBigShipName = {}
		table.insert(Mission.USBigShipName, "globals.unitclass_southdakota")
		table.insert(Mission.USBigShipName, "globals.unitclass_renown")
		--table.insert(Mission.USBigShipName, "globals.unitclass_yorktown")

	Mission.USMediumShipID = {}
		table.insert(Mission.USMediumShipID, 17)
		table.insert(Mission.USMediumShipID, 21)
		table.insert(Mission.USMediumShipID, 20)

	Mission.USMediumShipName = {}
		table.insert(Mission.USMediumShipName, "globals.unitclass_atlanta")
		table.insert(Mission.USMediumShipName, "globals.unitclass_york")
		table.insert(Mission.USMediumShipName, "globals.unitclass_deruyter")

	Mission.USSmallShipID = {}
		table.insert(Mission.USSmallShipID, 23)
		table.insert(Mission.USSmallShipID, 25)

	Mission.USSmallShipName = {}
		table.insert(Mission.USSmallShipName, "globals.unitclass_fletcher")
		table.insert(Mission.USSmallShipName, "globals.unitclass_clemson")

	Mission.USBoatID = {}
		table.insert(Mission.USBoatID, 27)

	Mission.USBoatName = {}
		table.insert(Mission.USBoatName, "globals.unitclass_elco")

	Mission.USAKID = {}
		table.insert(Mission.USAKID, 37)

	Mission.USAKName = {}
		table.insert(Mission.USAKName, "globals.unitclass_japcargotransporter")

	Mission.USSpawnPositions = {}
		table.insert(Mission.USSpawnPositions, GetPosition(FindEntity("Comp - US Ship SP1")))
		table.insert(Mission.USSpawnPositions, GetPosition(FindEntity("Comp - US Ship SP2")))

--------------------------
--[[
	Mission.BuffaloSpawnPoints = {}
		local firstpos = GetPosition(Mission.USHQs[1])
		local first = {["x"] = firstpos["x"], ["y"] = 350, ["z"] = firstpos["z"]}
		table.insert(Mission.BuffaloSpawnPoints, first)
		local secondpos = GetPosition(Mission.USHQs[2])
		local second = {["x"] = secondpos["x"], ["y"] = 350, ["z"] = secondpos["z"]}
		table.insert(Mission.BuffaloSpawnPoints, second)
		local third = {["x"] = firstpos["x"] + 250, ["y"] = 350, ["z"] = firstpos["z"] - 250}
		table.insert(Mission.BuffaloSpawnPoints, third)
		local fourth = {["x"] = secondpos["x"] + 250, ["y"] = 350, ["z"] = secondpos["z"] - 250}
		table.insert(Mission.BuffaloSpawnPoints, fourth)
]]
--[[
	Mission.USShipTMPLs = {}
		table.insert(Mission.USShipTMPLs, luaFindHidden("Comp - Atlanta"))
		table.insert(Mission.USShipTMPLs, luaFindHidden("Comp - Clemson"))
		table.insert(Mission.USShipTMPLs, luaFindHidden("Comp - Cleveland"))
		table.insert(Mission.USShipTMPLs, luaFindHidden("Comp - DeRuyter"))
		table.insert(Mission.USShipTMPLs, luaFindHidden("Comp - Fletcher"))
		table.insert(Mission.USShipTMPLs, luaFindHidden("Comp - Landin Ship"))
		table.insert(Mission.USShipTMPLs, luaFindHidden("Comp - Lexington"))
		table.insert(Mission.USShipTMPLs, luaFindHidden("Comp - NewYork"))
		table.insert(Mission.USShipTMPLs, luaFindHidden("Comp - Northampton"))
		table.insert(Mission.USShipTMPLs, luaFindHidden("Comp - PT Boat"))
		table.insert(Mission.USShipTMPLs, luaFindHidden("Comp - Renown"))
		table.insert(Mission.USShipTMPLs, luaFindHidden("Comp - TroopTransport"))
		table.insert(Mission.USShipTMPLs, luaFindHidden("Comp - Yorktown"))
]]
	Mission.USShipFlags = {}
	for i = 1, 13 do
		table.insert(Mission.USShipFlags, true)
	end
--[[
	Mission.USShips = {}
		table.insert(Mission.USShips, GenerateObject(Mission.USShipTMPLs[1].Name))
		table.insert(Mission.USShips, GenerateObject(Mission.USShipTMPLs[2].Name))
		table.insert(Mission.USShips, GenerateObject(Mission.USShipTMPLs[3].Name))
		table.insert(Mission.USShips, GenerateObject(Mission.USShipTMPLs[4].Name))
		table.insert(Mission.USShips, GenerateObject(Mission.USShipTMPLs[5].Name))
		table.insert(Mission.USShips, GenerateObject(Mission.USShipTMPLs[6].Name))
		table.insert(Mission.USShips, GenerateObject(Mission.USShipTMPLs[7].Name))
		table.insert(Mission.USShips, GenerateObject(Mission.USShipTMPLs[8].Name))
		table.insert(Mission.USShips, GenerateObject(Mission.USShipTMPLs[9].Name))
		table.insert(Mission.USShips, GenerateObject(Mission.USShipTMPLs[10].Name))
		table.insert(Mission.USShips, GenerateObject(Mission.USShipTMPLs[11].Name))
		table.insert(Mission.USShips, GenerateObject(Mission.USShipTMPLs[12].Name))
		table.insert(Mission.USShips, GenerateObject(Mission.USShipTMPLs[13].Name))

	for index, unit in pairs (Mission.USShips) do
		if index ~= 10 then
			AISetHintWeight(unit, 100)
		end
	end
]]
	Mission.BuffaloTMPL = luaFindHidden("Comp - Buffalo")

	Mission.USPathIndexes = {}
		table.insert(Mission.USPathIndexes, 3)
		table.insert(Mission.USPathIndexes, 3)
		table.insert(Mission.USPathIndexes, 1)
		table.insert(Mission.USPathIndexes, 4)
		table.insert(Mission.USPathIndexes, 1)
		table.insert(Mission.USPathIndexes, 3)
		table.insert(Mission.USPathIndexes, 2)
		table.insert(Mission.USPathIndexes, 4)
		table.insert(Mission.USPathIndexes, 1)
		table.insert(Mission.USPathIndexes, 3)
		table.insert(Mission.USPathIndexes, 4)
		table.insert(Mission.USPathIndexes, 2)
		table.insert(Mission.USPathIndexes, 2)

	Mission.USEntryPoints = {}
		table.insert(Mission.USEntryPoints, GetPosition(FindEntity("Comp - US Ship SP1")))
		table.insert(Mission.USEntryPoints, GetPosition(FindEntity("Comp - US Ship SP2")))
		table.insert(Mission.USEntryPoints, GetPosition(FindEntity("Comp - US Ship SP3")))
		table.insert(Mission.USEntryPoints, GetPosition(FindEntity("Comp - US Ship SP4")))
		table.insert(Mission.USEntryPoints, GetPosition(FindEntity("Comp - US Ship SP5")))
		table.insert(Mission.USEntryPoints, GetPosition(FindEntity("Comp - US Ship SP6")))
		table.insert(Mission.USEntryPoints, GetPosition(FindEntity("Comp - US Ship SP7")))
		table.insert(Mission.USEntryPoints, GetPosition(FindEntity("Comp - US Ship SP8")))

	Mission.USExitPaths = {}
		table.insert(Mission.USExitPaths, FindEntity("Comp - US Path 1"))
		table.insert(Mission.USExitPaths, FindEntity("Comp - US Path 2"))
		table.insert(Mission.USExitPaths, FindEntity("Comp - US Path 3"))
		table.insert(Mission.USExitPaths, FindEntity("Comp - US Path 4"))

	Mission.USExitPoints = {}
	for i = 1, 4 do
		local pathpoints = FillPathPoints(Mission.USExitPaths[i])
		local endpointindex = table.getn(pathpoints)
		table.insert(Mission.USExitPoints, endpointindex)
	end

	-- japan objektumok
	Mission.JapHQ = FindEntity("Comp - Command Post 3")
	SetInvincible(Mission.JapHQ, 1)
	Mission.JapShipTMPLs = {}
		table.insert(Mission.JapShipTMPLs, luaFindHidden("Comp - Tone"))
		table.insert(Mission.JapShipTMPLs, luaFindHidden("Comp - Fuso"))
		table.insert(Mission.JapShipTMPLs, luaFindHidden("Comp - Akagi"))
	Mission.JapShips = {}
	for index, value in pairs (Mission.JapShipTMPLs) do
		local ship = GenerateObject(Mission.JapShipTMPLs[index].Name)
		NavigatorSetTorpedoEvasion(ship, false)
		NavigatorSetAvoidLandCollision(ship, false)
		NavigatorSetAvoidShipCollision(ship, false)
		NavigatorEnable(ship, false)
		AAEnable(ship, false)
		ArtilleryEnable(ship, false)
		table.insert(Mission.JapShips, ship)
	end

	Mission.SpawnPoint = {["x"] = 300, ["y"] = 800, ["z"] = 800}
	Mission.JapExitPoint = {["x"] = 500, ["y"] = 800, ["z"] = 650}

	Mission.BettyTMPL = luaFindHidden("Comp - Betty")

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

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_JAPANESE,
				["PlayerIndex"] = 0,
				["ID"] = "jap_obj_primary_1_player_1",
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
				["ID"] = "jap_obj_primary_1_player_2",
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
				["ID"] = "jap_obj_primary_1_player_3",
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
				["ID"] = "jap_obj_primary_1_player_4",
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
				["ID"] = "jap_obj_primary_1_player_5",
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
				["ID"] = "jap_obj_primary_1_player_6",
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
				["ID"] = "jap_obj_primary_1_player_7",
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
				["ID"] = "jap_obj_primary_1_player_8",
				["Text"] = "mp.obj_comp_p1_text",
				["TextCompleted"] = "mp.obj_comp_p1_comp",
				["TextFailed"] = "mp.obj_comp_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
		},
		["secondary"] = {
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

    SetThink(this, "luaQAC1Mission_think")
end

function luaQAC1Mission_think(this, msg)
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
		luaQAC1CheckListeners()
		--luaQAC1CheckGameTime()
		--luaQAC1CheckAttackerPlanes()
		luaQAC1FilterBombers()
		luaQAC1CheckUSShipsNew()
		--luaQAC1CheckJapAIUnits()
		luaQAC1CheckMissionEnd()
		--luaUpdateCounters()
		luaQAC1HintManager()

--[[
		luaQAC1CheckShipSpeed()
		luaQAC1CheckUSShips()
]]

	elseif not Mission.Started then
		luaQAC1StartMission()
		luaUpdateCounters()
	end
end

function luaQAC1StartMission()
-- RELEASE_LOGOFF  	luaLog("  Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()

	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	if Mission.LobbyCountDown ~= 0 then
		Countdown("mp.score_comp_time_left", 0, Mission.LobbyCountDown, "luaQAC1MissionEndTimeIsUp")
	end

	luaDelay(luaQAC1AddP1Obj, 5)

--[[
	for index, unit in pairs (Mission.USShips) do]]
		--NavigatorMoveOnPath(unit, Mission.USExitPaths[Mission.USPathIndexes[index]])
--[[		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		SetShipSpeed(unit, 15)
	end

	for i = 1, 8 do
		luaObj_Add("primary", i)
	end

	for index, unit in pairs (Mission.USShips) do
		for i = 1, 8 do
			luaObj_AddUnit("primary", i, unit)
		end
	end
]]
	if Mission.Players <= 2 then
		Mission.MaxAttackerPlanes = 1
		Mission.Difficulty = DIFF_ROOKIE
	elseif Mission.Players >= 3 and Mission.Players <= 4 then
		--Mission.MaxAttackerPlanes = 2
		Mission.MaxAttackerPlanes = 1
		Mission.Difficulty = DIFF_ROOKIE
	elseif Mission.Players >= 5 and Mission.Players <= 6 then
		--Mission.MaxAttackerPlanes = 3
		Mission.MaxAttackerPlanes = 2
		Mission.Difficulty = DIFF_ROOKIE
		--Mission.Difficulty = DIFF_REGULAR
	elseif Mission.Players >= 7 and Mission.Players <= 8 then
		--Mission.MaxAttackerPlanes = 4
		Mission.MaxAttackerPlanes = 2
		Mission.Difficulty = DIFF_ROOKIE
		--Mission.Difficulty = DIFF_REGULAR
	end
--[[
	if Mission.MaxAttackerPlanes ~= nil then
		for i = 1, Mission.MaxAttackerPlanes do
			local buffalo = GenerateObject(Mission.BuffaloTMPL.Name, Mission.BuffaloSpawnPoints[i])
			--PutTo(buffalo, Mission.BuffaloSpawnPoints[i])
			EntityTurnToPosition(buffalo, Mission.SpawnPoint)
			table.insert(Mission.AttackerPlanes, buffalo)
		end
	end
]]
--[[
	if Mission.Difficulty then
		for index, unit in pairs (Mission.USShips) do
			SetCrewLevel(unit, Mission.Difficulty)
		end
	end
]]
	--luaDelay(luaQAC1SpawnUSShips, 2)
	Mission.Started = true
end

function luaQAC1AddP1Obj()
	for i = 1, 8 do
		luaObj_Add("primary", i)
	end
	--luaObj_Add("primary", 9)
	--luaObj_AddUnit("primary", 9, Mission.JapHQ)
end

--[[
function luaQAC1SpawnUSShips()
	local index = table.getn(Mission.USShips) + 1
	if index < 14 then
-- RELEASE_LOGOFF  		luaLog(" spawning US ship index "..index)
		local unit = GenerateObject(Mission.USShipTMPLs[index].Name)
		AISetHintWeight(unit, 100)
		NavigatorMoveOnPath(unit, Mission.USExitPaths[Mission.USPathIndexes[index]-]) -- a --t ki kell torolni
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		SetShipSpeed(unit, 15)
		SetCrewLevel(unit, Mission.Difficulty)
		table.insert(Mission.USShips, unit)
		luaDelay(luaQAC1SpawnUSShips, 0.55)
	else
		for index, unit in pairs (Mission.USShips) do
			for i = 1, 8 do
				luaObj_AddUnit("primary", i, unit)
			end
		end
	end
end

function luaQAC1CheckGameTime()
-- RELEASE_LOGOFF  	luaLog(" Checking gametime...")
	if CountdownTimeLeft() <= 900 and not Mission.FirstWarningDone then
-- RELEASE_LOGOFF  		luaLog(" 15 minutes warining")
		Mission.FirstWarningDone = true
		Mission.WarningTime = 15
		luaWarningNarrative()
	elseif CountdownTimeLeft() <= 600 and not Mission.SecondWarningDone then
-- RELEASE_LOGOFF  		luaLog(" 10 minutes warining")
		Mission.SecondWarningDone = true
		Mission.WarningTime = 10
		luaWarningNarrative()
	elseif CountdownTimeLeft() <= 300 and not Mission.ThirdWarningDone then
-- RELEASE_LOGOFF  		luaLog(" 5 minutes warining")
		Mission.ThirdWarningDone = true
		Mission.WarningTime = 5
		luaWarningNarrative()
	elseif CountdownTimeLeft() <= 60 and not Mission.FourthWarningDone then
-- RELEASE_LOGOFF  		luaLog(" 1 minutes warining")
		Mission.FourthWarningDone = true
		Mission.WarningTime = 1
		luaWarningNarrative()
	end
end

function luaWarningNarrative()
	local PlayersInGame = GetPlayerDetails()
	for index, value in pairs (PlayersInGame) do
		MultiScore[index][2] = Mission.WarningTime
	end
	MissionNarrativePlayer(0, "mp01.nar_comp_timer_warning_0")
	MissionNarrativePlayer(1, "mp01.nar_comp_timer_warning_1")
	MissionNarrativePlayer(2, "mp01.nar_comp_timer_warning_2")
	MissionNarrativePlayer(3, "mp01.nar_comp_timer_warning_3")
	MissionNarrativePlayer(4, "mp01.nar_comp_timer_warning_4")
	MissionNarrativePlayer(5, "mp01.nar_comp_timer_warning_5")
	MissionNarrativePlayer(6, "mp01.nar_comp_timer_warning_6")
	MissionNarrativePlayer(7, "mp01.nar_comp_timer_warning_7")
end
]]
function luaQAC1CheckAttackerPlanes()
	if Mission.MaxAttackerPlanes ~= nil then
-- RELEASE_LOGOFF  		luaLog(" Checking attacker planes...")
		if Mission.AttackerPlanes ~= nil then
			if table.getn(Mission.AttackerPlanes) == 1 then
				for index, unit in pairs (Mission.AttackerPlanes) do
					if unit.Dead then
-- RELEASE_LOGOFF  						luaLog("  dead buffalo found, checking for HQs...")
						if Mission.USHQs[1].Party == PARTY_ALLIED then
							luaQAC1SpawnAttackerPlane(index, 1)
						elseif Mission.USHQs[2].Party == PARTY_ALLIED then
							luaQAC1SpawnAttackerPlane(index, 2)
						end
					elseif not unit.Dead then
						luaQAC1CheckAttackTarget(index, unit)
					end
				end
			elseif table.getn(Mission.AttackerPlanes) == 2 then
				for index, unit in pairs (Mission.AttackerPlanes) do
					if unit.Dead then
-- RELEASE_LOGOFF  						luaLog("  dead buffalo found, checking for HQs...")
						if index == 1 then
							if Mission.USHQs[1].Party == PARTY_ALLIED then
								luaQAC1SpawnAttackerPlane(index, 1)
							elseif Mission.USHQs[2].Party == PARTY_ALLIED then
								luaQAC1SpawnAttackerPlane(index, 2)
							end
						elseif index == 2 then
							if Mission.USHQs[2].Party == PARTY_ALLIED then
								luaQAC1SpawnAttackerPlane(index, 2)
							elseif Mission.USHQs[1].Party == PARTY_ALLIED then
								luaQAC1SpawnAttackerPlane(index, 1)
							end
						end
					elseif not unit.Dead then
						luaQAC1CheckAttackTarget(index, unit)
					end
				end
			elseif table.getn(Mission.AttackerPlanes) == 3 then
				for index, unit in pairs (Mission.AttackerPlanes) do
					if unit.Dead then
-- RELEASE_LOGOFF  						luaLog("  dead buffalo found, checking for HQs...")
						if index == 1 then
							if Mission.USHQs[1].Party == PARTY_ALLIED then
								luaQAC1SpawnAttackerPlane(index, 1)
							elseif Mission.USHQs[2].Party == PARTY_ALLIED then
								luaQAC1SpawnAttackerPlane(index, 2)
							end
						elseif index == 2 then
							if Mission.USHQs[1].Party == PARTY_ALLIED then
								luaQAC1SpawnAttackerPlane(index, 1)
							end
						elseif index == 3 then
							if Mission.USHQs[2].Party == PARTY_ALLIED then
								luaQAC1SpawnAttackerPlane(index, 2)
							end
						end
					elseif not unit.Dead then
						luaQAC1CheckAttackTarget(index, unit)
					end
				end
			elseif table.getn(Mission.AttackerPlanes) == 4 then
				for index, unit in pairs (Mission.AttackerPlanes) do
					if unit.Dead then
-- RELEASE_LOGOFF  						luaLog("  dead buffalo found, checking for HQs...")
						if index == 1 or index == 2 then
							if Mission.USHQs[1].Party == PARTY_ALLIED then
								luaQAC1SpawnAttackerPlane(index, 1)
							end
						elseif index == 3 or index == 4 then
							if Mission.USHQs[2].Party == PARTY_ALLIED then
								luaQAC1SpawnAttackerPlane(index, 2)
							end
						end
					elseif not unit.Dead then
						luaQAC1CheckAttackTarget(index, unit)
					end
				end
			end
		end
	end
end

function luaQAC1SpawnAttackerPlane(index, hqindex)
-- RELEASE_LOGOFF  	luaLog("   spawning buffalo to HQ number "..hqindex)
	local modifier = index * 50
	local hqpos = GetPosition(Mission.USHQs[hqindex])
	local pos = {["x"] = hqpos["x"], ["y"] = 350, ["z"] = hqpos["z"]}
	Mission.AttackerPlanes[index] = GenerateObject(Mission.BuffaloTMPL.Name, hqpos)
	--PutTo(Mission.AttackerPlanes[index], hqpos)
	EntityTurnToPosition(Mission.AttackerPlanes[index], Mission.SpawnPoint)
end

function luaQAC1CheckAttackTarget(index, unit)
-- RELEASE_LOGOFF  	luaLog("  checking attack target...")
	if UnitGetAttackTarget(unit) == nil then
		local possibletargets = luaGetPlanesAroundCoordinate(Mission.CenterPoint, 30000, PARTY_JAPANESE, "own")
		if possibletargets ~= nil then
			local rndtarget = luaPickRnd(possibletargets)
			PilotSetTarget(unit, rndtarget)
-- RELEASE_LOGOFF  			luaLog("   ordering buffalo to attack "..rndtarget.Name)
		else
-- RELEASE_LOGOFF  			luaLog("   target not found for buffalo index "..index..", sending it to patrol")
			PilotMoveToRange(unit, Mission.SpawnPoint, 1500)
		end
	end
end

function luaQAC1CheckShipSpeed()
-- RELEASE_LOGOFF  	luaLog(" Checking ships speed...")
	if table.getn(Mission.USShips) ~= 0 then
		for index, unit in pairs (Mission.USShips) do
			if not unit.Dead then
				if GetShipSpeed(unit) >= 14.5 or GetShipSpeed(unit) <= 15.5 then
					SetShipSpeed(unit, 15)
				end
			end
		end
	end
end

function luaQAC1FilterBombers()
-- RELEASE_LOGOFF  	luaLog(" Filtering bombers...")
	local japplanes = luaGetPlanesAroundCoordinate(Mission.CenterPoint, 30000, PARTY_JAPANESE, "own")
	if japplanes ~= nil then
		for index, unit in pairs (japplanes) do
			--luaLog("  type = "..unit.Class.Type.." found")
			if unit.Class.Type == "LevelBomber" then
				if not unit.filtered and table.getn(GetPayloads(unit)) == 0 then
-- RELEASE_LOGOFF  					luaLog("  levelbomber ID "..unit.ID.." has dropped it's payload, it has to be removed")
					unit.filtered = true
					unit.filtertime = GameTime() + 5
				elseif unit.filtered and not Mission.Completed then
					if unit.killtime == nil and unit.filtertime < GameTime() then
						SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
						SquadronSetTravelAlt(unit, 800)
						PilotMoveTo(unit, Mission.JapExitPoint)
						unit.killtime = GameTime() + 5
-- RELEASE_LOGOFF  						luaLog("  killtime set for levelbomber ID "..unit.ID)
					elseif unit.killtime ~= nil then
						if unit.killtime < GameTime() then
-- RELEASE_LOGOFF  							luaLog("  removing levelbomber ID "..unit.ID)
							--luaLog(" levelbomber ID "..unit.ID.." reached the exitzone")
							Kill(unit, true)
						end
					end
				end
			end
		end
	else
-- RELEASE_LOGOFF  		luaLog("  no Japanese plane found")
	end
end

function luaQAC1CheckUSShips()
-- RELEASE_LOGOFF  	luaLog(" Checking US ships...")
	for index, value in pairs (Mission.USShipFlags) do
		if value == false then
-- RELEASE_LOGOFF  			luaLog("  dead ship found, it needs to be replaced...")
			local randompos = luaRnd(1, 8)
			if luaGetShipsAroundCoordinate(Mission.USEntryPoints[randompos], 200, PARTY_ALLIED, "own") == nil then
-- RELEASE_LOGOFF  				luaLog("   replacing ship with "..Mission.USShips[index].Name.." | moving to pos "..randompos)
				Mission.USShips[index] = GenerateObject(Mission.USShipTMPLs[index].Name, Mission.USEntryPoints[randompos])
				--PutTo(Mission.USShips[index], Mission.USEntryPoints[randompos])
				if randompos == 1 or randompos == 5 then
					NavigatorMoveOnPath(Mission.USShips[index], Mission.USExitPaths[1])
				elseif randompos == 2 or randompos == 6 then
					NavigatorMoveOnPath(Mission.USShips[index], Mission.USExitPaths[2])
				elseif randompos == 3 or randompos == 7 then
					NavigatorMoveOnPath(Mission.USShips[index], Mission.USExitPaths[3])
				elseif randompos == 4 or randompos == 8 then
					NavigatorMoveOnPath(Mission.USShips[index], Mission.USExitPaths[4])
				end
				SetShipSpeed(Mission.USShips[index], 15)
				Mission.USShipFlags[index] = true
				for i = 1, 8 do
					luaObj_AddUnit("primary", i, Mission.USShips[index])
				end
			else
-- RELEASE_LOGOFF  				luaLog("   replacement failed, another ship is in the way")
			end
		end
	end

	for index, unit in pairs (Mission.USShips) do
		local pathpoints = FillPathPoints(Mission.USExitPaths[Mission.USPathIndexes[index]])
		local endpoint = pathpoints[Mission.USExitPoints[Mission.USPathIndexes[index]]]
		if unit.Dead then
			Mission.USShipFlags[index] = false
		elseif luaGetDistance(unit, endpoint) < 500 then
			Mission.USShipFlags[index] = false
			Kill(unit, true)
		end
	end
end
--[[
function luaQAC1CheckJapAIUnits()
-- RELEASE_LOGOFF  	luaLog(" Checking Japanese AI units...")
	for index, unit in pairs (Mission.JapShips) do
		if unit.Dead then
			local PlayersInGame = GetPlayerDetails()
			for index, value in pairs (PlayersInGame) do
				MultiScore[index][3] = unit.Name
			end
			MissionNarrativePlayer(0, "mp01.nar_comp_ship_replacement_0")
			MissionNarrativePlayer(1, "mp01.nar_comp_ship_replacement_1")
			MissionNarrativePlayer(2, "mp01.nar_comp_ship_replacement_2")
			MissionNarrativePlayer(3, "mp01.nar_comp_ship_replacement_3")
			MissionNarrativePlayer(4, "mp01.nar_comp_ship_replacement_4")
			MissionNarrativePlayer(5, "mp01.nar_comp_ship_replacement_5")
			MissionNarrativePlayer(6, "mp01.nar_comp_ship_replacement_6")
			MissionNarrativePlayer(7, "mp01.nar_comp_ship_replacement_7")
			Mission.JapShips[index] = GenerateObject(Mission.JapShipTMPLs[index].Name)
		end
	end

	if Mission.JapHQ.Party ~= 1 then
-- RELEASE_LOGOFF  		luaLog("  the HQ is not japanese...")
		if Mission.CaptureNeeded then
-- RELEASE_LOGOFF  			luaLog("   recaping HQ")
			Mission.CaptureNeeded = false
			PermitSupportmanager()
			for i = 0, 7 do
				MissionNarrativePlayer(i, "mp01.nar_comp_ship_recapture")
			end
			SetParty(Mission.JapHQ, 1)
			SetRoleAvailable(Mission.JapHQ, EROLF_ALL, PLAYER_AI)
		else
-- RELEASE_LOGOFF  			luaLog("   setting recap flag to true")
			Mission.CaptureNeeded = true
			BannSupportmanager()
			for i = 0, 7 do
				MissionNarrativePlayer(i, "mp01.nar_comp_hq_lost")
			end
		end
	end
end
]]
function luaQAC1CheckMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Checking mission ending conditions...")
--[[
	if Mission.JapHQ.Party ~= PARTY_JAPANESE and not Mission.MissionEndCalled then
		Mission.MissionEndCalled = true
		Mission.MissionFailed = true
		for index, entity in pairs (Mission.SpawnPoints) do
			local slotID = index - 1
			for index2, value in pairs (Mission.SlotIDTable) do
				if slotID == value then
-- RELEASE_LOGOFF  					luaLog(" deactivating SPID "..index.." for slotID "..value)
					DeactivateSpawnpoint(entity, value)
				end
			end
		end
		luaQAC1MissionEnd()
	end
]]
	if Mission.PointLimit ~= 0 then
		local highestindex, highestplayerscore = luaQAC1CheckHighestScore()
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
			luaDelay(luaQAC1MissionEnd, 0.1)
		end
	end
end

function luaQAC1CheckHighestScore()
	--luaLog("!SCORES: ")
	local MPlayers = GetPlayerDetails()
	local actplayerscore = 0
	local highestplayerscore = 0
	local highestindex = 0
	for slotID, value in pairs (MPlayers) do
		actplayerscore = Scoring_GetTotalMissionScore(slotID)
-- RELEASE_LOGOFF  		luaLog(" playerindex: "..slotID.." | score: "..actplayerscore)
		if actplayerscore > highestplayerscore then
			highestplayerscore = actplayerscore
			highestindex = slotID
		end
	end
	--luaLog(" highestindex: "..highestindex)
	--luaLog(" highestplayerscore: "..highestplayerscore)
	return highestindex, highestplayerscore
end

function luaQAC1MissionEndTimeIsUp()
	MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_time_up")
	local highestindex, highestplayerscore = luaQAC1CheckHighestScore()
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
	luaDelay(luaQAC1MissionEnd, 0.1)
end

function luaQAC1MissionEnd()
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
		local highestindex, highestplayerscore = luaQAC1CheckHighestScore()
-- RELEASE_LOGOFF  		luaLog(" player "..highestindex.." won")
		local objindex = highestindex + 1
		luaObj_Completed("primary", objindex)
		for i = 1, 8 do
			if i ~= objindex then
				luaObj_Failed("primary", i)
			end
		end

		if Mission.MissionFailed then
			--luaObj_Failed("primary", 9)
		else
			--luaObj_Completed("primary", 9)
		end

		luaQAC1DelayedMissionComplete()
		--luaDelay(luaQAC1DelayedMissionComplete, 2)
	end
end

function luaQAC1DelayedMissionComplete()
	if not Mission.MissionEnd then
		if Mission.MissionFailed then
			luaMissionCompletedNew(Mission.JapHQ, "", nil, nil, nil, PARTY_ALLIED)
		else
			local planes = luaGetPlanesAroundCoordinate(Mission.CenterPoint, 30000, PARTY_JAPANESE, "own")
			Scoring_RealPlayTimeRunning(false)
			if planes ~= nil then
				local movietarget = luaPickRnd(planes)
				if movietarget.Class.Type == "LevelBomber" then
					luaMissionCompletedNew(movietarget, "", nil, nil, nil, PARTY_JAPANESE)
				else
					local moviebetty = GenerateObject(Mission.BettyTMPL.Name, Mission.SpawnPoint)
					--PutTo(moviebetty, Mission.SpawnPoint)
					--EntityTurnToPosition(moviebetty, Mission.BuffaloSpawnPoints[2])
					--PilotMoveTo(moviebetty, Mission.BuffaloSpawnPoints[2])
					luaMissionCompletedNew(moviebetty, "", nil, nil, nil, PARTY_JAPANESE)
				end
			else
				local moviebetty = GenerateObject(Mission.BettyTMPL.Name, Mission.SpawnPoint)
				--PutTo(moviebetty, Mission.SpawnPoint)
				--EntityTurnToPosition(moviebetty, Mission.BuffaloSpawnPoints[2])
				--PilotMoveTo(moviebetty, Mission.BuffaloSpawnPoints[2])
				luaMissionCompletedNew(moviebetty, "", nil, nil, nil, PARTY_JAPANESE)
			end
		end
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Competitive01")
	-- mode description hint overlay
end

function luaUpdateCounters()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Updating counters...")
		if MultiScore ~= nil then
			if table.getn(MultiScore) ~= 0 then
	--[[
				local highestindex, highestplayerscore = luaQAC1CheckHighestScore()
				for i = 0, 7 do
					MultiScore[i][2] = highestplayerscore
				end
	]]
				local PlayersInGame = GetPlayerDetails()
				local highestindex, highestplayerscore = luaQAC1CheckHighestScore()
				for index, value in pairs (PlayersInGame) do
					MultiScore[index][1] = Scoring_GetTotalMissionScore(index)
					MultiScore[index][5] = highestplayerscore
				end
			end
		end
	
		luaDelay(luaUpdateCounters, 0.7)
	end
end

---- cheat ----

function luaComplete()
	local highestindex, highestplayerscore = luaQAC1CheckHighestScore()
	local objindex = highestindex + 1
	luaObj_Completed("primary", objindex)
	for i = 1, 8 do
		if i ~= objindex then
			luaObj_Failed("primary", i)
		end
	end

	Scoring_RealPlayTimeRunning(false)
	luaMissionCompletedNew(Mission.JapHQ, "")
end

--------------------------------

function luaQAC1CheckUSShipsNew()
-- RELEASE_LOGOFF  	luaLog(" Checking US ships...")
	Mission.USShips = luaRemoveDeadsFromTable(Mission.USShips)
	if table.getn(Mission.USShips) == 0 and not Mission.SpawnStarted then
		Mission.SpawnStarted = true
		luaDelay(luaQAC1ResetSpawn, 7)
		local formation = luaRnd(1, 12)
-- RELEASE_LOGOFF  		luaLog("  a new wave is needed, setting one up with formation number "..formation)
		local pos2 = nil
		local pos3 = nil
		local pos4 = nil
		local pos5 = nil
		local pos6 = nil
		local pos7 = nil
		local pos8 = nil
		local pos9 = nil
		local pos10 = nil
		local pos11 = nil
		local pos12 = nil
		if formation == 1 then
			luaDelay(luaQAC1FleetNarrative, 6)
			--local pos1 = GetPosition(FindEntity("Comp - US Ship SP1"))
			Mission.LeaderPosition = luaRnd(1, 2)
			Mission.Pos1 = Mission.USSpawnPositions[Mission.LeaderPosition]
			if Mission.LeaderPosition == 1 then
				pos2 = {["x"] = Mission.Pos1.x - 140, ["y"] = 0, ["z"] = Mission.Pos1.z + 140}
				pos3 = {["x"] = Mission.Pos1.x - 140, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos4 = {["x"] = Mission.Pos1.x - 140, ["y"] = 0, ["z"] = Mission.Pos1.z - 140}
				pos5 = {["x"] = Mission.Pos1.x - 280, ["y"] = 0, ["z"] = Mission.Pos1.z + 280}
				pos6 = {["x"] = Mission.Pos1.x - 280, ["y"] = 0, ["z"] = Mission.Pos1.z + 140}
				pos7 = {["x"] = Mission.Pos1.x - 280, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos8 = {["x"] = Mission.Pos1.x - 280, ["y"] = 0, ["z"] = Mission.Pos1.z - 140}
				pos9 = {["x"] = Mission.Pos1.x - 280, ["y"] = 0, ["z"] = Mission.Pos1.z - 280}
			elseif Mission.LeaderPosition == 2 then
				pos2 = {["x"] = Mission.Pos1.x + 140, ["y"] = 0, ["z"] = Mission.Pos1.z - 140}
				pos3 = {["x"] = Mission.Pos1.x + 140, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos4 = {["x"] = Mission.Pos1.x + 140, ["y"] = 0, ["z"] = Mission.Pos1.z + 140}
				pos5 = {["x"] = Mission.Pos1.x + 280, ["y"] = 0, ["z"] = Mission.Pos1.z - 280}
				pos6 = {["x"] = Mission.Pos1.x + 280, ["y"] = 0, ["z"] = Mission.Pos1.z - 140}
				pos7 = {["x"] = Mission.Pos1.x + 280, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos8 = {["x"] = Mission.Pos1.x + 280, ["y"] = 0, ["z"] = Mission.Pos1.z + 140}
				pos9 = {["x"] = Mission.Pos1.x + 280, ["y"] = 0, ["z"] = Mission.Pos1.z + 280}
			end
			local ship1ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(Mission.Pos1, Mission.USBigShipID[ship1ID], Mission.USBigShipName[ship1ID], 1, 0)
			local ship2ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos2, Mission.USMediumShipID[ship2ID], Mission.USMediumShipName[ship2ID], 1, 0)
			local ship3ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos3, Mission.USMediumShipID[ship3ID], Mission.USMediumShipName[ship3ID], 1, 0)
			local ship4ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos4, Mission.USMediumShipID[ship4ID], Mission.USMediumShipName[ship4ID], 1, 0)
			local ship5ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos5, Mission.USSmallShipID[ship5ID], Mission.USSmallShipName[ship5ID], 1, 0)
			local ship6ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos6, Mission.USSmallShipID[ship6ID], Mission.USSmallShipName[ship6ID], 1, 0)
--[[
			local ship7ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos7, Mission.USSmallShipID[ship7ID], Mission.USSmallShipName[ship7ID], 1, 0)
			local ship8ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos8, Mission.USSmallShipID[ship8ID], Mission.USSmallShipName[ship8ID], 1, 0)
			local ship9ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos9, Mission.USSmallShipID[ship9ID], Mission.USSmallShipName[ship9ID], 1, 0)
]]
			luaDelay(luaQAC1DistanceCheckEnabler, 5)

		elseif formation == 2 then
			luaDelay(luaQAC1FleetNarrative, 6)
			--local pos1 = GetPosition(FindEntity("Comp - US Ship SP1"))
			Mission.LeaderPosition = luaRnd(1, 2)
			Mission.Pos1 = Mission.USSpawnPositions[Mission.LeaderPosition]
			if Mission.LeaderPosition == 1 then
				pos2 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 600}
				pos3 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 600}
				pos4 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos5 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos6 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos7 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos8 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos9 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos10 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
			elseif Mission.LeaderPosition == 2 then
				pos2 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 600}
				pos3 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 600}
				pos4 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos5 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos6 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos7 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos8 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos9 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos10 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
			end
			local ship1ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(Mission.Pos1, Mission.USMediumShipID[ship1ID], Mission.USMediumShipName[ship1ID], 1, 0)
			local ship2ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos2, Mission.USMediumShipID[ship2ID], Mission.USMediumShipName[ship2ID], 1, 0)
			local ship3ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos3, Mission.USMediumShipID[ship3ID], Mission.USMediumShipName[ship3ID], 1, 0)
			local ship4ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(pos4, Mission.USBigShipID[ship4ID], Mission.USBigShipName[ship4ID], 1, 0)
			local ship5ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(pos5, Mission.USBigShipID[ship5ID], Mission.USBigShipName[ship5ID], 1, 0)
			local ship6ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos6, Mission.USSmallShipID[ship6ID], Mission.USSmallShipName[ship6ID], 1, 0)
--[[
			local ship7ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos7, Mission.USSmallShipID[ship7ID], Mission.USSmallShipName[ship7ID], 1, 0)
			local ship8ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos8, Mission.USSmallShipID[ship8ID], Mission.USSmallShipName[ship8ID], 1, 0)
			local ship9ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos9, Mission.USSmallShipID[ship9ID], Mission.USSmallShipName[ship9ID], 1, 0)
			local ship10ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos10, Mission.USSmallShipID[ship10ID], Mission.USSmallShipName[ship10ID], 1, 0)
]]
			luaDelay(luaQAC1DistanceCheckEnabler, 5)

		elseif formation == 3 then
			luaDelay(luaQAC1FleetNarrative, 6)
			--local pos1 = GetPosition(FindEntity("Comp - US Ship SP1"))
			Mission.LeaderPosition = luaRnd(1, 2)
			Mission.Pos1 = Mission.USSpawnPositions[Mission.LeaderPosition]
			if Mission.LeaderPosition == 1 then
				pos2 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 400}
				pos3 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 400}
				pos4 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos5 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 400}
				pos6 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 400}
				pos7 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos8 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z + 400}
				pos9 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z - 400}
				pos10 = {["x"] = Mission.Pos1.x - 900, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos11 = {["x"] = Mission.Pos1.x - 900, ["y"] = 0, ["z"] = Mission.Pos1.z + 400}
				pos12 = {["x"] = Mission.Pos1.x - 900, ["y"] = 0, ["z"] = Mission.Pos1.z - 400}
			elseif Mission.LeaderPosition == 2 then
				pos2 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 400}
				pos3 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 400}
				pos4 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos5 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 400}
				pos6 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 400}
				pos7 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos8 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z - 400}
				pos9 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z + 400}
				pos10 = {["x"] = Mission.Pos1.x + 900, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos11 = {["x"] = Mission.Pos1.x + 900, ["y"] = 0, ["z"] = Mission.Pos1.z - 400}
				pos12 = {["x"] = Mission.Pos1.x + 900, ["y"] = 0, ["z"] = Mission.Pos1.z + 400}
			end
			local ship1ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(Mission.Pos1, Mission.USBigShipID[ship1ID], Mission.USBigShipName[ship1ID], 1, 0)
			local ship2ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(pos2, Mission.USBigShipID[ship2ID], Mission.USBigShipName[ship2ID], 1, 0)
			local ship3ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(pos3, Mission.USBigShipID[ship3ID], Mission.USBigShipName[ship3ID], 1, 0)
			local ship4ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos4, Mission.USMediumShipID[ship4ID], Mission.USMediumShipName[ship4ID], 1, 0)
			local ship5ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos5, Mission.USMediumShipID[ship5ID], Mission.USMediumShipName[ship5ID], 1, 0)
			local ship6ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos6, Mission.USMediumShipID[ship6ID], Mission.USMediumShipName[ship6ID], 1, 0)
--[[
			local ship7ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos7, Mission.USSmallShipID[ship7ID], Mission.USSmallShipName[ship7ID], 1, 0)
			local ship8ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos8, Mission.USSmallShipID[ship8ID], Mission.USSmallShipName[ship8ID], 1, 0)
			local ship9ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos9, Mission.USSmallShipID[ship9ID], Mission.USSmallShipName[ship9ID], 1, 0)
			local ship10ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos10, Mission.USSmallShipID[ship10ID], Mission.USSmallShipName[ship10ID], 1, 0)
			local ship11ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos11, Mission.USSmallShipID[ship11ID], Mission.USSmallShipName[ship11ID], 1, 0)
			local ship12ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos12, Mission.USSmallShipID[ship12ID], Mission.USSmallShipName[ship12ID], 1, 0)
]]
			luaDelay(luaQAC1DistanceCheckEnabler, 5)

		elseif formation == 4 then
			luaDelay(luaQAC1FleetNarrative, 6)
			--local pos1 = GetPosition(FindEntity("Comp - US Ship SP1"))
			Mission.LeaderPosition = luaRnd(1, 2)
			Mission.Pos1 = Mission.USSpawnPositions[Mission.LeaderPosition]
			if Mission.LeaderPosition == 1 then
				pos2 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 600}
				pos3 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 600}
				pos4 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos5 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos6 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos7 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos8 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
			elseif Mission.LeaderPosition == 2 then
				pos2 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 600}
				pos3 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 600}
				pos4 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos5 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos6 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos7 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos8 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
			end
			local ship1ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(Mission.Pos1, Mission.USMediumShipID[ship1ID], Mission.USMediumShipName[ship1ID], 1, 0)
			local ship2ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos2, Mission.USMediumShipID[ship2ID], Mission.USMediumShipName[ship2ID], 1, 0)
			local ship3ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos3, Mission.USMediumShipID[ship3ID], Mission.USMediumShipName[ship3ID], 1, 0)
			local ship4ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos4, Mission.USSmallShipID[ship4ID], Mission.USSmallShipName[ship4ID], 1, 0)
			local ship5ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos5, Mission.USSmallShipID[ship5ID], Mission.USSmallShipName[ship5ID], 1, 0)
			local ship6ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos6, Mission.USSmallShipID[ship6ID], Mission.USSmallShipName[ship6ID], 1, 0)
--[[
			local ship7ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos7, Mission.USSmallShipID[ship7ID], Mission.USSmallShipName[ship7ID], 1, 0)
			local ship8ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos8, Mission.USSmallShipID[ship8ID], Mission.USSmallShipName[ship8ID], 1, 0)
]]
			luaDelay(luaQAC1DistanceCheckEnabler, 5)

		elseif formation == 5 then
			luaDelay(luaQAC1FleetNarrative, 6)
			--local pos1 = GetPosition(FindEntity("Comp - US Ship SP1"))
			Mission.LeaderPosition = luaRnd(1, 2)
			Mission.Pos1 = Mission.USSpawnPositions[Mission.LeaderPosition]
			if Mission.LeaderPosition == 1 then
				pos2 = {["x"] = Mission.Pos1.x - 250, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos3 = {["x"] = Mission.Pos1.x - 250, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos4 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 600}
				pos5 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 600}
				pos6 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos7 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos8 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos9 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos10 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos11 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
			elseif Mission.LeaderPosition == 2 then
				pos2 = {["x"] = Mission.Pos1.x + 250, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos3 = {["x"] = Mission.Pos1.x + 250, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos4 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 600}
				pos5 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 600}
				pos6 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos7 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos8 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos9 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos10 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos11 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
			end
			local ship1ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(Mission.Pos1, Mission.USMediumShipID[ship1ID], Mission.USMediumShipName[ship1ID], 1, 0)
			local ship2ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos2, Mission.USMediumShipID[ship2ID], Mission.USMediumShipName[ship2ID], 1, 0)
			local ship3ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos3, Mission.USMediumShipID[ship3ID], Mission.USMediumShipName[ship3ID], 1, 0)
			local ship4ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos4, Mission.USSmallShipID[ship4ID], Mission.USSmallShipName[ship4ID], 1, 0)
			local ship5ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos5, Mission.USSmallShipID[ship5ID], Mission.USSmallShipName[ship5ID], 1, 0)
			local ship6ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos6, Mission.USSmallShipID[ship6ID], Mission.USSmallShipName[ship6ID], 1, 0)
--[[
			local ship7ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos7, Mission.USSmallShipID[ship7ID], Mission.USSmallShipName[ship7ID], 1, 0)
			local ship8ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos8, Mission.USSmallShipID[ship8ID], Mission.USSmallShipName[ship8ID], 1, 0)
			local ship9ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos9, Mission.USSmallShipID[ship9ID], Mission.USSmallShipName[ship9ID], 1, 0)
			local ship10ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos10, Mission.USSmallShipID[ship10ID], Mission.USSmallShipName[ship10ID], 1, 0)
			local ship11ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos11, Mission.USSmallShipID[ship11ID], Mission.USSmallShipName[ship11ID], 1, 0)
]]
			luaDelay(luaQAC1DistanceCheckEnabler, 5)

		elseif formation == 6 then
			luaDelay(luaQAC1FleetNarrative, 6)
			--local pos1 = GetPosition(FindEntity("Comp - US Ship SP1"))
			Mission.LeaderPosition = luaRnd(1, 2)
			Mission.Pos1 = Mission.USSpawnPositions[Mission.LeaderPosition]
			if Mission.LeaderPosition == 1 then
				pos2 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos3 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos4 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos5 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 600}
				pos6 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 600}
				pos7 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos8 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos9 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z + 250}
				pos10 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z - 250}
				pos11 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
			elseif Mission.LeaderPosition == 2 then
				pos2 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos3 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos4 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos5 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 600}
				pos6 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 600}
				pos7 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos8 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos9 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z - 250}
				pos10 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z + 250}
				pos11 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
			end
			local ship1ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(Mission.Pos1, Mission.USBigShipID[ship1ID], Mission.USBigShipName[ship1ID], 1, 0)
			local ship2ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos2, Mission.USMediumShipID[ship2ID], Mission.USMediumShipName[ship2ID], 1, 0)
			local ship3ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos3, Mission.USMediumShipID[ship3ID], Mission.USMediumShipName[ship3ID], 1, 0)
			local ship4ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos4, Mission.USMediumShipID[ship4ID], Mission.USMediumShipName[ship4ID], 1, 0)
			local ship5ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos5, Mission.USSmallShipID[ship5ID], Mission.USSmallShipName[ship5ID], 1, 0)
			local ship6ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos6, Mission.USSmallShipID[ship6ID], Mission.USSmallShipName[ship6ID], 1, 0)
--[[
			local ship7ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos7, Mission.USSmallShipID[ship7ID], Mission.USSmallShipName[ship7ID], 1, 0)
			local ship8ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos8, Mission.USSmallShipID[ship8ID], Mission.USSmallShipName[ship8ID], 1, 0)
			local ship9ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos9, Mission.USSmallShipID[ship9ID], Mission.USSmallShipName[ship9ID], 1, 0)
			local ship10ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos10, Mission.USSmallShipID[ship10ID], Mission.USSmallShipName[ship10ID], 1, 0)
			local ship11ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos11, Mission.USSmallShipID[ship11ID], Mission.USSmallShipName[ship11ID], 1, 0)
]]
			luaDelay(luaQAC1DistanceCheckEnabler, 5)

		elseif formation == 7 then
			luaDelay(luaQAC1FleetNarrative, 6)
			--local pos1 = GetPosition(FindEntity("Comp - US Ship SP1"))
			Mission.LeaderPosition = luaRnd(1, 2)
			Mission.Pos1 = Mission.USSpawnPositions[Mission.LeaderPosition]
			if Mission.LeaderPosition == 1 then
				pos2 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos3 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 200}
				pos4 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 200}
				pos5 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z + 200}
				pos6 = {["x"] = Mission.Pos1.x + 175, ["y"] = 0, ["z"] = Mission.Pos1.z - 400}
				pos7 = {["x"] = Mission.Pos1.x - 200, ["y"] = 0, ["z"] = Mission.Pos1.z - 400}
				pos8 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 200}
				pos9 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z - 200}
			elseif Mission.LeaderPosition == 2 then
				pos2 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos3 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 200}
				pos4 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 200}
				pos5 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z - 200}
				pos6 = {["x"] = Mission.Pos1.x - 175, ["y"] = 0, ["z"] = Mission.Pos1.z + 400}
				pos7 = {["x"] = Mission.Pos1.x + 200, ["y"] = 0, ["z"] = Mission.Pos1.z + 400}
				pos8 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 200}
				pos9 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z + 200}
			end
			local ship1ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(Mission.Pos1, Mission.USBigShipID[ship1ID], Mission.USBigShipName[ship1ID], 1, 0)
			local ship2ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(pos2, Mission.USBigShipID[ship2ID], Mission.USBigShipName[ship2ID], 1, 0)
			local ship3ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos3, Mission.USMediumShipID[ship3ID], Mission.USMediumShipName[ship3ID], 1, 0)
			local ship4ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos4, Mission.USMediumShipID[ship4ID], Mission.USMediumShipName[ship4ID], 1, 0)
			local ship5ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos5, Mission.USMediumShipID[ship5ID], Mission.USMediumShipName[ship5ID], 1, 0)
			local ship6ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos6, Mission.USSmallShipID[ship6ID], Mission.USSmallShipName[ship6ID], 1, 0)
--[[
			local ship7ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos7, Mission.USSmallShipID[ship7ID], Mission.USSmallShipName[ship7ID], 1, 0)
			local ship8ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos8, Mission.USSmallShipID[ship8ID], Mission.USSmallShipName[ship8ID], 1, 0)
			local ship9ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos9, Mission.USSmallShipID[ship9ID], Mission.USSmallShipName[ship9ID], 1, 0)
]]
			luaDelay(luaQAC1DistanceCheckEnabler, 5)

		elseif formation == 8 then
			luaDelay(luaQAC1FleetNarrative, 6)
			--local pos1 = GetPosition(FindEntity("Comp - US Ship SP1"))
			Mission.LeaderPosition = luaRnd(1, 2)
			Mission.Pos1 = Mission.USSpawnPositions[Mission.LeaderPosition]
			if Mission.LeaderPosition == 1 then
				pos2 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos3 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos4 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos5 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos6 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 425}
				pos7 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 425}
				pos8 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 600}
				pos9 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 600}
			elseif Mission.LeaderPosition == 2 then
				pos2 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos3 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos4 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos5 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos6 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 425}
				pos7 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 425}
				pos8 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 600}
				pos9 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 600}
			end
			local ship1ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(Mission.Pos1, Mission.USBigShipID[ship1ID], Mission.USBigShipName[ship1ID], 1, 0)
			local ship2ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(pos2, Mission.USBigShipID[ship2ID], Mission.USBigShipName[ship2ID], 1, 0)
			local ship3ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos3, Mission.USMediumShipID[ship3ID], Mission.USMediumShipName[ship3ID], 1, 0)
			local ship4ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos4, Mission.USSmallShipID[ship4ID], Mission.USSmallShipName[ship4ID], 1, 0)
			local ship5ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos5, Mission.USSmallShipID[ship5ID], Mission.USSmallShipName[ship5ID], 1, 0)
			local ship6ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos6, Mission.USSmallShipID[ship6ID], Mission.USSmallShipName[ship6ID], 1, 0)
--[[
			local ship7ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos7, Mission.USSmallShipID[ship7ID], Mission.USSmallShipName[ship7ID], 1, 0)
			local ship8ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos8, Mission.USSmallShipID[ship8ID], Mission.USSmallShipName[ship8ID], 1, 0)
			local ship9ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos9, Mission.USSmallShipID[ship9ID], Mission.USSmallShipName[ship9ID], 1, 0)
]]
			luaDelay(luaQAC1DistanceCheckEnabler, 5)

		elseif formation == 9 then
			luaDelay(luaQAC1FleetNarrative, 6)
			--local pos1 = GetPosition(FindEntity("Comp - US Ship SP1"))
			Mission.LeaderPosition = luaRnd(1, 2)
			Mission.Pos1 = Mission.USSpawnPositions[Mission.LeaderPosition]
			if Mission.LeaderPosition == 1 then
				pos2 = {["x"] = Mission.Pos1.x - 400, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos3 = {["x"] = Mission.Pos1.x - 650, ["y"] = 0, ["z"] = Mission.Pos1.z + 200}
				pos4 = {["x"] = Mission.Pos1.x - 650, ["y"] = 0, ["z"] = Mission.Pos1.z - 200}
				pos5 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos6 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos7 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 450}
				pos8 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 450}
				pos9 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z + 600}
				pos10 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z - 600}
			elseif Mission.LeaderPosition == 2 then
				pos2 = {["x"] = Mission.Pos1.x + 400, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos3 = {["x"] = Mission.Pos1.x + 650, ["y"] = 0, ["z"] = Mission.Pos1.z - 200}
				pos4 = {["x"] = Mission.Pos1.x + 650, ["y"] = 0, ["z"] = Mission.Pos1.z + 200}
				pos5 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos6 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos7 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 450}
				pos8 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 450}
				pos9 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z - 600}
				pos10 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z + 600}
			end
			local ship1ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(Mission.Pos1, Mission.USBigShipID[ship1ID], Mission.USBigShipName[ship1ID], 1, 0)
			local ship2ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos2, Mission.USMediumShipID[ship2ID], Mission.USMediumShipName[ship2ID], 1, 0)
			local ship3ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos3, Mission.USMediumShipID[ship3ID], Mission.USMediumShipName[ship3ID], 1, 0)
			local ship4ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos4, Mission.USMediumShipID[ship4ID], Mission.USMediumShipName[ship4ID], 1, 0)
			local ship5ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos5, Mission.USSmallShipID[ship5ID], Mission.USSmallShipName[ship5ID], 1, 0)
			local ship6ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos6, Mission.USSmallShipID[ship6ID], Mission.USSmallShipName[ship6ID], 1, 0)
--[[
			local ship7ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos7, Mission.USSmallShipID[ship7ID], Mission.USSmallShipName[ship7ID], 1, 0)
			local ship8ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos8, Mission.USSmallShipID[ship8ID], Mission.USSmallShipName[ship8ID], 1, 0)
			local ship9ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos9, Mission.USSmallShipID[ship9ID], Mission.USSmallShipName[ship9ID], 1, 0)
			local ship10ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos10, Mission.USSmallShipID[ship10ID], Mission.USSmallShipName[ship10ID], 1, 0)
]]
			luaDelay(luaQAC1DistanceCheckEnabler, 5)

		elseif formation == 10 then
			luaDelay(luaQAC1FleetNarrative, 6)
			--local pos1 = GetPosition(FindEntity("Comp - US Ship SP1"))
			Mission.LeaderPosition = luaRnd(1, 2)
			Mission.Pos1 = Mission.USSpawnPositions[Mission.LeaderPosition]
			if Mission.LeaderPosition == 1 then
				pos2 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos3 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos4 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos5 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos6 = {["x"] = Mission.Pos1.x - 750, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos7 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 200}
				pos8 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 200}
				pos9 = {["x"] = Mission.Pos1.x - 150, ["y"] = 0, ["z"] = Mission.Pos1.z + 600}
				pos10 = {["x"] = Mission.Pos1.x - 150, ["y"] = 0, ["z"] = Mission.Pos1.z - 600}
				pos11 = {["x"] = Mission.Pos1.x - 650, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos12 = {["x"] = Mission.Pos1.x - 650, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
			elseif Mission.LeaderPosition == 2 then
				pos2 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos3 = {["x"] = Mission.Pos1.x, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos4 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos5 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos6 = {["x"] = Mission.Pos1.x + 750, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos7 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 200}
				pos8 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 200}
				pos9 = {["x"] = Mission.Pos1.x + 150, ["y"] = 0, ["z"] = Mission.Pos1.z - 600}
				pos10 = {["x"] = Mission.Pos1.x + 150, ["y"] = 0, ["z"] = Mission.Pos1.z + 600}
				pos11 = {["x"] = Mission.Pos1.x + 650, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos12 = {["x"] = Mission.Pos1.x + 650, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
			end
			local ship1ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(Mission.Pos1, Mission.USBigShipID[ship1ID], Mission.USBigShipName[ship1ID], 1, 0)
			local ship2ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos2, Mission.USMediumShipID[ship2ID], Mission.USMediumShipName[ship2ID], 1, 0)
			local ship3ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos3, Mission.USMediumShipID[ship3ID], Mission.USMediumShipName[ship3ID], 1, 0)
			local ship4ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos4, Mission.USMediumShipID[ship4ID], Mission.USMediumShipName[ship4ID], 1, 0)
			local ship5ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos5, Mission.USMediumShipID[ship5ID], Mission.USMediumShipName[ship5ID], 1, 0)
			local ship6ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos6, Mission.USMediumShipID[ship6ID], Mission.USMediumShipName[ship6ID], 1, 0)
--[[
			local ship7ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos7, Mission.USSmallShipID[ship7ID], Mission.USSmallShipName[ship7ID], 1, 0)
			local ship8ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos8, Mission.USSmallShipID[ship8ID], Mission.USSmallShipName[ship8ID], 1, 0)
			local ship9ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos9, Mission.USSmallShipID[ship9ID], Mission.USSmallShipName[ship9ID], 1, 0)
			local ship10ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos10, Mission.USSmallShipID[ship10ID], Mission.USSmallShipName[ship10ID], 1, 0)
			local ship11ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos11, Mission.USSmallShipID[ship11ID], Mission.USSmallShipName[ship11ID], 1, 0)
			local ship12ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos12, Mission.USSmallShipID[ship12ID], Mission.USSmallShipName[ship12ID], 1, 0)
]]
			luaDelay(luaQAC1DistanceCheckEnabler, 5)

		elseif formation == 11 then
			luaDelay(luaQAC1FleetNarrative, 6)
			--local pos1 = GetPosition(FindEntity("Comp - US Ship SP1"))
			Mission.LeaderPosition = luaRnd(1, 2)
			Mission.Pos1 = Mission.USSpawnPositions[Mission.LeaderPosition]
			if Mission.LeaderPosition == 1 then
				pos2 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos3 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos4 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos5 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z + 600}
				pos6 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z - 600}
			elseif Mission.LeaderPosition == 2 then
				pos2 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos3 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos4 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z}
				pos5 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z - 600}
				pos6 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z + 600}
			end
			local ship1ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(Mission.Pos1, Mission.USBigShipID[ship1ID], Mission.USBigShipName[ship1ID], 1, 0)
			local ship2ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(pos2, Mission.USBigShipID[ship2ID], Mission.USBigShipName[ship2ID], 1, 0)
			local ship3ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(pos3, Mission.USBigShipID[ship3ID], Mission.USBigShipName[ship3ID], 1, 0)
			local ship4ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(pos4, Mission.USBigShipID[ship4ID], Mission.USBigShipName[ship4ID], 1, 0)
			local ship5ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(pos5, Mission.USBigShipID[ship5ID], Mission.USBigShipName[ship5ID], 1, 0)
			local ship6ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(pos6, Mission.USBigShipID[ship6ID], Mission.USBigShipName[ship6ID], 1, 0)
			luaDelay(luaQAC1DistanceCheckEnabler, 5)

		elseif formation == 12 then
			luaDelay(luaQAC1FleetNarrative, 6)
			--local pos1 = GetPosition(FindEntity("Comp - US Ship SP1"))
			Mission.LeaderPosition = luaRnd(1, 2)
			Mission.Pos1 = Mission.USSpawnPositions[Mission.LeaderPosition]
			if Mission.LeaderPosition == 1 then
				pos2 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos3 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos4 = {["x"] = Mission.Pos1.x + 600, ["y"] = 0, ["z"] = Mission.Pos1.z + 200}
				pos5 = {["x"] = Mission.Pos1.x + 200, ["y"] = 0, ["z"] = Mission.Pos1.z - 550}
				pos6 = {["x"] = Mission.Pos1.x - 200, ["y"] = 0, ["z"] = Mission.Pos1.z - 550}
				pos7 = {["x"] = Mission.Pos1.x + 450, ["y"] = 0, ["z"] = Mission.Pos1.z - 200}
				pos8 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos9 = {["x"] = Mission.Pos1.x - 150, ["y"] = 0, ["z"] = Mission.Pos1.z - 700}
			elseif Mission.LeaderPosition == 2 then
				pos2 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos3 = {["x"] = Mission.Pos1.x + 300, ["y"] = 0, ["z"] = Mission.Pos1.z - 300}
				pos4 = {["x"] = Mission.Pos1.x - 600, ["y"] = 0, ["z"] = Mission.Pos1.z - 200}
				pos5 = {["x"] = Mission.Pos1.x - 200, ["y"] = 0, ["z"] = Mission.Pos1.z + 550}
				pos6 = {["x"] = Mission.Pos1.x + 200, ["y"] = 0, ["z"] = Mission.Pos1.z + 550}
				pos7 = {["x"] = Mission.Pos1.x - 450, ["y"] = 0, ["z"] = Mission.Pos1.z + 200}
				pos8 = {["x"] = Mission.Pos1.x - 300, ["y"] = 0, ["z"] = Mission.Pos1.z + 300}
				pos9 = {["x"] = Mission.Pos1.x + 150, ["y"] = 0, ["z"] = Mission.Pos1.z + 700}
			end
			local ship1ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(Mission.Pos1, Mission.USBigShipID[ship1ID], Mission.USBigShipName[ship1ID], 1, 0)
			local ship2ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(pos2, Mission.USBigShipID[ship2ID], Mission.USBigShipName[ship2ID], 1, 0)
			local ship3ID = luaQAC1RandomUnit("big")
			luaQAC1SpawnUnit(pos3, Mission.USBigShipID[ship3ID], Mission.USBigShipName[ship3ID], 1, 0)
			local ship4ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos4, Mission.USMediumShipID[ship4ID], Mission.USMediumShipName[ship4ID], 1, 0)
			local ship5ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos5, Mission.USMediumShipID[ship5ID], Mission.USMediumShipName[ship5ID], 1, 0)
			local ship6ID = luaQAC1RandomUnit("medium")
			luaQAC1SpawnUnit(pos6, Mission.USMediumShipID[ship6ID], Mission.USMediumShipName[ship6ID], 1, 0)
--[[
			local ship7ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos7, Mission.USSmallShipID[ship7ID], Mission.USSmallShipName[ship7ID], 1, 0)
			local ship8ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos8, Mission.USSmallShipID[ship8ID], Mission.USSmallShipName[ship8ID], 1, 0)
			local ship9ID = luaQAC1RandomUnit("small")
			luaQAC1SpawnUnit(pos9, Mission.USSmallShipID[ship9ID], Mission.USSmallShipName[ship9ID], 1, 0)
]]
			luaDelay(luaQAC1DistanceCheckEnabler, 5)
		end
	elseif table.getn(Mission.USShips) ~= 0 and not Mission.DistanceCheckDisabled then
		if not Mission.PathInitiated then
			Mission.PathInitiated = true
			local pathpoints1 = FillPathPoints(FindEntity("Comp - US Path 1"))
			local pathpointsnumber1 = table.getn(pathpoints1)
			Mission.EndCoordinates1 = pathpoints1[pathpointsnumber1]
			local pathpoints2 = FillPathPoints(FindEntity("Comp - US Path 2"))
			local pathpointsnumber2 = table.getn(pathpoints2)
			Mission.EndCoordinates2 = pathpoints2[pathpointsnumber2]
		end
		local leader = nil
		if table.getn(Mission.USShips) > 1 then
			leader = GetFormationLeader(Mission.USShips[1])
		else
			leader = Mission.USShips[1]
		end
		if leader ~= nil then
			if not leader.Dead then
				if Mission.LeaderPosition == 1 and luaGetDistance(leader, Mission.EndCoordinates1) < 300 or Mission.LeaderPosition == 2 and luaGetDistance(leader, Mission.EndCoordinates2) < 300 then
					for index, unit in pairs (Mission.USShips) do
						Kill(unit, true)
					end
					MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_fleet_exited")
					Mission.DistanceCheckDisabled = true
				end
			end
		end
	end
end

function luaQAC1ResetSpawn()
	Mission.SpawnStarted = false
end

function luaQAC1DistanceCheckEnabler()
	Mission.DistanceCheckDisabled = false
end

function luaQAC1FleetNarrative()
	if not Mission.Completed and Mission.MissionEnd then
		if Mission.LeaderPosition == 1 then
			MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_fleet_west")
		elseif Mission.LeaderPosition == 2 then
			MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_fleet_east")
		end
	end
end

function luaQAC1RandomUnit(size)
	if size == "big" then
		local indexnumber = table.getn(Mission.USBigShipID)
		local randomnumber = luaRnd(1, indexnumber)
		return randomnumber
	elseif size == "medium" then
		local indexnumber = table.getn(Mission.USMediumShipID)
		local randomnumber = luaRnd(1, indexnumber)
		return randomnumber
	elseif size == "small" then
		local indexnumber = table.getn(Mission.USSmallShipID)
		local randomnumber = luaRnd(1, indexnumber)
		return randomnumber
	end
end

function luaQAC1SpawnUnit(position, unittype, unitname, wingcount, eqindex)
	--luaLog(" luaQAC1SpawnUnit params:")
	--luaLog(position)
	--luaLog(unittype)
	--luaLog(unitname)
	if unittype ~= nil and unitname ~= nil then
		if unitname == "globals.unitclass_yorktown" then
			SpawnNew({
				["party"] = PARTY_ALLIED,
				["groupMembers"] = {
					{
						["Type"] = unittype,
						["Name"] = unitname,
						["Crew"] = 1,
						["Race"] = USA,
						["NumSlots"] = 4,
						["MaxInAirPlanes"] = 12,
						["PlaneStock 1"] = {
							["Type"] = 113,
							["Count"] = 20,
							["SquadLimit"] = 5,
						},
						["Slot 1"] = {
							["Type"] = 113,
							["Arm"] = 1,
							["Count"] = 3,
						},
						["OwnerPlayer"] = PLAYER_AI,
					},
				},
				["area"] = {
					["refPos"] = position,
					["angleRange"] = { DEG(180), DEG(185) },
				},
				["callback"] = "luaQAC1UnitSpawned",
				["excludeRadiusOverride"] = {
					["ownHorizontal"] = 50,
					["enemyHorizontal"] = 50,
					["ownVertical"] = 50,
					["formationHorizontal"] = 50,
					["enemyVertical"] = 50,
					["enemyHorizontal"] = 50,
				},
			})
		else
			SpawnNew({
				["party"] = PARTY_ALLIED,
				["groupMembers"] = {
					{
						["Type"] = unittype,
						["Name"] = unitname,
						["Crew"] = 1,
						["Race"] = USA,
						["WingCount"] = wingcount,
						["Equipment"] = eqindex,
						["OwnerPlayer"] = PLAYER_AI,
					},
				},
				["area"] = {
					["refPos"] = position,
					["angleRange"] = { DEG(180), DEG(185) },
				},
				["callback"] = "luaQAC1UnitSpawned",
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
end

function luaQAC1UnitSpawned(unit)
-- RELEASE_LOGOFF  	luaLog(unit.Name.." with ID "..unit.ID.." spawned")
	local pos = GetPosition(unit)
	AISetHintWeight(unit, 100)
	if Mission.LeaderPosition == 1 then
		EntityTurnToPosition(unit, {["x"] = pos.x + 175, ["y"] = pos.y, ["z"] = pos.z})
	elseif Mission.LeaderPosition == 2 then
		EntityTurnToPosition(unit, {["x"] = pos.x - 175, ["y"] = pos.y, ["z"] = pos.z})
	end
	if table.getn(Mission.USShips) <= 3 then
		SetSkillLevel(unit, SKILL_SPNORMAL)
	else
		SetSkillLevel(unit, SKILL_STUN)
	end
	if table.getn(Mission.USShips) ~= 0 then
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		JoinFormation(unit, Mission.USShips[1])
		local leaderpos = GetPosition(Mission.USShips[1])
		local rndform = luaRnd(1, 3)
		if Mission.LeaderPosition == 1 then
			PutFormationTo(Mission.USShips[1], {["x"] = leaderpos.x + 175, ["y"] = leaderpos.y, ["z"] = leaderpos.z}, rndform)
		elseif Mission.LeaderPosition == 2 then
			PutFormationTo(Mission.USShips[1], {["x"] = leaderpos.x - 175, ["y"] = leaderpos.y, ["z"] = leaderpos.z}, rndform)
		end
	else
		SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
		if Mission.LeaderPosition == 1 then
			NavigatorMoveOnPath(unit, FindEntity("Comp - US Path 1"))
		elseif Mission.LeaderPosition == 2 then
			NavigatorMoveOnPath(unit, FindEntity("Comp - US Path 2"))
		end
		--SetFormationShape(unit, 0)
	end
	NavigatorSetTorpedoEvasion(unit, false)
	NavigatorSetAvoidLandCollision(unit, false)
	table.insert(Mission.USShips, unit)
end

function luaQAC1CheckListeners()
-- RELEASE_LOGOFF  	luaLog(" Checking Listeners...")
	if not Mission.ListenerTimerSet then
-- RELEASE_LOGOFF  		luaLog("  setting listener timer")
		Mission.ListenerTimerSet = true
		Mission.ListenerTimer = 30
		Mission.ReminderTimer = 0
	end

	if GameTime() > Mission.ListenerTimer and not Mission.ListenerActive then
		local randomtime = luaRnd(30, 70)
		Mission.ListenerTimer = GameTime() + randomtime
		Mission.ReminderTimer = GameTime() + 14
		Mission.USShips = luaRemoveDeadsFromTable(Mission.USShips)
		if table.getn(Mission.USShips) ~= 0 then
			Mission.RandomTarget = luaPickRnd(Mission.USShips)
			Mission.RandomListener = luaRnd(1, 2)
-- RELEASE_LOGOFF  			luaLog("  Mission.RandomListener: "..Mission.RandomListener)
			if Mission.RandomListener == 1 then
				MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_bonus_hit")
				for i = 1, 8 do
					luaObj_AddUnit("primary", i, Mission.RandomTarget)
				end
				AISetHintWeight(Mission.RandomTarget, 300)
				SetSkillLevel(Mission.RandomTarget, SKILL_SPNORMAL)
				luaQAC1RandomTargetHitListener(Mission.RandomTarget)
			elseif Mission.RandomListener == 2 then
				MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_bonus_kill")
				for i = 1, 8 do
					luaObj_AddUnit("primary", i, Mission.RandomTarget)
				end
				AISetHintWeight(Mission.RandomTarget, 300)
				SetSkillLevel(Mission.RandomTarget, SKILL_SPNORMAL)
				luaQAC1RandomTargetHitListener(Mission.RandomTarget)
			end
		end
	elseif GameTime() > Mission.ReminderTimer and Mission.ListenerActive then
		if Mission.RandomListener == 1 then
			Mission.ReminderTimer = GameTime() + 22
			if not Mission.RandomTarget.Dead then
				MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_bonus_hit")
			else
-- RELEASE_LOGOFF  				luaLog("  ERROR!!! Mission.ListenerActive was wrong")
				Mission.ListenerActive = false
				if IsListenerActive("hit", "TargetHit") then
					RemoveListener("hit", "TargetHit")
				end
			end
		elseif Mission.RandomListener == 2 then
			Mission.ReminderTimer = GameTime() + 22
			if not Mission.RandomTarget.Dead then
				MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_bonus_kill")
			else
-- RELEASE_LOGOFF  				luaLog("  ERROR!!! Mission.ListenerActive was wrong")
				Mission.ListenerActive = false
				if IsListenerActive("kill", "TargetKill") then
					RemoveListener("kill", "TargetKill")
				end
			end
		end
	end
end

function luaQAC1RandomTargetHitListener(target)
	if target ~= nil then
		if Mission.RandomListener == 1 then
-- RELEASE_LOGOFF  			luaLog(" LISTENER: Activating hit listener on "..target.Name)
			AddListener("hit", "TargetHit", {
				["callback"] = "luaQAC1TargetHit",
				["target"] = {target},
				["targetDevice"] = {},
				["attacker"] = {},
				["attackType"] = {"KAMIKAZE"},
				["attackerPlayerIndex"] = {},
				["damageCaused"] = {},
				["fireCaused"] = {},
				["leakCaused"] = {},
			})
		elseif Mission.RandomListener == 2 then
-- RELEASE_LOGOFF  			luaLog(" LISTENER: Activating kill listener on "..target.Name)
			AddListener("kill", "TargetKill", {
				["callback"] = "luaQAC1TargetKill",
				["entity"] = {target},
				["lastAttacker"] = {},
				["lastAttackerPlayerIndex"] = {},
			})
		end
		Mission.ListenerActive = true
	else
-- RELEASE_LOGOFF  		luaLog(" LISTENER: listener activation failed, got nil for target")
	end
end

function luaQAC1TargetHit(target, targetDevice, attacker, attackType, attackerPlayerIndex, damageCaused, fireCaused, leakCaused)
	if attacker ~= nil then
		if not attacker.Dead then
			attackerPlayerIndex = GetRoleAvailable(attacker)[1]
		end
-- RELEASE_LOGOFF  		luaLog(" LISTENER: target hit by player "..attackerPlayerIndex)
		if attackerPlayerIndex >= 0 and attackerPlayerIndex <= 7 then
			Scoring_AddCommandScore(attackerPlayerIndex, "mp01.nar_comp_bonus_hit", Mission.HitScore)
			if IsListenerActive("hit", "TargetHit") then
				RemoveListener("hit", "TargetHit")
			end
			for i = 1, 8 do
				local y = i - 1
				if y == attackerPlayerIndex then
					MissionNarrativePlayer(y, "mp01.nar_comp_hit")
				else
					MissionNarrativePlayer(y, "mp01.nar_comp_hit_fail")
				end
--[[
					local playerwhoscored = GetPlayerDetails()[y]
-- RELEASE_LOGOFF  					luaLog(playerwhoscored.playerName)
					Mission.MultiScoreAILevelHit = 33
					for z = 1, 8 do
						local x = z - 1
						if playerwhoscored.playerName == "" and playerwhoscored.ailevel == 3 then
							Mission.MultiScoreAILevelHit = 3
						elseif playerwhoscored.playerName == "" and playerwhoscored.ailevel == 4 then
							Mission.MultiScoreAILevelHit = 4
						elseif playerwhoscored.playerName == "" and playerwhoscored.ailevel == 5 then
							Mission.MultiScoreAILevelHit = 5
						end
						MultiScore[x][6] = playerwhoscored.playerName
					end
				end
]]
			end
			--luaDelay(luaHitNarrative, 2, "ai", Mission.MultiScoreAILevelHit)
		else
-- RELEASE_LOGOFF  			luaLog(" FAIL!!! attackerPlayerIndex")
			for i = 0, 7 do
				MissionNarrativePlayer(i, "mp01.nar_comp_hit_fail")
			end
		end
	else
-- RELEASE_LOGOFF  		luaLog(" FAIL!!! attacker")
	end
	if IsListenerActive("hit", "TargetHit") then
		RemoveListener("hit", "TargetHit")
	end
	Mission.ListenerActive = false
	if not Mission.RandomTarget.Dead then
		for i = 1, 8 do
			luaObj_RemoveUnit("primary", i, Mission.RandomTarget)
		end
	end
	if GameTime() > Mission.ListenerTimer then
-- RELEASE_LOGOFF  		luaLog("  ListenerTimer needs to be modified")
		local randomtime = luaRnd(15, 30)
		Mission.ListenerTimer = GameTime() + randomtime
	end
end

function luaQAC1TargetKill(target, lastAttacker, lastAttackerPlayerIndex)
	if lastAttacker ~= nil then
		if not lastAttacker.Dead then
			lastAttackerPlayerIndex = GetRoleAvailable(lastAttacker)[1]
		end
-- RELEASE_LOGOFF  		luaLog(" LISTENER: target killed by player "..lastAttackerPlayerIndex)
		if lastAttackerPlayerIndex >= 0 and lastAttackerPlayerIndex <= 7 then
			Scoring_AddCommandScore(lastAttackerPlayerIndex, "mp01.nar_comp_bonus_kill", Mission.KillScore)
			if IsListenerActive("kill", "TargetKill") then
				RemoveListener("kill", "TargetKill")
			end
			for i = 1, 8 do
				local y = i - 1
				if y == lastAttackerPlayerIndex then
					MissionNarrativePlayer(y, "mp01.nar_comp_kill")
				else
					MissionNarrativePlayer(y, "mp01.nar_comp_kill_fail")
				end
--[[
					local playerwhoscored = GetPlayerDetails()[y]
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
	if IsListenerActive("kill", "TargetKill") then
		RemoveListener("kill", "TargetKill")
	end
	Mission.ListenerActive = false
	if GameTime() > Mission.ListenerTimer then
-- RELEASE_LOGOFF  		luaLog("  ListenerTimer needs to be modified")
		local randomtime = luaRnd(15, 30)
		Mission.ListenerTimer = GameTime() + randomtime
	end
end

function luaHitNarrative(timerthis)
	if timerthis.ParamTable.ai == 33 then
		MissionNarrativePlayer(0, "mp01.nar_comp_hit".."| #MultiScore.0.6#")
		MissionNarrativePlayer(1, "mp01.nar_comp_hit".."| #MultiScore.1.6#")
		MissionNarrativePlayer(2, "mp01.nar_comp_hit".."| #MultiScore.2.6#")
		MissionNarrativePlayer(3, "mp01.nar_comp_hit".."| #MultiScore.3.6#")
		MissionNarrativePlayer(4, "mp01.nar_comp_hit".."| #MultiScore.4.6#")
		MissionNarrativePlayer(5, "mp01.nar_comp_hit".."| #MultiScore.5.6#")
		MissionNarrativePlayer(6, "mp01.nar_comp_hit".."| #MultiScore.6.6#")
		MissionNarrativePlayer(7, "mp01.nar_comp_hit".."| #MultiScore.7.6#")
	elseif timerthis.ParamTable.ai == 3 then
		MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_hit".."| |FE.easy")
	elseif timerthis.ParamTable.ai == 4 then
		MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_hit".."| |FE.normal")
	elseif timerthis.ParamTable.ai == 5 then
		MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_hit".."| |FE.hard")
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
		MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_kill".."| |FE.easy")
	elseif timerthis.ParamTable.ai == 4 then
		MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_kill".."| |FE.normal")
	elseif timerthis.ParamTable.ai == 5 then
		MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_kill".."| |FE.hard")
	end
end

function luaQAC1HintManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 30 and not Mission.Hint1Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint1Shown")
			ShowHint("ID_Hint_Competitive01_Spawn")
			Mission.Hint1Shown = true
		elseif GameTime() > 60 and not Mission.Hint2Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint2Shown")
			ShowHint("ID_Hint_Competitive01_Bonus")
			Mission.Hint2Shown = true
		end
	end
end