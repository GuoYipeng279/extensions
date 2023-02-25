--SceneFile="Missions\Multi\Scene8.scn"

function luaPrecacheUnits()
	--PrepareClass(85) -- Japanese Tanker
	PrepareClass(172) -- Jake
	PrepareClass(75) -- Minekaze
	PrepareClass(31) -- Narwhal
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAC8Mission")
end

function luaInitQAC8Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Comp8"..dateandtime

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

	--SetDeviceReloadEnabled(false) -- kikapcs, ha be lenne kapcsolva

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
	Mission.CompetitiveParty = PARTY_ALLIED

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- globalban hasznalando
	this.Multiplayer = true
	Mission.MultiplayerType = "Competitive"
	Mission.MultiplayerNumber = 1
	this.ThinkCounter = 0
	Mission.CompetitiveParty = PARTY_ALLIED

	-- mission tablak, valtozok

	-- spawn pontok
--[[
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
]]

	-- amerikai objektumok

	-- japan objektumok
	Mission.JapTankerType = 85
	Mission.JapTankerName = "globals.unitclass_japfleetoiler"
	Mission.JapReconType = 172
	Mission.JapReconName = "globals.unitclass_jake"
	Mission.JapDestroyerType = 75
	Mission.JapDestroyerName = "globals.unitclass_minekaze"
	--Mission.JapTankers = {}
	Mission.JapRecons = {}
	Mission.JapDestroyers = {}

	-- pathok, navpointok
	Mission.JapTankers = {}
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 01"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 02"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 03"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 04"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 05"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 06"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 07"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 08"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 09"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 10"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 11"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 12"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 13"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 14"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 15"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 16"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 18"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 19"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 22"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 23"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 17"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 20"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 21"))
		table.insert(Mission.JapTankers, FindEntity("Comp - Japan Tanker 24"))

	Mission.JapFleet = {}
		table.insert(Mission.JapFleet, FindEntity("Comp - Soryu-class 01"))
		table.insert(Mission.JapFleet, FindEntity("Comp - Fuso-class Battleship 01"))
		--table.insert(Mission.JapFleet, FindEntity("Comp - Kongo-class Battleship 01"))
		table.insert(Mission.JapFleet, FindEntity("Comp - Takao-class 01"))
		table.insert(Mission.JapFleet, FindEntity("Comp - Kuma-class 01"))
		table.insert(Mission.JapFleet, FindEntity("Comp - Kuma-class 02"))
		table.insert(Mission.JapFleet, FindEntity("Comp - Kuma-class 03"))

	Kill(FindEntity("Comp - Kongo-class Battleship 01"), true)

	Mission.JapFleet2 = {}
		table.insert(Mission.JapFleet2, FindEntity("Comp - Agano-class 01"))
		table.insert(Mission.JapFleet2, FindEntity("Comp - Mogami-class 01"))
		table.insert(Mission.JapFleet2, FindEntity("Comp - Agano-class 02"))
		table.insert(Mission.JapFleet2, FindEntity("Comp - Kuma-class 04"))
		table.insert(Mission.JapFleet2, FindEntity("Comp - Takao-class 02"))

	for index, unit in pairs (Mission.JapTankers) do
		AISetHintWeight(unit, 250)
	end
	for index, unit in pairs (Mission.JapFleet) do
		AISetHintWeight(unit, 150)
	end
	for index, unit in pairs (Mission.JapFleet2) do
		AISetHintWeight(unit, 100)
	end

	AISetTargetWeight(31, 85, false, 250)
	AISetTargetWeight(31, 53, false, 150)
	AISetTargetWeight(31, 61, false, 150)
	AISetTargetWeight(31, 60, false, 150)
	AISetTargetWeight(31, 69, false, 150)
	AISetTargetWeight(31, 70, false, 150)
	AISetTargetWeight(31, 71, false, 100)
	AISetTargetWeight(31, 67, false, 100)

	Kill(Mission.JapTankers[24], true)
	Kill(Mission.JapTankers[23], true)
	Kill(Mission.JapTankers[22], true)
	Kill(Mission.JapTankers[21], true)
--[[
	Kill(Mission.JapTankers[20], true)
	Kill(Mission.JapTankers[19], true)
	Kill(Mission.JapTankers[18], true)
	Kill(Mission.JapTankers[17], true)
]]
	Kill(Mission.JapFleet[6], true)
	Kill(Mission.JapFleet2[5], true)

--[[
	Mission.JapTankerPoints = {}
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 1")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 2")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 3")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 4")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 5")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 6")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 7")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 8")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 9")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 10")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 11")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 12")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 13")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 14")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 15")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 16")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 17")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 18")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 19")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 20")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 21")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 22")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 23")))
		table.insert(Mission.JapTankerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 24")))
]]
	Mission.JapTankerPaths = {}
		table.insert(Mission.JapTankerPaths, FindEntity("Comp - JapTankerPath1"))
		table.insert(Mission.JapTankerPaths, FindEntity("Comp - JapTankerPath2"))
		table.insert(Mission.JapTankerPaths, FindEntity("Comp - JapTankerPath3"))
		table.insert(Mission.JapTankerPaths, FindEntity("Comp - JapTankerPath4"))
		table.insert(Mission.JapTankerPaths, FindEntity("Comp - JapTankerPath5"))
		table.insert(Mission.JapTankerPaths, FindEntity("Comp - JapTankerPath6"))
		table.insert(Mission.JapTankerPaths, FindEntity("Comp - JapTankerPath7"))
		table.insert(Mission.JapTankerPaths, FindEntity("Comp - JapTankerPath8"))
	Mission.JapDestroyerPoints = {}
		table.insert(Mission.JapDestroyerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 25")))
		table.insert(Mission.JapDestroyerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 29")))
		table.insert(Mission.JapDestroyerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 26")))
		table.insert(Mission.JapDestroyerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 30")))
		table.insert(Mission.JapDestroyerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 27")))
		table.insert(Mission.JapDestroyerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 31")))
		table.insert(Mission.JapDestroyerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 28")))
		table.insert(Mission.JapDestroyerPoints, GetPosition(FindEntity("Comp - JapUnitPoint 32")))
	Mission.JapDestroyerPaths = {}
		table.insert(Mission.JapDestroyerPaths, FindEntity("Comp - JapDestroyerPath 1"))
		table.insert(Mission.JapDestroyerPaths, FindEntity("Comp - JapDestroyerPath 2"))
	Mission.JapReconPoints = {}
		table.insert(Mission.JapReconPoints, GetPosition(FindEntity("Comp - JapUnitPoint 33")))
		table.insert(Mission.JapReconPoints, GetPosition(FindEntity("Comp - JapUnitPoint 34")))
	Mission.JapReconPaths = {}
		table.insert(Mission.JapReconPaths, FindEntity("Comp - JapReconPath 1"))
		table.insert(Mission.JapReconPaths, FindEntity("Comp - JapReconPath 2"))
	Mission.JapFleetPaths = {}
		table.insert(Mission.JapFleetPaths, FindEntity("Comp - JapFleetPath1"))
		table.insert(Mission.JapFleetPaths, FindEntity("Comp - JapFleetPath2"))
		table.insert(Mission.JapFleetPaths, FindEntity("Comp - JapFleetPath3"))
		table.insert(Mission.JapFleetPaths, FindEntity("Comp - JapFleetPath4"))
	Mission.JapFleetSpeeds = {}
		table.insert(Mission.JapFleetSpeeds, 0.9)
		table.insert(Mission.JapFleetSpeeds, 0.87)
		table.insert(Mission.JapFleetSpeeds, 0.84)
		table.insert(Mission.JapFleetSpeeds, 0.81)

	Mission.KillScoreShip = 175
	Mission.KillScorePlane = 100

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
		Mission.JapDestroyerNumber = 2
		Mission.JapReconNumber = 1
	elseif Mission.Players == 3 then
		Mission.JapDestroyerNumber = 2
		Mission.JapReconNumber = 1
	elseif Mission.Players == 4 then
		Mission.JapDestroyerNumber = 2
		Mission.JapReconNumber = 1
	elseif Mission.Players == 5 then
		Mission.JapDestroyerNumber = 2
		Mission.JapReconNumber = 2
	elseif Mission.Players == 6 then
		Mission.JapDestroyerNumber = 4
		Mission.JapReconNumber = 2
	elseif Mission.Players == 7 then
		Mission.JapDestroyerNumber = 4
		Mission.JapReconNumber = 2
	elseif Mission.Players == 8 then
		Mission.JapDestroyerNumber = 4
		Mission.JapReconNumber = 2
	end

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

    SetThink(this, "luaQAC8Mission_think")
end

function luaQAC8Mission_think(this, msg)
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
		luaQAC8CheckHostiles()
		luaQAC8CheckJapFleets()
		--luaQAC8CheckGameTime()
		luaQAC8CheckMissionEnd()
		luaQAC8HintManager()

	elseif not Mission.Started then
		luaQAC8StartMission()
		luaUpdateCounters()			
	end
end

function luaQAC8StartMission()
-- RELEASE_LOGOFF  	luaLog("  Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()
	
	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	for i = 1, 8 do
		luaObj_Add("primary", i)
	end

	Mission.JapTankers = luaRemoveDeadsFromTable(Mission.JapTankers)
	Mission.JapTankerNumber = table.getn(Mission.JapTankers)
	for index, unit in pairs (Mission.JapTankers) do
		local unitpos = GetPosition(unit)
		if unitpos.x <= -9900 and unitpos.x >= -10000 then
-- RELEASE_LOGOFF  			luaLog("  chosing Mission.JapTankerPaths[1]")
			NavigatorMoveOnPath(unit, Mission.JapTankerPaths[1])
		elseif unitpos.x <= -9600 and unitpos.x >= -9700 then
-- RELEASE_LOGOFF  			luaLog("  chosing Mission.JapTankerPaths[2]")
			NavigatorMoveOnPath(unit, Mission.JapTankerPaths[2])
		elseif unitpos.x <= -9400 and unitpos.x >= -9500 then
-- RELEASE_LOGOFF  			luaLog("  chosing Mission.JapTankerPaths[3]")
			NavigatorMoveOnPath(unit, Mission.JapTankerPaths[3])
		elseif unitpos.x <= -9100 and unitpos.x >= -9200 then
-- RELEASE_LOGOFF  			luaLog("  chosing Mission.JapTankerPaths[4]")
			NavigatorMoveOnPath(unit, Mission.JapTankerPaths[4])
		elseif unitpos.x <= -10900 and unitpos.x >= -11000 then
-- RELEASE_LOGOFF  			luaLog("  chosing Mission.JapTankerPaths[5]")
			NavigatorMoveOnPath(unit, Mission.JapTankerPaths[5])
		elseif unitpos.x <= -11200 and unitpos.x >= -11300 then
-- RELEASE_LOGOFF  			luaLog("  chosing Mission.JapTankerPaths[6]")
			NavigatorMoveOnPath(unit, Mission.JapTankerPaths[6])
		elseif unitpos.x <= -11500 and unitpos.x >= -11600 then
-- RELEASE_LOGOFF  			luaLog("  chosing Mission.JapTankerPaths[7]")
			NavigatorMoveOnPath(unit, Mission.JapTankerPaths[7])
		elseif unitpos.x <= -11800 and unitpos.x >= -11900 then
-- RELEASE_LOGOFF  			luaLog("  chosing Mission.JapTankerPaths[8]")
			NavigatorMoveOnPath(unit, Mission.JapTankerPaths[8])
		end
		SetShipSpeed(unit, GetShipMaxSpeed(unit)*0.33)
		ArtilleryEnable(unit, false)
		AAEnable(unit, false)
		NavigatorSetTorpedoEvasion(unit, false)
		
		--luaQAC8SpawnUnit(Mission.JapTankerPoints[i], Mission.JapTankerType, Mission.JapTankerName, 1, 1)
	end

	Mission.JapFleet = luaRemoveDeadsFromTable(Mission.JapFleet)
	for index, unit in pairs (Mission.JapFleet) do
		if index == 1 then
			Mission.SelectedPath = luaPickRnd(Mission.JapFleetPaths)
			Mission.SelectedSpeed = luaPickRnd(Mission.JapFleetSpeeds)
			Mission.MaxSpeed = GetShipMaxSpeed(unit) * Mission.SelectedSpeed
			local pathpoints = FillPathPoints(Mission.SelectedPath)
			local lastpoint = table.getn(pathpoints)
			Mission.ExitPoint = pathpoints[lastpoint]
			NavigatorMoveOnPath(unit, Mission.SelectedPath, PATH_FM_SIMPLE, PATH_SM_JOIN_FORWARD)
			SetShipMaxSpeed(unit, Mission.MaxSpeed)
			SetShipSpeed(unit, Mission.MaxSpeed)
-- RELEASE_LOGOFF  			luaLog(" "..unit.Name.." "..Mission.MaxSpeed.."-vel kene hogy menjen...")
		else
			JoinFormation(unit, Mission.JapFleet[1])
			SetShipMaxSpeed(unit, Mission.MaxSpeed)
			SetShipSpeed(unit, Mission.MaxSpeed)
		end
		SetSkillLevel(unit, SKILL_SPNORMAL)
	end

	Mission.JapFleet2 = luaRemoveDeadsFromTable(Mission.JapFleet2)
	for index, unit in pairs (Mission.JapFleet2) do
		if index == 1 then
			Mission.SelectedPath2 = luaPickRnd(Mission.JapFleetPaths)
			Mission.SelectedSpeed2 = luaPickRnd(Mission.JapFleetSpeeds)
			Mission.MaxSpeed2 = GetShipMaxSpeed(unit) * Mission.SelectedSpeed2
			local pathpoints = FillPathPoints(Mission.SelectedPath2)
			local lastpoint = table.getn(pathpoints)
			Mission.ExitPoint2 = pathpoints[lastpoint]
			NavigatorMoveOnPath(unit, Mission.SelectedPath2, PATH_FM_SIMPLE, PATH_SM_JOIN_FORWARD)
			SetShipMaxSpeed(unit, Mission.MaxSpeed2)
			SetShipSpeed(unit, Mission.MaxSpeed2)
-- RELEASE_LOGOFF  			luaLog(" "..unit.Name.." "..Mission.MaxSpeed2.."-vel kene hogy menjen...")
		else
			JoinFormation(unit, Mission.JapFleet2[1])
			SetShipMaxSpeed(unit, Mission.MaxSpeed2)
			SetShipSpeed(unit, Mission.MaxSpeed2)
		end
		SetSkillLevel(unit, SKILL_SPNORMAL)
	end

	if Mission.LobbyCountDown ~= 0 then
		Countdown("mp.score_comp_time_left", 0, Mission.LobbyCountDown, "luaQAC8MissionEndTimeIsUp")
	end
	Mission.Started = true
end

function luaQAC8SpawnUnit(position, unittype, unitname, wingcount, eqindex)
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
			["callback"] = "luaQAC8UnitSpawned",
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

function luaQAC8UnitSpawned(unit)
-- RELEASE_LOGOFF  	luaLog(" vehicle ID "..tostring(unit.ClassID).." spawned")
	if unit.ClassID == 85 then
--[[
		local unitpos = GetPosition(unit)
		--luaLog(" position:")
		--luaLog(unitpos)
		local turntopos = {["x"] = unitpos.x, ["y"] = unitpos.y, ["z"] = unitpos.z - 100}
		EntityTurnToPosition(unit, turntopos)
		if unitpos.x >= -9900 and unitpos.x <= -10000 then
			--luaLog("  chosing Mission.JapTankerPaths[1]")
			NavigatorMoveOnPath(unit, Mission.JapTankerPaths[1])
		elseif unitpos.x <= -9600 and unitpos.x >= -9700 then
			--luaLog("  chosing Mission.JapTankerPaths[2]")
			NavigatorMoveOnPath(unit, Mission.JapTankerPaths[2])
		elseif unitpos.x <= -9400 and unitpos.x >= -9500 then
			--luaLog("  chosing Mission.JapTankerPaths[3]")
			NavigatorMoveOnPath(unit, Mission.JapTankerPaths[3])
		elseif unitpos.x <= -9100 and unitpos.x >= -9200 then
			--luaLog("  chosing Mission.JapTankerPaths[4]")
			NavigatorMoveOnPath(unit, Mission.JapTankerPaths[4])
		elseif unitpos.x <= -10900 and unitpos.x >= -11000 then
			--luaLog("  chosing Mission.JapTankerPaths[5]")
			NavigatorMoveOnPath(unit, Mission.JapTankerPaths[5])
		elseif unitpos.x <= -11200 and unitpos.x >= -11300 then
			--luaLog("  chosing Mission.JapTankerPaths[6]")
			NavigatorMoveOnPath(unit, Mission.JapTankerPaths[6])
		elseif unitpos.x <= -11500 and unitpos.x >= -11600 then
			--luaLog("  chosing Mission.JapTankerPaths[7]")
			NavigatorMoveOnPath(unit, Mission.JapTankerPaths[7])
		elseif unitpos.x <= -11800 and unitpos.x >= -11900 then
			--luaLog("  chosing Mission.JapTankerPaths[8]")
			NavigatorMoveOnPath(unit, Mission.JapTankerPaths[8])
		end
		SetShipSpeed(unit, GetShipMaxSpeed(unit)*0.33)
		table.insert(Mission.JapTankers, unit)
]]
	elseif unit.ClassID == 172 then
		local pathindex = 0
		local closestdist = 10000
		for i, value in pairs (Mission.JapReconPaths) do
			local pathpoints = FillPathPoints(value)
			local distance = luaGetDistance(unit, pathpoints[1])
			if distance < closestdist then
				pathindex = i
				closestdist = distance
			end
		end
		unit.pathindex = pathindex
		PilotMoveOnPath(unit, Mission.JapReconPaths[pathindex], PATH_FM_CIRCLE, PATH_SM_BEGIN)
		table.insert(Mission.JapRecons, unit)
	elseif unit.ClassID == 75 then
		local pathindex = 0
		local closestdist = 10000
		for i, value in pairs (Mission.JapDestroyerPaths) do
			local pathpoints = FillPathPoints(value)
			local distance = luaGetDistance(unit, pathpoints[1])
			if distance < closestdist then
				pathindex = i
				closestdist = distance
			end
		end
		unit.pathindex = pathindex
		NavigatorMoveOnPath(unit, Mission.JapDestroyerPaths[pathindex], PATH_FM_CIRCLE, PATH_SM_BEGIN)
		table.insert(Mission.JapDestroyers, unit)
	end
	SetSkillLevel(unit, SKILL_SPNORMAL)
	UnitFreeAttack(unit)
end

function luaQAC8CheckHostiles()
	Mission.JapTankers = luaRemoveDeadsFromTable(Mission.JapTankers)
	if table.getn(Mission.JapTankers) == Mission.JapTankerNumber and not Mission.JapHostilesAllowed then
		Mission.JapHostilesAllowed = true
	end

	if Mission.JapHostilesAllowed then
-- RELEASE_LOGOFF  		luaLog(" Checking hostile units...")
		local reconspawnnumber = Mission.JapTankerNumber - 1
		if table.getn(Mission.JapTankers) <= reconspawnnumber then
			if table.getn(Mission.JapRecons) == 0 then
-- RELEASE_LOGOFF  				luaLog("  first recon plane spawn called")
				for i = 1, Mission.JapReconNumber do
					luaQAC8SpawnUnit(Mission.JapReconPoints[i], Mission.JapReconType, Mission.JapReconName, 1, 2)
				end
--[[
			else
				for index, unit in pairs (Mission.JapRecons) do
					if unit.Dead then
-- RELEASE_LOGOFF  						luaLog("  dead recon plane found")
						if unit.attacktargetassigned then
							local playerships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 33333, PARTY_ALLIED, "own")
							for i, v in pairs (playerships) do
								if unit.attacktargetassigned == v.ID then
-- RELEASE_LOGOFF  									luaLog("   clearing attackerplaneassigned variable")
									v.attackerplaneassigned = nil
								end
							end
						end
						table.remove(Mission.JapRecons, index)
						luaQAC8SpawnUnit(Mission.JapReconPoints[index], Mission.JapReconType, Mission.JapReconName, 1, 2)
					else
						if UnitGetAttackTarget(unit) == nil then
							if LobbySettings.ReloadPayload == "globals.off" then
								if table.getn(GetPayloads(unit)) == 0 and not unit.reloadset then
-- RELEASE_LOGOFF  									luaLog("  reload set")
									unit.reloadset = true
									unit.reloadtimer = GameTime() + 30
									PilotMoveOnPath(unit, Mission.JapReconPaths[unit.pathindex], PATH_FM_CIRCLE, PATH_SM_JOIN_FORWARD)
								elseif unit.reloadset and GameTime() > unit.reloadtimer then
-- RELEASE_LOGOFF  									luaLog("  reload done")
									unit.reloadset = false
									PlaneReloadBombPlatforms(unit)
									luaQAC8SetTarget(unit)
								elseif table.getn(GetPayloads(unit)) ~= 0 then
									luaQAC8SetTarget(unit)
								end
							else
								luaQAC8SetTarget(unit)
							end
						end
					end
				end
]]
			end
		end
	
		local destroyerspawnnumber = Mission.JapTankerNumber - 1
		if table.getn(Mission.JapTankers) <= destroyerspawnnumber then
			if table.getn(Mission.JapDestroyers) == 0 then
-- RELEASE_LOGOFF  				luaLog("  first destroyer spawn called")
				--for i = 1, 8 do
				for i = 1, Mission.JapDestroyerNumber do
					luaQAC8SpawnUnit(Mission.JapDestroyerPoints[i], Mission.JapDestroyerType, Mission.JapDestroyerName, 1, 1)
				end
			else
				for index, unit in pairs (Mission.JapDestroyers) do
					if unit.Dead then
-- RELEASE_LOGOFF  						luaLog("  dead destroyer found")
--[[
						if unit.attacktargetassigned then
							local playerships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 33333, PARTY_ALLIED, "own")
							for i, v in pairs (playerships) do
								if unit.attacktargetassigned == v.ID then
-- RELEASE_LOGOFF  									luaLog("   clearing attackershipassigned variable")
									v.attackershipassigned = nil
								end
							end
						end
]]
						table.remove(Mission.JapDestroyers, index)
						luaQAC8SpawnUnit(Mission.JapDestroyerPoints[index], Mission.JapDestroyerType, Mission.JapDestroyerName, 1, 1)
--[[
					else
						if UnitGetAttackTarget(unit) == nil then
							luaQAC8SetTarget(unit)
						end
]]
					end
				end
			end
		end
	end
end

function luaQAC8SetTarget(unit)
	local playerships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 33333, PARTY_ALLIED, "own")
	if playerships ~= nil then
		local possibleplanetargets = {}
		local possibleshiptargets = {}
		for i, playership in pairs (playerships) do
			if GetSubmarineDepthLevel(playership) == 0 or GetSubmarineDepthLevel(playership) == 1 or GetSubmarineDepthLevel(playership) == 2 then
				--luaLog(" sub on level 0 or 1")
				--if playership.attackerplaneassigned == nil then
					--luaLog(" adding to possibleplanetargets")
					table.insert(possibleplanetargets, playership)
				--end
				--if playership.attackershipassigned  == nil then
					--luaLog(" adding to possibleshiptargets")
					table.insert(possibleshiptargets, playership)
				--end
			end
		end
-- RELEASE_LOGOFF  		luaLog(" possibleplanetargets: "..tostring(table.getn(possibleplanetargets)))
		if unit.ClassID == 172 then
			if table.getn(possibleplanetargets) ~= 0 then
				local target = luaPickRnd(playerships)
				PilotSetTarget(unit, target)
--[[
				unit.attacktargetassigned = target.ID
				target.attackerplaneassigned = unit.ID
				PilotSetTarget(unit, target)
				for i, v in pairs (possibleplanetargets) do
					if v.ID == target.ID then
						table.remove(possibleplanetargets, i)
					end
				end
]]
			end
		end
-- RELEASE_LOGOFF  		luaLog(" possibleshiptargets: "..tostring(table.getn(possibleshiptargets)))
		if unit.ClassID == 75 then
			if table.getn(possibleshiptargets) ~= 0 then
				local target = luaPickRnd(playerships)
				NavigatorAttackMove(unit, target, {})
--[[
				unit.attacktargetassigned = target.ID
				target.attackershipassigned = unit.ID
				NavigatorAttackMove(unit, target, {})
				for i, v in pairs (possibleshiptargets) do
					if v.ID == target.ID then
						table.remove(possibleshiptargets, i)
					end
				end
]]
			end
		elseif unit.ClassID == 172 then
-- RELEASE_LOGOFF  			luaLog("  no target found for a recon plane 1")
			PilotMoveOnPath(unit, Mission.JapReconPaths[unit.pathindex], PATH_FM_CIRCLE, PATH_SM_JOIN_FORWARD)
		elseif unit.ClassID == 75 then
-- RELEASE_LOGOFF  			luaLog("  no target found for a destroyer 1")
			NavigatorMoveOnPath(unit, Mission.JapDestroyerPaths[unit.pathindex], PATH_FM_CIRCLE, PATH_SM_JOIN_FORWARD)
		end
	elseif unit.ClassID == 172 then
-- RELEASE_LOGOFF  		luaLog("  no target found for a recon plane 2")
		PilotMoveOnPath(unit, Mission.JapReconPaths[unit.pathindex], PATH_FM_CIRCLE, PATH_SM_JOIN_FORWARD)
	elseif unit.ClassID == 75 then
-- RELEASE_LOGOFF  		luaLog("  no target found for a destroyer 2")
		NavigatorMoveOnPath(unit, Mission.JapDestroyerPaths[unit.pathindex], PATH_FM_CIRCLE, PATH_SM_JOIN_FORWARD)
	end
end

function luaQAC8CheckJapFleets()
-- RELEASE_LOGOFF  	luaLog(" Checking Japanese fleets...")
	Mission.JapFleet = luaRemoveDeadsFromTable(Mission.JapFleet)
	if table.getn(Mission.JapFleet) ~= 0 then
		if not Mission.JapFleetExitCalled and luaGetDistance(Mission.JapFleet[1], Mission.ExitPoint) < 800 then
-- RELEASE_LOGOFF  			luaLog("  the Japanese fleet reached the exit point")
			MissionNarrativeParty(PARTY_ALLIED, "mp08.nar_comp_fleet_leaving")
			luaDelay(luaQAC8JapFleetExit, 7)
			Mission.JapFleetExitCalled = true
		end
	end	

	Mission.JapFleet2 = luaRemoveDeadsFromTable(Mission.JapFleet2)
	if table.getn(Mission.JapFleet2) ~= 0 then
		if not Mission.JapFleetExitCalled2 and luaGetDistance(Mission.JapFleet2[1], Mission.ExitPoint2) < 800 then
-- RELEASE_LOGOFF  			luaLog("  the second Japanese fleet reached the exit point")
			MissionNarrativeParty(PARTY_ALLIED, "mp08.nar_comp_fleet_leaving")
			luaDelay(luaQAC8JapFleetExit2, 7)
			Mission.JapFleetExitCalled2 = true
		end
	end	
end

function luaQAC8JapFleetExit()
-- RELEASE_LOGOFF  	luaLog(" Removing Japanese fleet...")
	if not Mission.Completed and not Mission.MissionEnd then
		Mission.JapFleet = luaRemoveDeadsFromTable(Mission.JapFleet)
		if table.getn(Mission.JapFleet) ~= 0 then
			for index, unit in pairs (Mission.JapFleet) do
				Kill(unit, true)
			end
		end
	end
end

function luaQAC8JapFleetExit2()
-- RELEASE_LOGOFF  	luaLog(" Removing the second Japanese fleet...")
	if not Mission.Completed and not Mission.MissionEnd then
		Mission.JapFleet2 = luaRemoveDeadsFromTable(Mission.JapFleet2)
		if table.getn(Mission.JapFleet2) ~= 0 then
			for index, unit in pairs (Mission.JapFleet2) do
				Kill(unit, true)
			end
		end
	end
end

function luaQAC8CheckGameTime()
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

function luaQAC8CheckMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Checking mission ending conditions...")
	if Mission.PointLimit ~= 0 then
		local highestindex, highestplayerscore = luaQAC8CheckHighestScore()
		if highestplayerscore >= Mission.PointLimit and not Mission.MissionEndCalled then
-- RELEASE_LOGOFF  			luaLog(" playerindex: "..highestindex.." | score: "..highestplayerscore.." | calling mission end")
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
			luaDelay(luaQAC8MissionEnd, 0.1)
		end
	end

	if table.getn(Mission.JapFleet) == 0 and table.getn(Mission.JapFleet2) == 0 and not Mission.MissionEndCalled then
-- RELEASE_LOGOFF  		luaLog("  Mission.JapFleet and Mission.JapFleet2 are no more, ending mission")
		MissionNarrativeParty(PARTY_ALLIED, "mp08.nar_comp_fleet_destroyed")
		local highestindex, highestplayerscore = luaQAC8CheckHighestScore()
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
		Mission.JapFleetsDown = true
		CountdownCancel()
		ForceMultiScoreSend()
		luaDelay(luaQAC8MissionEnd, 0.1)
	end
end

function luaQAC8CheckHighestScore()
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

function luaQAC8MissionEndTimeIsUp()
	MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_time_up")
	local highestindex, highestplayerscore = luaQAC8CheckHighestScore()
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
	luaDelay(luaQAC8MissionEnd, 0.1)
end

function luaQAC8MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	if not Mission.Completed then
		Mission.Completed = true
--[[
		if not Mission.TimeIsUp and not Mission.JapFleetsDown then
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
		local highestindex, highestplayerscore = luaQAC8CheckHighestScore()
-- RELEASE_LOGOFF  		luaLog(" player "..highestindex.." won")
		local objindex = highestindex + 1
		luaObj_Completed("primary", objindex)
		for i = 1, 8 do
			if i ~= objindex then
				luaObj_Failed("primary", i)
			end
		end

		luaQAC8DelayedMissionComplete()
		--luaDelay(luaQAC8DelayedMissionComplete, 4)
	end
end

function luaQAC8DelayedMissionComplete()
	if not Mission.MissionEnd then
		Mission.MissionEnd = true
		Scoring_RealPlayTimeRunning(false)
		luaMissionCompletedNew(endplane, "", nil, nil, nil, PARTY_ALLIED)
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Competitive08")
	-- mode description hint overlay
end

function luaUpdateCounters()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Updating counters...")
		if MultiScore ~= nil then
			if table.getn(MultiScore) ~= 0 then
				local PlayersInGame = GetPlayerDetails()
				local highestindex, highestplayerscore = luaQAC8CheckHighestScore()
				for index, value in pairs (PlayersInGame) do
					MultiScore[index][1] = Scoring_GetTotalMissionScore(index)
					MultiScore[index][5] = highestplayerscore
				end
			end
		end
	
		luaDelay(luaUpdateCounters, 0.7)
	end
end

function luaQAC8HintManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 30 and not Mission.Hint1Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint1Shown")
			ShowHint("ID_Hint_Competitive08_dive")
			Mission.Hint1Shown = true
		elseif GameTime() > 60 and not Mission.Hint2Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint2Shown")
			ShowHint("ID_Hint_Competitive08_destroyer")
			Mission.Hint2Shown = true
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
		Mission.AttackerShips = {}
		Mission.JapTankers = luaRemoveDeadsFromTable(Mission.JapTankers)
		Mission.JapFleet2 = luaRemoveDeadsFromTable(Mission.JapFleet2)
		Mission.JapFleet = luaRemoveDeadsFromTable(Mission.JapFleet)
		if table.getn(Mission.JapTankers) > 3 then
			for index, unit in pairs (Mission.JapTankers) do
				table.insert(Mission.AttackerShips, unit)
			end
		elseif table.getn(Mission.JapFleet2) > 1 then
			for index, unit in pairs (Mission.JapFleet2) do
				table.insert(Mission.AttackerShips, unit)
			end
		elseif table.getn(Mission.JapFleet) > 0 then
			for index, unit in pairs (Mission.JapFleet) do
				table.insert(Mission.AttackerShips, unit)
			end
		end
		Mission.AttackerPlanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 20000, PARTY_JAPANESE, "own")
		if Mission.AttackerPlanes == nil then
			Mission.AttackerPlanes = {}
		end
		if table.getn(Mission.AttackerShips) ~= 0 or table.getn(Mission.AttackerPlanes) ~= 0 then
			Mission.RandomListener = luaRnd(1, 2)
			if Mission.RandomListener == 1 and table.getn(Mission.AttackerShips) ~= 0 then
				Mission.RandomTarget = luaPickRnd(Mission.AttackerShips)
			elseif Mission.RandomListener == 2 and table.getn(Mission.AttackerPlanes) ~= 0 then
				Mission.RandomTarget = luaPickRnd(Mission.AttackerPlanes)
			else
				Mission.RandomTarget = nil
			end
			if Mission.RandomTarget ~= nil then
				MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_bonus_kill")
				for i = 1, 8 do
					luaObj_AddUnit("primary", i, Mission.RandomTarget)
				end
				if Mission.RandomListener == 1 then
					AISetHintWeight(Mission.RandomTarget, 50)
				end
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