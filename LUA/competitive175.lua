function luaPrecacheUnits()
	PrepareClass(135) -- P-40 Warhawk
	PrepareClass(101) -- F4F Wildcat
	PrepareClass(113) -- TBF Avenger
	PrepareClass(112) -- TBD Devastator
	PrepareClass(108) -- SBD Dauntless
	PrepareClass(118) -- B-25 Mitchell
	PrepareClass(116) -- B-17 Flying Fortress
	PrepareClass(27)  -- Elco
	PrepareClass(150) -- A6M Zero
	PrepareClass(158) -- D3A Val
	PrepareClass(162) -- B5N Kate
	PrepareClass(86)  -- TroopTransJ
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitScene175Com")
end

function luaInitScene175Com(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Port Moresby"

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
	Mission.MultiplayerNumber = 175
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

-- RELEASE_LOGOFF  	luaLog("-- start of spawnpoint activation --")

-- RELEASE_LOGOFF  	luaLog("-- end of spawnpoint activation --")

	-- mission tablak, valtozok
	Mission.KillScore = 50
	Mission.Targets = {}
	Mission.PlanesTime = 60
	Mission.ElcoTime = 45
	

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

	if Mission.Players <= 4 then
		Mission.SquadCount = 3
	elseif Mission.Players <= 6 then
		Mission.SquadCount = 4
	elseif Mission.Players <= 8 then
		Mission.SquadCount = 5
	else 
		Mission.SquadCount = 2
	end
	
	AISetTargetWeight(150, 108, false, 20) --Zero to Dauntless	
	AISetTargetWeight(150, 112, false, 20) --Zero to Devastator	
	AISetTargetWeight(150, 116, false, 20) --Zero to Flying Fortress	
	AISetTargetWeight(150, 118, false, 20) --Zero to Mitchell	
	AISetTargetWeight(150, 35, false, 20) --Zero to FleetOilerUS
	SetDeviceReloadEnabled(false)
	
	Mission.Zuikaku = FindEntity("Zuikaku")
	Mission.ZuikakuLook = FindEntity("LookTo")
	RepairEnable(Mission.Zuikaku, false)
	
	hp = Mission.Zuikaku.Class.HP*1.5
	OverrideHP(Mission.Zuikaku, hp)
	SetShipMaxSpeed(Mission.Zuikaku, 12.8611)  --25kts
	
	Mission.JPPlanes = {}
	
	Mission.ZuikakuTargets = {}
		table.insert(Mission.ZuikakuTargets, FindEntity("Lexington"))
		table.insert(Mission.ZuikakuTargets, FindEntity("SecondaryAirfieldEntity 01"))
		table.insert(Mission.ZuikakuTargets, FindEntity("MainShipyardEntity 01"))
		table.insert(Mission.ZuikakuTargets, FindEntity("MainShipyardEntity 02"))
		table.insert(Mission.ZuikakuTargets, FindEntity("MainAirfieldEntity 01"))
	
	Mission.SecondaryAirfield = FindEntity("SecondaryAirfieldEntity 01")
	Mission.SecondaryAirfieldSpawnpoint = FindEntity("Secondary Airfield Spawnpoint")
	
	Mission.MainAirfield = FindEntity("MainAirfieldEntity 01")
	Mission.MainAirfieldSpawnpoint = FindEntity("Main Airfield Spawnpoint")
	
	Mission.Shipyard1 = FindEntity("MainShipyardEntity 01")
	Mission.Shipyard2 = FindEntity("MainShipyardEntity 02")
	
	Mission.Lexington = FindEntity("Lexington")
	Mission.LexingtonSpawnpoint = FindEntity("Lexington Spawnpoint")
	RepairEnable(Mission.Lexington, false)
	NavigatorSetTorpedoEvasion(Mission.Lexington, false)
	
	Mission.USPlanes = {}
	
	Mission.Warhawk1TMP = luaFindHidden("Warhawk1")
	Mission.Warhawk2TMP = luaFindHidden("Warhawk2")
	Mission.WildcatTMP = luaFindHidden("Wildcat1")
	Mission.ZeroTMP = luaFindHidden("Zero1")
	
	Mission.PT1TMP = luaFindHidden("Elco1")
	Mission.PT2TMP = luaFindHidden("Elco2")

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
			[9] =
			{
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jp_obj1",
				["Text"] = "ijn11.hint_loading_3", --Never leave your carrier without air cover. 
				--["Text"] = "mm01.obj_p1",
				--["TextCompleted"] = "The enemy Command Buildings have been captured",
				["TextCompleted"] = "",
				--["TextFailed"] = "Our Command Buildings have been captured",
				["TextFailed"] = "",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0,
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

	SetThink(this, "luaScene175Com_think")
end

function luaScene175Com_think(this, msg)
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
		luaGetTargets()
		luaCheckListeners()
		luaCheckMissionEnd()
		luaCAPListener()
		luaZuikakuBombers()
		luaCheckAdditionalSpawns()		
	elseif not Mission.Started then
		luaStartMission()
		luaAddZuikakuListener()
		luaUpdateCounters()
		luaGenerateWH1()
		luaGenerateWH2()
		luaGenerateF4F1()
		luaGenerateA6M1()
	end
end

function luaStartMission()
-- RELEASE_LOGOFF  	luaLog("  Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()			
	
	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	if Mission.LobbyCountDown ~= 0 then
		Countdown("mp.score_comp_time_left", 0, Mission.LobbyCountDown, "luaMissionEndTimeIsUp")
	end

	for i = 1, 8 do
		luaObj_Add("primary", i)
	end
	luaObj_Add("primary", 9)	
	DisplayUnitHP({Mission.Zuikaku}, "ingame.shipnames_zuikaku")
	Mission.Started = true
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Competitive03")
	-- mode description hint overlay
end

function luaMissionEndTimeIsUp()
	MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_time_up")
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
		RemoveListener("kill", "ZuikakuKill")
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
		luaObj_Completed("primary", 9)
		for i = 1, 8 do
			if i ~= objindex then
				luaObj_Failed("primary", i)
			end
		end
		local planes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
		Scoring_RealPlayTimeRunning(false)
		if Mission.Zuikaku.Dead then 
			luaMissionCompletedNew(Mission.Zuikaku, "", nil, nil, nil, PARTY_JAPANESE)
		elseif planes ~= nil then
			local movietarget = luaPickRnd(planes)
			luaMissionCompletedNew(movietarget, "", nil, nil, nil, PARTY_JAPANESE)
		else
			luaMissionCompletedNew(Mission.Zuikaku, "", nil, nil, nil, PARTY_JAPANESE)
		end
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

function luaAddZuikakuListener()
			AddListener("kill", "ZuikakuKill", {
					["callback"] = "luaZuikakuKill",
					["entity"] = {Mission.Zuikaku},
					["lastAttacker"] = {},
					["lastAttackerPlayerIndex"] = {},
				})
end

function luaZuikakuKill()
	Mission.MissionEndCalled = true
	Mission.MissionFailed = true
	HideUnitHP()

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
	Mission.PointLimitReached = true
	CountdownCancel()
	ForceMultiScoreSend()
	luaObj_Failed("primary", 9)
	luaDelay(luaMissionEnd, 0.1)	
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

function luaGetTargets(unittype, squadtype)
	local targetplanes = luaGetPlanesAroundCoordinate(GetPosition(Mission.Zuikaku), 8000, PARTY_ALLIED, "own")
	local targetships = luaGetShipsAroundCoordinate(GetPosition(Mission.Zuikaku), 5000, PARTY_ALLIED, "own")
	if targetplanes ~= nil then
		for index, unit in pairs (targetplanes) do
			if unit.Class.ID == 108 or unit.Class.ID == 112 or unit.Class.ID == 116 or unit.Class.ID == 118 then
				if not luaIsInside(unit, Mission.Targets) then
					table.insert(Mission.Targets, unit)
				end
			end
		end
	end
	
	if targetships ~= nil then
		for index, unit in pairs (targetships) do
			if unit.Class.ID == 35 or unit.Class.ID == 27 then
				if not luaIsInside(unit, Mission.Targets) then
					table.insert(Mission.Targets, unit)
				end
			end
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
		if table.getn(Mission.Targets) ~= 0 then
			local possibletargets = luaRemoveDeadsFromTable(Mission.Targets)
			if possibletargets ~= nil then
				Mission.RandomTarget = luaPickRnd(possibletargets)
				SetForcedReconLevel(Mission.RandomTarget, 2, PARTY_JAPANESE)
				MissionNarrativeParty(PARTY_JAPANESE, "mp01.nar_comp_bonus_kill")
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

function luaEventSpawnUSPlanes(plane1, plane2, count, coord) 
	  	local SpawnCoord = GetPosition(coord)	
			SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
				{
					["Type"] = plane1,
					["Name"] = "TBF Avenger",
					["Crew"] = 3,
					["Race"] = USA,
					["WingCount"] = count,
					["Equipment"] = 1,
				},
				{
					["Type"] = plane2,
					["Name"] = "B-17 Flying Fortress",
					["Crew"] = 3,
					["Race"] = USA,
					["WingCount"] = count,
					["Equipment"] = 2,
				},
			},
			["area"] = {
				["refPos"] = SpawnCoord,
				["angleRange"] = { DEG(-10),DEG(10)},
			},
			["callback"] = "luaEventSpawnUSPlanesCallback",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 150,
				["enemyHorizontal"] = 150,
				["ownVertical"] = 150,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			})
		
-- RELEASE_LOGOFF  			luaLog("Allied Force spawned")
		
end

function luaEventSpawnUSPlanesCallback(unit1, unit2)
	table.insert(Mission.USPlanes, unit1)
	table.insert(Mission.USPlanes, unit2)
		for idx, unit in pairs (Mission.USPlanes) do
			if not unit.Dead and not unit.assigned then
				SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
				PilotSetTarget(unit, Mission.Zuikaku)
				EntityTurnToEntity(unit, Mission.Zuikaku)
				SetForcedReconLevel(unit, 2, PARTY_JAPANESE)
				unit.assigned = true				
			end				
-- RELEASE_LOGOFF  			luaLog("spawn2 callback done")
		end	
end

function luaGenerateWH1()
	Mission.WH1 = GenerateObject(Mission.Warhawk1TMP.Name)	
	PilotMoveToRange(Mission.WH1, Mission.MainAirfield)
	SetRoleAvailable(Mission.WH1, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.WH1, 2)
	Mission.WH1.ignore = false
end

function luaGenerateWH2()
	Mission.WH2 = GenerateObject(Mission.Warhawk2TMP.Name)	
	PilotMoveToRange(Mission.WH2, Mission.SecondaryAirfield)
	SetRoleAvailable(Mission.WH2, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.WH2, 2)
	Mission.WH2.ignore = false
end

function luaGenerateF4F1()
	Mission.F4F1 = GenerateObject(Mission.WildcatTMP.Name)	
	PilotMoveToRange(Mission.F4F1, Mission.Lexington)
	SetRoleAvailable(Mission.F4F1, EROLF_ALL, PLAYER_AI)
	UnitSetFireStance(Mission.F4F1, 2)
	Mission.F4F1.ignore = false
end

function luaGenerateA6M1()
	Mission.A6M1 = GenerateObject(Mission.ZeroTMP.Name)	
	PutTo(Mission.A6M1, GetPosition(FindEntity("SpawnPoint Zuikaku")))
	
	PilotMoveToRange(Mission.A6M1, Mission.Zuikaku)
	SetRoleAvailable(Mission.A6M1, EROLF_ALL, PLAYER_AI)
	SquadronSetTravelAlt(Mission.A6M1, 1000)
	Mission.A6M1.ignore = false
end

function luaCAPListener()
	if not Mission.MainAirfield.Dead then
		if Mission.WH1.Dead and not Mission.WH1.ignore then
			Mission.WH1.ignore = true
			luaDelay(luaGenerateWH1, 20)
		end
	end

	if not Mission.SecondaryAirfield.Dead then	
		if Mission.WH2.Dead and not Mission.WH2.ignore then
			Mission.WH2.ignore = true
			if Mission.MainAirfield.Dead then
				luaDelay(luaGenerateWH2, 10)
			else
				luaDelay(luaGenerateWH2, 20)
			end	
		end
	end

	if not Mission.Lexington.Dead then	
		if Mission.F4F1.Dead and not Mission.F4F1.ignore then
			Mission.F4F1.ignore = true
			luaDelay(luaGenerateF4F1, 20)
		end	
	end	
	
	if not Mission.Zuikaku.Dead then	
		if Mission.A6M1.Dead and not Mission.A6M1.ignore then
			Mission.A6M1.ignore = true
			luaDelay(luaGenerateA6M1, 20)
		end
		
		if not Mission.A6M1.Dead then
			local planes = luaGetPlanesAroundCoordinate(GetPosition(Mission.Zuikaku), 5000, PARTY_ALLIED, "own")
			if planes ~= nil then
				local newTarget = luaSortByDistance(Mission.Zuikaku, planes, true)
				PilotSetTarget(Mission.A6M1, newTarget)
			else
				PilotMoveToRange(Mission.A6M1, Mission.Zuikaku)
			end
		end
	end
end

function luaJapAttack()
	if luaZuikakuTarget() == 2 or luaZuikakuTarget() == 3 then
		luaEventSpawnJPPlanes(158, 158)
	elseif luaZuikakuTarget() == 1 then
		luaEventSpawnJPPlanes(158, 162)
	end
end

function luaEventSpawnJPPlanes(plane1, plane2) 
	  	local SpawnCoord = GetPosition(Mission.ZuikakuLook)	
			SpawnNew({
			["party"] = PARTY_JAPANESE,
			["groupMembers"] = {
				{
					["Type"] = plane1,
					["Name"] = "TBF Avenger",
					["Crew"] = 3,
					["Race"] = Japan,
					["WingCount"] = 5,
					["Equipment"] = 1,
				},
				{
					["Type"] = plane2,
					["Name"] = "B-17 Flying Fortress",
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
			["callback"] = "luaEventSpawnJPPlanesCallback",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 150,
				["enemyHorizontal"] = 150,
				["ownVertical"] = 150,
				["enemyVertical"] = 150,
				["formationHorizontal"] = 100,
			},
			})
		
-- RELEASE_LOGOFF  			luaLog("Allied Force spawned")
		
end

function luaEventSpawnJPPlanesCallback(unit1, unit2)
	table.insert(Mission.JPPlanes, unit1)
	table.insert(Mission.JPPlanes, unit2)
	local i = luaZuikakuTarget()
		for idx, unit in pairs (Mission.JPPlanes) do
			if not unit.Dead and not unit.assigned then
				SetRoleAvailable(unit, EROLF_ALL, PLAYER_AI)
				PilotSetTarget(unit, Mission.ZuikakuTargets[i])
				EntityTurnToEntity(unit, Mission.ZuikakuTargets[i])	
				unit.assigned = false				
			end				
-- RELEASE_LOGOFF  			luaLog("spawn2 callback done")
		end	
end

function luaEventSpawnElcos() 
	if not Mission.Shipyard1.Dead then
		Mission.PT1 = GenerateObject(Mission.PT1TMP.Name)
		NavigatorSetAvoidLandCollision(Mission.PT1, false)
		NavigatorMoveToRange(Mission.PT1, Mission.Zuikaku)
		TorpedoEnable(Mission.PT1, true)
		--SetForcedReconLevel(Mission.PT1, 2, PARTY_JAPANESE)
		NavigatorAttackMove(Mission.PT1, Mission.Zuikaku, {})
	end

	if not Mission.Shipyard2.Dead then
		Mission.PT2 = GenerateObject(Mission.PT2TMP.Name)
		NavigatorSetAvoidLandCollision(Mission.PT2, false)
		NavigatorMoveToRange(Mission.PT2, Mission.Zuikaku)
		TorpedoEnable(Mission.PT2, true)
		--SetForcedReconLevel(Mission.PT2, 2, PARTY_JAPANESE)
		NavigatorAttackMove(Mission.PT2, Mission.Zuikaku, {})
	end
end

function luaZuikakuTarget()
	local number = 0
		if not Mission.ZuikakuTargets[1].Dead then
			number = 1
		elseif not Mission.ZuikakuTargets[2].Dead then
			number = 2
		elseif not Mission.ZuikakuTargets[3].Dead then
			number = 3
		elseif not Mission.ZuikakuTargets[4].Dead then
			number = 4
		elseif not Mission.ZuikakuTargets[5].Dead then
			number = 5
		else
			luaDelay(luaMissionEnd, 2)
		end
	return number
end

function luaZuikakuBombers()
	local bombers = luaRemoveDeadsFromTable(Mission.JPPlanes)
	local i = luaZuikakuTarget()
	if bombers ~= nil then
		for idx, unit in pairs (bombers) do
			if unit.Class.ID == 162 and i ~= 1 then
				PilotLand(unit, Mission.Zuikaku)
			else
				if table.getn(GetPayloads(unit)) == 0 then
					PilotLand(unit, Mission.Zuikaku)
				else
					PilotSetTarget(unit, Mission.ZuikakuTargets[i])
				end
			end
		end
	end
end

function luaCheckAdditionalSpawns()
	Mission.PlanesTime = Mission.PlanesTime + 1
	if Mission.PlanesTime >= 60 then
		if not Mission.SecondaryAirfield.Dead then
			luaEventSpawnUSPlanes(108, 118, Mission.SquadCount, Mission.SecondaryAirfieldSpawnpoint)
		end
		if not Mission.MainAirfield.Dead then
			luaEventSpawnUSPlanes(112, 116, Mission.SquadCount, Mission.MainAirfieldSpawnpoint)
		end
		if not Mission.Lexington.Dead then
			luaEventSpawnUSPlanes(108, 112, Mission.SquadCount, Mission.LexingtonSpawnpoint)
		end
		if not Mission.Zuikaku.Dead then
			luaJapAttack()
		end
		Mission.PlanesTime = 0
	end		

	Mission.ElcoTime = Mission.ElcoTime + 1
	if Mission.ElcoTime >= 45 then
		luaEventSpawnElcos()
		Mission.ElcoTime = 0
	end
end
