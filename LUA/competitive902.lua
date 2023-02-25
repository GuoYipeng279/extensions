function luaPrecacheUnits()
	PrepareClass(2006) 	-- North Carolina
	PrepareClass(13) 	-- North Carolina
	PrepareClass(7) 	-- South Dakota
	PrepareClass(19) 	-- Northampton
	PrepareClass(903) 	-- Brooklyn
	PrepareClass(11) 	-- Atlanta	
	PrepareClass(901) 	-- Porter
	PrepareClass(900) 	-- Luppis
	PrepareClass(11) 	-- Allen M Sumner
	PrepareClass(48) 	-- ASW Fletcher
	PrepareClass(30) 	-- Gato

	PrepareClass(116) 	-- Flying Fortress
	PrepareClass(118) 	-- Mitchell
	PrepareClass(38) 	-- Helldiver
	PrepareClass(113) 	-- Avenger
	PrepareClass(16) 	-- TBM Avenger
	PrepareClass(104) 	-- Lightning
	PrepareClass(26) 	-- Hellcat
	PrepareClass(27) 	-- Elco
	PrepareClass(167) 	-- Betty
	PrepareClass(32) 	-- BettyOhka
	PrepareClass(166) 	-- Nell
	PrepareClass(152) 	-- Gekko
	PrepareClass(171) 	-- Pete
	PrepareClass(174) 	-- Mavis
	
	PrepareClass(58) 	-- Shimakaze
	PrepareClass(59) 	-- Yamato	
	PrepareClass(60) 	-- Kongo
	PrepareClass(2007) 	-- Nagato	
	PrepareClass(67) 	-- Mogami	
	PrepareClass(68) 	-- Tone	
	PrepareClass(69) 	-- Takao
	PrepareClass(71) 	-- Agano
	PrepareClass(73) 	-- Fubuki
	PrepareClass(75)	-- Minekaze
	PrepareClass(93)	-- Type B
	
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitScene902Com")
end

function luaInitScene902Com(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Sibuyan Sea"

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
	Mission.MultiplayerNumber = 902
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

	Mission.KillScore = 100
	
	--Plane types for reference
	Mission.TypeB17 = 116
	Mission.TypeB25 = 118
	Mission.TypeSB2C = 38
	Mission.TypeTBF = 113
	Mission.TypeP38 = 104
	Mission.TypeF6F = 26
	Mission.TypeG4M = 167
	Mission.TypeG4MOhka = 32
	Mission.TypeG3M = 166
	Mission.TypeJ1N1 = 152
	Mission.TypeH6K = 174
	Mission.TypeF1M = 171
	
	Mission.MapCentre = {["x"] = -2500, ["y"] = 2000, ["z"] = 2500}
	Mission.Point = FindEntity("Navpoint")
	
	-- spawn pontok
	Mission.SpawnPoints = {}
		table.insert(Mission.SpawnPoints, FindEntity("USN Spawn1"))	--Battleships
		table.insert(Mission.SpawnPoints, FindEntity("USN Spawn2"))	--Cruisers
		table.insert(Mission.SpawnPoints, FindEntity("USN Spawn3"))	--Destroyers
		table.insert(Mission.SpawnPoints, FindEntity("USN Spawn4"))	--Submarines
		table.insert(Mission.SpawnPoints, FindEntity("USN Spawn5"))	--Aircraft
		
	Mission.USFleet = {}
		table.insert(Mission.USFleet, FindEntity("New Jersey"))
		table.insert(Mission.USFleet, FindEntity("Iowa"))
		table.insert(Mission.USFleet, FindEntity("Miller"))
		table.insert(Mission.USFleet, FindEntity("Hickox"))
		table.insert(Mission.USFleet, FindEntity("Owen"))
		table.insert(Mission.USFleet, FindEntity("Benham"))
		
	Mission.ElcoTMPL ={}
		table.insert(Mission.ElcoTMPL, luaFindHidden("Elco1"))
		table.insert(Mission.ElcoTMPL, luaFindHidden("Elco2"))
		table.insert(Mission.ElcoTMPL, luaFindHidden("Elco3"))
		table.insert(Mission.ElcoTMPL, luaFindHidden("Elco4"))
		
	Mission.USAFPlanes = {}
	Mission.USCVPlanes = {}
	Mission.USSYShips = {}
	Mission.USAirfield = FindEntity("CB1_AF")
	Mission.USShipyard = FindEntity("US Shipyard")
	Mission.Wasp = FindEntity("Wasp")
		
	Mission.FormationYamato = {}
		table.insert(Mission.FormationYamato, luaFindHidden("Yamato"))
		table.insert(Mission.FormationYamato, luaFindHidden("Musashi"))
		table.insert(Mission.FormationYamato, luaFindHidden("Chikuma"))
		table.insert(Mission.FormationYamato, luaFindHidden("Kiyoshimo"))
		table.insert(Mission.FormationYamato, luaFindHidden("Urakaze"))
		table.insert(Mission.FormationYamato, luaFindHidden("Nowaki"))
		table.insert(Mission.FormationYamato, luaFindHidden("Hamakaze"))
		table.insert(Mission.FormationYamato, luaFindHidden("Kishinami"))
		table.insert(Mission.FormationYamato, luaFindHidden("Hayanami"))
		
	Mission.FormationKongo = {}
		table.insert(Mission.FormationKongo, luaFindHidden("Kongo"))	
		table.insert(Mission.FormationKongo, luaFindHidden("Haruna"))	
		table.insert(Mission.FormationKongo, luaFindHidden("Suzuya"))	
		table.insert(Mission.FormationKongo, luaFindHidden("Yahagi"))	
		table.insert(Mission.FormationKongo, luaFindHidden("Yukikaze"))	
		table.insert(Mission.FormationKongo, luaFindHidden("Isokaze"))	
		table.insert(Mission.FormationKongo, luaFindHidden("Fujinami"))	
		
	Mission.FormationNagato = {}
		table.insert(Mission.FormationNagato, luaFindHidden("Nagato"))
		table.insert(Mission.FormationNagato, luaFindHidden("Myoko"))
		table.insert(Mission.FormationNagato, luaFindHidden("Haguro"))
		table.insert(Mission.FormationNagato, luaFindHidden("Noshiro"))
		table.insert(Mission.FormationNagato, luaFindHidden("Shimakaze"))
		table.insert(Mission.FormationNagato, luaFindHidden("Hayashimo"))
		table.insert(Mission.FormationNagato, luaFindHidden("Akishimo"))
		
	Mission.Subs = {}
		table.insert(Mission.Subs, FindEntity("Submarine TypeB w Jake 01"))
		table.insert(Mission.Subs, FindEntity("Submarine TypeB w Jake 02"))
		table.insert(Mission.Subs, FindEntity("Submarine TypeB w Jake 03"))
		table.insert(Mission.Subs, FindEntity("Submarine TypeB w Jake 04"))
	
	Mission.JPFleet = {}
	Mission.JPSubmarines = {}
	Mission.JPAFPlanes = {}
	Mission.JPSYPlanes = {}
	Mission.JPAirfield = FindEntity("AFDLCL06SA")
	Mission.JPShipyard = FindEntity("JP Shipyard")
	
	Mission.USAFTarget = nil
	Mission.USCVTarget = nil
	Mission.USSYTarget = nil
	Mission.JPAFTarget = nil
	Mission.JPSYTarget = nil
	
	Mission.ClassTypes = {}
		table.insert(Mission.ClassTypes, "battleship")
		table.insert(Mission.ClassTypes, "cruiser")
		table.insert(Mission.ClassTypes, "destroyer")
		table.insert(Mission.ClassTypes, "submarine")
		table.insert(Mission.ClassTypes, "mothership")
	
	local randomnr = random(1, 50)	
	if randomnr <= 10 then
		randomnr = 1
	elseif randomnr <= 20 then
		randomnr = 2
	elseif randomnr <= 30 then
		randomnr = 3
	elseif randomnr <= 40 then
		randomnr = 4
	elseif randomnr <= 50 then
		randomnr = 5
	end
	for u = 0, 7 do
		DeactivateSpawnpoint(Mission.SpawnPoints[1], u)
		DeactivateSpawnpoint(Mission.SpawnPoints[2], u)
		DeactivateSpawnpoint(Mission.SpawnPoints[3], u)
		DeactivateSpawnpoint(Mission.SpawnPoints[4], u)
		DeactivateSpawnpoint(Mission.SpawnPoints[5], u)
		ActivateSpawnpoint(Mission.SpawnPoints[randomnr], u)
		Mission.SubmarineTargetClass = Mission.ClassTypes[randomnr]
	end	
	Mission.ActiveSpawn = Mission.SpawnPoints[randomnr]
	
	if randomnr <= 3 then
		Mission.Type = "ships"
	elseif randomnr == 4 then
		Mission.Type = "submarines"
	else
		Mission.Type = "aircraft"
	end
	
	Music_Control_SetLevel(MUSIC_ACTION)
	-- mission tablak, valtozok
	
	SetDeviceReloadEnabled(true)
	
	-- jatekosok
	Mission.Player1 = false
	Mission.Player2 = false
	Mission.Player3 = false
	Mission.Player4 = false
	Mission.Player5 = false
	Mission.Player6 = false
	Mission.Player7 = false
	Mission.Player8 = false

	Mission.PlayersTable = GetPlayerDetails()

	Mission.Players = 0
	
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end

	if Mission.Players <= 2 then
		Mission.Skilllevel = SKILL_STUN
	elseif Mission.Players <= 4 then
		Mission.Skilllevel = SKILL_MPNORMAL
	elseif Mission.Players <= 6 then
		Mission.Skilllevel = SKILL_MPVETERAN
	else 
		Mission.Skilllevel = SKILL_ELITE
	end	
	
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

	MultiScore =	{
		[0]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = nil,
			[8] = nil,
			[9] = nil,
		},
		[1]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = nil,
			[8] = nil,
			[9] = nil,
		},
		[2]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = nil,
			[8] = nil,
			[9] = nil,
			[10] = Mission.Digit4,
		},
		[3]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = nil,
			[8] = nil,
			[9] = nil,
			[10] = Mission.Digit4,
		},
		[4]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = nil,
			[8] = nil,
			[9] = nil,
			[10] = Mission.Digit4,
		},
		[5]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = nil,
			[8] = nil,
			[9] = nil,
			[10] = Mission.Digit4,
		},
		[6]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = nil,
			[8] = nil,
			[9] = nil,
			[10] = Mission.Digit4,
		},
		[7]= {
			[1] = Mission.Digit4,
			[2] = nil,
			[3] = nil,
			[4] = nil,
			[5] = Mission.Digit4,
			[6] = nil,
			[7] = nil,
			[8] = nil,
			[9] = nil,
			[10] = Mission.Digit4,
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
		DisplayScores(1, 0, "mp01.score_comp_your".."| #MultiScore.0.1# / #MultiScore.0.10#", "mp01.score_comp_high".."| #MultiScore.0.5# / #MultiScore.0.10#")
		DisplayScores(1, 1, "mp01.score_comp_your".."| #MultiScore.1.1# / #MultiScore.1.10#", "mp01.score_comp_high".."| #MultiScore.1.5# / #MultiScore.1.10#")
		DisplayScores(1, 2, "mp01.score_comp_your".."| #MultiScore.2.1# / #MultiScore.2.10#", "mp01.score_comp_high".."| #MultiScore.2.5# / #MultiScore.2.10#")
		DisplayScores(1, 3, "mp01.score_comp_your".."| #MultiScore.3.1# / #MultiScore.3.10#", "mp01.score_comp_high".."| #MultiScore.3.5# / #MultiScore.3.10#")
		DisplayScores(1, 4, "mp01.score_comp_your".."| #MultiScore.4.1# / #MultiScore.4.10#", "mp01.score_comp_high".."| #MultiScore.4.5# / #MultiScore.4.10#")
		DisplayScores(1, 5, "mp01.score_comp_your".."| #MultiScore.5.1# / #MultiScore.5.10#", "mp01.score_comp_high".."| #MultiScore.5.5# / #MultiScore.5.10#")
		DisplayScores(1, 6, "mp01.score_comp_your".."| #MultiScore.6.1# / #MultiScore.6.10#", "mp01.score_comp_high".."| #MultiScore.6.5# / #MultiScore.6.10#")
		DisplayScores(1, 7, "mp01.score_comp_your".."| #MultiScore.7.1# / #MultiScore.7.10#", "mp01.score_comp_high".."| #MultiScore.7.5# / #MultiScore.7.10#")
	end

	local PlayersInGame = GetPlayerDetails()
	for index, value in pairs (PlayersInGame) do
		MultiScore[index][1] = 0
		MultiScore[index][5] = 0
		if Mission.PointLimit ~= 0 then
			MultiScore[index][10] = Mission.PointLimit
		end
	end

	AISetSpawnSceneUnitsWeightMul(0)

	SetThink(this, "luaScene902Com_think")
end

function luaScene902Com_think(this, msg)
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
		luaCheckMissionEnd()
		luaUSSpawnPoint()
		luaUSAFTargeting()
		luaUSCVTargeting()
		luaUSSYTargeting()
		luaJPAFTargeting()
		luaJPSYTargeting()
		luaJPSubmarineTargeting()
		luaCheckListeners()
	elseif not Mission.Started then
		luaStartMission()
		luaUpdateCounters()
		luaSpawnJPFleet()
		luaCheckJPFleet()
		luaDelay(luaSpawnUSAirfield, 15)
		luaDelay(luaSpawnUSCV, 15)
		luaDelay(luaSpawnUSShipyard, 15)
		luaDelay(luaSpawnJPAirfield, 15)
		luaDelay(luaSpawnJPShipyard, 15)
	end
end

function luaStartMission()
-- RELEASE_LOGOFF  	luaLog("  Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()			
	
	luaMultiVoiceOverHandler()

	AISetTargetWeight(2006, 59, false, 50)		--North Carolina to Yamato	
	AISetTargetWeight(2006, 60, false, 50)		--North Carolina to Kongo	
	AISetTargetWeight(2006, 2007, false, 50)	--North Carolina to Nagato	
	AISetTargetWeight(2006, 205, false, 0)		--North Carolina to Shipyard
	
	AISetTargetWeight(7, 59, false, 50)			--North Carolina to Yamato	
	AISetTargetWeight(7, 60, false, 50)			--South Dakota to Kongo	
	AISetTargetWeight(7, 2007, false, 50)		--South Dakota to Nagato	
	AISetTargetWeight(7, 205, false, 0)			--South Dakota to Shipyard
	
	AISetTargetWeight(13, 59, false, 50)		--New York to Yamato	
	AISetTargetWeight(13, 60, false, 50)		--New York to Kongo	
	AISetTargetWeight(13, 2007, false, 50)		--New York to Nagato	
	AISetTargetWeight(13, 205, false, 0)		--New York to Shipyard
	
	AISetTargetWeight(19, 59, false, 50)		--Northampton to Yamato	
	AISetTargetWeight(19, 60, false, 50)		--Northampton to Kongo	
	AISetTargetWeight(19, 2007, false, 50)		--Northampton to Nagato	
	AISetTargetWeight(19, 205, false, 0)		--Northampton to Shipyard
	
	AISetTargetWeight(903, 59, false, 50)		--Brooklyn to Yamato	
	AISetTargetWeight(903, 60, false, 50)		--Brooklyn to Kongo	
	AISetTargetWeight(903, 2007, false, 50)		--Brooklyn to Nagato	
	AISetTargetWeight(903, 205, false, 0)		--Brooklyn to Shipyard
	
	AISetTargetWeight(901, 59, false, 50)		--Porter to Yamato	
	AISetTargetWeight(901, 60, false, 50)		--Porter to Kongo	
	AISetTargetWeight(901, 2007, false, 50)		--Porter to Nagato	
	AISetTargetWeight(901, 205, false, 0)		--Porter to Shipyard
	
	AISetTargetWeight(11, 59, false, 50)		--Allen M Sumner to Yamato	
	AISetTargetWeight(11, 60, false, 50)		--Allen M Sumner to Kongo	
	AISetTargetWeight(11, 2007, false, 50)		--Allen M Sumner to Nagato	
	AISetTargetWeight(11, 205, false, 0)		--Allen M Sumner to Shipyard
	
	AISetTargetWeight(30, 59, false, 50)		--Gato to Yamato	
	AISetTargetWeight(30, 60, false, 50)		--Gato to Kongo	
	AISetTargetWeight(30, 2007, false, 50)		--Gato to Nagato	
	AISetTargetWeight(30, 205, false, 0)		--Gato to Shipyard
	
	AISetTargetWeight(16, 59, false, 50)		--TBM to Yamato	
	AISetTargetWeight(16, 60, false, 50)		--TBM to Kongo	
	AISetTargetWeight(16, 2007, false, 50)		--TBM to Nagato	
	AISetTargetWeight(16, 205, false, 10)		--TBM to Shipyard
	
	AISetTargetWeight(113, 59, false, 50)		--TBF to Yamato	
	AISetTargetWeight(113, 60, false, 50)		--TBF to Kongo	
	AISetTargetWeight(113, 2007, false, 50)		--TBF to Nagato	
	AISetTargetWeight(113, 205, false, 10)		--TBF to Shipyard
	
	AISetTargetWeight(38, 59, false, 50)		--Helldiver to Yamato	
	AISetTargetWeight(38, 60, false, 50)		--Helldiver to Kongo	
	AISetTargetWeight(38, 2007, false, 50)		--Helldiver to Nagato	
	AISetTargetWeight(38, 205, false, 10)		--Helldiver to Shipyard
	
	AISetTargetWeight(118, 59, false, 50)		--Mitchell to Yamato	
	AISetTargetWeight(118, 60, false, 50)		--Mitchell to Kongo	
	AISetTargetWeight(118, 2007, false, 50)		--Mitchell to Nagato	
	AISetTargetWeight(118, 205, false, 10)		--Mitchell to Shipyard
	
	AISetTargetWeight(26, 167, false, 10)		--Hellcat to Betty	
	AISetTargetWeight(26, 32, false, 10)		--Hellcat to Ohka	
	AISetTargetWeight(26, 166, false, 10)		--Hellcat to Nell	
	AISetTargetWeight(26, 174, false, 10)		--Hellcat to Mavis
	AISetTargetWeight(26, 174, false, 10)		--Hellcat to Mavis
	AISetTargetWeight(26, 205, false, 10)		--Hellcat to Shipyard
	AISetTargetWeight(26, 463, false, 0)		--Hellcat to Heavy AA	
	
	AISetTargetWeight(104, 167, false, 10)		--Lightning to Betty	
	AISetTargetWeight(104, 32, false, 10)		--Lightning to Ohka	
	AISetTargetWeight(104, 166, false, 10)		--Lightning to Nell	
	AISetTargetWeight(104, 174, false, 10)		--Lightning to Mavis
	AISetTargetWeight(104, 174, false, 10)		--Lightning to Mavis
	AISetTargetWeight(104, 205, false, 10)		--Lightning to Shipyard
	AISetTargetWeight(104, 463, false, 0)		--Lightning to Heavy AA
	
	if Mission.LobbyCountDown ~= 0 then
		Countdown("mp.score_comp_time_left", 0, Mission.LobbyCountDown, "luaMissionEndTimeIsUp")
	end

	for i = 1, 8 do
		luaObj_Add("primary", i)
	end
	Mission.Started = true
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Competitive02")
	-- mode description hint overlay
end


--------------------------------FUNCTIONS TO SPAWN ALL THE DIFFERENT UNITS IN THE MATCH-------------------------------
function luaSpawnJPFleet()
	local fleetnum = random(1, 30)
	if fleetnum <= 10 then
		for i = 1, 9 do
			local unit = GenerateObject(Mission.FormationYamato[i].Name)
			SetForcedReconLevel(unit, 2, PARTY_ALLIED)
			SetSkillLevel(unit, Mission.Skilllevel)
			table.insert(Mission.JPFleet, unit)		
		end
	elseif fleetnum <= 20 then
		for i = 1, 7 do
			local unit = GenerateObject(Mission.FormationKongo[i].Name)
			SetForcedReconLevel(unit, 2, PARTY_ALLIED)
			SetSkillLevel(unit, Mission.Skilllevel)
			table.insert(Mission.JPFleet, unit)		
		end
	elseif fleetnum <= 30 then
		for i = 1, 7 do
			local unit = GenerateObject(Mission.FormationNagato[i].Name)
			SetForcedReconLevel(unit, 2, PARTY_ALLIED)
			SetSkillLevel(unit, Mission.Skilllevel)
			table.insert(Mission.JPFleet, unit)		
		end	
	end
end

function luaSpawnUSAirfield()
	if not Mission.USAirfield.Dead then
	  	local SpawnCoord = GetPosition(Mission.USAirfield)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeP38,
				["Name"] = "P-38 Lightning",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 5,
				["Equipment"] = 0,
			},
			{
				["Type"] = Mission.TypeB17,
				["Name"] = "B-17 Flying Fortress",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 5,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeB25,
				["Name"] = "B-25 Mitchell",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 5,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaEventSpawnUSAirfieldCallback",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
		luaDelay(luaSpawnUSAirfield, 180)
	end
end

function luaEventSpawnUSAirfieldCallback(unit1,unit2,unit3)
	if Mission.JPAirfield.Dead and Mission.JPShipyard.Dead then
		Kill(unit1, true)
	else	
		SetRoleAvailable(unit1, EROLF_ALL, PLAYER_AI)
		SquadronSetSpeed(unit1, 55)
		EntityTurnToPosition(unit1, Mission.MapCentre)	
		unit1.reloadset = false
		table.insert(Mission.USAFPlanes, unit1)
	end
	
	SetRoleAvailable(unit2, EROLF_ALL, PLAYER_AI)
	SquadronSetSpeed(unit2, 55)	
	EntityTurnToPosition(unit2, Mission.MapCentre)
	unit2.reloadset = false
	table.insert(Mission.USAFPlanes, unit2)	
	
	SetRoleAvailable(unit3, EROLF_ALL, PLAYER_AI)
	SquadronSetSpeed(unit3, 55)
	EntityTurnToPosition(unit3, Mission.MapCentre)
	unit3.reloadset = false
	table.insert(Mission.USAFPlanes, unit3)
end

function luaSpawnUSCV()
	if not Mission.Wasp.Dead then
	  	local SpawnCoord = GetPosition(Mission.Wasp)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_ALLIED,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeF6F,
				["Name"] = "F6F Hellcat",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 5,
				["Equipment"] = 0,
			},
			{
				["Type"] = Mission.TypeSB2C,
				["Name"] = "SB2C Helldiver",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 5,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeTBF,
				["Name"] = "TBF Avenger",
				["Crew"] = 3,
				["Race"] = USA,
				["WingCount"] = 5,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaEventSpawnUSCVCallback",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})
	luaDelay(luaSpawnUSCV, 180)
	end
end

function luaEventSpawnUSCVCallback(unit1,unit2,unit3)
	if Mission.JPAirfield.Dead and Mission.JPShipyard.Dead then
		Kill(unit1, true)
	else	
		SetRoleAvailable(unit1, EROLF_ALL, PLAYER_AI)
		SquadronSetSpeed(unit1, 55)
		EntityTurnToPosition(unit1, Mission.MapCentre)	
		unit1.reloadset = false
		table.insert(Mission.USCVPlanes, unit1)
	end
	
	SetRoleAvailable(unit2, EROLF_ALL, PLAYER_AI)
	SquadronSetSpeed(unit2, 55)	
	EntityTurnToPosition(unit2, Mission.MapCentre)
	unit2.reloadset = false
	table.insert(Mission.USCVPlanes, unit2)
	
	SetRoleAvailable(unit3, EROLF_ALL, PLAYER_AI)
	SquadronSetSpeed(unit3, 55)
	EntityTurnToPosition(unit3, Mission.MapCentre)	
	unit3.reloadset = false
	table.insert(Mission.USCVPlanes, unit3)
end

function luaSpawnUSShipyard()
	if not Mission.USShipyard.Dead then
		for i = 1, 4 do
			local unit = GenerateObject(Mission.ElcoTMPL[i].Name)
			SetShipSpeed(unit, 20)
			table.insert(Mission.USSYShips, unit)
		end
		luaDelay(luaSpawnUSShipyard, 180)
	end
end

function luaSpawnJPAirfield()
	if not Mission.JPAirfield.Dead then
	  	local SpawnCoord = GetPosition(Mission.JPAirfield)
		SpawnCoord.y = 500
		SpawnNew({
		["party"] = PARTY_JAPANESE,
		["groupMembers"] = {
			{
				["Type"] = Mission.TypeJ1N1,
				["Name"] = "J1N1 Gekko",
				["Crew"] = 3,
				["Race"] = Japan,
				["WingCount"] = 5,
				["Equipment"] = 0,
			},
			{
				["Type"] = Mission.TypeJ1N1,
				["Name"] = "J1N1 Gekko",
				["Crew"] = 3,
				["Race"] = Japan,
				["WingCount"] = 5,
				["Equipment"] = 0,
			},
			{
				["Type"] = Mission.TypeG3M,
				["Name"] = "G3M Nell",
				["Crew"] = 3,
				["Race"] = Japan,
				["WingCount"] = 5,
				["Equipment"] = 2,
			},
			{
				["Type"] = Mission.TypeG4M,
				["Name"] = "G4M Betty",
				["Crew"] = 3,
				["Race"] = Japan,
				["WingCount"] = 5,
				["Equipment"] = 1,
			},
			{
				["Type"] = Mission.TypeG4MOhka,
				["Name"] = "Ohka Carrier",
				["Crew"] = 3,
				["Race"] = Japan,
				["WingCount"] = 5,
				["Equipment"] = 1,
			},
		},
		["area"] = {
			["refPos"] = SpawnCoord,
			["angleRange"] = { DEG(-10),DEG(10)},
		},
		["callback"] = "luaEventSpawnJPAirfieldCallback",
		["excludeRadiusOverride"] = {
			["ownHorizontal"] = 150,
			["enemyHorizontal"] = 150,
			["ownVertical"] = 150,
			["enemyVertical"] = 150,
			["formationHorizontal"] = 100,
		},
		})	
		luaDelay(luaSpawnJPAirfield, 180)
	end
end

function luaEventSpawnJPAirfieldCallback(unit1,unit2,unit3,unit4, unit5)
	table.insert(Mission.JPAFPlanes, unit1)
	table.insert(Mission.JPAFPlanes, unit2)
	table.insert(Mission.JPAFPlanes, unit3)
	table.insert(Mission.JPAFPlanes, unit4)
	table.insert(Mission.JPAFPlanes, unit5)
	
	SetRoleAvailable(unit1, EROLF_ALL, PLAYER_AI)
	SquadronSetSpeed(unit1, 55)
	EntityTurnToPosition(unit1, Mission.MapCentre)
	PilotMoveToRange(unit1, Mission.MapCentre)
	UnitSetFireStance(unit1, 2)
	unit1.reloadset = false
	
	SetRoleAvailable(unit2, EROLF_ALL, PLAYER_AI)
	SquadronSetSpeed(unit2, 55)	
	EntityTurnToPosition(unit2, Mission.MapCentre)
	PilotMoveToRange(unit1, Mission.MapCentre)
	UnitSetFireStance(unit1, 2)
	unit2.reloadset = false
	
	SetRoleAvailable(unit3, EROLF_ALL, PLAYER_AI)
	SquadronSetSpeed(unit3, 55)
	EntityTurnToPosition(unit3, Mission.MapCentre)
	unit3.reloadset = false
	
	SetRoleAvailable(unit4, EROLF_ALL, PLAYER_AI)
	SquadronSetSpeed(unit4, 55)
	EntityTurnToPosition(unit4, Mission.MapCentre)
	unit4.reloadset = false
	
	SetRoleAvailable(unit5, EROLF_ALL, PLAYER_AI)
	SquadronSetSpeed(unit5, 55)
	EntityTurnToPosition(unit5, Mission.MapCentre)	
	unit5.reloadset = false
end

function luaSpawnJPShipyard()
	if not Mission.JPShipyard.Dead then
	  	local SpawnCoord = GetPosition(Mission.JPShipyard)
		SpawnCoord.y = 500
		if Mission.Type ~= "submarines" then
			SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = Mission.TypeH6K,
					["Name"] = "H6K Mavis",
					["Crew"] = 3,
					["Race"] = Japan,
					["WingCount"] = 1,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeH6K,
					["Name"] = "H6K Mavis",
					["Crew"] = 3,
					["Race"] = Japan,
					["WingCount"] = 1,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeH6K,
					["Name"] = "H6K Mavis",
					["Crew"] = 3,
					["Race"] = Japan,
					["WingCount"] = 1,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeH6K,
					["Name"] = "H6K Mavis",
					["Crew"] = 3,
					["Race"] = Japan,
					["WingCount"] = 1,
					["Equipment"] = 1,
				},
			},
			["area"] = {
				["refPos"] = SpawnCoord,
				["angleRange"] = { DEG(-10),DEG(10)},
			},
			["callback"] = "luaEventSpawnJPShipYardCallback",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 150,
				["enemyHorizontal"] = 150,
				["ownVertical"] = 150,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			})	
		else
			SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = Mission.TypeF1M,
					["Name"] = "F1M Pete",
					["Crew"] = 3,
					["Race"] = Japan,
					["WingCount"] = 1,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeF1M,
					["Name"] = "F1M Pete",
					["Crew"] = 3,
					["Race"] = Japan,
					["WingCount"] = 1,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeF1M,
					["Name"] = "F1M Pete",
					["Crew"] = 3,
					["Race"] = Japan,
					["WingCount"] = 1,
					["Equipment"] = 1,
				},
				{
					["Type"] = Mission.TypeF1M,
					["Name"] = "F1M Pete",
					["Crew"] = 3,
					["Race"] = Japan,
					["WingCount"] = 1,
					["Equipment"] = 1,
				},
			},
			["area"] = {
				["refPos"] = SpawnCoord,
				["angleRange"] = { DEG(-10),DEG(10)},
			},
			["callback"] = "luaEventSpawnJPShipYardCallback",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 150,
				["enemyHorizontal"] = 150,
				["ownVertical"] = 150,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			})			
		end
		luaDelay(luaSpawnJPShipyard, 240)
	end
end

function luaEventSpawnJPShipYardCallback(unit1,unit2,unit3,unit4)
	table.insert(Mission.JPSYPlanes, unit1)
	table.insert(Mission.JPSYPlanes, unit2)
	table.insert(Mission.JPSYPlanes, unit3)
	table.insert(Mission.JPSYPlanes, unit4)

	SetRoleAvailable(unit1, EROLF_ALL, PLAYER_AI)
	SquadronSetSpeed(unit1, 55)
	EntityTurnToPosition(unit1, Mission.MapCentre)	
	unit1.reloadset = false
	
	SetRoleAvailable(unit2, EROLF_ALL, PLAYER_AI)
	SquadronSetSpeed(unit2, 55)	
	EntityTurnToPosition(unit2, Mission.MapCentre)
	unit2.reloadset = false
	
	SetRoleAvailable(unit3, EROLF_ALL, PLAYER_AI)
	SquadronSetSpeed(unit3, 55)
	EntityTurnToPosition(unit3, Mission.MapCentre)
	unit3.reloadset = false
	
	SetRoleAvailable(unit4, EROLF_ALL, PLAYER_AI)
	SquadronSetSpeed(unit4, 55)
	EntityTurnToPosition(unit4, Mission.MapCentre)	
	unit4.reloadset = false
end

----------------------------------------------------------------------------------------------------------------------

--------------------------------------FUNCTIONS TO MANAGE UNITS DURING THE MATCH--------------------------------------
function luaCheckJPFleet()
	luaRemoveDeadsFromTable(Mission.JPFleet)
	if table.getn(luaRemoveDeadsFromTable(Mission.JPFleet)) == 0 then
		luaDelay(luaSpawnJPFleet, 5)
		MissionNarrativeParty(PARTY_ALLIED, "mp02.nar_comp_ships") --Japanese ships incoming!
	end
	luaDelay(luaCheckJPFleet, 10)
end

function luaUSSpawnPoint()
	local ships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 20000, PARTY_JAPANESE, "own", nil, nil, "ship")
	if ships ~= nil then
		local ship = luaGetNearestUnitFromTable({["x"] = 0, ["y"] = 0, ["z"] = 0}, ships)
		local coord = GetPosition(ship)
			coord.x = coord.x + 4000
			coord.z = 4000
			if Mission.Type ~= "aircraft" then
				coord.y = -0.5146
			else
				coord.y = 500
			end
			
			PutTo(Mission.ActiveSpawn, coord)	
	end
end

function luaUSAFTargeting()
	if not Mission.USAirfield.Dead then
		if Mission.USAFTarget == nil or Mission.USAFTarget.Dead then
			luaRemoveDeadsFromTable(Mission.USAFPlanes)
			if table.getn(luaRemoveDeadsFromTable(Mission.USAFPlanes)) ~= 0 then
				if not Mission.JPAirfield.Dead then
					Mission.USAFTarget = Mission.JPAirfield
				elseif not Mission.JPShipyard.Dead then
					Mission.USAFTarget = Mission.JPShipyard
				else
					luaRemoveDeadsFromTable(Mission.JPFleet)
					if table.getn(luaRemoveDeadsFromTable(Mission.JPFleet)) ~= 0 then
						Mission.USAFTarget = luaPickRnd(Mission.JPFleet)
					end
				end		
			end
		end

		local cmd = nil
		if not Mission.USAFTarget.Dead then
			for idx, unit in pairs (Mission.USAFPlanes) do
				if not unit.Dead then
					if unit.Class.ID == Mission.TypeP38 then
						cmd = GetProperty(unit, "unitcommand")
						if cmd ~= "dogfight" or cmd ~= "moveto" then
							PilotMoveToRange(unit, Mission.USAFTarget)
							UnitSetFireStance(unit, 2)
						end
					elseif unit.Class.ID == Mission.TypeB17 or unit.Class.ID == Mission.TypeB25 then
						cmd = GetProperty(unit, "unitcommand")
						if table.getn(GetPayloads(unit)) == 0 and cmd ~= "land" then
							if not Mission.USAirfield.Dead then
								PilotLand(unit, Mission.USAirfield)
							end
						elseif cmd ~= "land" then
							PilotSetTarget(unit, Mission.USAFTarget)
						end					
					end
				end
			end
		end
	end
end

function luaUSCVTargeting()
	if not Mission.Wasp.Dead then
		if Mission.USCVTarget == nil or Mission.USCVTarget.Dead then
			luaRemoveDeadsFromTable(Mission.USCVPlanes)
			if table.getn(luaRemoveDeadsFromTable(Mission.USCVPlanes)) ~= 0 then
				luaRemoveDeadsFromTable(Mission.JPFleet)
				if table.getn(luaRemoveDeadsFromTable(Mission.JPFleet)) ~= 0 then
					Mission.USCVTarget = luaPickRnd(Mission.JPFleet)
				end	
			end
		end

		local cmd = nil
		if not Mission.USCVTarget.Dead then
			for idx, unit in pairs (Mission.USCVPlanes) do
				if not unit.Dead then
					if unit.Class.ID == Mission.TypeF6F then
					cmd = GetProperty(unit, "unitcommand")
						if cmd ~= "dogfight" or cmd ~= "moveto" then
							PilotMoveToRange(unit, Mission.USAFTarget)
							UnitSetFireStance(unit, 2)
						end
					elseif unit.Class.ID == Mission.TypeSB2C or unit.Class.ID == Mission.TypeTBF then
						cmd = GetProperty(unit, "unitcommand")
						if table.getn(GetPayloads(unit)) == 0 and cmd ~= "land" then
							if not Mission.Wasp.Dead then
								PilotLand(unit, Mission.Wasp)
							end
						elseif cmd ~= "land" then
							PilotSetTarget(unit, Mission.USCVTarget)
						end
					end
				end
			end
		end		
	end
end

function luaUSSYTargeting()
	if not Mission.USShipyard.Dead then
		if Mission.USSYTarget == nil or Mission.USSYTarget.Dead then
			luaRemoveDeadsFromTable(Mission.USSYShips)
			if table.getn(luaRemoveDeadsFromTable(Mission.USSYShips)) ~= 0 then
				luaRemoveDeadsFromTable(Mission.JPFleet)
				if table.getn(luaRemoveDeadsFromTable(Mission.JPFleet)) ~= 0 then
					Mission.USSYTarget = luaPickRnd(Mission.JPFleet)
				end
			end
		end
		
		if not Mission.USSYTarget.Dead then
			for idx, unit in pairs (Mission.USSYShips) do
				if not unit.Dead then
					NavigatorAttackMove(unit, Mission.USSYTarget, {})
				end	
			end	
		end
	end
end

function luaJPAFTargeting()
	if not Mission.JPAirfield.Dead then
		if Mission.JPAFTarget == nil or Mission.JPAFTarget.Dead then
			luaRemoveDeadsFromTable(Mission.JPAFPlanes)
			if table.getn(luaRemoveDeadsFromTable(Mission.JPAFPlanes)) ~= 0 then
				if Mission.Type == "ships" then
					local potentialtargets = {}
					local usships = luaGetShipsAroundCoordinate({["x"] = -2500, ["y"] = 0, ["z"] = 2500}, 20000, PARTY_ALLIED, "own")
					if usships ~= nil then
						for index, unit in pairs (usships) do
							if unit.Class.ID == 2006 or unit.Class.ID == 7 or unit.Class.ID == 13 or unit.Class.ID == 903 or unit.Class.ID == 19 or unit.Class.ID == 17 or unit.Class.ID == 900 or unit.Class.ID == 901 or unit.Class.ID == 43 or unit.Class.ID == 11 then
								table.insert(potentialtargets, unit)
							end
						end
					end	
					if table.getn(potentialtargets) ~= 0 then
						Mission.JPAFTarget = luaPickRnd(potentialtargets)
					end	
				elseif Mission.Type == "submarines" or Mission.Type == "aircraft" then
					luaRemoveDeadsFromTable(Mission.USFleet)
					if table.getn(luaRemoveDeadsFromTable(Mission.USFleet)) ~= 0 then
						Mission.JPAFTarget = luaPickRnd(Mission.USFleet)
					end					
				end			
			end
		end

		if not Mission.JPAFTarget.Dead then
			for idx, unit in pairs (Mission.JPAFPlanes) do
				if not unit.Dead then
					if unit.Class.ID == Mission.TypeJ1N1 then
						PilotMoveToRange(unit, Mission.MapCentre)
						UnitSetFireStance(unit, 2)
					elseif unit.Class.ID == Mission.TypeG3M or unit.Class.ID == Mission.TypeG4M or unit.Class.ID == Mission.TypeG4MOhka then
						local cmd = GetProperty(unit, "unitcommand")
						if table.getn(GetPayloads(unit)) == 0 and cmd ~= "land" then
							if not Mission.JPAirfield.Dead then
								PilotLand(unit, Mission.JPAirfield)
							end
						elseif cmd ~= "land" then
							PilotSetTarget(unit, Mission.JPAFTarget)
						end
					end
				end
			end
		end		
	end	
end

function luaJPSYTargeting()
	if not Mission.JPShipyard.Dead then
		if Mission.JPSYTarget == nil or Mission.JPSYTarget.Dead then
			luaRemoveDeadsFromTable(Mission.JPSYPlanes)
			if table.getn(luaRemoveDeadsFromTable(Mission.JPSYPlanes)) ~= 0 then
				if Mission.Type == "ships" then
					local potentialtargets = {}
					local usships = luaGetShipsAroundCoordinate({["x"] = -2500, ["y"] = 0, ["z"] = 2500}, 20000, PARTY_ALLIED, "own")
					if usships ~= nil then
						for index, unit in pairs (usships) do
							if unit.Class.ID == 2006 or unit.Class.ID == 7 or unit.Class.ID == 13 or unit.Class.ID == 903 or unit.Class.ID == 19 or unit.Class.ID == 17 or unit.Class.ID == 900 or unit.Class.ID == 901 or unit.Class.ID == 43 or unit.Class.ID == 11 then
								table.insert(potentialtargets, unit)
							end
						end
					end	
					if table.getn(potentialtargets) ~= 0 then
						Mission.JPSYTarget = luaPickRnd(potentialtargets)
					end	
				elseif Mission.Type == "submarines" then
					local potentialtargets = {}
					local usships = luaGetShipsAroundCoordinate({["x"] = -2500, ["y"] = 0, ["z"] = 2500}, 20000, PARTY_ALLIED, "own")
					if usships ~= nil then
						for index, unit in pairs (usships) do
							if unit.Class.ID == 30  then
								table.insert(potentialtargets, unit)
							end
						end
					end	
					if table.getn(potentialtargets) ~= 0 then
						Mission.JPSYTarget = luaPickRnd(potentialtargets)
					end	
				elseif Mission.Type == "aircraft" then
					luaRemoveDeadsFromTable(Mission.USFleet)
					if table.getn(luaRemoveDeadsFromTable(Mission.USFleet)) ~= 0 then
						Mission.JPSYTarget = luaPickRnd(Mission.USFleet)
					end					
				end			
			end
		end
		
		if not Mission.JPSYTarget.Dead then
			for idx, unit in pairs (Mission.JPSYPlanes) do
				if not unit.Dead then
					local cmd = GetProperty(unit, "unitcommand")
					if table.getn(GetPayloads(unit)) == 0 and cmd ~= "retreat" then
						PilotRetreat(unit)
					elseif cmd ~= "retreat" then
						PilotSetTarget(unit, Mission.JPSYTarget)
					end				
				end
			end
		end	
	end
end

function luaJPSubmarineTargeting()
	for idx, unit in pairs (Mission.Subs) do
		if not unit.Dead then
			local subtarget = luaGetNearestEnemy(unit, Mission.SubmarineTargetClass)
			if subtarget ~= nil then
				NavigatorAttackMove(unit, subtarget, {})
			end
		end
	end
end

----------------------------------------------------------------------------------------------------------------------

-------------------------------------------FUNCTIONS FOR OBJECTIVE WATCHING-------------------------------------------
function luaUpdateCounters()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Updating counters...")
		if MultiScore ~= nil then
			if table.getn(MultiScore) ~= 0 then
				local PlayersInGame = GetPlayerDetails()
				local highestindex, highestplayerscore = luaCheckHighestScore()
				for index, value in pairs (PlayersInGame) do
					MultiScore[index][1] = Scoring_GetTotalMissionScore(index)
					MultiScore[index][5] = highestplayerscore
				end
			end
		end
	
		luaDelay(luaUpdateCounters, 0.7)
	end
end

function luaMissionEndTimeIsUp()
	MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_time_up")
	local highestindex, highestplayerscore = luaCheckHighestScore()
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
	luaDelay(luaMissionEnd, 0.1)
end

function luaMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	if not Mission.Completed then
		Mission.Completed = true
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
		local highestindex, highestplayerscore = luaCheckHighestScore()
-- RELEASE_LOGOFF  		luaLog(" player "..highestindex.." won")
		local objindex = highestindex + 1
		luaObj_Completed("primary", objindex)
		for i = 1, 8 do
			if i ~= objindex then
				luaObj_Failed("primary", i)
			end
		end
		--local ships = luaGetShipsAroundCoordinate({["x"] = -2500, ["y"] = 0, ["z"] = 2500}, 20000, PARTY_ALLIED, "own")
		if Mission.Type == "ships" or Mission.Type == "submarines" then
			local ships = luaGetShipsAroundCoordinate({["x"] = -2500, ["y"] = 0, ["z"] = 2500}, 20000, PARTY_ALLIED, "own", nil, nil, Mission.SubmarineTargetClass)
			if ships == nil then
				ships = luaGetShipsAroundCoordinate({["x"] = -2500, ["y"] = 0, ["z"] = 2500}, 20000, PARTY_JAPANESE, "own")
			end
			local movietarget = luaPickRnd(ships)
		elseif Mission.Type == "aircraft" then
			local planes = luaGetPlanesAroundCoordinate({["x"] = -2500, ["y"] = 0, ["z"] = 2500}, 20000, PARTY_ALLIED, "own")
			if planes == nil then
				planes = luaGetShipsAroundCoordinate({["x"] = -2500, ["y"] = 0, ["z"] = 2500}, 20000, PARTY_JAPANESE, "own")
			end
			local movietarget = luaPickRnd(planes)
		end
		
		Scoring_RealPlayTimeRunning(false)
		luaMissionCompletedNew(movietarget, "", nil, nil, nil, PARTY_ALLIED)
	end
end

function luaCheckHighestScore()
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

function luaCheckMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Checking mission ending conditions...")
	if Mission.PointLimit ~= 0 then
		local highestindex, highestplayerscore = luaCheckHighestScore()
		if highestplayerscore >= Mission.PointLimit and not Mission.MissionEndCalled then
-- RELEASE_LOGOFF  			luaLog(" playerindex: "..highestindex.." | score: "..highestplayerscore.." | calling mission end")
			Mission.MissionEndCalled = true
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
			luaDelay(luaMissionEnd, 0.1)				
		end
	end
end

function luaCheckListeners()
-- RELEASE_LOGOFF  	luaLog(" Checking Listeners...")
	if not Mission.ListenerTimerSet then
-- RELEASE_LOGOFF  		luaLog("  setting listener timer")
		Mission.ListenerTimerSet = true
		Mission.ListenerTimer = 60
		Mission.ReminderTimer = 0
	end

	if GameTime() > Mission.ListenerTimer and not Mission.ListenerActive then
		local randomtime = luaRnd(90, 130)
		Mission.ListenerTimer = GameTime() + randomtime
		Mission.ReminderTimer = GameTime() + 14
		if table.getn(Mission.JPFleet) ~= 0 then
			local possibletargets = luaRemoveDeadsFromTable(Mission.JPFleet)
			if possibletargets ~= nil then
				Mission.RandomTarget = luaPickRnd(possibletargets)
				SetForcedReconLevel(Mission.RandomTarget, 2, PARTY_ALLIED)
				MissionNarrativeParty(PARTY_ALLIED, "mp01.nar_comp_bonus_kill")
				for i = 1, 8 do
					luaObj_AddUnit("primary", i, Mission.RandomTarget)
				end
				AISetHintWeight(Mission.RandomTarget, 300)
				AddListener("kill", "TargetKill", {
					["callback"] = "luaTargetKill",
					["entity"] = {Mission.RandomTarget},
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {},
				})
				Mission.ListenerActive = true
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

function luaTargetKill(target, lastAttacker, lastAttackerPlayerIndex)
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
		local randomtime = luaRnd(60, 80)
		Mission.ListenerTimer = GameTime() + randomtime
	end
end

----------------------------------------------------------------------------------------------------------------------