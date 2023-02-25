--SceneFile="Missions\Multi\Scene7.scn"

function luaPrecacheUnits()
	PrepareClass(16) -- Avenger Tiny Tim
	PrepareClass(101) -- Wildcat
	PrepareClass(133) -- Buffalo
	PrepareClass(27) -- Elco
	PrepareClass(23) -- Fletcher
	PrepareClass(25) -- Clemson
	PrepareClass(316) -- Cleveland
	PrepareClass(17) -- Atlanta
	PrepareClass(317) -- Northampton
	PrepareClass(21) -- York
	PrepareClass(2) -- Yorktown
	PrepareClass(9) -- King George
	PrepareClass(58) -- Shimakaze
	PrepareClass(67) -- Mogami
	PrepareClass(59) -- Yamato
	PrepareClass(14) -- Akizuki
	PrepareClass(10) -- Renown
	PrepareClass(13) -- New York
	PrepareClass(116) -- B-17
	PrepareClass(113) -- Avenger
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAC7Mission")
end

function luaInitQAC7Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Comp7"..dateandtime

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
	Mission.MultiplayerNumber = 7
	Mission.CompetitiveParty = PARTY_JAPANESE

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- mission tablak, valtozok
	Mission.ActiveUSFleet = {}
	--Mission.USFleet1 = {}
	Mission.USFleet1UnitNames = {}
		table.insert(Mission.USFleet1UnitNames, "globals.unitclass_fletcher")
		table.insert(Mission.USFleet1UnitNames, "globals.unitclass_clemson")
		table.insert(Mission.USFleet1UnitNames, "globals.unitclass_cleveland")
	--Mission.USFleet2 = {}
	Mission.USFleet2UnitNames = {}
		table.insert(Mission.USFleet2UnitNames, "globals.unitclass_cleveland")
		table.insert(Mission.USFleet2UnitNames, "globals.unitclass_atlanta")
	--Mission.USFleet3 = {}
	Mission.USFleet3UnitNames = {}
		table.insert(Mission.USFleet3UnitNames, "globals.unitclass_northampton")
		table.insert(Mission.USFleet3UnitNames, "globals.unitclass_york")
	--Mission.USFleet4 = {}
	Mission.USFleet4UnitNames = {}
		table.insert(Mission.USFleet4UnitNames, "globals.unitclass_renown")
		table.insert(Mission.USFleet4UnitNames, "globals.unitclass_newyork")
	--Mission.USFleet5 = {}
	Mission.USFleet5UnitNames = {}
		table.insert(Mission.USFleet5UnitNames, "globals.unitclass_kinggeorge")
		table.insert(Mission.USFleet5UnitNames, "globals.unitclass_atlanta")
	Mission.USAnchoredFleet = {}
		table.insert(Mission.USAnchoredFleet, FindEntity("Comp - Iowa Class 01"))
		table.insert(Mission.USAnchoredFleet, FindEntity("Comp - Atlanta-class 01"))
		table.insert(Mission.USAnchoredFleet, FindEntity("Comp - ASW Fletcher 01"))
		table.insert(Mission.USAnchoredFleet, FindEntity("Comp - ASW Fletcher 02"))
		table.insert(Mission.USAnchoredFleet, FindEntity("Comp - ASW Fletcher 03"))

	for index, unit in pairs (Mission.USAnchoredFleet) do
		AISetHintWeight(unit, 80)
	end

	-- amerikai objektumok
	Mission.Yorktown = luaFindHidden("Comp - Yorktown")
	Mission.YorktownsBombers = {}
	Mission.YorktownsBomber = 16
	Mission.YorktownsBomberName = "globals.unitclass_avenger"
	Mission.YorktownsFighters = {}
	Mission.YorktownsFighter = 101
	Mission.YorktownsFighterName = "globals.unitclass_wildcat"
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("Comp - Headquarter 1"))
		table.insert(Mission.HQs, FindEntity("Comp - Headquarter 2"))
		table.insert(Mission.HQs, FindEntity("Comp - Headquarter 3"))
	Mission.HQsFighter = 133
	Mission.HQsFighterName = "globals.unitclass_buffalo"
	Mission.HQsPT = 27
	Mission.HQsPTName = "globals.unitclass_elco"
	Mission.HQ1Planes = {}
	Mission.HQ2Planes = {}
	Mission.HQ3Boats = {}

	-- japan objektumok
	Mission.Akagi = FindEntity("Comp - Akagi")
	Mission.Yamato = luaFindHidden("Comp - Yamato")
	Mission.Akizuki = luaFindHidden("Comp - Akizuki")
	Mission.Mogami = luaFindHidden("Comp - Mogami")
	Mission.AkagiDefShips = {}
		table.insert(Mission.AkagiDefShips, FindEntity("Comp - Fubuki"))
		table.insert(Mission.AkagiDefShips, FindEntity("Comp - Tone"))
	Mission.Shimakazes = {}
	Mission.ShimakazeTMPLs = {}
		table.insert(Mission.ShimakazeTMPLs, luaFindHidden("Comp - Shimakaze 01"))
		table.insert(Mission.ShimakazeTMPLs, luaFindHidden("Comp - Shimakaze 02"))
		table.insert(Mission.ShimakazeTMPLs, luaFindHidden("Comp - Shimakaze 03"))

	-- utvonalak, navpontok
	Mission.AkagiPath = FindEntity("Comp - AkagiPath")
	Mission.YorktownPath = FindEntity("Comp - YorktownPath")
	Mission.USSpawnPoints1 = {}
		table.insert(Mission.USSpawnPoints1, GetPosition(FindEntity("Comp - Navpoint 1")))
		table.insert(Mission.USSpawnPoints1, GetPosition(FindEntity("Comp - Navpoint 2")))
		table.insert(Mission.USSpawnPoints1, GetPosition(FindEntity("Comp - Navpoint 3")))
		table.insert(Mission.USSpawnPoints1, GetPosition(FindEntity("Comp - Navpoint 4")))
		--table.insert(Mission.USSpawnPoints1, GetPosition(FindEntity("Comp - Navpoint 5")))
		--table.insert(Mission.USSpawnPoints1, GetPosition(FindEntity("Comp - Navpoint 6")))
	Mission.USSpawnPoints2 = {}
		table.insert(Mission.USSpawnPoints2, GetPosition(FindEntity("Comp - Navpoint2 1")))
		table.insert(Mission.USSpawnPoints2, GetPosition(FindEntity("Comp - Navpoint2 2")))
		table.insert(Mission.USSpawnPoints2, GetPosition(FindEntity("Comp - Navpoint2 3")))
		table.insert(Mission.USSpawnPoints2, GetPosition(FindEntity("Comp - Navpoint2 4")))
		--table.insert(Mission.USSpawnPoints2, GetPosition(FindEntity("Comp - Navpoint2 5")))
		--table.insert(Mission.USSpawnPoints2, GetPosition(FindEntity("Comp - Navpoint2 6")))
	Mission.USSpawnPoints3 = {}
		table.insert(Mission.USSpawnPoints3, GetPosition(FindEntity("Comp - Navpoint3 1")))
		table.insert(Mission.USSpawnPoints3, GetPosition(FindEntity("Comp - Navpoint3 2")))
		table.insert(Mission.USSpawnPoints3, GetPosition(FindEntity("Comp - Navpoint3 3")))
		table.insert(Mission.USSpawnPoints3, GetPosition(FindEntity("Comp - Navpoint3 4")))
		--table.insert(Mission.USSpawnPoints3, GetPosition(FindEntity("Comp - Navpoint3 5")))
		--table.insert(Mission.USSpawnPoints3, GetPosition(FindEntity("Comp - Navpoint3 6")))
	Mission.USSpawnPoints4 = {}
		table.insert(Mission.USSpawnPoints4, GetPosition(FindEntity("Comp - Navpoint4 1")))
		table.insert(Mission.USSpawnPoints4, GetPosition(FindEntity("Comp - Navpoint4 2")))
		table.insert(Mission.USSpawnPoints4, GetPosition(FindEntity("Comp - Navpoint4 3")))
	Mission.USSpawnPoints5 = {}
		table.insert(Mission.USSpawnPoints5, GetPosition(FindEntity("Comp - Navpoint5 1")))
		table.insert(Mission.USSpawnPoints5, GetPosition(FindEntity("Comp - Navpoint5 2")))
		table.insert(Mission.USSpawnPoints5, GetPosition(FindEntity("Comp - Navpoint5 3")))
		--table.insert(Mission.USSpawnPoints5, GetPosition(FindEntity("Comp - Navpoint5 4")))
	Mission.YamatoSpawnPoint = GetPosition(FindEntity("Comp - YamatoPoint"))
	Mission.YamatoFleetPoints = {}
		table.insert(Mission.YamatoFleetPoints, GetPosition(FindEntity("Comp - YamatoPoint 01")))
		table.insert(Mission.YamatoFleetPoints, GetPosition(FindEntity("Comp - YamatoPoint 02")))
	Mission.YamatoEscapePoint = GetPosition(FindEntity("Comp - YamatoEscapePoint"))
	Mission.USEscapePoint = GetPosition(FindEntity("Comp - US EscapePoint"))
	Mission.PTSpawnPoint = GetPosition(FindEntity("Comp - PTSpawnPoint"))

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
		Mission.USSmallPlanes = 1
		Mission.USPTs = 2
		Mission.CrewLevel = 1
		Mission.USFleetReducer = 2
	elseif Mission.Players == 3 then
		Mission.USSmallPlanes = 2
		Mission.USPTs = 2
		Mission.CrewLevel = 1
		Mission.USFleetReducer = 2
	elseif Mission.Players == 4 then
		Mission.USSmallPlanes = 2
		Mission.USPTs = 3
		Mission.CrewLevel = 1
		Mission.USFleetReducer = 1
	elseif Mission.Players == 5 then
		Mission.USSmallPlanes = 2
		Mission.USPTs = 3
		Mission.CrewLevel = 2
		Mission.USFleetReducer = 1
	elseif Mission.Players == 6 then
		Mission.USSmallPlanes = 3
		Mission.USPTs = 3
		Mission.CrewLevel = 2
		Mission.USFleetReducer = 0
	elseif Mission.Players == 7 then
		Mission.USSmallPlanes = 3
		Mission.USPTs = 3
		Mission.CrewLevel = 2
		Mission.USFleetReducer = 0
	elseif Mission.Players == 8 then
		Mission.USSmallPlanes = 3
		Mission.USPTs = 3
		Mission.CrewLevel = 2
		Mission.USFleetReducer = 0
	end

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
			[9] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_primary_2",
				["Text"] = "mp07.obj_comp_p2_text",
				["TextCompleted"] = "mp07.obj_comp_p2_comp",
				["TextFailed"] = "mp07.obj_comp_p2_fail",
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
				["ID"] = "jap_obj_secondary_1",
				["Text"] = "mp07.obj_comp_s1_text",
				["TextCompleted"] = "mp07.obj_comp_s1_comp",
				["TextFailed"] = "mp07.obj_comp_s1_fail",
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

	AISetSpawnSceneUnitsWeightMul(0)

	luaInitNewSystems()

    SetThink(this, "luaQAC7Mission_think")
end

function luaQAC7Mission_think(this, msg)
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
		luaQAC7CheckUSForces()
		--luaQAC7CheckGameTime()
		luaQAC7CheckMissionEnd()
		luaQAC7HintManager()
		luaQAC7CheckJapForces()

	elseif not Mission.Started then
		luaQAC7StartMission()
		luaUpdateCounters()
	end
end

function luaQAC7StartMission()
-- RELEASE_LOGOFF  	luaLog("  Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()
	
	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	for i = 1, 8 do
		luaObj_Add("primary", i)
	end
	luaObj_Add("primary", 9, Mission.Akagi)

	-- advanced Akagi
	SetShipMaxSpeed(Mission.Akagi, GetShipMaxSpeed(Mission.Akagi)*1.25)
	SetRepairEffectivity(Mission.Akagi, 1.35)
	--
	NavigatorMoveOnPath(Mission.Akagi, Mission.AkagiPath, PATH_FM_SIMPLE, PATH_SM_JOIN)
	local pathpoints = FillPathPoints(Mission.AkagiPath)
	local pathpointsnumber = table.getn(pathpoints)
	AddProximityTrigger(Mission.Akagi, "AkagiExit", "luaQAC7AkagiExit", pathpoints[pathpointsnumber], 800)
	--luaObj_AddUnit("primary", 9, pathpoints[pathpointsnumber])
	NavigatorSetAvoidLandCollision(Mission.Akagi, false)
	NavigatorSetAvoidLandCollision(Mission.AkagiDefShips[1], false)
	NavigatorSetAvoidLandCollision(Mission.AkagiDefShips[2], false)

--[[
	local PlayersInGame = GetPlayerDetails()
	for index, value in pairs (PlayersInGame) do
		DisplayUnitHP(index, {Mission.Akagi})
	end
]]

	for i = 1, 8 do
		index = i - 1
		DisplayUnitHP(index, {Mission.Akagi})
	end

	if Mission.LobbyCountDown ~= 0 then
		Countdown("mp.score_comp_time_left", 0, Mission.LobbyCountDown, "luaQAC7MissionEndTimeIsUp")
	end

	for index, unit in pairs (Mission.AkagiDefShips) do
		SetSkillLevel(unit, SKILL_SPNORMAL)
		JoinFormation(unit, Mission.Akagi)
	end

	luaDelay(luaQAC7CheckHQ1, 1)
	luaDelay(luaQAC7CheckHQ2, 1.5)
	luaDelay(luaQAC7CheckHQ3, 2)
	Mission.Started = true
end

function luaQAC7AkagiExit()
-- RELEASE_LOGOFF  	luaLog(" The Akagi has reached the last path point...")
	local PlayersInGame = GetPlayerDetails()
	local highestindex, highestplayerscore = luaQAC7CheckHighestScore()
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
	Mission.AkagiExited = true
	MissionNarrativeParty(PARTY_JAPANESE, "mp07.nar_comp_akagi_exit")
	CountdownCancel()
	ForceMultiScoreSend()
	luaDelay(luaQAC7MissionEnd, 0.1)
end

function luaQAC7CheckJapForces()
-- RELEASE_LOGOFF  	luaLog(" Checking Akagi...")
	if Mission.Akagi.Dead and not Mission.MissionEndCalled then
		Mission.MissionEndCalled = true
		Mission.MissionFailed = true
		CountdownCancel()
		luaQAC7MissionEnd()
--[[
	elseif not Mission.Akagi.Dead then
		if GetHpPercentage(Mission.Akagi) <= 0.25 and not Mission.WarningDone25 then
-- RELEASE_LOGOFF  			luaLog("  25% HP warning")
			Mission.WarningDone25 = true
			Mission.WarningPercentAkagi = 25
			MissionNarrativeParty(PARTY_JAPANESE, "mp07.nar_comp_akagi_warning")
		elseif GetHpPercentage(Mission.Akagi) <= 0.5 and not Mission.WarningDone50 then
-- RELEASE_LOGOFF  			luaLog("  50% HP warning")
			Mission.WarningDone50 = true
			Mission.WarningPercentAkagi = 50
			MissionNarrativeParty(PARTY_JAPANESE, "mp07.nar_comp_akagi_warning")
		elseif GetHpPercentage(Mission.Akagi) <= 0.75 and not Mission.WarningDone75 then
-- RELEASE_LOGOFF  			luaLog("  75% HP warning")
			Mission.WarningDone75 = true
			Mission.WarningPercentAkagi = 75
			MissionNarrativeParty(PARTY_JAPANESE, "mp07.nar_comp_akagi_warning")
		end

		if GetHpPercentage(Mission.Akagi) >= 0.75 and Mission.WarningDone75 and not Mission.ResetWD75Initiated then
			Mission.ResetWD75Initiated = true
			luaDelay(luaQAC7ResetWD75Flag, 30)
		elseif GetHpPercentage(Mission.Akagi) >= 0.5 and Mission.WarningDone50 and not Mission.ResetWD50Initiated then
			Mission.ResetWD50Initiated = true
			luaDelay(luaQAC7ResetWD50Flag, 30)
		elseif GetHpPercentage(Mission.Akagi) >= 0.25 and Mission.WarningDone25 and not Mission.ResetWD25Initiated then
			Mission.ResetWD25Initiated = true
			luaDelay(luaQAC7ResetWD25Flag, 30)
		end
]]
	end

	if Mission.USFleet4Spawned and not Mission.YamatoExited then
		if Mission.Yamato.Dead and not Mission.YamatoDown then
			Mission.YamatoDown = true
			luaObj_Failed("secondary", 1)
--[[
		elseif not Mission.Yamato.Dead then
			if GetHpPercentage(Mission.Yamato) <= 0.25 and not Mission.WarningDone25Y then
-- RELEASE_LOGOFF  				luaLog("  25% HP warning for Yamato")
				Mission.WarningDone25Y = true
				Mission.WarningPercentYamato = 25
				MissionNarrativeParty(PARTY_JAPANESE, "mp07.nar_comp_yamato_warning")
			elseif GetHpPercentage(Mission.Yamato) <= 0.5 and not Mission.WarningDone50Y then
-- RELEASE_LOGOFF  				luaLog("  50% HP warning for Yamato")
				Mission.WarningDone50Y = true
				Mission.WarningPercentYamato = 50
				MissionNarrativeParty(PARTY_JAPANESE, "mp07.nar_comp_yamato_warning")
			end
	
			if GetHpPercentage(Mission.Yamato) >= 0.5 and Mission.WarningDone50Y and not Mission.ResetWD50YInitiated then
				Mission.ResetWD50YInitiated = true
				luaDelay(luaQAC7ResetWD50YFlag, 10)
			elseif GetHpPercentage(Mission.Yamato) >= 0.25 and Mission.WarningDone25Y and not Mission.ResetWD25YInitiated then
				Mission.ResetWD25YInitiated = true
				luaDelay(luaQAC7ResetWD25YFlag, 10)
			end
			if luaGetDistance(Mission.Yamato, Mission.YamatoEscapePoint) < 333 then
				Kill(Mission.Yamato, true)
				Mission.YamatoExited = true
			end
]]
		end
	end
end

function luaQAC7ResetWD75Flag()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Reseting WD75 flag")
		Mission.ResetWD75Initiated = false
		Mission.WarningDone75 = false
	end
end

function luaQAC7ResetWD50Flag()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Reseting WD50 flag")
		Mission.ResetWD50Initiated = false
		Mission.WarningDone50 = false
	end
end

function luaQAC7ResetWD25Flag()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Reseting WD25 flag")
		Mission.ResetWD25Initiated = false
		Mission.WarningDone25 = false
	end
end

function luaQAC7ResetWD50YFlag()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Reseting WD50Y flag")
		Mission.ResetWD50YInitiated = false
		Mission.WarningDone50Y = false
	end
end

function luaQAC7ResetWD25YFlag()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Reseting WD25Y flag")
		Mission.ResetWD25YInitiated = false
		Mission.WarningDone25Y = false
	end
end

function luaQAC7CheckUSForces()
-- RELEASE_LOGOFF  	luaLog(" Checking US forces...")
	Mission.ActiveUSFleet = luaRemoveDeadsFromTable(Mission.ActiveUSFleet)
	local ships = table.getn(Mission.ActiveUSFleet)

	if not Mission.USFleet1Spawned then
		local shiptriggertable = luaGetShipsAroundCoordinate(Mission.USSpawnPoints1[1], 4000, PARTY_JAPANESE, "own")
		local planetriggertable = luaGetPlanesAroundCoordinate(Mission.USSpawnPoints1[1], 4000, PARTY_JAPANESE, "own")
		if shiptriggertable ~= nil or planetriggertable ~= nil then
			MissionNarrativeParty(PARTY_JAPANESE, "mp06.nar_comp_incoming")
			Mission.USFleet1Spawned = true
-- RELEASE_LOGOFF  			luaLog("  spawning US fleet 1")
			luaQAC7SpawnUSShips(1)
		end
		Mission.SpawnDisabled = true
		luaDelay(luaQAC7EnableSpawning, 7)
	end

	if not Mission.USFleet2Spawned and not Mission.SpawnDisabled and ships == 0 then
		local shiptriggertable = luaGetShipsAroundCoordinate(Mission.USSpawnPoints2[1], 4000, PARTY_JAPANESE, "own")
		local planetriggertable = luaGetPlanesAroundCoordinate(Mission.USSpawnPoints2[1], 4000, PARTY_JAPANESE, "own")
		if shiptriggertable ~= nil or planetriggertable ~= nil then
			MissionNarrativeParty(PARTY_JAPANESE, "mp06.nar_comp_incoming")
			Mission.USFleet2Spawned = true
-- RELEASE_LOGOFF  			luaLog("  spawning US fleet 2")
			luaQAC7SpawnUSShips(2)
		end
		Mission.SpawnDisabled = true
		luaDelay(luaQAC7EnableSpawning, 7)
	end

	if not Mission.USFleet3Spawned and not Mission.SpawnDisabled and ships == 0 then
		local shiptriggertable = luaGetShipsAroundCoordinate(Mission.USSpawnPoints3[1], 4000, PARTY_JAPANESE, "own")
		local planetriggertable = luaGetPlanesAroundCoordinate(Mission.USSpawnPoints3[1], 4000, PARTY_JAPANESE, "own")
		if shiptriggertable ~= nil or planetriggertable ~= nil then
			MissionNarrativeParty(PARTY_JAPANESE, "mp06.nar_comp_incoming")
			Mission.USFleet3Spawned = true
-- RELEASE_LOGOFF  			luaLog("  spawning US fleet 3")
			luaQAC7SpawnUSShips(3)
		end
		Mission.SpawnDisabled = true
		luaDelay(luaQAC7EnableSpawning, 7)
	end

	if not Mission.USFleet5Spawned and not Mission.SpawnDisabled and ships == 0 then
		local shiptriggertable = luaGetShipsAroundCoordinate(Mission.USSpawnPoints5[1], 4000, PARTY_JAPANESE, "own")
		local planetriggertable = luaGetPlanesAroundCoordinate(Mission.USSpawnPoints5[1], 4000, PARTY_JAPANESE, "own")
		if shiptriggertable ~= nil or planetriggertable ~= nil then
			MissionNarrativeParty(PARTY_JAPANESE, "mp06.nar_comp_incoming")
			Mission.USFleet5Spawned = true
-- RELEASE_LOGOFF  			luaLog("  spawning US fleet 5")
			luaQAC7SpawnUSShips(5)
		end
		Mission.SpawnDisabled = true
		luaDelay(luaQAC7EnableSpawning, 7)
	end

	if not Mission.USFleet4Spawned and not Mission.SpawnDisabled and ships == 0 then
		local shiptriggertable = luaGetShipsAroundCoordinate(Mission.USSpawnPoints4[1], 4000, PARTY_JAPANESE, "own")
		local planetriggertable = luaGetPlanesAroundCoordinate(Mission.USSpawnPoints4[1], 4000, PARTY_JAPANESE, "own")
		local shiptriggertableY = luaGetShipsAroundCoordinate(Mission.YamatoSpawnPoint, 4000, PARTY_JAPANESE, "own")
		local planetriggertableY = luaGetPlanesAroundCoordinate(Mission.YamatoSpawnPoint, 4000, PARTY_JAPANESE, "own")
		if shiptriggertable ~= nil or planetriggertable ~= nil or shiptriggertableY ~= nil or planetriggertableY ~= nil then
			MissionNarrativeParty(PARTY_JAPANESE, "mp06.nar_comp_incoming")
			Mission.USFleet4Spawned = true
-- RELEASE_LOGOFF  			luaLog("  spawning US fleet 4")
			Mission.Yamato = GenerateObject(Mission.Yamato.Name, Mission.YamatoSpawnPoint)
			SetSkillLevel(Mission.Yamato, SKILL_MPVETERAN)
			NavigatorMoveToPos(Mission.Yamato, Mission.YamatoEscapePoint)
			Mission.Yorktown = GenerateObject(Mission.Yorktown.Name)
			SetSkillLevel(Mission.Yorktown, SKILL_ELITE)
			NavigatorMoveToPos(Mission.Yorktown, Mission.YorktownPath)
			Mission.YamatoDefShips = {}
				table.insert(Mission.YamatoDefShips, GenerateObject(Mission.Akizuki.Name, Mission.YamatoFleetPoints[1]))
				table.insert(Mission.YamatoDefShips, GenerateObject(Mission.Mogami.Name, Mission.YamatoFleetPoints[2]))
			for index, unit in pairs (Mission.YamatoDefShips) do
				JoinFormation(unit, Mission.Yamato)
				SetSkillLevel(unit, SKILL_MPNORMAL)
			end
			-- advanced Yorktown
			SetShipMaxSpeed(Mission.Yorktown, GetShipMaxSpeed(Mission.Yorktown)*1.25)
			SetRepairEffectivity(Mission.Yorktown, 1.35)
			--
			MissionNarrativeParty(PARTY_JAPANESE, "mp07.nar_comp_yamato")
			luaDelay(luaQAC7YamatoObjAdd, 7)
			luaQAC7SpawnUSShips(4)
		end
		Mission.SpawnDisabled = true
		luaDelay(luaQAC7EnableSpawning, 7)
	elseif Mission.USFleet4Spawned then
		if not Mission.Yorktown.Dead then
			if table.getn(Mission.YorktownsBombers) == 0 then
				local mod = 75
				for i = 1, Mission.USSmallPlanes do
					local yorktownpos = GetPosition(Mission.Yorktown)
					local posmod = mod * i
					luaQAC7SpawnUnit({["x"] = yorktownpos.x + posmod, ["y"] = 150, ["z"] = yorktownpos.z + posmod}, Mission.YorktownsBomber, Mission.YorktownsBomberName, 3, 1)
				end
			else
				Mission.YorktownsBombers = luaRemoveDeadsFromTable(Mission.YorktownsBombers)
				if table.getn(Mission.YorktownsBombers) ~= Mission.USSmallPlanes then
					local bombersneeded = Mission.USSmallPlanes - table.getn(Mission.YorktownsBombers)
					local mod = 75
					for i = 1, bombersneeded do
						local yorktownpos = GetPosition(Mission.Yorktown)
						local posmod = mod * i
						luaQAC7SpawnUnit({["x"] = yorktownpos.x + posmod, ["y"] = 150, ["z"] = yorktownpos.z + posmod}, Mission.YorktownsBomber, Mission.YorktownsBomberName, 1, 1)
					end
				end
				for index, unit in pairs (Mission.YorktownsBombers) do
					if table.getn(GetPayloads(unit)) ~= 0 and UnitGetAttackTarget(unit) == nil then
-- RELEASE_LOGOFF  						luaLog("  bomber doesn't have a target, looking for a new one")
						luaQAC7SetBomberTarget(unit)
					elseif table.getn(GetPayloads(unit)) == 0 and not unit.retreating then
						if not Mission.Yorktown.Dead then
							unit.retreating = true
							PilotCloseToShip(unit, Mission.Yorktown)
							SquadronSetTravelAlt(unit, 500)
						else
							unit.retreating = true
							unit.toescapepoint = true
							PilotMove(unit, Mission.USEscapePoint)
							SquadronSetTravelAlt(unit, 500)
						end
					elseif unit.retreating then
						if not Mission.Yorktown.Dead then
							local yorktownpos = GetPosition(Mission.Yorktown)
							local checkpos = {["x"] = yorktownpos.x, ["y"] = 200, ["z"] = yorktownpos.z}
							if luaGetDistance(unit, Mission.Yorktown) < 700 and not unit.travelaltchanged then
-- RELEASE_LOGOFF  								luaLog("  a bomber changing travel alt")
								unit.travelaltchanged = true
								SquadronSetTravelAlt(unit, 200)
							elseif luaGetDistance(unit, Mission.Yorktown) < 200 then
-- RELEASE_LOGOFF  								luaLog("  a bomber reached Yorktown")
								Kill(unit, true)
							end
						elseif not unit.toescapepoint then
-- RELEASE_LOGOFF  							luaLog("  Yorktown down, moving bomber to escape point")
							unit.toescapepoint = true
							PilotMove(unit, Mission.USEscapePoint)
							SquadronSetTravelAlt(unit, 500)
						else
							if luaGetDistance(unit, Mission.EscapePoint) < 200 then
-- RELEASE_LOGOFF  								luaLog("  a bomber reached the escape point")
								Kill(unit, true)
							end
						end
					end
				end
			end
			if table.getn(Mission.YorktownsFighters) == 0 then
				local mod = 75
				for i = 1, Mission.USSmallPlanes do
					local yorktownpos = GetPosition(Mission.Yorktown)
					local posmod = mod * i
					luaQAC7SpawnUnit({["x"] = yorktownpos.x + posmod, ["y"] = 225, ["z"] = yorktownpos.z + posmod}, Mission.YorktownsFighter, Mission.YorktownsFighterName, 3, 0)
				end
			else
				Mission.YorktownsFighters = luaRemoveDeadsFromTable(Mission.YorktownsFighters)
				if table.getn(Mission.YorktownsFighters) ~= Mission.USSmallPlanes then
					local fightersneeded = Mission.USSmallPlanes - table.getn(Mission.YorktownsFighters)
					local mod = 75
					for i = 1, fightersneeded do
						local yorktownpos = GetPosition(Mission.Yorktown)
						local posmod = mod * i
						luaQAC7SpawnUnit({["x"] = yorktownpos.x + posmod, ["y"] = 225, ["z"] = yorktownpos.z + posmod}, Mission.YorktownsFighter, Mission.YorktownsFighterName, 3, 0)
					end
				end
			end
		end
	end

	for index, unit in pairs (Mission.ActiveUSFleet) do
		if UnitGetAttackTarget(unit) == nil then
-- RELEASE_LOGOFF  			luaLog("  ship without target found")
			if not Mission.Akagi.Dead then
-- RELEASE_LOGOFF  				luaLog("  sending it against the Akagi")
				NavigatorAttackMove(unit, Mission.Akagi, {})
			end
		end
	end

	if not Mission.USAnchoredFleetOnMove then
		Mission.USAnchoredFleet = luaRemoveDeadsFromTable(Mission.USAnchoredFleet)
		if not Mission.Akagi.Dead and table.getn(Mission.USAnchoredFleet) ~= 0 then
			if luaGetDistance(Mission.Akagi, Mission.USAnchoredFleet[1]) < 7777 then
-- RELEASE_LOGOFF  				luaLog("  Akagi is near to the anchored fleet")
				MissionNarrativeParty(PARTY_JAPANESE, "mp06.nar_comp_incoming")
				MissionNarrativeParty(PARTY_JAPANESE, "mp07.nar_comp_shimakazes")
				Mission.USAnchoredFleetOnMove = true
				Mission.CheckShimakazes = true
				for index, unit in pairs (Mission.USAnchoredFleet) do
					if index == 1 then
						NavigatorAttackMove(unit, Mission.Akagi, {})
						local shipspeed = GetShipMaxSpeed(unit) * 0.8
						SetShipSpeed(unit, shipspeed)
					else
						local shipspeed = GetShipMaxSpeed(Mission.USAnchoredFleet[1]) * 0.8
						SetShipSpeed(unit, shipspeed)
						JoinFormation(unit, Mission.USAnchoredFleet[1])
					end
				end
				for index, template in pairs (Mission.ShimakazeTMPLs) do
					table.insert(Mission.Shimakazes, GenerateObject(template.Name))
				end
				for index, unit in pairs (Mission.Shimakazes) do
					if index == 1 then
						NavigatorAttackMove(unit, Mission.USAnchoredFleet[1], {})
					else
						JoinFormation(unit, Mission.Shimakazes[1])
					end
				end
			end
		end
	elseif Mission.CheckShimakazes then
		Mission.Shimakazes = luaRemoveDeadsFromTable(Mission.Shimakazes)
		Mission.USAnchoredFleet = luaRemoveDeadsFromTable(Mission.USAnchoredFleet)
		if table.getn(Mission.Shimakazes) ~= 0 then
			if table.getn(Mission.USAnchoredFleet) ~= 0 then
				for index, unit in pairs (Mission.Shimakazes) do
					if UnitGetAttackTarget(unit) == nil then
						NavigatorAttackMove(unit, Mission.USAnchoredFleet[1], {})
					end
				end
			elseif not Mission.Akagi.Dead then
				for index, unit in pairs (Mission.Shimakazes) do
					JoinFormation(unit, Mission.Akagi)
				end
			end
		end
	end
end

function luaQAC7SpawnUSShips(index)
	if index == 1 then
		local number = table.getn(Mission.USSpawnPoints1) - Mission.USFleetReducer
		for i = 1, number do
			local unittype = 0
			local wingcount = 1
			local unitname = luaPickRnd(Mission.USFleet1UnitNames)
			if unitname == "globals.unitclass_fletcher" then
				unittype = 23
			elseif unitname == "globals.unitclass_clemson" then
				unittype = 25
			elseif unitname == "globals.unitclass_cleveland" then
				unittype = 316
			end
			luaQAC7SpawnUnit(Mission.USSpawnPoints1[i], unittype, unitname, 1, 1)
		end
	elseif index == 2 then
		local number = table.getn(Mission.USSpawnPoints2) - Mission.USFleetReducer
		for i = 1, number do
			local unittype = 0
			local wingcount = 1
			local unitname = luaPickRnd(Mission.USFleet2UnitNames)
			if unitname == "globals.unitclass_cleveland" then
				unittype = 316
			elseif unitname == "globals.unitclass_atlanta" then
				unittype = 17
			end
			luaQAC7SpawnUnit(Mission.USSpawnPoints2[i], unittype, unitname, 1, 1)
		end
	elseif index == 3 then
		local number = table.getn(Mission.USSpawnPoints3) - Mission.USFleetReducer
		for i = 1, number do
			local unittype = 0
			local wingcount = 1
			local unitname = luaPickRnd(Mission.USFleet3UnitNames)
			if unitname == "globals.unitclass_northampton" then
				unittype = 317
			elseif unitname == "globals.unitclass_york" then
				unittype = 21
			end
			luaQAC7SpawnUnit(Mission.USSpawnPoints3[i], unittype, unitname, 1, 1)
		end
	elseif index == 4 then
		local number = table.getn(Mission.USSpawnPoints4) - Mission.USFleetReducer
		for i = 1, number do
			local unittype = 0
			local wingcount = 1
			local unitname = luaPickRnd(Mission.USFleet4UnitNames)
			if unitname == "globals.unitclass_renown" then
				unittype = 10
			elseif unitname == "globals.unitclass_newyork" then
				unittype = 13
			end
			luaQAC7SpawnUnit(Mission.USSpawnPoints4[i], unittype, unitname, 1, 1)
		end
	elseif index == 5 then
		local number = table.getn(Mission.USSpawnPoints5) - Mission.USFleetReducer
		for i = 1, number do
			local unittype = 0
			local wingcount = 1
			local unitname = luaPickRnd(Mission.USFleet5UnitNames)
			if unitname == "globals.unitclass_kinggeorge" then
				unittype = 9
			elseif unitname == "globals.unitclass_atlanta" then
				unittype = 17
			end
			luaQAC7SpawnUnit(Mission.USSpawnPoints5[i], unittype, unitname, 1, 1)
		end
	end
end

function luaQAC7SpawnUnit(position, unittype, unitname, wingcount, eqindex)
	if unittype ~= nil and unitname ~= nil then
		SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
				{
					["Type"] = unittype,
					["Name"] = unitname,
					["Crew"] = Mission.CrewLevel,
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
			["callback"] = "luaQAC7UnitSpawned",
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

function luaQAC7UnitSpawned(unit)
-- RELEASE_LOGOFF  	luaLog(" -> "..unit.Class.Type.." spawned")
	if unit.Class.Type == "TorpedoBomber" then
		Mission.YamatoDefShips = luaRemoveDeadsFromTable(Mission.YamatoDefShips)
		luaQAC7SetBomberTarget(unit)
-- RELEASE_LOGOFF  		luaLog("  inserting to Mission.YorktownsBombers")
		table.insert(Mission.YorktownsBombers, unit)
		local skilllevel = luaRnd(1, 10)
		if skilllevel <= 7 then
			SetSkillLevel(unit, SKILL_STUN)
		else
			SetSkillLevel(unit, SKILL_SPNORMAL)
		end
	elseif unit.Class.Type == "Fighter" and unit.Class.ID == 133 then
		if not Mission.Akagi.Dead then
			PilotMoveToRange(unit, Mission.Akagi, 1500)
		end
		local closesthqid = 0
		local closestdist = 10000
		for hqid, hq in pairs (Mission.HQs) do
			local currentdist = luaGetDistance(unit, hq)
			if currentdist < closestdist then
				closesthqid = hqid
				closestdist = currentdist
			end
		end
		if closesthqid == 1 then
-- RELEASE_LOGOFF  			luaLog("  inserting to Mission.HQ1Planes")
			table.insert(Mission.HQ1Planes, unit)
		elseif closesthqid == 2 then
-- RELEASE_LOGOFF  			luaLog("  inserting to Mission.HQ2Planes")
			table.insert(Mission.HQ2Planes, unit)
		end
	elseif unit.Class.Type == "Fighter" then
		PilotCloseToShip(unit, Mission.Yorktown)
		table.insert(Mission.YorktownsFighters, unit)
		SetSkillLevel(unit, SKILL_SPNORMAL)
	elseif unit.Class.Type == "TorpedoBoat" then
		TorpedoEnable(unit, true)
		if not Mission.Akagi.Dead then
			EntityTurnToEntity(unit, Mission.Akagi)
			NavigatorAttackMove(unit, Mission.Akagi, {})
		end
-- RELEASE_LOGOFF  		luaLog("  inserting to Mission.HQ3Boats")
		table.insert(Mission.HQ3Boats, unit)
		SetSkillLevel(unit, SKILL_SPNORMAL)
	else
		table.insert(Mission.ActiveUSFleet, unit)
		TorpedoEnable(unit, true)
		AISetHintWeight(unit, 80)
		if Mission.USFleet4Spawned then
			if not Mission.Yamato.Dead then
				EntityTurnToEntity(unit, Mission.Yamato)
				NavigatorAttackMove(unit, Mission.Yamato, {})
			elseif not Mission.Yamato.Dead then
				EntityTurnToEntity(unit, Mission.Yamato)
				NavigatorAttackMove(unit, Mission.Yamato, {})
			end
		elseif not Mission.Akagi.Dead then
			EntityTurnToEntity(unit, Mission.Akagi)
			NavigatorAttackMove(unit, Mission.Akagi, {})
		end
		local skilllevel = luaRnd(1, 10)
		if skilllevel <= 6 then
			SetSkillLevel(unit, SKILL_SPNORMAL)
		else
			SetSkillLevel(unit, SKILL_MPNORMAL)
		end
	end
end

function luaQAC7SetBomberTarget(unit)
	Mission.YamatoDefShips = luaRemoveDeadsFromTable(Mission.YamatoDefShips)
	if table.getn(Mission.YamatoDefShips) ~= 0 then
		local target = luaPickRnd(Mission.YamatoDefShips)
		PilotSetTarget(unit, target)
	elseif not Mission.Yamato.Dead then
		PilotSetTarget(unit, Mission.Yamato)
	elseif not Mission.Akagi.Dead then
		PilotSetTarget(unit, Mission.Akagi)
	end
end

function luaQAC7EnableSpawning()
-- RELEASE_LOGOFF  	luaLog(" Enabling US fleet spawning...")
	Mission.SpawnDisabled = false
end

function luaQAC7YamatoObjAdd()
	if not Mission.Completed and not Mission.MissionEnd then
		if not Mission.Yamato.Dead then
-- RELEASE_LOGOFF  			luaLog(" Addig seconday 1 objective...")
			luaObj_Add("secondary", 1, Mission.Yamato)
		else
-- RELEASE_LOGOFF  			luaLog(" ERROR! The Yamato is dead!")
		end
	end
end

function luaQAC7CheckHQ1()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Checking headquarters... (1)")
		local mod = 75
		if Mission.HQs[1].Party == PARTY_ALLIED then
			if table.getn(Mission.HQ1Planes) == 0 then
				for i = 1, Mission.USSmallPlanes do
					local hqpos = GetPosition(Mission.HQs[1])
					local posmod = mod * i
					luaQAC7SpawnUnit({["x"] = hqpos.x + posmod, ["y"] = 150, ["z"] = hqpos.z + posmod}, Mission.HQsFighter, Mission.HQsFighterName, 3, 0)
				end
			else
				Mission.HQ1Planes = luaRemoveDeadsFromTable(Mission.HQ1Planes)
				if table.getn(Mission.HQ1Planes) < Mission.USSmallPlanes then
-- RELEASE_LOGOFF  					luaLog("  dead plane found under HQ1")
					local planesneeded = Mission.USSmallPlanes - table.getn(Mission.HQ1Planes)
					for i = 1, planesneeded do
						local hqpos = GetPosition(Mission.HQs[1])
						local posmod = mod * i
						luaQAC7SpawnUnit({["x"] = hqpos.x + posmod, ["y"] = 150, ["z"] = hqpos.z + posmod}, Mission.HQsFighter, Mission.HQsFighterName, 3, 0)
					end
				end
			end
		else
-- RELEASE_LOGOFF  			luaLog("  HQ1 down")
		end
		luaDelay(luaQAC7CheckHQ1, 3)
	end
end

function luaQAC7CheckHQ2()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Checking headquarters... (2)")
		local mod = 75
		if Mission.HQs[2].involved then
			if Mission.HQs[2].Party == PARTY_ALLIED then
				if table.getn(Mission.HQ2Planes) == 0 then
-- RELEASE_LOGOFF  					luaLog("  spawning planes for HQ2")
					for i = 1, Mission.USSmallPlanes do
						local hqpos = GetPosition(Mission.HQs[2])
						local posmod = mod * i
						luaQAC7SpawnUnit({["x"] = hqpos.x + posmod, ["y"] = 150, ["z"] = hqpos.z + posmod}, Mission.HQsFighter, Mission.HQsFighterName, 3, 0)
					end
				else
					Mission.HQ2Planes = luaRemoveDeadsFromTable(Mission.HQ2Planes)
					if table.getn(Mission.HQ2Planes) < Mission.USSmallPlanes then
-- RELEASE_LOGOFF  						luaLog("  dead plane found under HQ2")
						local planesneeded = Mission.USSmallPlanes - table.getn(Mission.HQ2Planes)
						for i = 1, planesneeded do
							local hqpos = GetPosition(Mission.HQs[2])
							local posmod = mod * i
							luaQAC7SpawnUnit({["x"] = hqpos.x + posmod, ["y"] = 150, ["z"] = hqpos.z + posmod}, Mission.HQsFighter, Mission.HQsFighterName, 3, 0)
						end
					end
				end
			else
-- RELEASE_LOGOFF  				luaLog("  HQ2 down")
			end
		else
			local shiptriggertable = luaGetShipsAroundCoordinate(GetPosition(Mission.HQs[2]), 4000, PARTY_JAPANESE, "own")
			local planetriggertable = luaGetPlanesAroundCoordinate(GetPosition(Mission.HQs[2]), 4000, PARTY_JAPANESE, "own")
			if shiptriggertable ~= nil or planetriggertable ~= nil then
-- RELEASE_LOGOFF  				luaLog("  HQ2 involved")
				Mission.HQs[2].involved = true
			end
		end
		luaDelay(luaQAC7CheckHQ2, 3)
	end
end

function luaQAC7CheckHQ3()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Checking headquarters... (3)")
		local mod = 75
		if Mission.HQs[3].involved then
			if Mission.HQs[3].Party == PARTY_ALLIED then
				if table.getn(Mission.HQ3Boats) == 0 then
-- RELEASE_LOGOFF  					luaLog("  spawning boats for HQ3")
					for i = 1, Mission.USPTs do
						local posmod = mod * i
						luaQAC7SpawnUnit({["x"] = Mission.PTSpawnPoint.x - posmod, ["y"] = 0, ["z"] = Mission.PTSpawnPoint.z - posmod}, Mission.HQsPT, Mission.HQsPTName, 1, 1)
					end
				else
					Mission.HQ3Boats = luaRemoveDeadsFromTable(Mission.HQ3Boats)
					if table.getn(Mission.HQ3Boats) < Mission.USPTs then
-- RELEASE_LOGOFF  						luaLog("  dead boat found under HQ3")
						local boatsneeded = Mission.USPTs - table.getn(Mission.HQ3Boats)
						for i = 1, boatsneeded do
							local posmod = mod * i
							luaQAC7SpawnUnit({["x"] = Mission.PTSpawnPoint.x - posmod, ["y"] = 0, ["z"] = Mission.PTSpawnPoint.z - posmod}, Mission.HQsPT, Mission.HQsPTName, 1, 1)
						end
					end
				end
			else
-- RELEASE_LOGOFF  				luaLog("  HQ3 down")
			end
		else
			local shiptriggertable = luaGetShipsAroundCoordinate(GetPosition(Mission.HQs[3]), 4000, PARTY_JAPANESE, "own")
			local planetriggertable = luaGetPlanesAroundCoordinate(GetPosition(Mission.HQs[3]), 4000, PARTY_JAPANESE, "own")
			if shiptriggertable ~= nil or planetriggertable ~= nil then
-- RELEASE_LOGOFF  				luaLog("  HQ3 involved")
				Mission.HQs[3].involved = true
			end
		end
		luaDelay(luaQAC7CheckHQ3, 3)
	end
end

function luaQAC7CheckGameTime()
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

function luaQAC7CheckMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Checking mission ending conditions...")
	if Mission.PointLimit ~= 0 then
		local highestindex, highestplayerscore = luaQAC7CheckHighestScore()
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
			luaDelay(luaQAC7MissionEnd, 0.1)
		end
	end
end

function luaQAC7CheckHighestScore()
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

function luaQAC7MissionEndTimeIsUp()
	MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_time_up")
	local highestindex, highestplayerscore = luaQAC7CheckHighestScore()
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
	luaDelay(luaQAC7MissionEnd, 0.1)
end

function luaQAC7MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	if not Mission.Completed then
		Mission.Completed = true
--[[
		if not Mission.Akagi.Dead then
			if not Mission.TimeIsUp or Mission.AkagiExited then
				MissionNarrativePlayer(0, "#MultiScore.0.4# |".."mp01.nar_comp_player_won")
				MissionNarrativePlayer(1, "#MultiScore.1.4# |".."mp01.nar_comp_player_won")
				MissionNarrativePlayer(2, "#MultiScore.2.4# |".."mp01.nar_comp_player_won")
				MissionNarrativePlayer(3, "#MultiScore.3.4# |".."mp01.nar_comp_player_won")
				MissionNarrativePlayer(4, "#MultiScore.4.4# |".."mp01.nar_comp_player_won")
				MissionNarrativePlayer(5, "#MultiScore.5.4# |".."mp01.nar_comp_player_won")
				MissionNarrativePlayer(6, "#MultiScore.6.4# |".."mp01.nar_comp_player_won")
				MissionNarrativePlayer(7, "#MultiScore.7.4# |".."mp01.nar_comp_player_won")
			end
		end
]]
		local highestindex, highestplayerscore = luaQAC7CheckHighestScore()
-- RELEASE_LOGOFF  		luaLog(" player "..highestindex.." won")
		local objindex = highestindex + 1
		luaObj_Completed("primary", objindex)
		for i = 1, 8 do
			if i ~= objindex then
				luaObj_Failed("primary", i)
			end
		end

		if Mission.Akagi.Dead then
			Mission.MissionLost = true
			luaObj_Failed("primary", 9)
		else
			luaObj_Completed("primary", 9)
		end

		luaQAC7DelayedMissionComplete()
		--luaDelay(luaQAC7DelayedMissionComplete, 4)
	end
end

function luaQAC7DelayedMissionComplete()
	if not Mission.MissionEnd then
		Scoring_RealPlayTimeRunning(false)
		if Mission.MissionLost then
			local planes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 40000, PARTY_JAPANESE, "own")
			if planes ~= nil then
				local endplane = luaPickRnd(planes)
				luaMissionCompletedNew(endplane, "", nil, nil, nil, PARTY_ALLIED)
			end
		else
			luaMissionCompletedNew(Mission.Akagi, "", nil, nil, nil, PARTY_JAPANESE)
		end
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Competitive07")
	-- mode description hint overlay
end

function luaUpdateCounters()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Updating counters...")
		if MultiScore ~= nil then
			if table.getn(MultiScore) ~= 0 then
				local PlayersInGame = GetPlayerDetails()
				local highestindex, highestplayerscore = luaQAC7CheckHighestScore()
				for index, value in pairs (PlayersInGame) do
					MultiScore[index][1] = Scoring_GetTotalMissionScore(index)
					MultiScore[index][5] = highestplayerscore
				end
			end
		end
	
		luaDelay(luaUpdateCounters, 0.7)
	end
end

function luaQAC7HintManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 30 and not Mission.Hint1Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint1Shown")
			ShowHint("ID_Hint_Competitive05_enemy_planes")
			Mission.Hint1Shown = true
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
		Mission.AttackerPlanes = {}
		if table.getn(Mission.HQ1Planes) ~= 0 then
			for index, unit in pairs (Mission.HQ1Planes) do
				if not unit.Dead then
					table.insert(Mission.AttackerPlanes, unit)
				end
			end
		end
		if table.getn(Mission.HQ2Planes) ~= 0 then
			for index, unit in pairs (Mission.HQ2Planes) do
				if not unit.Dead then
					table.insert(Mission.AttackerPlanes, unit)
				end
			end
		end
		if table.getn(Mission.YorktownsFighters) ~= 0 then
			for index, unit in pairs (Mission.YorktownsFighters) do
				if not unit.Dead then
					table.insert(Mission.AttackerPlanes, unit)
				end
			end
		end
		if table.getn(Mission.HQ3Boats) ~= 0 then
			for index, unit in pairs (Mission.HQ3Boats) do
				if not unit.Dead then
					table.insert(Mission.AttackerShips, unit)
				end
			end
		end
		if table.getn(Mission.ActiveUSFleet) ~= 0 then
			for index, unit in pairs (Mission.ActiveUSFleet) do
				if not unit.Dead then
					table.insert(Mission.AttackerShips, unit)
				end
			end
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
				MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_bonus_kill")
				for i = 1, 8 do
					luaObj_AddUnit("primary", i, Mission.RandomTarget)
				end
				if Mission.RandomListener ~= 2 then
					AISetHintWeight(Mission.RandomTarget, 100)
				end
				luaQACRandomTargetKillListener(Mission.RandomTarget)
			end
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
		MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_kill".."| |FE.easy")
	elseif timerthis.ParamTable.ai == 4 then
		MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_kill".."| |FE.normal")
	elseif timerthis.ParamTable.ai == 5 then
		MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_kill".."| |FE.hard")
	end
end