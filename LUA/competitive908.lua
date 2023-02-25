function luaPrecacheUnits()
	PrepareClass(43) 	-- Shinyo
	PrepareClass(77) 	-- Gyoraitei
	PrepareClass(800) 	-- Zoscar
	
	PrepareClass(27) 	-- Elco
	PrepareClass(102) 	-- Corsair (Rocket Strike Naval Supply)
	PrepareClass(45) 	-- Kamikaze Zero (Rocket Strike Naval Supply)
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitScene908Com")
end

function luaInitScene908Com(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "BattlestationZ"

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
	Mission.MultiplayerNumber = 908
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
		Mission.PointLimit = 500000
	elseif LobbySettings.PointLimit == "500" then
		Mission.PointLimit = 500000
	elseif LobbySettings.PointLimit == "1000" then
		Mission.PointLimit = 500000
	elseif LobbySettings.PointLimit == "2000" then
		Mission.PointLimit = 500000
	elseif LobbySettings.PointLimit == "3000" then
		Mission.PointLimit = 500000
	elseif LobbySettings.PointLimit == "4000" then
		Mission.PointLimit = 500000
	elseif LobbySettings.PointLimit == "5000" then
		Mission.PointLimit = 500000
	else
-- RELEASE_LOGOFF  		luaLog(" LobbySettings.PointLimit contains non-handled string | LobbySettings.PointLimit: "..LobbySettings.PointLimit)
		Mission.PointLimit = 500000
	end

	-- spawn pontok
	-- nincsenek berakva a pontok

-- RELEASE_LOGOFF  	luaLog("-- start of spawnpoint activation --")

-- RELEASE_LOGOFF  	luaLog("-- end of spawnpoint activation --")
	Music_Control_SetLevel(MUSIC_ACTION)
	-- mission tablak, valtozok

	Mission.MapCentre = {["x"] = 0, ["y"] = 0, ["z"] = 0}
	
	Mission.SpawnPoint = {["x"] = 1000, ["y"] = 0, ["z"] = 0}	
	
	Mission.ZShipcoords = {}
		table.insert(Mission.ZShipcoords, FindEntity("ZS1"))
		table.insert(Mission.ZShipcoords, FindEntity("ZS2"))
		table.insert(Mission.ZShipcoords, FindEntity("ZS3"))
		table.insert(Mission.ZShipcoords, FindEntity("ZS4"))
		table.insert(Mission.ZShipcoords, FindEntity("ZS5"))
		table.insert(Mission.ZShipcoords, FindEntity("ZS6"))
		table.insert(Mission.ZShipcoords, FindEntity("ZS7"))
		table.insert(Mission.ZShipcoords, FindEntity("ZS8"))
		table.insert(Mission.ZShipcoords, FindEntity("ZS9"))
		table.insert(Mission.ZShipcoords, FindEntity("ZS10"))
		
		table.insert(Mission.ZShipcoords, FindEntity("ZS11"))
		table.insert(Mission.ZShipcoords, FindEntity("ZS12"))
		table.insert(Mission.ZShipcoords, FindEntity("ZS13"))
		table.insert(Mission.ZShipcoords, FindEntity("ZS14"))
		table.insert(Mission.ZShipcoords, FindEntity("ZS15"))
		table.insert(Mission.ZShipcoords, FindEntity("ZS16"))
		table.insert(Mission.ZShipcoords, FindEntity("ZS17"))
	
	Mission.ZUnits = {}
	
	Mission.ElcoTMPL = luaFindHidden("ElcoTMPL")	
	Mission.ShinyoTMPL = luaFindHidden("ShinyoTMPL")	
		
	Mission.USUnits = {}
	
	Mission.HPMultiplier = 0
		
	Mission.Powerups = {}
		table.insert(Mission.Powerups, "rocket1")
		table.insert(Mission.Powerups, "improved_ship_manoeuvreability")
		table.insert(Mission.Powerups, "improved_repair_team")
		table.insert(Mission.Powerups, "targeting_computer")
		table.insert(Mission.Powerups, "improved_shells")
		table.insert(Mission.Powerups, "hardened_armour")
	
	Mission.Ownertable = {}
		table.insert(Mission.Ownertable, PLAYER_1)
		table.insert(Mission.Ownertable, PLAYER_2)
		table.insert(Mission.Ownertable, PLAYER_3)
		table.insert(Mission.Ownertable, PLAYER_4)
		table.insert(Mission.Ownertable, PLAYER_5)
		table.insert(Mission.Ownertable, PLAYER_6)
		table.insert(Mission.Ownertable, PLAYER_7)
		table.insert(Mission.Ownertable, PLAYER_8)
		table.insert(Mission.Ownertable, PLAYER_AI)
		
	Mission.SpawnPoint = FindEntity("USN Spawn")
	
	Mission.WaveTime = 0
	Mission.EnableSpawn = false
	Mission.ClosedMessage = false
	
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

	DisplayScores(1, 0, "Next Naval Supply"..":| #MultiScore.0.12#", "Players alive:".."| #Mission.PlayersAlive# / ".."Wave: ".."#Mission.Wave#")
	DisplayScores(1, 1, "Next Naval Supply"..":| #MultiScore.1.12#", "Players alive:".."| #Mission.PlayersAlive# / ".."Wave: ".."#Mission.Wave#")
	DisplayScores(1, 2, "Next Naval Supply"..":| #MultiScore.2.12#", "Players alive:".."| #Mission.PlayersAlive# / ".."Wave: ".."#Mission.Wave#")
	DisplayScores(1, 3, "Next Naval Supply"..":| #MultiScore.3.12#", "Players alive:".."| #Mission.PlayersAlive# / ".."Wave: ".."#Mission.Wave#")
	DisplayScores(1, 4, "Next Naval Supply"..":| #MultiScore.4.12#", "Players alive:".."| #Mission.PlayersAlive# / ".."Wave: ".."#Mission.Wave#")
	DisplayScores(1, 5, "Next Naval Supply"..":| #MultiScore.5.12#", "Players alive:".."| #Mission.PlayersAlive# / ".."Wave: ".."#Mission.Wave#")
	DisplayScores(1, 6, "Next Naval Supply"..":| #MultiScore.6.12#", "Players alive:".."| #Mission.PlayersAlive# / ".."Wave: ".."#Mission.Wave#")
	DisplayScores(1, 7, "Next Naval Supply"..":| #MultiScore.7.12#", "Players alive:".."| #Mission.PlayersAlive# / ".."Wave: ".."#Mission.Wave#")

	local PlayersInGame = GetPlayerDetails()
	for index, value in pairs (PlayersInGame) do
		MultiScore[index][1] = 0
		MultiScore[index][5] = 0
		if Mission.PointLimit ~= 0 then
			MultiScore[index][10] = 50
			MultiScore[index][11] = 1
			MultiScore[index][12] = MultiScore[index][10]
		end
	end
	
	Mission.Players = 0
	
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
	
	Mission.Wave = 0
	Mission.WaveCount = Mission.Players * 4

	AISetSpawnSceneUnitsWeightMul(0)

	SetThink(this, "luaScene908Com_think")
end

function luaScene908Com_think(this, msg)
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
		luaUpgrades()
		luaWaves()
		luaTargeting()
		luaGetPlayersAlive()
		luaCheckMissionEnd()
		luaSpawnPlayers()
	elseif not Mission.Started then
		luaStartMission()
		luaMissionTimer()
		luaUpdateCounters()
	end
end

function luaStartMission()
-- RELEASE_LOGOFF  	luaLog("  Starting mission...")
	Scoring_RealPlayTimeRunning(true)
	
	luaMultiVoiceOverHandler()
	
	AISetTargetWeight(27, 43, false, 250)
	AISetTargetWeight(27, 77, false, 250)

	--[[if Mission.LobbyCountDown ~= 0 then
		Countdown("mp.score_comp_time_left", 0, Mission.LobbyCountDown, "luaMissionEndTimeIsUp")
	end]]

	for i = 1, 8 do
		luaObj_Add("primary", i)
	end
	Mission.Started = true
end

function luaMissionTimer()
	Mission.WaveTime = Mission.WaveTime + 1
	luaDelay(luaMissionTimer, 1)
end

function luaSpawnPlayers()
	if Mission.EnableSpawn == true then
		Mission.WaveTime = 0
		MissionNarrativeParty(PARTY_ALLIED, "Dead players have 5 seconds to respawn")
		for i = 0, 7 do
			ActivateSpawnpoint(Mission.SpawnPoint, i)
		end
		Mission.EnableSpawn = false
		Mission.ClosedMessage = true
	end
	if Mission.WaveTime >= 10 and Mission.ClosedMessage == true then
		MissionNarrativeParty(PARTY_ALLIED, "Spawnpoints closed")
		for i = 0, 7 do
			DeactivateSpawnpoint(Mission.SpawnPoint, i)
		end	
		Mission.ClosedMessage = false
	end
end

function luaUSCallback(unit)
	UnitSetFireStance(unit, STANCE_FREE_ATTACK)
	table.insert(Mission.USUnits, unit)
end

function luaUpgrades()
	local ingame = Mission.Players - 1
	for i = 0, ingame do
		MultiScore[i][12] = MultiScore[i][10] - MultiScore[i][1]
		if MultiScore[i][12] < 0 then
			MultiScore[i][12] = 0
		end
		if MultiScore[i][1] >= MultiScore[i][10] then
			MultiScore[i][11] = MultiScore[i][11] + 1
			MultiScore[i][10] = MultiScore[i][10] + (50 * MultiScore[i][11])
			local powerup = luaRnd(1, 6)
			AddPowerup(i , {["classID"] = Mission.Powerups[powerup],["useLimit"] = 1})
		end	
	end
end

function luaSpawnShipZombie(ship, coord)
		SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = ship,
					["Name"] = "ZOMBIE",
					["Crew"] = 1,
					["Race"] = JAPANESE,
				},
			},
			["area"] = {
				["refPos"] = coord,
				["angleRange"] = { DEG(0),DEG(180)},
				["lookAt"] = coord,
	
			},
			["callback"] = "luaZombieShipSpawned",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 5,
				["enemyHorizontal"] = 5,
				["ownVertical"] = 5,
				["enemyVertical"] = 5,
				["formationHorizontal"] = 200,
			},
		})
end

function luaSpawnPlaneZombie(coord)
			SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = 800,
					["Name"] = "Z",
					["Crew"] = 3,
					["Race"] = Japan,
					["WingCount"] = 1,
					["Equipment"] = 0,
				},
			},
			["area"] = {
				["refPos"] = coord,
				["angleRange"] = { DEG(-10),DEG(10)},
			},
			["callback"] = "luaZombiePlaneSpawned",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 150,
				["enemyHorizontal"] = 150,
				["ownVertical"] = 150,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			})
end

function luaZombieShipSpawned(unit)
	SetShipSpeed(unit, 20.5778) --40kts
	SetShipMaxSpeed(unit, 36.0117) --70kts
	--SetForcedReconLevel(unit, 2, PARTY_ALLIED)
	SetGuiName(unit, "Z")
	local closestenemy = luaGetNearestEnemy(unit)
	if closestenemy ~= nil then
		NavigatorAttackMove(unit, closestenemy, {})
		EntityTurnToEntity(unit, closestenemy)
	end
	OverrideHP(unit, unit.Class.HP * Mission.HPMultiplier)
	table.insert(Mission.ZUnits, unit)
end

function luaZombiePlaneSpawned(unit)
	SquadronSetSpeed(unit, 55) --198km/h
	--SetForcedReconLevel(unit, 2, PARTY_ALLIED)
	SetGuiName(unit, "Z")
	local closestenemy = luaGetNearestEnemy(unit)
	if closestenemy ~= nil then
		PilotSetTarget(unit, closestenemy)
		EntityTurnToEntity(unit, closestenemy)
	end
	table.insert(Mission.ZUnits, unit)
end

function luaWaves()
	Mission.ZAlive = table.getn(luaRemoveDeadsFromTable(Mission.ZUnits))
	if Mission.ZAlive == 0 then
		Mission.Wave = Mission.Wave + 1
		--MissionNarrativeParty(PARTY_ALLIED, "WAVE ".."#Mission.Wave#")
		Mission.EnableSpawn = true
		Mission.HPMultiplier = Mission.HPMultiplier + 0.25
		Mission.WaveCount = Mission.WaveCount + (Mission.Players * 2)
		for i = 1, Mission.WaveCount do
			
			local Ztype = random(1,50)
			if Ztype <= 40 then	
				Ztype = 43
			elseif Ztype <= 47 then	
				Ztype = 77
			else
				Ztype = 800	
			end
			
			local Zcoord = random(1,17)
			if Ztype == 43 or Ztype == 77 then
				luaSpawnShipZombie(Ztype, Mission.ZShipcoords[Zcoord])
			else
				luaSpawnPlaneZombie(Mission.ZShipcoords[Zcoord])
			end
		end
	end
end

function luaTargeting()
	for index, unit in pairs (Mission.ZUnits) do
		if not unit.Dead then
			local closestenemy = luaGetNearestEnemy(unit)
			if closestenemy ~= nil then
				if unit.Class.ID == 77 then
					NavigatorMoveToRange(unit, closestenemy)
				elseif unit.Class.ID == 43 then
					NavigatorAttackMove(unit, closestenemy, {})
				else 
					PilotSetTarget(unit, closestenemy)
				end
			end		
		end
	end
end

function luaGetPlayersAlive()
	--Mission.PlayersAlive = table.getn(luaRemoveDeadsFromTable(Mission.USUnits))
	local playertable = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 40000, PARTY_ALLIED, "own")
	if playertable == nil then
		Mission.PlayersAlive = 0
		if Mission.WaveTime >= 20 then
			luaMissionEndTimeIsUp()
		end
	else
		Mission.PlayersAlive = table.getn(playertable)
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
	luaDelay(luaMissionEnd, 1)
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
		local ships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 20000, PARTY_ALLIED, "own")
		Scoring_RealPlayTimeRunning(false)
		if ships ~= nil then
			local movietarget = luaPickRnd(ships)
			luaMissionCompletedNew(movietarget, "", nil, nil, nil, PARTY_ALLIED)
		else
			local movietarget = GenerateObject(Mission.ShinyoTMPL.Name)
			luaMissionCompletedNew(movietarget, "", nil, nil, nil, PARTY_ALLIED)
		end
	end
end
