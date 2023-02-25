-------------------------------------------------------------------
---				INIT				---
-------------------------------------------------------------------
Inputs = nil
function luaPrecacheUnits()
--	PrepareClass(102) -- atmeneti hack a "rocket1", amig nem mukodik kodbol
--	PrepareClass(45) -- atmeneti hack a "rocket1", amig nem mukodik kodbol
--[[
PrepareClass() -- 
PrepareClass() -- 
PrepareClass() -- 
PrepareClass() -- 
--]]
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitIslandCapture906")
end

function luaInitIslandCapture906(this)
	Mission = this
	Mission.Name = "Ring of Fire"
-- logolasok
--	DamageLog = true
--	Mission.HelperLog = true
	Mission.CustomLog = true
	SETLOG(this, true)
-- RELEASE_LOGOFF  	Log("Initiating IslandCapture01")
	-- Loc-Kit dolgok
--	AddLockitPathToSelection(this.Name)
--	AddLockitPathToSelection("missionglobals")
--	AddLockitPathToSelection("mm01")
--	LoadSelectedPaths()
	Music_Control_SetLevel(MUSIC_TENSION)
	Mission.Multiplayer = true
	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})
	DoFile("scripts/datatables/Scoring.lua")
-- mission objectives

-- Lobby

-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")
		
	Mission.IC1v1 = false
	Mission.IC2v2 = false
	Mission.IC3v3 = false
	Mission.IC4v4 = false
	
	if LobbySettings.GameMode == "globals.gamemode_islandcapture" then
-- RELEASE_LOGOFF  		luaLog(LobbySettings.GameMode)
		if LobbySettings.MapSize == "FE.multi_small" then
-- RELEASE_LOGOFF  			luaLog("IC1v1 Objective")
			this.Objectives =
			{
				["primary"] =
				{
					[1] =
					{
						["Party"] = PARTY_ALLIED,
						["ID"] = "us_obj1",
						["Text"] = "mp.obj_ic_pri",				
						["TextCompleted"] = "mp.obj_ic_uswon",
						["TextFailed"] = "mp.obj_ic_jpwon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = 500,
						["ScoreFailed"] = 0,
					},
					[2] =
					{
						["Party"] = PARTY_JAPANESE,
						["ID"] = "jap_obj1",
						["Text"] = "mp.obj_ic_pri",
						["TextCompleted"] = "mp.obj_ic_jpwon",
						["TextFailed"] = "mp.obj_ic_uswon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = 500,
						["ScoreFailed"] = 0,
					},
				},
			}
-- RELEASE_LOGOFF  			luaLog("")
-- RELEASE_LOGOFF  			luaLog(LobbySettings.MapSize)
			Mission.IC1v1 = true
-- RELEASE_LOGOFF  			luaLog("IC1v1 flag is true")
-- RELEASE_LOGOFF  			luaLog("")
		elseif LobbySettings.MapSize == "FE.multi_medium" then
-- RELEASE_LOGOFF  			luaLog("IC2v2 Objective")
			this.Objectives =
			{
				["primary"] =
				{
					[1] =
					{
						["Party"] = PARTY_ALLIED,
						["ID"] = "us_obj1",
						["Text"] = "mp.obj_ic_pri",				
						["TextCompleted"] = "mp.obj_ic_uswon",
						["TextFailed"] = "mp.obj_ic_jpwon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = 1000,
						["ScoreFailed"] = 0,
					},
					[2] =
					{
						["Party"] = PARTY_JAPANESE,
						["ID"] = "jap_obj1",
						["Text"] = "mp.obj_ic_pri",
						["TextCompleted"] = "mp.obj_ic_jpwon",
						["TextFailed"] = "mp.obj_ic_uswon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = 1000,
						["ScoreFailed"] = 0,
					},
				},
			}
-- RELEASE_LOGOFF  			luaLog("")
-- RELEASE_LOGOFF  			luaLog(LobbySettings.MapSize)
			Mission.IC2v2 = true
-- RELEASE_LOGOFF  			luaLog("IC2v2 flag is true")
-- RELEASE_LOGOFF  			luaLog("")			
		elseif LobbySettings.MapSize == "FE.multi_large" then
-- RELEASE_LOGOFF  			luaLog("IC3v3 Objective")
			this.Objectives =
			{
				["primary"] =
				{
					[1] =
					{
						["Party"] = PARTY_ALLIED,
						["ID"] = "us_obj1",
						["Text"] = "mp.obj_ic_pri",				
						["TextCompleted"] = "mp.obj_ic_uswon",
						["TextFailed"] = "mp.obj_ic_jpwon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = 2500,
						["ScoreFailed"] = 0,
					},
					[2] =
					{
						["Party"] = PARTY_JAPANESE,
						["ID"] = "jap_obj1",
						["Text"] = "mp.obj_ic_pri",
						["TextCompleted"] = "mp.obj_ic_jpwon",
						["TextFailed"] = "mp.obj_ic_uswon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = 2500,
						["ScoreFailed"] = 0,
					},
				},
			}
-- RELEASE_LOGOFF  			luaLog("")
-- RELEASE_LOGOFF  			luaLog(LobbySettings.MapSize)
			Mission.IC3v3 = true
-- RELEASE_LOGOFF  			luaLog("IC3v3 flag is true")
-- RELEASE_LOGOFF  			luaLog("")
		elseif LobbySettings.MapSize == "FE.multi_huge" then
-- RELEASE_LOGOFF  			luaLog("IC4v4 Objective")
			this.Objectives =
			{
				["primary"] =
				{
					[1] =
					{
						["Party"] = PARTY_ALLIED,
						["ID"] = "us_obj1",
						["Text"] = "mp.obj_ic_pri",				
						["TextCompleted"] = "mp.obj_ic_uswon",
						["TextFailed"] = "mp.obj_ic_jpwon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = 5000,
						["ScoreFailed"] = 0,
					},
					[2] =
					{
						["Party"] = PARTY_JAPANESE,
						["ID"] = "jap_obj1",
						["Text"] = "mp.obj_ic_pri",
						["TextCompleted"] = "mp.obj_ic_jpwon",
						["TextFailed"] = "mp.obj_ic_uswon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = 5000,
						["ScoreFailed"] = 0,
					},
				},
			}
-- RELEASE_LOGOFF  			luaLog("")
-- RELEASE_LOGOFF  			luaLog(LobbySettings.MapSize)
			Mission.IC4v4 = true
-- RELEASE_LOGOFF  			luaLog("IC4v4 flag is true")
-- RELEASE_LOGOFF  			luaLog("")
		end
	end
	
	if LobbySettings.TimeLimit_IC == "globals.none" then
		--luaLog("Setting Mission TimeLimit: "..tostring(Mission.TimeLimit))
	elseif LobbySettings.TimeLimit_IC == "globals.30m" then
		Mission.TimeLimit = 30 * 60
-- RELEASE_LOGOFF  		luaLog("Setting Mission TimeLimit: "..tostring(Mission.TimeLimit))
	elseif LobbySettings.TimeLimit_IC == "globals.1h" then
		Mission.TimeLimit = 60 * 60		
-- RELEASE_LOGOFF  		luaLog("Setting Mission TimeLimit: "..tostring(Mission.TimeLimit))
	elseif LobbySettings.TimeLimit_IC == "globals.2h" then
		Mission.TimeLimit = 120 * 60		
-- RELEASE_LOGOFF  		luaLog("Setting Mission TimeLimit:"..tostring(Mission.TimeLimit))
	elseif LobbySettings.TimeLimit_IC == "globals.4h" then
		Mission.TimeLimit = 240 * 60		
-- RELEASE_LOGOFF  		luaLog("Setting Mission TimeLimit"..tostring(Mission.TimeLimit))
	end		
	
	if LobbySettings.PointLimit == "globals.none" then
-- RELEASE_LOGOFF  		luaLog(LobbySettings.PointLimit)
		Mission.CapturePointLimit = 0
-- RELEASE_LOGOFF  		luaLog("Setting Mission CapturePointLimit"..tostring(Mission.CapturePointLimit))
	elseif LobbySettings.PointLimit == "500" then
-- RELEASE_LOGOFF  		luaLog(LobbySettings.PointLimit)
		Mission.CapturePointLimit = 500
-- RELEASE_LOGOFF  		luaLog("Setting Mission CapturePointLimit"..tostring(Mission.CapturePointLimit))	
	elseif LobbySettings.PointLimit == "1000" then
-- RELEASE_LOGOFF  		luaLog(LobbySettings.PointLimit)
		Mission.CapturePointLimit = 1000
-- RELEASE_LOGOFF  		luaLog("Setting Mission CapturePointLimit"..tostring(Mission.CapturePointLimit))
	elseif LobbySettings.PointLimit == "2000" then		
-- RELEASE_LOGOFF  		luaLog(LobbySettings.PointLimit)
		Mission.CapturePointLimit = 2000
-- RELEASE_LOGOFF  		luaLog("Setting Mission CapturePointLimit"..tostring(Mission.CapturePointLimit))
	elseif LobbySettings.PointLimit == "3000" then		
-- RELEASE_LOGOFF  		luaLog(LobbySettings.PointLimit)
		Mission.CapturePointLimit = 3000
-- RELEASE_LOGOFF  		luaLog("Setting Mission CapturePointLimit"..tostring(Mission.CapturePointLimit))
	elseif LobbySettings.PointLimit == "4000" then		
-- RELEASE_LOGOFF  		luaLog(LobbySettings.PointLimit)
		Mission.CapturePointLimit = 4000
-- RELEASE_LOGOFF  		luaLog("Setting Mission CapturePointLimit"..tostring(Mission.CapturePointLimit))
	elseif LobbySettings.PointLimit == "5000" then		
-- RELEASE_LOGOFF  		luaLog(LobbySettings.PointLimit)
		Mission.CapturePointLimit = 5000
-- RELEASE_LOGOFF  		luaLog("Setting Mission CapturePointLimit"..tostring(Mission.CapturePointLimit))
	end
				
	Mission.AlliedCapturePoints = 0000
	Mission.JapaneseCapturePoints = 0000
	Mission.AlliedCBCounter = 0000
	Mission.JapaneseCBCounter = 0000
	Mission.TimeLimitReached = false
	Mission.MissionInit = true
	Mission.MissionEnd = false
	Mission.MissionTime = 0				-- mennyi ido telt el a jatekidobol
	Mission.StepCounter = 0
	Mission.CaptureCounters = false
	Mission.MissionStart = true
	Mission.HintDisplayed = false
-- Mission units
	
	
	if Mission.IC3v3 == true then
-- RELEASE_LOGOFF  		luaLog("Initiating Island Capture Mode 3v3")

	Mission.Yorktown = FindEntity("Yorktown")
	Mission.Essex = FindEntity("Essex")
	Mission.Lexington = FindEntity("Lexington")
	Mission.Kaga = FindEntity("Kaga")
	Mission.Zuikaku = FindEntity("Zuikaku")
	Mission.Hiryu = FindEntity("Hiryu")
		
	Mission.Shipyards = {}
		table.insert(Mission.Shipyards, FindEntity("SY_01"))
		table.insert(Mission.Shipyards, FindEntity("SY_02"))
		table.insert(Mission.Shipyards, FindEntity("SY_04"))
		table.insert(Mission.Shipyards, FindEntity("SY_06"))
		table.insert(Mission.Shipyards, FindEntity("SY_07"))
		table.insert(Mission.Shipyards, FindEntity("SY_09"))
		table.insert(Mission.Shipyards, FindEntity("SY_11"))
		table.insert(Mission.Shipyards, FindEntity("SY_12"))

		
	Mission.CommandPosts = {}	
		for i = 1, 8 do
			local cp
				cp = FindEntity("SB 0"..tostring(i))
				SetGuiName(cp, "globals.unitclass_commandpost|".." - |0"..tostring(i))
				cp.CaptureWeight = 0.5
				cp.StrategicGain = 1
			table.insert(Mission.CommandPosts, cp)
		end		

		Mission.CommandBuildings = {}
		for i = 1, 12 do
			local hq
			if i < 10 then
				hq = FindEntity("HQ 0"..tostring(i))
				SetGuiName(hq, "globals.unitclass_headquarter|".." - |0"..tostring(i))
				hq.CaptureWeight = 3
				hq.StrategicGain = 4
			else
				hq = FindEntity("HQ "..tostring(i))
				SetGuiName(hq, "globals.unitclass_headquarter|".." - |"..tostring(i))
				hq.CaptureWeight = 3
				hq.StrategicGain = 4				
			end
			table.insert(Mission.CommandBuildings, hq)
		end

		Mission.USCB = {}
			table.insert(Mission.USCB, Mission.CommandBuildings[1])
			table.insert(Mission.USCB, Mission.CommandBuildings[2])
			table.insert(Mission.USCB, Mission.Yorktown)
			table.insert(Mission.USCB, Mission.Essex)
			table.insert(Mission.USCB, Mission.Lexington)
		Mission.JPCB = {}
			table.insert(Mission.JPCB, Mission.CommandBuildings[6])
			table.insert(Mission.JPCB, Mission.CommandBuildings[7])
			table.insert(Mission.JPCB, Mission.Kaga)
			table.insert(Mission.JPCB, Mission.Zuikaku)
			table.insert(Mission.JPCB, Mission.Hiryu)
		
	end	
	
	---- unit tablak es ertekek atmenetileg a scriptben
	Mission.USTable = {}
	Mission.JapTable = {}
	Mission.UnitValue = {}
	Mission.UnitValue.BattleShip = 24
	Mission.UnitValue.Cruiser = 12
	Mission.UnitValue.Destroyer = 6
	Mission.UnitValue.MotherShip = 18
	Mission.UnitValue.TorpedoBoat = 2
	Mission.UnitValue.Submarine = 8
	Mission.UnitValue.LandingShip = 2
	Mission.UnitValue.Cargo = 2
	Mission.UnitValue.Fighter = 3
	Mission.UnitValue.DiveBomber = 3
	Mission.UnitValue.TorpedoBomber = 3
	Mission.UnitValue.LevelBomber = 6
	Mission.UnitValue.LargeReconPlane = 6
	Mission.UnitValue.SmallReconPlane = 3
	Mission.UnitValue.Kamikaze = 3

	Mission.CBMultiplier = 1.3
	----
	
	luaShipyardManagerInit(Mission.Shipyards)
	
	luaUnitRedistribution()
	
	AISetTargetWeight(100, 6, false, 0)
	AISetTargetWeight(100, 408, false, 0)
	AISetTargetWeight(100, 97, false, 0)
	AISetTargetWeight(100, 241, false, 0)
	AISetTargetWeight(100, 88, false, 0)

-- Players
	
-- korulmenyek beallitasa
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	SetThink(this, "luaIslandCapture909_think")	
	
	luaMultiVoiceOverHandler()

	Scoring_RealPlayTimeRunning(true)
end
-----------------------------------------------------------------------------------------
-------------------------				THINK				---------------------------------------------
-----------------------------------------------------------------------------------------
function luaIslandCapture909_think(this, msg)

	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	if Mission.MissionEnd then
		return
	end			
	
	if Mission.MissionStart then
-- RELEASE_LOGOFF  			luaLog("")
-- RELEASE_LOGOFF  			luaLog("!!!MissionStart!!!")
-- RELEASE_LOGOFF  			luaLog("")
		if LobbySettings.TimeLimit_IC == "globals.none" then
-- RELEASE_LOGOFF  			luaLog("Timelimit: none")
		else
			Countdown("mp.nar_timeleft", 0, Mission.TimeLimit, "luaSetTimeLimit")
-- RELEASE_LOGOFF  			luaLog("Timelimit: Countdown started")
		end
		Mission.MissionStart = false
	end
	
	Mission.StepCounter = Mission.StepCounter+1		
	
	Mission.AIBehaviourSet = false
	Mission.AIRushSet = false
	
	luaSetObjectives()
	luaCheckCBParty()
	luaCheckAlliedCB()
	luaCheckJapaneseCB()
	luaCheckTimelimit()
	luaCheckCapturePointlimit()
	luaCaptureCounters()
	luaCheckPlayerUnits()
	luaSetMissionHint()
	
	local selUnit = GetSelectedUnit()
	if selUnit then
		luaCheckMusic(selUnit)
	end
	
end
---------------------------------------------------------------------------------------------
------------------------------- Functions ---------------------------------------------------
---------------------------------------------------------------------------------------------
function luaCaptureCounters()
-- RELEASE_LOGOFF  	luaLog(" Updating counters...")
	if not Mission.CaptureCounters == true then
		Mission.CaptureCounters = true
-- RELEASE_LOGOFF  		luaLog(" Initializing counters...")
		MultiScore=	{
			[0]= {
				[1] = Mission.AlliedCapturePoints,
				[2] = Mission.CapturePointLimit,
				[3] = Mission.AlliedCBCounter,
				[4] = Mission.JapaneseCapturePoints,
				[5] = Mission.JapaneseCBCounter,
			},
			[1]= {
				[1] = Mission.AlliedCapturePoints,
				[2] = Mission.CapturePointLimit,
				[3] = Mission.AlliedCBCounter,
				[4] = Mission.JapaneseCapturePoints,
				[5] = Mission.JapaneseCBCounter,
			},
			[2]= {
				[1] = Mission.AlliedCapturePoints,
				[2] = Mission.CapturePointLimit,
				[3] = Mission.AlliedCBCounter,
				[4] = Mission.JapaneseCapturePoints,
				[5] = Mission.JapaneseCBCounter,
			},
			[3]= {
				[1] = Mission.AlliedCapturePoints,
				[2] = Mission.CapturePointLimit,
				[3] = Mission.AlliedCBCounter,
				[4] = Mission.JapaneseCapturePoints,
				[5] = Mission.JapaneseCBCounter,
			},
			[4]= {
				[1] = Mission.AlliedCapturePoints,
				[2] = Mission.CapturePointLimit,
				[3] = Mission.AlliedCBCounter,
				[4] = Mission.JapaneseCapturePoints,
				[5] = Mission.JapaneseCBCounter,
			},
			[5]= {
				[1] = Mission.AlliedCapturePoints,
				[2] = Mission.CapturePointLimit,
				[3] = Mission.AlliedCBCounter,
				[4] = Mission.JapaneseCapturePoints,
				[5] = Mission.JapaneseCBCounter,
			},
			[6]= {
				[1] = Mission.AlliedCapturePoints,
				[2] = Mission.CapturePointLimit,
				[3] = Mission.AlliedCBCounter,
				[4] = Mission.JapaneseCapturePoints,
				[5] = Mission.JapaneseCBCounter,
			},
			[7]= {
				[1] = Mission.AlliedCapturePoints,
				[2] = Mission.CapturePointLimit,
				[3] = Mission.AlliedCBCounter,
				[4] = Mission.JapaneseCapturePoints,
				[5] = Mission.JapaneseCBCounter,
			},
		}
				
		if LobbySettings.PointLimit == "globals.none" then			
			DisplayScores(1, 0, "mp.score_ic_points|".." #MultiScore.0.1#".." |mp.score_ic_bases|".." #MultiScore.0.3#", "mp.score_ic_points|".." #MultiScore.0.4#".." |mp.score_ic_bases|".." #MultiScore.0.5#",2,1)
			DisplayScores(1, 1, "mp.score_ic_points|".." #MultiScore.1.1#".." |mp.score_ic_bases|".." #MultiScore.1.3#", "mp.score_ic_points|".." #MultiScore.1.4#".." |mp.score_ic_bases|".." #MultiScore.1.5#",2,1)
			DisplayScores(1, 2, "mp.score_ic_points|".." #MultiScore.2.1#".." |mp.score_ic_bases|".." #MultiScore.2.3#", "mp.score_ic_points|".." #MultiScore.2.4#".." |mp.score_ic_bases|".." #MultiScore.2.5#",2,1)
			DisplayScores(1, 3, "mp.score_ic_points|".." #MultiScore.3.1#".." |mp.score_ic_bases|".." #MultiScore.3.3#", "mp.score_ic_points|".." #MultiScore.3.4#".." |mp.score_ic_bases|".." #MultiScore.3.5#",2,1)
			DisplayScores(1, 4, "mp.score_ic_points|".." #MultiScore.4.1#".." |mp.score_ic_bases|".." #MultiScore.4.3#", "mp.score_ic_points|".." #MultiScore.4.4#".." |mp.score_ic_bases|".." #MultiScore.4.5#",2,1)
			DisplayScores(1, 5, "mp.score_ic_points|".." #MultiScore.5.1#".." |mp.score_ic_bases|".." #MultiScore.5.3#", "mp.score_ic_points|".." #MultiScore.5.4#".." |mp.score_ic_bases|".." #MultiScore.5.5#",2,1)
			DisplayScores(1, 6, "mp.score_ic_points|".." #MultiScore.6.1#".." |mp.score_ic_bases|".." #MultiScore.6.3#", "mp.score_ic_points|".." #MultiScore.6.4#".." |mp.score_ic_bases|".." #MultiScore.6.5#",2,1)
			DisplayScores(1, 7, "mp.score_ic_points|".." #MultiScore.7.1#".." |mp.score_ic_bases|".." #MultiScore.7.3#", "mp.score_ic_points|".." #MultiScore.7.4#".." |mp.score_ic_bases|".." #MultiScore.7.5#",2,1)
		else
			DisplayScores(1, 0, "mp.score_ic_points|".." #MultiScore.0.1# / #MultiScore.0.2#".." |mp.score_ic_bases|".." #MultiScore.0.3#", "mp.score_ic_points|".." #MultiScore.0.4# / #MultiScore.0.2#".." |mp.score_ic_bases|".." #MultiScore.0.5#",2,1)
			DisplayScores(1, 1, "mp.score_ic_points|".." #MultiScore.1.1# / #MultiScore.1.2#".." |mp.score_ic_bases|".." #MultiScore.1.3#", "mp.score_ic_points|".." #MultiScore.1.4# / #MultiScore.1.2#".." |mp.score_ic_bases|".." #MultiScore.1.5#",2,1)
			DisplayScores(1, 2, "mp.score_ic_points|".." #MultiScore.2.1# / #MultiScore.2.2#".." |mp.score_ic_bases|".." #MultiScore.2.3#", "mp.score_ic_points|".." #MultiScore.2.4# / #MultiScore.2.2#".." |mp.score_ic_bases|".." #MultiScore.2.5#",2,1)
			DisplayScores(1, 3, "mp.score_ic_points|".." #MultiScore.3.1# / #MultiScore.3.2#".." |mp.score_ic_bases|".." #MultiScore.3.3#", "mp.score_ic_points|".." #MultiScore.3.4# / #MultiScore.3.2#".." |mp.score_ic_bases|".." #MultiScore.3.5#",2,1)
			DisplayScores(1, 4, "mp.score_ic_points|".." #MultiScore.4.1# / #MultiScore.4.2#".." |mp.score_ic_bases|".." #MultiScore.4.3#", "mp.score_ic_points|".." #MultiScore.4.4# / #MultiScore.4.2#".." |mp.score_ic_bases|".." #MultiScore.4.5#",2,1)
			DisplayScores(1, 5, "mp.score_ic_points|".." #MultiScore.5.1# / #MultiScore.5.2#".." |mp.score_ic_bases|".." #MultiScore.5.3#", "mp.score_ic_points|".." #MultiScore.5.4# / #MultiScore.5.2#".." |mp.score_ic_bases|".." #MultiScore.5.5#",2,1)
			DisplayScores(1, 6, "mp.score_ic_points|".." #MultiScore.6.1# / #MultiScore.6.2#".." |mp.score_ic_bases|".." #MultiScore.6.3#", "mp.score_ic_points|".." #MultiScore.6.4# / #MultiScore.6.2#".." |mp.score_ic_bases|".." #MultiScore.6.5#",2,1)
			DisplayScores(1, 7, "mp.score_ic_points|".." #MultiScore.7.1# / #MultiScore.7.2#".." |mp.score_ic_bases|".." #MultiScore.7.3#", "mp.score_ic_points|".." #MultiScore.7.4# / #MultiScore.7.2#".." |mp.score_ic_bases|".." #MultiScore.7.5#",2,1)
		end
	end
	
	if table.getn(MultiScore) ~= 0 then
		for i = 0, 3 do
			MultiScore[i][1] = Mission.AlliedCapturePoints
			MultiScore[i][2] = Mission.CapturePointLimit
			MultiScore[i][3] = Mission.AlliedCBCounter
			MultiScore[i][4] = Mission.JapaneseCapturePoints
			MultiScore[i][5] = Mission.JapaneseCBCounter
		end
		
		for i = 4, 7 do
			MultiScore[i][1] = Mission.AlliedCapturePoints
			MultiScore[i][2] = Mission.CapturePointLimit
			MultiScore[i][3] = Mission.AlliedCBCounter
			MultiScore[i][4] = Mission.JapaneseCapturePoints
			MultiScore[i][5] = Mission.JapaneseCBCounter
		end
	end	
end

function luaCheckCapturePointlimit()
-- MissionEnd1
	--if Mission.CapturePointLimit == 0 and Mission.TimeLimit == 0 then
	if Mission.CapturePointLimit == 0 then
-- RELEASE_LOGOFF  		luaLog("CapturePointLimit 0, adjusting victory points...")
		luaGiveCapturePoints()
	elseif not Mission.TimeLimitReached then
		luaGiveCapturePoints()
		if Mission.CapturePointLimit <= Mission.AlliedCapturePoints or Mission.CapturePointLimit <= Mission.JapaneseCapturePoints then
			if Mission.AlliedCapturePoints == Mission.JapaneseCapturePoints then
				luaGiveCapturePoints()
				elseif Mission.AlliedCapturePoints > Mission.JapaneseCapturePoints then
					if not Mission.MissionEnd then
						-- allied wins
						--todo mas kamera dobas, otletek!!!
						luaMissionCompletedNew(Mission.CommandBuildings[3], "", nil, nil, nil, PARTY_ALLIED)
						Scoring_RealPlayTimeRunning(false)
						luaObj_Completed("primary", 1)
						luaObj_Failed("primary", 2)
						Mission.MissionEnd = true
					end
				elseif Mission.JapaneseCapturePoints > Mission.AlliedCapturePoints then
					if not Mission.MissionEnd then
						-- japanese wins
						--todo mas kamera dobas, otletek!!!
						luaMissionCompletedNew(Mission.CommandBuildings[1], "", nil, nil, nil, PARTY_JAPANESE)
						Scoring_RealPlayTimeRunning(false)
						luaObj_Completed("primary", 2)
						luaObj_Failed("primary", 1)
						Mission.MissionEnd = true
					end
				end
			end
	end
end

function luaGiveCapturePoints()	
	if not Mission.MissionEnd then
		local USCB = 0
		local JapCB = 0
		for idx, unit in pairs(Mission.CommandBuildings) do
			if unit.Party == PARTY_ALLIED then
				if USCB == 0 then
					USCB = 1
				else
					USCB = (USCB + 1)
				end
			elseif unit.Party == PARTY_JAPANESE then
				if JapCB == 0 then
					JapCB = 1
				else
					JapCB = (JapCB + 1)
				end
			end
		end
		
		for idx, unit in pairs(Mission.CommandPosts) do
			if unit.Party == PARTY_ALLIED then
				if USCB == 0 then
					USCB = 1
				else
					USCB = (USCB + 1)
				end
			elseif unit.Party == PARTY_JAPANESE then
				if JapCB == 0 then
					JapCB = 1
				else
					JapCB = (JapCB + 1)
				end
			end
		end
		
		USCB = USCB * Mission.CBMultiplier
		JapCB = JapCB * Mission.CBMultiplier
		
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + luaRound(USCB)
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + luaRound(JapCB)
	end
end

function luaSetTimeLimit()
	Mission.TimeLimit = 0
	luaCaptureCounters()
end

function luaCheckTimelimit()
-- RELEASE_LOGOFF  		luaLog("Checking Timelimit")
		if Mission.TimeLimit == 0	then
-- RELEASE_LOGOFF  			luaLog("...")
-- RELEASE_LOGOFF  			luaLog("!!!!!!! STARTING MISSION END v2!!!!!!")
-- RELEASE_LOGOFF  			luaLog("...")
			luaMissionEnd2()
		end
end

function luaMissionEnd2()
	Mission.TimeLimitReached = true	
-- todo camera meghivas objectiva completere allitas stb
	if Mission.AlliedCapturePoints == Mission.JapaneseCapturePoints then
-- RELEASE_LOGOFF  		luaLog("Checking until is not equal")
		luaGiveCapturePoints()		
	elseif Mission.AlliedCapturePoints > Mission.JapaneseCapturePoints then
		if not Mission.MissionEnd then
			-- allied wins
			--todo mas kamera dobas
			luaMissionCompletedNew(Mission.CommandBuildings[3], "", nil, nil, nil, PARTY_ALLIED)
			Scoring_RealPlayTimeRunning(false)
			luaObj_Completed("primary", 1)
			luaObj_Failed("primary", 2)
-- RELEASE_LOGOFF  			luaLog("!!!!!!!MISSION END v2!!!!!!")
			Mission.MissionEnd = true
		end
	elseif Mission.AlliedCapturePoints < Mission.JapaneseCapturePoints then
		if not Mission.MissionEnd then
			-- japanese wins
			--todo mas kamera dobas
			luaMissionCompletedNew(Mission.CommandBuildings[1], "", nil, nil, nil, PARTY_JAPANESE)
			Scoring_RealPlayTimeRunning(false)
			luaObj_Completed("primary", 2)
			luaObj_Failed("primary", 1)
-- RELEASE_LOGOFF  			luaLog("!!!!!!!MISSION END v2!!!!!!")
			Mission.MissionEnd = true
		end
	end
end

function luaSetObjectives()	
	if Mission.IC3v3 == true then
		if Mission.MissionInit then

		-- allied objs
		luaObj_Add("primary", 1, {Mission.Yorktown, Mission.Essex, Mission.Lexington, Mission.Kaga, Mission.Zuikaku, Mission.Hiryu, Mission.CommandBuildings[1], Mission.CommandBuildings[2], Mission.CommandBuildings[3], Mission.CommandBuildings[4], Mission.CommandBuildings[5], Mission.CommandBuildings[6], Mission.CommandBuildings[7], Mission.CommandBuildings[8], Mission.CommandBuildings[9], Mission.CommandBuildings[10], Mission.CommandBuildings[11], Mission.CommandBuildings[12]})
		-- japanese objs
		luaObj_Add("primary", 2, {Mission.Yorktown, Mission.Essex, Mission.Lexington, Mission.Kaga, Mission.Zuikaku, Mission.Hiryu, Mission.CommandBuildings[1], Mission.CommandBuildings[2], Mission.CommandBuildings[3], Mission.CommandBuildings[4], Mission.CommandBuildings[5], Mission.CommandBuildings[6], Mission.CommandBuildings[7], Mission.CommandBuildings[8], Mission.CommandBuildings[9], Mission.CommandBuildings[10], Mission.CommandBuildings[11], Mission.CommandBuildings[12]})
		Mission.MissionInit = false
		end	
	end
end

function luaCheckCBParty()
	local counterA = 0
	for idx,unit in pairs(Mission.CommandBuildings) do
		if unit.Party == PARTY_ALLIED then
			counterA = counterA + 1
		end
	end
	if counterA == 0 then
		---todo unit counter time counter
		luaMissionCompletedNew(Mission.CommandBuildings[1], "", nil, nil, nil, PARTY_JAPANESE)
		Scoring_RealPlayTimeRunning(false)
-- RELEASE_LOGOFF  		luaLog("luaMissionCompleted: ")
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		Mission.MissionEnd = true
	end
	local counterJ = 0
	for idx,unit in pairs(Mission.CommandBuildings) do
		if unit.Party == PARTY_JAPANESE then
			counterJ = counterJ + 1
		end
	end
	if counterJ == 0 then
		---todo unit counter time counter
-- RELEASE_LOGOFF  		luaLog("Japanese CB-s are captured")
		-- allied wins
		luaMissionCompletedNew(Mission.CommandBuildings[3], "", nil, nil, nil, PARTY_ALLIED)
		Scoring_RealPlayTimeRunning(false)
-- RELEASE_LOGOFF  		luaLog("luaMissionCompleted: ")
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		Mission.MissionEnd = true
	end
end

function luaCheckAlliedCB()
	Mission.AlliedCBCounter = 0
	for idx,unit in pairs(Mission.CommandBuildings) do	
		if unit.Party == PARTY_ALLIED then
			Mission.AlliedCBCounter = Mission.AlliedCBCounter + 1
		end
	end
	for idx,unit in pairs(Mission.CommandPosts) do
		if unit.Party == PARTY_ALLIED then
			Mission.AlliedCBCounter = Mission.AlliedCBCounter + 1
		end
	end
end

function luaCheckJapaneseCB()
	Mission.JapaneseCBCounter = 0
	for idx,unit in pairs(Mission.CommandBuildings) do	
		if unit.Party == PARTY_JAPANESE then
			Mission.JapaneseCBCounter = Mission.JapaneseCBCounter + 1
		end
	end
	for idx,unit in pairs(Mission.CommandPosts) do
		if unit.Party == PARTY_JAPANESE then
			Mission.JapaneseCBCounter = Mission.JapaneseCBCounter + 1
		end
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_IslandCapture01")
	-- mode description hint overlay
end


function luaCheckPlayerUnits()
-- RELEASE_LOGOFF  	luaLog(" Checking players units...")
	if table.getn(Mission.USTable) ~= 0 then
		for index, unit in pairs (Mission.USTable) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead "..tostring(unit.Class.Type).." found in Mission.USTable")
				luaManageDeadUnit(unit.Class.Type, unit.Party)
				table.remove(Mission.USTable, index)
			end
		end
	end

	if table.getn(Mission.JapTable) ~= 0 then
		for index, unit in pairs (Mission.JapTable) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead "..tostring(unit.Class.Type).." found in Mission.JapTable")
				luaManageDeadUnit(unit.Class.Type, unit.Party)
				table.remove(Mission.JapTable, index)
			end
		end
	end

	local usships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	local japships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
	local japplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
	local usplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	if usships ~= nil then
		for index, unit in pairs (usships) do
			if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  				luaLog("  new US "..tostring(unit.Class.Type).." found, inserting it to Mission.USTable")
				table.insert(Mission.USTable, unit)
			end
		end
	end
	if japships ~= nil then
		for index, unit in pairs (japships) do
			if not luaIsInside(unit, Mission.JapTable) then
-- RELEASE_LOGOFF  				luaLog("  new Japanese "..tostring(unit.Class.Type).." found, inserting it to Mission.JapTable")
				table.insert(Mission.JapTable, unit)
			end
		end
	end
	if usplanes ~= nil then
		for index, unit in pairs (usplanes) do
			if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  				luaLog("  new US "..tostring(unit.Class.Type).." found, inserting it to Mission.USTable")
				table.insert(Mission.USTable, unit)
			end
		end
	end
	if japplanes ~= nil then
		for index, unit in pairs (japplanes) do
			if not luaIsInside(unit, Mission.JapTable) then
-- RELEASE_LOGOFF  				luaLog("  new Japanese "..tostring(unit.Class.Type).." found, inserting it to Mission.JapTable")
				table.insert(Mission.JapTable, unit)
			end
		end
	end
end

function luaManageDeadUnit(unitType, unitParty)
	if unitType == "BattleShip" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.BattleShip
	elseif unitType == "BattleShip" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.BattleShip
	elseif unitType == "Cruiser" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.Cruiser
	elseif unitType == "Cruiser" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.Cruiser
	elseif unitType == "Destroyer" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.Destroyer
	elseif unitType == "Destroyer" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.Destroyer
	elseif unitType == "MotherShip" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.MotherShip
	elseif unitType == "MotherShip" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.MotherShip
	elseif unitType == "TorpedoBoat" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.TorpedoBoat
	elseif unitType == "TorpedoBoat" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.TorpedoBoat
	elseif unitType == "Submarine" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.Submarine
	elseif unitType == "Submarine" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.Submarine
	elseif unitType == "LandingShip" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.LandingShip
	elseif unitType == "LandingShip" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.LandingShip
	elseif unitType == "Cargo" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.Cargo
	elseif unitType == "Cargo" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.Cargo
	elseif unitType == "Fighter" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.Fighter
	elseif unitType == "Fighter" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.Fighter
	elseif unitType == "DiveBomber" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.DiveBomber
	elseif unitType == "DiveBomber" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.DiveBomber
	elseif unitType == "TorpedoBomber" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.TorpedoBomber
	elseif unitType == "TorpedoBomber" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.TorpedoBomber
	elseif unitType == "LevelBomber" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.LevelBomber
	elseif unitType == "LevelBomber" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.LevelBomber
	elseif unitType == "LargeReconPlane" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.LargeReconPlane
	elseif unitType == "LargeReconPlane" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.LargeReconPlane
	elseif unitType == "SmallReconPlane" and unitParty == PARTY_ALLIED then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.SmallReconPlane
	elseif unitType == "SmallReconPlane" and unitParty == PARTY_JAPANESE then
		Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + Mission.UnitValue.SmallReconPlane
	elseif unitType == "Kamikaze" and unitParty == PARTY_JAPANESE then
		Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + Mission.UnitValue.Kamikaze
	end
end

function luaSkirmishAI()
	--todo
	Mission.AIParty = luaGetICSkirmishAIParty()	
	if not Mission.AIBehaviourSet then
		Mission.AIBehaviourSet = true
		Mission.AIBehaviour = luaRnd (1,3)
	end	
	if Mission.AIBehaviour == 1 then
		luaSkirmishAINormal()
	elseif Mission.AIBehaviour == 2 then
		luaSkirmishAIOffensive()
	elseif Mission.AIBehaviour == 3 then
		luaSkirmishAIDefensive()
	end	
end

function luaSkirmishAINormal()
	--TODO Normal skirmish AI
	if not Mission.AIRushSet then
		Mission.AIRushSet = true		
		local AIRush = luaRnd (1,6)	
		if AIRush == 1 then
			luaSkirmishAIRush()
		end
	else
		for idx,unit in pairs(Mission.CommandBuildings) do
			unit.CaptureWeight = 2
			unit.StrategicGain = 3
		end		
		MissionAISetDefendResourcePercent(0.3)		
	end
end

function luaSkirmishAIOffensive()
--TODO Tamado jellegu skirmish AI	
	if not Mission.AIRushSet then
		Mission.AIRushSet = true		
		local AIRush = luaRnd (1,2)	
		if AIRush == 1 then
			luaSkirmishAIRush()
		end
	end
	for idx,unit in pairs(Mission.CommandBuildings) do
		unit.CaptureWeight = 3
		unit.StrategicGain = 5
	end
	AISetDefendResourcePercent(0.2)	
end

function luaSkirmishAIDefensive()
	--TODO Vedekezo jellegu skirmish AI
	if not Mission.AIRushSet then
		Mission.AIRushSet = true		
		local AIRush = luaRnd (1,9)	
		if AIRush == 1 then
			luaSkirmishAIRush()
		end
	end
	for idx,unit in pairs(Mission.CommandBuildings) do
		unit.CaptureWeight = 2
		unit.StrategicGain = 2
	end
	AISetDefendResourcePercent(0.5)	
end

function luaSkirmishAIRush()
-- RELEASE_LOGOFF  	luaLog("")
-- RELEASE_LOGOFF  	luaLog("Inbitialzing Rush Sequence")	
-- RELEASE_LOGOFF  	luaLog("")
	AISetDefendResourcePercent(0.0)
-- RELEASE_LOGOFF  	luaLog("")
-- RELEASE_LOGOFF  	luaLog("ChangeAI CB weights: ")	
-- RELEASE_LOGOFF  	luaLog("")
	
	Mission.UsCBs = {}
	Mission.JpCBs = {}
	
	local JpCBCount = 0
	local UsCBCount = 0
	
	Mission.FirstTarget = luaRnd(1,2)
	
	if Mission.FirstTarget == 1 then
		--todo range szamitast beleintegralni
		for idx,unit in pairs(Mission.CommandBuildings) do
			if unit.Party == PARTY_ALLIED then
				table.insert(Mission.UsCBs, unit)
			elseif unit.Party == PARTY_JAPANESE then
				table.insert(Mission.JpCBs, unit)
			end
		end
		if Mission.AIParty == PARTY_ALLIED then
			for idx,unit in pairs(Mission.JpCBs) do
				JpCBCount = JpCBCount + 1
-- RELEASE_LOGOFF  				luaLog("Jap CB count: "..tostring(JpCBCount))
			end
			local x = luaRnd(1, JpCBCount)
-- RELEASE_LOGOFF  			luaLog("Random CB number: "..tostring(x))
			Mission.JpCBs[x].CaptureWeight = 2
			Mission.JpCBs[x].StrategicGain = 10
		elseif Mission.AIParty == PARTY_JAPANESE then
			for idx,unit in pairs(Mission.UsCBs) do
				UsCBCount = UsCBCount + 1			
-- RELEASE_LOGOFF  				luaLog("Jap CB count: "..tostring(UsCBCount))
			end
			local x = luaRnd(1, UsCBCount)
-- RELEASE_LOGOFF  			luaLog("Random CB number: "..tostring(x))
			Mission.UsCBs[x].CaptureWeight = 2
			Mission.UsCBs[x].StrategicGain = 10
		end
	elseif Mission.FirstTarget == 2 then
		--todo palyafuggo besttarget???
	end
end

function luaSetMissionHint()
	if not Mission.HintDisplayed then
		Mission.HintDisplayed = true
		luaShowMissionHint()
	end
end