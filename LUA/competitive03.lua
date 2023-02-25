--SceneFile="Missions\Multi\Scene3.scn"

function luaPrecacheUnits()
	PrepareClass(133) -- Buffalo
	PrepareClass(26) -- Hellcat
	PrepareClass(102) -- Corsair
	PrepareClass(104) -- Lightning
	PrepareClass(5) -- Shooting Star
	PrepareClass(101) -- Wildcat
	PrepareClass(134) -- Hurricane
	PrepareClass(392) -- Mustang
	PrepareClass(118) -- B-25 Mitchell
	PrepareClass(125) -- PBY Catalina
	PrepareClass(38) -- SB2C Helldiver
	PrepareClass(112) -- TDB Devastator
	PrepareClass(27) -- Elco
	PrepareClass(37) -- Cargo
	PrepareClass(12) -- LSM (spec QA)
	PrepareClass(41) -- LST (spec QA)
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAC3Mission")
end

function luaInitQAC3Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Comp3"..dateandtime

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
	Mission.MultiplayerNumber = 3
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

	-- spawn pontok
	-- nincsenek berakva a pontok
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

	-- mission tablak, valtozok
	Mission.KillScore = 50

	Mission.AttackerPlanes = {}
	Mission.BomberFilter = {}
	Mission.ShipFilter = {}
	Mission.SpawnPointOccupied = {}
		table.insert(Mission.SpawnPointOccupied, false)
		table.insert(Mission.SpawnPointOccupied, false)
		table.insert(Mission.SpawnPointOccupied, false)
		table.insert(Mission.SpawnPointOccupied, false)
		table.insert(Mission.SpawnPointOccupied, false)
		table.insert(Mission.SpawnPointOccupied, false)
		table.insert(Mission.SpawnPointOccupied, false)
		table.insert(Mission.SpawnPointOccupied, false)
		table.insert(Mission.SpawnPointOccupied, false)
		table.insert(Mission.SpawnPointOccupied, false)
		table.insert(Mission.SpawnPointOccupied, false)
		table.insert(Mission.SpawnPointOccupied, false)

	-- amerikai objektumok
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("Comp - HQ 01"))
		table.insert(Mission.HQs, FindEntity("Comp - HQ 02"))
	Mission.CenterPoint = GetPosition(FindEntity("Comp - CenterPoint"))
	Mission.SpawnPoints = {}
		table.insert(Mission.SpawnPoints, GetPosition(FindEntity("Comp - Navpoint 01")))
		table.insert(Mission.SpawnPoints, GetPosition(FindEntity("Comp - Navpoint 02")))
		table.insert(Mission.SpawnPoints, GetPosition(FindEntity("Comp - Navpoint 03")))
		table.insert(Mission.SpawnPoints, GetPosition(FindEntity("Comp - Navpoint 04")))
		table.insert(Mission.SpawnPoints, GetPosition(FindEntity("Comp - Navpoint 05")))
		table.insert(Mission.SpawnPoints, GetPosition(FindEntity("Comp - Navpoint 06")))
		table.insert(Mission.SpawnPoints, GetPosition(FindEntity("Comp - Navpoint 07")))
		table.insert(Mission.SpawnPoints, GetPosition(FindEntity("Comp - Navpoint 08")))
		table.insert(Mission.SpawnPoints, GetPosition(FindEntity("Comp - Navpoint 09")))
		table.insert(Mission.SpawnPoints, GetPosition(FindEntity("Comp - Navpoint 10")))
		table.insert(Mission.SpawnPoints, GetPosition(FindEntity("Comp - Navpoint 11")))
		table.insert(Mission.SpawnPoints, GetPosition(FindEntity("Comp - Navpoint 12")))
	Mission.BomberPoints = {}
		table.insert(Mission.BomberPoints, GetPosition(FindEntity("Comp - Navpoint Bomb 01")))
		table.insert(Mission.BomberPoints, GetPosition(FindEntity("Comp - Navpoint Bomb 02")))
	Mission.ShipPoints = {}
		table.insert(Mission.ShipPoints, GetPosition(FindEntity("Comp - Navpoint Ship 01")))
		table.insert(Mission.ShipPoints, GetPosition(FindEntity("Comp - Navpoint Ship 02")))
	Mission.ExitPoint = GetPosition(FindEntity("Comp - Navpoint ExitPoint"))
	Mission.USPlanes = {}
		table.insert(Mission.USPlanes, luaFindHidden("Comp - Buffalo 01"))
		table.insert(Mission.USPlanes, luaFindHidden("Comp - Corsair 01"))
		table.insert(Mission.USPlanes, luaFindHidden("Comp - Hellcat 01"))
		table.insert(Mission.USPlanes, luaFindHidden("Comp - Lightning 01"))
		table.insert(Mission.USPlanes, luaFindHidden("Comp - Shooting Star 01"))
		table.insert(Mission.USPlanes, luaFindHidden("Comp - Wildcat 01"))
		table.insert(Mission.USPlanes, luaFindHidden("Comp - Hurricane 01"))
		table.insert(Mission.USPlanes, luaFindHidden("Comp - Mustang 01"))
	Mission.USBombers = {}
		table.insert(Mission.USBombers, luaFindHidden("Comp - B-25 Mitchell"))
		table.insert(Mission.USBombers, luaFindHidden("Comp - PBY Catalina"))
		table.insert(Mission.USBombers, luaFindHidden("Comp - SB2C Helldiver"))
		table.insert(Mission.USBombers, luaFindHidden("Comp - TDB Devastator"))
	Mission.USShips = {}
		table.insert(Mission.USShips, luaFindHidden("Comp - Elco"))
		table.insert(Mission.USShips, luaFindHidden("Comp - LSM"))
		table.insert(Mission.USShips, luaFindHidden("Comp - LST"))
		table.insert(Mission.USShips, luaFindHidden("Comp - Cargo"))

	-- japan objektumok
	Mission.RaidenTMPL = luaFindHidden("Comp - RaidenTMPL")

	-- jatekosok
	Mission.Player1 = false
	Mission.Player2 = false
	Mission.Player3 = false
	Mission.Player4 = false
	Mission.Player5 = false
	Mission.Player6 = false
	Mission.Player7 = false
	Mission.Player8 = false
	Mission.AI1 = false
	Mission.AI2 = false
	Mission.AI3 = false
	Mission.AI4 = false
	Mission.AI5 = false
	Mission.AI6 = false
	Mission.AI7 = false
	Mission.AI8 = false

	--Mission.Players = 0
	--Mission.AIPlayers = 0
	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog("-- playertable --")
-- RELEASE_LOGOFF  	luaLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	luaLog("-----------------")
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)
--[[
	local players = Multi_GetPlayers()
	for playerindex, playerparty in pairs (players) do
		if playerindex == 0 then
			Mission.Player1 = true
		elseif playerindex == 1 then
			Mission.Player2 = true
		elseif playerindex == 2 then
			Mission.Player3 = true
		elseif playerindex == 3 then
			Mission.Player4 = true
		elseif playerindex == 4 then
			Mission.Player5 = true
		elseif playerindex == 5 then
			Mission.Player6 = true
		elseif playerindex == 6 then
			Mission.Player7 = true
		elseif playerindex == 7 then
			Mission.Player8 = true
		end
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Human players total: "..Mission.Players)
]]
	-- lefigyelesek

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

	SetRocketAirGroundTypeDifferent(false)

	AISetSpawnSceneUnitsWeightMul(0)

	luaInitNewSystems()

    SetThink(this, "luaQAC3Mission_think")
end

function luaQAC3Mission_think(this, msg)
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
		luaQAC3CheckListeners()
		luaQAC3CheckPlanes()
		luaQAC3CheckBombers()
		luaQAC3CheckShips()
		luaQAC3CheckMissionEnd()
		luaQAC3HintManager()

	elseif not Mission.Started then
		luaQAC3StartMission()		
		luaUpdateCounters()
	end
end

function luaQAC3StartMission()
-- RELEASE_LOGOFF  	luaLog("  Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()			
	
	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	if Mission.LobbyCountDown ~= 0 then
		Countdown("mp.score_comp_time_left", 0, Mission.LobbyCountDown, "luaQAC3MissionEndTimeIsUp")
	end

	local randomtimer = luaRnd(60, 80)
	luaDelay(luaQAC3PermitBombers, randomtimer)
	randomtimer = luaRnd(150, 200)
	luaDelay(luaQAC3PermitShips, randomtimer)
	luaDelay(luaPermitSpawn, 4)

	for i = 1, 8 do
		luaObj_Add("primary", i)
	end

	Mission.Started = true
end

function luaPermitSpawn()
	if Mission.Players >= 7 then
		--Mission.AttackerPlanesToSpawn = 10
		Mission.AttackerPlanesToSpawn = 9
	elseif Mission.Players == 5 or Mission.Players == 6 then
		--Mission.AttackerPlanesToSpawn = 8
		Mission.AttackerPlanesToSpawn = 7
	elseif Mission.Players <= 4 then
		--Mission.AttackerPlanesToSpawn = 6
		Mission.AttackerPlanesToSpawn = 5
	elseif Mission.Players <= 2 then
		--Mission.AttackerPlanesToSpawn = 6
		Mission.AttackerPlanesToSpawn = 3
	end
-- RELEASE_LOGOFF  	luaLog("  -> Attacker planes: "..Mission.AttackerPlanesToSpawn)
	Mission.PermitAttack = true
	MissionNarrativeParty(PARTY_JAPANESE, "mp03.nar_comp_us_fighter")
--[[
	Mission.PlanesInScene = luaGetPlanesAroundCoordinate(Mission.CenterPoint, 30000, PARTY_JAPANESE, "own")
	if Mission.PlanesInScene ~= nil then
		--luaLog(" ... "..tostring(table.getn(Mission.PlanesInScene)).." planes found ...")
		if table.getn(Mission.PlanesInScene) ~= 0 then
			Mission.PlanesInScene = luaRemoveDeadsFromTable(Mission.PlanesInScene)
			for index, value in pairs (Mission.PlanesInScene) do
				local unitroles = GetRoleAvailable(value)
				local ownerplayer = unitroles[1]
				--luaLog(" ... ownerplayer: "..tostring(ownerplayer).." ...")
				if ownerplayer == 0 then
					if Mission.Player1 == false then
-- RELEASE_LOGOFF  						luaLog("  -> AI1 found")
						Mission.AIPlayers = Mission.AIPlayers + 1
						Mission.Players = Mission.Players + 1
					end
				elseif ownerplayer == 1 then
					if Mission.Player2 == false then
-- RELEASE_LOGOFF  						luaLog("  -> AI2 found")
						Mission.AIPlayers = Mission.AIPlayers + 1
						Mission.Players = Mission.Players + 1
					end
				elseif ownerplayer == 2 then
					if Mission.Player3 == false then
-- RELEASE_LOGOFF  						luaLog("  -> AI3 found")
						Mission.AIPlayers = Mission.AIPlayers + 1
						Mission.Players = Mission.Players + 1
					end
				elseif ownerplayer == 3 then
					if Mission.Player4 == false then
-- RELEASE_LOGOFF  						luaLog("  -> AI4 found")
						Mission.AIPlayers = Mission.AIPlayers + 1
						Mission.Players = Mission.Players + 1
					end
				elseif ownerplayer == 4 then
					if Mission.Player5 == false then
-- RELEASE_LOGOFF  						luaLog("  -> AI5 found")
						Mission.AIPlayers = Mission.AIPlayers + 1
						Mission.Players = Mission.Players + 1
					end
				elseif ownerplayer == 5 then
					if Mission.Player6 == false then
-- RELEASE_LOGOFF  						luaLog("  -> AI6 found")
						Mission.AIPlayers = Mission.AIPlayers + 1
						Mission.Players = Mission.Players + 1
					end
				elseif ownerplayer == 6 then
					if Mission.Player7 == false then
-- RELEASE_LOGOFF  						luaLog("  -> AI7 found")
						Mission.AIPlayers = Mission.AIPlayers + 1
						Mission.Players = Mission.Players + 1
					end
				elseif ownerplayer == 7 then
					if Mission.Player8 == false then
-- RELEASE_LOGOFF  						luaLog("  -> AI8 found")
						Mission.AIPlayers = Mission.AIPlayers + 1
						Mission.Players = Mission.Players + 1
					end
				else
-- RELEASE_LOGOFF  					luaLog("  -> unindexed unit found")
					Mission.AIPlayers = Mission.AIPlayers + 1
					Mission.Players = Mission.Players + 1
				end
			end
		end
	else
-- RELEASE_LOGOFF  		luaLog("nil")
	end
	if Mission.Players >= 7 then
		Mission.AttackerPlanesToSpawn = 12
	elseif Mission.Players == 5 or Mission.Players == 6 then
		Mission.AttackerPlanesToSpawn = 9
	elseif Mission.Players <= 4 then
		Mission.AttackerPlanesToSpawn = 6
	end
-- RELEASE_LOGOFF  	luaLog("  -> AI players total: "..Mission.AIPlayers)
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)
-- RELEASE_LOGOFF  	luaLog("  -> Attacker planes: "..Mission.AttackerPlanesToSpawn)
	Mission.PermitAttack = true
	MissionNarrativeParty(PARTY_JAPANESE, "Incoming!")
]]
end

function luaQAC3CheckPlanes()
-- RELEASE_LOGOFF  	luaLog(" Checking planes...")
	if Mission.PermitAttack then
		if not Mission.FirstSpawnCalled then
			for i = 1, Mission.AttackerPlanesToSpawn do
				luaQAC3GeneratePlane(i)
			end
			Mission.FirstSpawnCalled = true
		else
			for index, unit in pairs (Mission.AttackerPlanes) do
				if unit.Dead and Mission.SpawnPointOccupied[index] then
					Mission.SpawnPointOccupied[index] = false
					luaQAC3GeneratePlane(index)
				else
					if UnitGetAttackTarget(unit) == nil then
						local nearestenemy = luaGetNearestEnemy(unit)
						if nearestenemy ~= nil then
							PilotSetTarget(unit, nearestenemy)
						end
					end
				end
			end
		end
	end
end

function luaQAC3GeneratePlane(index)
-- RELEASE_LOGOFF  	luaLog("  -> SPAWNING SQUAD TO SPAWNPOINT "..index.." <-")
	local planetospawn = luaPickRnd(Mission.USPlanes)
	Mission.AttackerPlanes[index] = GenerateObject(planetospawn.Name, Mission.SpawnPoints[index])
	AISetHintWeight(Mission.AttackerPlanes[index], 1)
	--PutTo(Mission.AttackerPlanes[index], Mission.SpawnPoints[index])
	Mission.SpawnPointOccupied[index] = true
end

function luaQAC3CheckBombers()
-- RELEASE_LOGOFF  	luaLog(" Checking bombers...")
	if Mission.PermitBomb then
		--local squadnumber = luaRnd(2, 4)
		local squadnumber = luaRnd(2, 3)
		local squadtype = luaPickRnd(Mission.USBombers)
		local spawnindex, movetoindex = luaQAC3CheckPlayersAroundHQs("planes", squadtype)
		for i = 1, squadnumber do
			local puttomod = 150 * i
			local coordinate = Mission.BomberPoints[spawnindex]
			local bomber = GenerateObject(squadtype.Name, {["x"] = coordinate.x + puttomod, ["y"] = coordinate.y, ["z"] = coordinate.z + puttomod})
			AISetHintWeight(bomber, 10)
			--PutTo(bomber, {["x"] = coordinate.x + puttomod, ["y"] = coordinate.y, ["z"] = coordinate.z + puttomod})
			--EntityTurnToPosition(bomber, Mission.BomberPoints[movetoindex])
			EntityTurnToPosition(bomber, Mission.ExitPoint)
			--PilotMoveTo(bomber, Mission.BomberPoints[movetoindex])
			PilotMoveTo(bomber, Mission.ExitPoint)
			local maxspeed = bomber.Class.MaxSpd * 0.6
			SquadronSetTravelAlt(bomber, 550)
			SquadronSetTravelSpeed(bomber, maxspeed)
			SquadronSetSpeed(bomber, maxspeed)
			bomber.moveto = movetoindex
			table.insert(Mission.BomberFilter, bomber)
--[[
			if i == 1 then
				for index = 1, 8 do
					luaObj_AddUnit("primary", index, bomber)
				end
				luaQAC3BomberListener(i, bomber)
			end
]]
		end
		Mission.PermitBomb = false
		local randomtimer = luaRnd(200, 250)
		luaDelay(luaQAC3PermitBombers, randomtimer)
	end

	Mission.BomberFilter = luaRemoveDeadsFromTable(Mission.BomberFilter)
	if table.getn(Mission.BomberFilter) ~= 0 then
-- RELEASE_LOGOFF  		luaLog(" Filtering bombers...")
		for index, unit in pairs (Mission.BomberFilter) do
			local distance = luaGetDistance(unit, Mission.ExitPoint)
--[[
			if unit.moveto == 1 then
				distance = luaGetDistance(unit, Mission.BomberPoints[1])
			elseif unit.moveto == 2 then
				distance = luaGetDistance(unit, Mission.BomberPoints[2])
			end
]]
			--luaLog("  moveto: "..tostring(unit.moveto).." | distance: "..tostring(distance))
--[[
			if distance <= 2500 and distance >= 301 and not unit.landing then
-- RELEASE_LOGOFF  				luaLog("  bomber preparing to land...")
				unit.landing = true
				SquadronSetTravelAlt(unit, 200)
			elseif distance <= 250 then
-- RELEASE_LOGOFF  				luaLog("  removing bomber from the scene...")
				Kill(unit, true)
			end
]]
			if distance <= 250 then
-- RELEASE_LOGOFF  				luaLog("  removing bomber from the scene...")
				Kill(unit, true)
			end
		end
	end
end

function luaQAC3CheckShips()
-- RELEASE_LOGOFF  	luaLog(" Checking ships...")
	if Mission.PermitShips then
		--local fleetnumber = luaRnd(3, 6)
		local fleetnumber = luaRnd(2, 3)
		local shiptype = luaPickRnd(Mission.USShips)
		local spawnindex, movetoindex = luaQAC3CheckPlayersAroundHQs("ships", shiptype)
		for i = 1, fleetnumber do
			local puttomod = 100 * i
			local coordinate = Mission.ShipPoints[spawnindex]
			local ship = GenerateObject(shiptype.Name, {["x"] = coordinate.x - puttomod, ["y"] = coordinate.y, ["z"] = coordinate.z})
			AISetHintWeight(ship, 10)
			EntityTurnToPosition(ship, Mission.ExitPoint)
			if i == 1 then
				NavigatorMoveToPos(ship, Mission.ExitPoint)
			else
				JoinFormation(ship, Mission.ShipFilter[1])
			end
			table.insert(Mission.ShipFilter, ship)
		end
		Mission.PermitShips = false
		local randomtimer = luaRnd(180, 210)
		luaDelay(luaQAC3PermitShips, randomtimer)
	end

	Mission.ShipFilter = luaRemoveDeadsFromTable(Mission.ShipFilter)
	if table.getn(Mission.ShipFilter) ~= 0 then
-- RELEASE_LOGOFF  		luaLog(" Filtering ships...")
		for index, unit in pairs (Mission.ShipFilter) do
			local distance = luaGetDistance(unit, Mission.ExitPoint)
			if distance <= 300 then
-- RELEASE_LOGOFF  				luaLog("  removing ship from the scene...")
				Kill(unit, true)
			end
		end
	end
end

function luaQAC3CheckPlayersAroundHQs(unittype, squadtype)
	local planesat1 = luaGetPlanesAroundCoordinate(Mission.BomberPoints[1], 2500, PARTY_JAPANESE, "own")
	local planesat2 = luaGetPlanesAroundCoordinate(Mission.BomberPoints[2], 2500, PARTY_JAPANESE, "own")
	local spawnindex = 0
	local movetoindex = 0
	if planesat1 ~= nil and planesat2 ~= nil then
		if table.getn(planesat1) < table.getn(planesat2) then
			spawnindex = 1
			movetoindex = 2
		elseif table.getn(planesat1) > table.getn(planesat2) then
			spawnindex = 2
			movetoindex = 1
		else
			local randomnumber = luaRnd(1, 2)
			spawnindex = randomnumber
			movetoindex = 3 - spawnindex
		end
	elseif planesat1 == nil and planesat2 == nil then
		local randomnumber = luaRnd(1, 2)
		spawnindex = randomnumber
		movetoindex = 3 - spawnindex
	elseif planesat1 == nil and planesat2 ~= nil then
		spawnindex = 1
		movetoindex = 2
	elseif planesat1 ~= nil and planesat2 == nil then
		spawnindex = 2
		movetoindex = 1
	end
	if spawnindex == 1 then
		if unittype == "ships" then
			MissionNarrativeParty(PARTY_JAPANESE, "mp03.nar_comp_ship_north")
		elseif unittype == "planes" then
			MissionNarrativeParty(PARTY_JAPANESE, "mp03.nar_comp_bomber_north")
		end
	elseif spawnindex == 2 then
		if unittype == "ships" then
			MissionNarrativeParty(PARTY_JAPANESE, "mp03.nar_comp_ship_south")
		elseif unittype == "planes" then
			MissionNarrativeParty(PARTY_JAPANESE, "mp03.nar_comp_bomber_south")
		end
	end
	local pa1tolog = 0
	local pa2tolog = 0
	if planesat1 ~= nil then
		pa1tolog = table.getn(planesat1)
	end
	if planesat2 ~= nil then
		pa2tolog = table.getn(planesat2)
	end
-- RELEASE_LOGOFF  	luaLog("  spawning bombers | sn: "..tostring(squadnumber).." | st: "..tostring(squadtype.Name).." | pa1: "..tostring(pa1tolog).." | pa2: "..tostring(pa2tolog).." | si: "..tostring(spawnindex).." | mi: "..movetoindex)
	return spawnindex, movetoindex
end

function luaQAC3CheckMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Checking mission ending conditions...")
	if Mission.PointLimit ~= 0 then
		local highestindex, highestplayerscore = luaQAC3CheckHighestScore()
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
			luaDelay(luaQAC3MissionEnd, 0.1)
		end
	end
end

function luaQAC3CheckHighestScore()
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

function luaQAC3PermitBombers()
	if not Mission.Completed and not Mission.MissionEnd then
		Mission.BomberFilter = luaRemoveDeadsFromTable(Mission.BomberFilter)
		if table.getn(Mission.BomberFilter) == 0 then
-- RELEASE_LOGOFF  			luaLog(" Permitting Bombing...")
			Mission.PermitBomb = true
		else
			luaDelay(luaQAC3PermitBombers, 30)
		end
	end
end

function luaQAC3PermitShips()
	if not Mission.Completed and not Mission.MissionEnd then
		Mission.ShipFilter = luaRemoveDeadsFromTable(Mission.ShipFilter)
		if table.getn(Mission.ShipFilter) == 0 then
-- RELEASE_LOGOFF  			luaLog(" Permitting Ships...")
			Mission.PermitShips = true
		else
			luaDelay(luaQAC3PermitShips, 30)
		end
	end
end

function luaQAC3MissionEndTimeIsUp()
	MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_time_up")
	local highestindex, highestplayerscore = luaQAC3CheckHighestScore()
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
	luaDelay(luaQAC3MissionEnd, 0.1)
end

function luaQAC3MissionEnd()
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
		local highestindex, highestplayerscore = luaQAC3CheckHighestScore()
-- RELEASE_LOGOFF  		luaLog(" player "..highestindex.." won")
		local objindex = highestindex + 1
		luaObj_Completed("primary", objindex)
		for i = 1, 8 do
			if i ~= objindex then
				luaObj_Failed("primary", i)
			end
		end
		local planes = luaGetPlanesAroundCoordinate(Mission.CenterPoint, 30000, PARTY_JAPANESE, "own")
		Scoring_RealPlayTimeRunning(false)
		if planes ~= nil then
			local movietarget = luaPickRnd(planes)
			luaMissionCompletedNew(movietarget, "", nil, nil, nil, PARTY_JAPANESE)
		else
			local movieraiden = GenerateObject(Mission.RaidenTMPL.Name, Mission.SpawnPoint)
			--PutTo(movieraiden, Mission.SpawnPoint)
			local moveto = luaPickRnd(Mission.HQs)
			EntityTurnToPosition(movieraiden, moveto)
			PilotMoveTo(movieraiden, moveto)
			luaMissionCompletedNew(movieraiden, "", nil, nil, nil, PARTY_JAPANESE)
		end
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Competitive03")
	-- mode description hint overlay
end

function luaUpdateCounters()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Updating counters...")
		if MultiScore ~= nil then
			if table.getn(MultiScore) ~= 0 then
				local PlayersInGame = GetPlayerDetails()
				local highestindex, highestplayerscore = luaQAC3CheckHighestScore()
				for index, value in pairs (PlayersInGame) do
					MultiScore[index][1] = Scoring_GetTotalMissionScore(index)
					MultiScore[index][5] = highestplayerscore
				end
			end
		end
	
		luaDelay(luaUpdateCounters, 0.7)
	end
end

function luaQAC3CheckListeners()
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
		if table.getn(Mission.AttackerPlanes) ~= 0 then
			local possibletargets = luaRemoveDeadsFromTable(Mission.AttackerPlanes)
			if possibletargets ~= nil then
				Mission.RandomTarget = luaPickRnd(possibletargets)
				MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_bonus_kill")
				for i = 1, 8 do
					luaObj_AddUnit("primary", i, Mission.RandomTarget)
				end
				AISetHintWeight(Mission.RandomTarget, 300)
				AddListener("kill", "TargetKill", {
					["callback"] = "luaQAC3TargetKill",
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

function luaQAC3TargetKill(target, lastAttacker, lastAttackerPlayerIndex)
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
--[[
function luaQAC3BomberListener(squadnumber, bomber)
-- RELEASE_LOGOFF  	luaLog("  luaQAC3BomberListener called... | squadnumber: "..squadnumber.." name: "..bomber.Name)
	if squadnumber == 1 then
		if Mission.Bomber1Listener then
			RemoveListener("kill", "BomberKill1")
		end
		AddListener("kill", "BomberKill1", {
			["callback"] = "luaQAC3BomberKill1",
			["entity"] = {bomber},
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {},
		})
		Mission.Bomber1Listener = true

	elseif squadnumber == 2 then
		if Mission.Bomber2Listener then
			RemoveListener("kill", "BomberKill2")
		end
		AddListener("kill", "BomberKill2", {
			["callback"] = "luaQAC3BomberKill2",
			["entity"] = {bomber},
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {},
		})
		Mission.Bomber2Listener = true
	elseif squadnumber == 3 then
		if Mission.Bomber3Listener then
			RemoveListener("kill", "BomberKill3")
		end
		AddListener("kill", "BomberKill3", {
			["callback"] = "luaQAC3BomberKill3",
			["entity"] = {bomber},
			["lastAttacker"] = {},
			["lastAttackerPlayerIndex"] = {},
		})
		Mission.Bomber3Listener = true
	else
-- RELEASE_LOGOFF  		luaLog(" LISTENER: already active!")
	end
end

function luaQAC3BomberKill1(target, lastAttacker, lastAttackerPlayerIndex)
-- RELEASE_LOGOFF  	luaLog(" LISTENER: target killed by player "..lastAttackerPlayerIndex)
	if lastAttackerPlayerIndex >= 0 and lastAttackerPlayerIndex <= 7 then
		Scoring_AddCommandScore(lastAttackerPlayerIndex, "mp01.nar_comp_bonus_kill", Mission.KillScore)
		local powerupnumber = luaRnd(1, 4)
		local powerup
		if powerupnumber == 1 then
			powerup = "evasive_manoeuvre"
		elseif powerupnumber == 2 then
			powerup = "full_throttle"
		elseif powerupnumber == 3 then
			powerup = "improved_shells"
		elseif powerupnumber == 4 then
			powerup = "targeting_computer"
		end
		AddPowerup(lastAttackerPlayerIndex , {["classID"] = powerup,["useLimit"] = 1})
		RemoveListener("kill", "BomberKill1")
		for i = 1, 8 do
			local y = i - 1
			if y == lastAttackerPlayerIndex then
				local playerwhoscored = GetPlayerDetails()[y]
-- RELEASE_LOGOFF  				luaLog(playerwhoscored.playerName)
				for z = 1, 8 do
					local x = z - 1
					MultiScore[x][7] = playerwhoscored.playerName
				end
			end
		end
		luaDelay(luaKillNarrativeBomber1, 2)
	else
-- RELEASE_LOGOFF  		luaLog(" FAIL!!!")
		RemoveListener("kill", "BomberKill1")
		MissionNarrativeParty(PARTY_JAPANESE, "mp03.nar_comp_bomber_bonus_denied")
	end
	Mission.Bomber1Listener = false
end

function luaQAC3BomberKill2(target, lastAttacker, lastAttackerPlayerIndex)
-- RELEASE_LOGOFF  	luaLog(" LISTENER: target killed by player "..lastAttackerPlayerIndex)
	if lastAttackerPlayerIndex >= 0 and lastAttackerPlayerIndex <= 7 then
		Scoring_AddCommandScore(lastAttackerPlayerIndex, "mp01.nar_comp_bonus_kill", Mission.KillScore)
		RemoveListener("kill", "BomberKill2")
		for i = 1, 8 do
			local y = i - 1
			if y == lastAttackerPlayerIndex then
				local playerwhoscored = GetPlayerDetails()[y]
-- RELEASE_LOGOFF  				luaLog(playerwhoscored.playerName)
				for z = 1, 8 do
					local x = z - 1
					MultiScore[x][8] = playerwhoscored.playerName
				end
			end
		end
		luaDelay(luaKillNarrativeBomber2, 2)
	else
-- RELEASE_LOGOFF  		luaLog(" FAIL!!!")
		RemoveListener("kill", "BomberKill2")
		MissionNarrativeParty(PARTY_JAPANESE, "mp03.nar_comp_bomber_bonus_denied")
	end
	Mission.Bomber2Listener = false
end

function luaQAC3BomberKill3(target, lastAttacker, lastAttackerPlayerIndex)
-- RELEASE_LOGOFF  	luaLog(" LISTENER: target killed by player "..lastAttackerPlayerIndex)
	if lastAttackerPlayerIndex >= 0 and lastAttackerPlayerIndex <= 7 then
		Scoring_AddCommandScore(lastAttackerPlayerIndex, "mp01.nar_comp_bonus_kill", Mission.KillScore)
		RemoveListener("kill", "BomberKill3")
		for i = 1, 8 do
			local y = i - 1
			if y == lastAttackerPlayerIndex then
				local playerwhoscored = GetPlayerDetails()[y]
-- RELEASE_LOGOFF  				luaLog(playerwhoscored.playerName)
				for z = 1, 8 do
					local x = z - 1
					MultiScore[x][9] = playerwhoscored.playerName
				end
			end
		end
		luaDelay(luaKillNarrativeBomber3, 2)
	else
-- RELEASE_LOGOFF  		luaLog(" FAIL!!!")
		RemoveListener("kill", "BomberKill3")
		MissionNarrativeParty(PARTY_JAPANESE, "mp03.nar_comp_bomber_bonus_denied")
	end
	Mission.Bomber3Listener = false
end
]]

function luaKillNarrativeBomber1()
	MissionNarrativePlayer(0, "mp03.nar_comp_kill1_1")
	MissionNarrativePlayer(1, "mp03.nar_comp_kill1_2")
	MissionNarrativePlayer(2, "mp03.nar_comp_kill1_3")
	MissionNarrativePlayer(3, "mp03.nar_comp_kill1_4")
	MissionNarrativePlayer(4, "mp03.nar_comp_kill1_5")
	MissionNarrativePlayer(5, "mp03.nar_comp_kill1_6")
	MissionNarrativePlayer(6, "mp03.nar_comp_kill1_7")
	MissionNarrativePlayer(7, "mp03.nar_comp_kill1_8")
end

function luaKillNarrativeBomber2()
	MissionNarrativePlayer(0, "mp03.nar_comp_kill2_1")
	MissionNarrativePlayer(1, "mp03.nar_comp_kill2_2")
	MissionNarrativePlayer(2, "mp03.nar_comp_kill2_3")
	MissionNarrativePlayer(3, "mp03.nar_comp_kill2_4")
	MissionNarrativePlayer(4, "mp03.nar_comp_kill2_5")
	MissionNarrativePlayer(5, "mp03.nar_comp_kill2_6")
	MissionNarrativePlayer(6, "mp03.nar_comp_kill2_7")
	MissionNarrativePlayer(7, "mp03.nar_comp_kill2_8")
end

function luaKillNarrativeBomber3()
	MissionNarrativePlayer(0, "mp03.nar_comp_kill3_1")
	MissionNarrativePlayer(1, "mp03.nar_comp_kill3_2")
	MissionNarrativePlayer(2, "mp03.nar_comp_kill3_3")
	MissionNarrativePlayer(3, "mp03.nar_comp_kill3_4")
	MissionNarrativePlayer(4, "mp03.nar_comp_kill3_5")
	MissionNarrativePlayer(5, "mp03.nar_comp_kill3_6")
	MissionNarrativePlayer(6, "mp03.nar_comp_kill3_7")
	MissionNarrativePlayer(7, "mp03.nar_comp_kill3_8")
end

function luaQAC3HintManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 30 and not Mission.Hint1Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint1Shown")
			ShowHint("ID_Hint_Competitive03_SB_spawn")
			Mission.Hint1Shown = true
		elseif GameTime() > 60 and not Mission.Hint2Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint2Shown")
			ShowHint("ID_Hint_Competitive03_SB")
			Mission.Hint2Shown = true
		elseif GameTime() > 90 and not Mission.Hint3Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint3Shown")
			ShowHint("ID_Hint_Competitive02_Bonus")
			Mission.Hint3Shown = true
		end
	end
end