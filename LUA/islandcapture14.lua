-------------------------------------------------------------------
---				INIT				---
-------------------------------------------------------------------
Inputs = nil

function luaPrecacheUnits()

end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitIslandCapture14")
end

function luaInitIslandCapture14(this)
	Mission = this
	Mission.Name = "IslandCapture14"

	------
	--Log
	------
	--DamageLog = true
	--Mission.HelperLog = true
	Mission.CustomLog = true
	SETLOG(this, true)
-- RELEASE_LOGOFF  	Log("Initiating IslandCapture14")

	Music_Control_SetLevel(MUSIC_TENSION)
	Mission.Multiplayer = true
	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})
	DoFile("scripts/datatables/Scoring.lua")

	-----------
	---Lobby---
	-----------
-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")

	Mission.Players = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog(Mission.Players)

	Mission.IJNAI = false
	Mission.USNAI = false

	if Mission.Players[0] ~= nil then
		if Mission.Players[0]["ai"] == true then
			Mission.USNAI = true
-- RELEASE_LOGOFF  			luaLog("US is AI")
		end
	end

	if Mission.Players[4] ~= nil then
		if Mission.Players[4]["ai"] == true then
			Mission.IJNAI = true
-- RELEASE_LOGOFF  			luaLog("JP is AI")
		end
	end

	if LobbySettings.MapSize == "FE.multi_small" then
		Mission.IC1v1 = true
		Mission.IC2v2 = false
		Mission.IC3v3 = false
	elseif LobbySettings.MapSize == "FE.multi_medium" then
		Mission.IC1v1 = false
		Mission.IC2v2 = true
		Mission.IC3v3 = false
	elseif LobbySettings.MapSize == "FE.multi_large" then
		Mission.IC1v1 = false
		Mission.IC2v2 = false
		Mission.IC3v3 = true
	end

	Mission.ObjScores = {}
		Mission.ObjScores["FE.multi_small"] = 500
		Mission.ObjScores["FE.multi_medium"] = 1000
		Mission.ObjScores["FE.multi_large"] = 2500

	if LobbySettings.GameMode == "globals.gamemode_islandcapture" then
-- RELEASE_LOGOFF  		luaLog(LobbySettings.GameMode)
			this.Objectives =
			{
				["primary"] =
				{
					[1] =
					{
						["Party"] = PARTY_ALLIED,
						["ID"] = "us_obj1",
						["Text"] = "mp14.obj_ic_pri",
						["TextCompleted"] = "mp.obj_ic_uswon",
						["TextFailed"] = "mp.obj_ic_jpwon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = Mission.ObjScores[tostring(LobbySettings.MapSize)],
						["ScoreFailed"] = 0,
					},
					[2] =
					{
						["Party"] = PARTY_JAPANESE,
						["ID"] = "jap_obj1",
						["Text"] = "mp14.obj_ic_pri",
						["TextCompleted"] = "mp.obj_ic_jpwon",
						["TextFailed"] = "mp.obj_ic_uswon",
						["Active"] = false,
						["Success"] = nil,
						["Target"] = {},
						["ScoreCompleted"] = Mission.ObjScores[tostring(LobbySettings.MapSize)],
						["ScoreFailed"] = 0,
					},
				},
			}
	end

-- RELEASE_LOGOFF  	luaLog("----------------")
-- RELEASE_LOGOFF  	luaLog("Time Limit")
-- RELEASE_LOGOFF  	luaLog("----------------")
	if LobbySettings.TimeLimit_IC == "globals.none" then
-- RELEASE_LOGOFF  		luaLog("Setting Mission TimeLimit: no time limit")
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

-- RELEASE_LOGOFF  	luaLog("----------------")
-- RELEASE_LOGOFF  	luaLog("Point Limit")
-- RELEASE_LOGOFF  	luaLog("----------------")
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
	Mission.CaptureCounters = false
	Mission.MissionStart = true
	Mission.HintDisplayed = false


-- RELEASE_LOGOFF  	luaLog("----------------")
-- RELEASE_LOGOFF  	luaLog("Units init")
-- RELEASE_LOGOFF  	luaLog("----------------")

	if Mission.IC3v3 == true then
-- RELEASE_LOGOFF  		luaLog("Initiating Island Capture Mode 3v3")

		Mission.Shipyards = {}
			table.insert(Mission.Shipyards, FindEntity("CB2_SY"))
			table.insert(Mission.Shipyards, FindEntity("CB2_SY"))
			table.insert(Mission.Shipyards, FindEntity("CB3_SY"))
			table.insert(Mission.Shipyards, FindEntity("CB4_SY"))
			table.insert(Mission.Shipyards, FindEntity("CB5_SY"))
			table.insert(Mission.Shipyards, FindEntity("CB6_SY"))
			table.insert(Mission.Shipyards, FindEntity("CB7_SY"))
			table.insert(Mission.Shipyards, FindEntity("CB8_SY"))


		Mission.CB1 = FindEntity("CB1")
		SetGuiName(Mission.CB1, "globals.unitclass_headquarter|".." - |01")
		SetCommandBuildingOwnerPlayer(Mission.CB1, PLAYER_1)
		Mission.CB2 = FindEntity("CB2")
		SetGuiName(Mission.CB2, "globals.unitclass_headquarter|".." - |02")
		Mission.CB3 = FindEntity("CB3")
		SetGuiName(Mission.CB3, "globals.unitclass_headquarter|".." - |06")
		Mission.CB4 = FindEntity("CB4")
		SetGuiName(Mission.CB4, "globals.unitclass_headquarter|".." - |05")
		Mission.CB5 = FindEntity("CB5")
		SetGuiName(Mission.CB5, "globals.unitclass_headquarter|".." - |04")
		Mission.CB6 = FindEntity("CB6")
		SetGuiName(Mission.CB6, "globals.unitclass_headquarter|".." - |03")
		Mission.CB7 = FindEntity("CB7 - Large")
		SetGuiName(Mission.CB7, "globals.unitclass_headquarter|".." - |07")
		Mission.CB8 = FindEntity("CB8")
		SetGuiName(Mission.CB8, "globals.unitclass_headquarter|".." - |08")
		Mission.CB9 = FindEntity("CB9")
		SetGuiName(Mission.CB9, "globals.unitclass_headquarter|".." - |09")
		SetCommandBuildingOwnerPlayer(Mission.CB9, PLAYER_5)


		Mission.CommandBuildings = {}
			table.insert(Mission.CommandBuildings, FindEntity("CB1"))
			table.insert(Mission.CommandBuildings, FindEntity("CB2"))
			table.insert(Mission.CommandBuildings, FindEntity("CB3"))
			table.insert(Mission.CommandBuildings, FindEntity("CB4"))
			table.insert(Mission.CommandBuildings, FindEntity("CB5"))
			table.insert(Mission.CommandBuildings, FindEntity("CB6"))
			table.insert(Mission.CommandBuildings, FindEntity("CB7 - Large"))
			table.insert(Mission.CommandBuildings, FindEntity("CB8"))
			table.insert(Mission.CommandBuildings, FindEntity("CB9"))

		--Carriers
		Mission.USNCV1 = FindEntity("CV_USN 01")
		SetParty(Mission.USNCV1, PARTY_ALLIED)
		SetRoleAvailable(Mission.USNCV1, EROLF_ALL,PLAYER_1)
		Mission.USNCV2 = FindEntity("CV_USN 02")
		SetParty(Mission.USNCV2, PARTY_ALLIED)
		SetRoleAvailable(Mission.USNCV2, EROLF_ALL,PLAYER_1)

		Mission.IJNCV1 = FindEntity("CV_IJN 01")
		SetParty(Mission.IJNCV1, PARTY_JAPANESE)
		SetRoleAvailable(Mission.IJNCV1, EROLF_ALL,PLAYER_5)
		Mission.IJNCV2 = FindEntity("CV_IJN 02")
		SetParty(Mission.IJNCV2, PARTY_JAPANESE)
		SetRoleAvailable(Mission.IJNCV2, EROLF_ALL,PLAYER_5)


		Mission.USCB = {}
			table.insert(Mission.USCB, Mission.CB1)
			table.insert(Mission.USCB, Mission.USNCV1)
			table.insert(Mission.USCB, Mission.USNCV2)
		Mission.JPCB = {}
			table.insert(Mission.JPCB, Mission.CB9)
			table.insert(Mission.JPCB, Mission.IJNCV1)
			table.insert(Mission.JPCB, Mission.IJNCV2)
		Mission.USCVs = {}
			table.insert(Mission.USCVs, Mission.USNCV1)
			table.insert(Mission.USCVs, Mission.USNCV2)
		Mission.JPCVs = {}
			table.insert(Mission.JPCVs, Mission.IJNCV1)
			table.insert(Mission.JPCVs, Mission.IJNCV2)

		-- Skirmish AI CVs MoveOnPath
		if Mission.IJNAI == true then
			Mission.CV_IJN_01MovePath = FindEntity("IC - CV_IJN_01MovePath")
			NavigatorMoveOnPath(Mission.IJNCV1, Mission.CV_IJN_01MovePath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
			Mission.CV_IJN_02MovePath = FindEntity("IC - CV_IJN_02MovePath")
			NavigatorMoveOnPath(Mission.IJNCV2, Mission.CV_IJN_02MovePath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
		elseif Mission.USNAI == true then
			Mission.CV_USN_01MovePath = FindEntity("IC - CV_USN_01MovePath")
			NavigatorMoveOnPath(Mission.USNCV1, Mission.CV_USN_01MovePath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
			Mission.CV_USN_02MovePath = FindEntity("IC - CV_USN_02MovePath")
			NavigatorMoveOnPath(Mission.USNCV2, Mission.CV_USN_02MovePath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
		end

		--capture weights etc.
		Mission.CB1.CaptureWeight = 1
		Mission.CB1.StrategicGain = 2
		Mission.CB2.CaptureWeight = 1
		Mission.CB2.StrategicGain = 2
		Mission.CB3.CaptureWeight = 1
		Mission.CB3.StrategicGain = 2
		Mission.CB4.CaptureWeight = 1
		Mission.CB4.StrategicGain = 2

		Mission.CBMultiplier = 1.0
--[[
		Mission.CP1.CaptureWeight = 2
		Mission.CP1.StrategicGain = 1
		Mission.CP2.CaptureWeight = 2
		Mission.CP2.StrategicGain = 1
		Mission.CP3.CaptureWeight = 2
		Mission.CP3.StrategicGain = 1
]]
	end

	if Mission.IC2v2 == true then
-- RELEASE_LOGOFF  		luaLog("Initiating Island Capture Mode 2v2")

		Mission.Shipyards = {}
			table.insert(Mission.Shipyards, FindEntity("CB2_SY"))
			table.insert(Mission.Shipyards, FindEntity("CB7_SY"))
			table.insert(Mission.Shipyards, FindEntity("CB4_SY"))
			table.insert(Mission.Shipyards, FindEntity("CB6_SY"))
			table.insert(Mission.Shipyards, FindEntity("CB5_SY"))

		Mission.CB2 = FindEntity("CB2")
		SetGuiName(Mission.CB2, "globals.unitclass_headquarter|".." - |01")
		SetCommandBuildingOwnerPlayer(Mission.CB2, PLAYER_1)
		Mission.CB7 = FindEntity("CB7")
		SetGuiName(Mission.CB7, "globals.unitclass_headquarter|".." - |05")
		SetCommandBuildingOwnerPlayer(Mission.CB7, PLAYER_5)
		Mission.CB4 = FindEntity("CB4 - SM")
		SetGuiName(Mission.CB4, "globals.unitclass_headquarter|".." - |04")
		Mission.CB6 = FindEntity("CB6")
		SetGuiName(Mission.CB6, "globals.unitclass_headquarter|".." - |02")
		Mission.CB5 = FindEntity("CB5")
		SetGuiName(Mission.CB5, "globals.unitclass_headquarter|".." - |03")


		Mission.CommandBuildings = {}
			table.insert(Mission.CommandBuildings, FindEntity("CB2"))
			table.insert(Mission.CommandBuildings, FindEntity("CB5"))
			table.insert(Mission.CommandBuildings, FindEntity("CB4 - SM"))
			table.insert(Mission.CommandBuildings, FindEntity("CB6"))
			table.insert(Mission.CommandBuildings, FindEntity("CB7"))

		--Carriers
		Mission.USNCV1 = FindEntity("CV_USN 03")
		SetParty(Mission.USNCV1, PARTY_ALLIED)
		SetRoleAvailable(Mission.USNCV1, EROLF_ALL,PLAYER_1)

		Mission.IJNCV1 = FindEntity("CV_IJN 03")
		SetParty(Mission.IJNCV1, PARTY_JAPANESE)
		SetRoleAvailable(Mission.IJNCV1, EROLF_ALL,PLAYER_5)

		Mission.USCB = {}
			table.insert(Mission.USCB, Mission.CB2)
			table.insert(Mission.USCB, Mission.USNCV1)

		Mission.JPCB = {}
			table.insert(Mission.JPCB, Mission.CB7)
			table.insert(Mission.JPCB, Mission.IJNCV1)

		Mission.USCVs = {}
			table.insert(Mission.USCVs, Mission.USNCV1)

		Mission.JPCVs = {}
			table.insert(Mission.JPCVs, Mission.IJNCV1)


		-- Skirmish AI CVs MoveOnPath
		if Mission.IJNAI == true then
			Mission.CV_IJN_01MovePath = FindEntity("IC - CV_IJN_01MovePath")
			NavigatorMoveOnPath(Mission.IJNCV1, Mission.CV_IJN_01MovePath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
		elseif Mission.USNAI == true then
			Mission.CV_USN_01MovePath = FindEntity("IC - CV_USN_01MovePath")
			NavigatorMoveOnPath(Mission.USNCV1, Mission.CV_USN_01MovePath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
		end

		--capture weights etc.
		Mission.CB2.CaptureWeight = 1
		Mission.CB2.StrategicGain = 2
		Mission.CB4.CaptureWeight = 1
		Mission.CB4.StrategicGain = 2
		Mission.CB5.CaptureWeight = 1
		Mission.CB5.StrategicGain = 2
		Mission.CB6.CaptureWeight = 1
		Mission.CB6.StrategicGain = 2
		Mission.CB7.CaptureWeight = 1
		Mission.CB7.StrategicGain = 2

		Mission.CBMultiplier = 1.0


--[[
		Mission.CP1.CaptureWeight = 2
		Mission.CP1.StrategicGain = 1
		Mission.CP2.CaptureWeight = 2
		Mission.CP2.StrategicGain = 1
		Mission.CP3.CaptureWeight = 2
		Mission.CP3.StrategicGain = 1
]]

	end

	if Mission.IC1v1 == true then
-- RELEASE_LOGOFF  		luaLog("Initiating Island Capture Mode 1v1")

		Mission.Shipyards = {}
			table.insert(Mission.Shipyards, FindEntity("CB4_SY"))
			table.insert(Mission.Shipyards, FindEntity("CB5_SY"))
			table.insert(Mission.Shipyards, FindEntity("CB6_SY"))

		Mission.CB4 = FindEntity("CB4 - SM")
		SetGuiName(Mission.CB4, "globals.unitclass_headquarter|".." - |03")
		SetCommandBuildingOwnerPlayer(Mission.CB4, PLAYER_5)
		Mission.CB6 = FindEntity("CB6")
		SetGuiName(Mission.CB6, "globals.unitclass_headquarter|".." - |01")
		SetCommandBuildingOwnerPlayer(Mission.CB6, PLAYER_1)
		Mission.CB5 = FindEntity("CB5")
		SetGuiName(Mission.CB5, "globals.unitclass_headquarter|".." - |02")

		Mission.CommandBuildings = {}
			table.insert(Mission.CommandBuildings, FindEntity("CB4 - SM"))
			table.insert(Mission.CommandBuildings, FindEntity("CB6"))
			table.insert(Mission.CommandBuildings, FindEntity("CB5"))

		--Carriers
		Mission.USNCV1 = FindEntity("CV_USN 03")
		SetParty(Mission.USNCV1, PARTY_ALLIED)
		SetRoleAvailable(Mission.USNCV1, EROLF_ALL,PLAYER_1)

		Mission.IJNCV1 = FindEntity("CV_IJN 03")
		SetParty(Mission.IJNCV1, PARTY_JAPANESE)
		SetRoleAvailable(Mission.IJNCV1, EROLF_ALL,PLAYER_5)

		Mission.USCB = {}
			table.insert(Mission.USCB, Mission.CB6)
			table.insert(Mission.USCB, Mission.USNCV1)
		Mission.JPCB = {}
			table.insert(Mission.JPCB, Mission.CB4)
			table.insert(Mission.JPCB, Mission.IJNCV1)
		Mission.USCVs = {}
			table.insert(Mission.USCVs, Mission.USNCV1)
			--table.insert(Mission.USCVs, Mission.USNCV2)
		Mission.JPCVs = {}
			table.insert(Mission.JPCVs, Mission.IJNCV1)
			--table.insert(Mission.JPCVs, Mission.IJNCV2)

		-- Skirmish AI CVs MoveOnPath
		if Mission.IJNAI == true then
			Mission.CV_IJN_03MovePath = FindEntity("IC - CV_IJN_03MovePath")
			NavigatorMoveOnPath(Mission.IJNCV1, Mission.CV_IJN_03MovePath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
		elseif Mission.USNAI == true then
			Mission.CV_USN_03MovePath = FindEntity("IC - CV_USN_03MovePath")
			NavigatorMoveOnPath(Mission.USNCV1, Mission.CV_USN_03MovePath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
		end

		--capture weights etc.
		Mission.CB4.CaptureWeight = 1
		Mission.CB4.StrategicGain = 2
		Mission.CB5.CaptureWeight = 1
		Mission.CB5.StrategicGain = 2
		Mission.CB6.CaptureWeight = 1
		Mission.CB6.StrategicGain = 2

		Mission.CBMultiplier = 2.0

--[[
		Mission.CP2.CaptureWeight = 2
		Mission.CP2.StrategicGain = 1
]]

	end

	---- unit tablak es ertekek atmenetileg a scriptben
	Mission.USTable = {}
	Mission.JapTable = {}
	Mission.UnitValue = {}
	Mission.UnitValue.BattleShip = 24
	Mission.UnitValue.Cruiser = 12
	Mission.UnitValue.Destroyer = 6
	Mission.UnitValue.MotherShip = 150
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
	----

	luaShipyardManagerInit(Mission.Shipyards)

	luaUnitRedistribution()

-- korulmenyek beallitasa
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	luaInitNewSystems()

    SetThink(this, "luaIslandCapture14_think")

	luaMultiVoiceOverHandler()

	Scoring_RealPlayTimeRunning(true)
end
-----------------------------------------------------------------------------------------
-------------------------				THINK				---------------------------------------------
-----------------------------------------------------------------------------------------
function luaIslandCapture14_think(this, msg)

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

	luaSetObjectives()
	luaCheckCBParty()
	luaCheckTimelimit()
	luaCheckCapturePointlimit()
	luaCaptureCounters()
	luaCheckPlayerUnits()
	luaDelay(luaShowMissionHint,2)

	local selUnit = GetSelectedUnit()
	if selUnit then
		luaCheckMusic(selUnit)
	end

end
---------------------------------------------------------------------------------------------
------------------------------- Functions ---------------------------------------------------
---------------------------------------------------------------------------------------------
function luaCaptureCounters()
-- RELEASE_LOGOFF  --	luaLog(" Updating counters...")
	if not Mission.CaptureCounters == true then
		Mission.CaptureCounters = true
-- RELEASE_LOGOFF  --		luaLog(" Initializing counters...")
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

						luaIC14CheckAchievement(PARTY_ALLIED)

						luaMissionCompletedNew(Mission.CommandBuildings[1], "", nil, nil, nil, PARTY_ALLIED)
						Scoring_RealPlayTimeRunning(false)

						luaObj_Completed("primary", 1)
-- RELEASE_LOGOFF  						luaLog("point szar")
						--luaObj_Completed("primary", 3)

						luaObj_Failed("primary", 2)
						--luaObj_Failed("primary", 4)
						Mission.MissionEnd = true
					end
				elseif Mission.JapaneseCapturePoints > Mission.AlliedCapturePoints then
					if not Mission.MissionEnd then
						-- japanese wins
						--todo mas kamera dobas, otletek!!!

						luaIC14CheckAchievement(PARTY_JAPANESE)

						luaMissionCompletedNew(Mission.CommandBuildings[1], "", nil, nil, nil, PARTY_JAPANESE)
						Scoring_RealPlayTimeRunning(false)
						luaObj_Completed("primary", 2)
-- RELEASE_LOGOFF  						luaLog("point szar 2")
						--luaObj_Completed("primary", 4)

						luaObj_Failed("primary", 1)
						--luaObj_Failed("primary", 3)
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
-- RELEASE_LOGOFF  --			luaLog(" Mission.CommandBuildings idx: "..idx.." | party: "..tostring(unit.Party))
			if unit.Party == PARTY_ALLIED then
				if USCB == 0 then
					USCB = 1
				else
					USCB = (USCB + 1)
				end
				--Mission.AlliedCapturePoints = Mission.AlliedCapturePoints + 1
			elseif unit.Party == PARTY_JAPANESE then
				if JapCB == 0 then
					JapCB = 1
				else
					JapCB = (JapCB + 1)
				end
				--Mission.JapaneseCapturePoints = Mission.JapaneseCapturePoints + 1
			end
		end

		Mission.USCVs = luaRemoveDeadsFromTable(Mission.USCVs)
		USCB = USCB + luaCountTable(Mission.USCVs)
		Mission.JPCVs = luaRemoveDeadsFromTable(Mission.JPCVs)
		JapCB = JapCB + luaCountTable(Mission.JPCVs)

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
-- RELEASE_LOGOFF  --		luaLog("Checking Timelimit")
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

			luaIC14CheckAchievement(PARTY_ALLIED)

			luaMissionCompletedNew(Mission.CommandBuildings[1], "", nil, nil, nil, PARTY_ALLIED)
			Scoring_RealPlayTimeRunning(false)
			luaObj_Completed("primary", 1)
			--luaObj_Completed("primary", 3)

			luaObj_Failed("primary", 2)
			--luaObj_Failed("primary", 4)
-- RELEASE_LOGOFF  			luaLog("!!!!!!!MISSION END v2!!!!!!")
			Mission.MissionEnd = true
		end
	elseif Mission.AlliedCapturePoints < Mission.JapaneseCapturePoints then
		if not Mission.MissionEnd then
			-- japanese wins
			--todo mas kamera dobas

			luaIC14CheckAchievement(PARTY_JAPANESE)

			luaMissionCompletedNew(Mission.CommandBuildings[1], "", nil, nil, nil, PARTY_JAPANESE)
			Scoring_RealPlayTimeRunning(false)
			luaObj_Completed("primary", 2)
			--luaObj_Completed("primary", 4)
			luaObj_Failed("primary", 1)
			--luaObj_Failed("primary", 3)
-- RELEASE_LOGOFF  			luaLog("!!!!!!!MISSION END v2!!!!!!")
			Mission.MissionEnd = true
		end
	end
end

function luaSetObjectives()
	if Mission.IC4v4 == true then
		if Mission.MissionInit then

		-- allied objs
		luaObj_Add("primary", 1, {Mission.CB1, Mission.CB2, Mission.CB3, Mission.CB4, Mission.CB5, Mission.CB6, Mission.CB7, Mission.CB8, Mission.CB9, Mission.USNCV1, Mission.USNCV2, Mission.USNCV4, Mission.JPCV1, Mission.JPCV2, Mission.JPCV4})
		-- japanese objs
		luaObj_Add("primary", 2, {Mission.CB1, Mission.CB2, Mission.CB3, Mission.CB4, Mission.CB5, Mission.CB6, Mission.CB7, Mission.CB8, Mission.CB9, Mission.USNCV1, Mission.USNCV2, Mission.USNCV4, Mission.JPCV1, Mission.JPCV2, Mission.JPCV4})
		Mission.MissionInit = false
		end
	end

	if Mission.IC3v3 == true then
		if Mission.MissionInit then

		-- allied objs
		luaObj_Add("primary", 1, {Mission.CB1, Mission.CB2, Mission.CB3, Mission.CB4, Mission.CB5, Mission.CB6, Mission.CB7, Mission.CB8, Mission.CB9, Mission.USNCV1, Mission.USNCV2, Mission.USNCV4, Mission.JPCV1, Mission.JPCV2, Mission.JPCV4})
		-- japanese objs
		luaObj_Add("primary", 2, {Mission.CB1, Mission.CB2, Mission.CB3, Mission.CB4, Mission.CB5, Mission.CB6, Mission.CB7, Mission.CB8, Mission.CB9, Mission.USNCV1, Mission.USNCV2, Mission.USNCV4, Mission.JPCV1, Mission.JPCV2, Mission.JPCV4})
		Mission.MissionInit = false
		end
	end

	if Mission.IC2v2 == true then
		if Mission.MissionInit then

		-- allied objs
		luaObj_Add("primary", 1, {Mission.CB2, Mission.CB4, Mission.CB5, Mission.CB6, Mission.CB7, Mission.USNCV1, Mission.JPCV1})
		-- japanese objs
		luaObj_Add("primary", 2, {Mission.CB2, Mission.CB4, Mission.CB5, Mission.CB6, Mission.CB7, Mission.USNCV1, Mission.JPCV1})
		Mission.MissionInit = false
		end
	end

	if Mission.IC1v1 == true then
		if Mission.MissionInit then
-- RELEASE_LOGOFF  		luaLog("Hint mejelenites")

		-- allied objs
		luaObj_Add("primary", 1, {Mission.CB4, Mission.CB5, Mission.CB6})
		-- japanese objs
		luaObj_Add("primary", 2, {Mission.CB4, Mission.CB5, Mission.CB6})
		Mission.MissionInit = false
		end
	end
end

function luaCheckCBParty()

	Mission.AlliedCBCounter = 0
	Mission.JapaneseCBCounter = 0

	for idx,unit in pairs(Mission.CommandBuildings) do
		if unit.Party == PARTY_ALLIED then
			Mission.AlliedCBCounter = Mission.AlliedCBCounter + 1
		elseif unit.Party == PARTY_JAPANESE then
			Mission.JapaneseCBCounter = Mission.JapaneseCBCounter + 1
		end
	end

	if Mission.AlliedCBCounter == 0 then

		luaIC14CheckAchievement(PARTY_JAPANESE)

		luaMissionCompletedNew(Mission.CommandBuildings[1], "", nil, nil, nil, PARTY_JAPANESE)
		Scoring_RealPlayTimeRunning(false)
-- RELEASE_LOGOFF  		luaLog("luaMissionCompleted: ")
-- RELEASE_LOGOFF  		luaLog("Allied cb 0")
		luaObj_Completed("primary", 2)
		--luaObj_Completed("primary", 4)
		luaObj_Failed("primary", 1)
		--luaObj_Failed("primary", 3)
		Mission.MissionEnd = true
	end

	if Mission.JapaneseCBCounter == 0 then

		luaIC14CheckAchievement(PARTY_ALLIED)

		luaMissionCompletedNew(Mission.CommandBuildings[1], "", nil, nil, nil, PARTY_ALLIED)
		Scoring_RealPlayTimeRunning(false)
-- RELEASE_LOGOFF  		luaLog("luaMissionCompleted: ")
-- RELEASE_LOGOFF  		luaLog("Jap cb 0")
		luaObj_Completed("primary", 1)
		--luaObj_Completed("primary", 3)
		luaObj_Failed("primary", 2)
		--luaObj_Failed("primary", 4)
		Mission.MissionEnd = true
	end

	Mission.USCVs = luaRemoveDeadsFromTable(Mission.USCVs)
	Mission.AlliedCBCounter = Mission.AlliedCBCounter + luaCountTable(Mission.USCVs)
	Mission.JPCVs = luaRemoveDeadsFromTable(Mission.JPCVs)
	Mission.JapaneseCBCounter = Mission.JapaneseCBCounter + luaCountTable(Mission.JPCVs)

end


function luaShowMissionHint()
	ShowHint("ID_Hint_IslandCapture01")
	-- mode description hint overlay
end


function luaCheckPlayerUnits()

	local deadUnits = {}
-- RELEASE_LOGOFF  --	luaLog(" Checking players units...")
	if table.getn(luaRemoveDeadsFromTable(Mission.USTable)) ~= 0 then
		for index, unit in pairs (luaRemoveDeadsFromTable(Mission.USTable)) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead "..tostring(unit.Class.Type).." found in luaRemoveDeadsFromTable(Mission.USTable)")
				table.insert(deadUnits, unit)
				--luaManageDeadUnit(unit.Class.Type, unit.Party)
				table.remove(luaRemoveDeadsFromTable(Mission.USTable), index)
			end
		end
	end

	if table.getn(luaRemoveDeadsFromTable(Mission.JapTable)) ~= 0 then
		for index, unit in pairs (luaRemoveDeadsFromTable(Mission.JapTable)) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead "..tostring(unit.Class.Type).." found in luaRemoveDeadsFromTable(Mission.JapTable)")
				--luaManageDeadUnit(unit.Class.Type, unit.Party)
				table.insert(deadUnits, unit)
				table.remove(luaRemoveDeadsFromTable(Mission.JapTable), index)
			end
		end
	end

	luaManageDeadUnit(deadUnits)

	local usships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	local japships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
	local japplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
	local usplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")

	if usships ~= nil then
		for index, unit in pairs (usships) do
			if not luaIsInside(unit, luaRemoveDeadsFromTable(Mission.USTable)) then
-- RELEASE_LOGOFF  				luaLog("  new US "..tostring(unit.Class.Type).." found, inserting it to luaRemoveDeadsFromTable(Mission.USTable)")
				table.insert(luaRemoveDeadsFromTable(Mission.USTable), unit)
			end
		end
	end
	if japships ~= nil then
		for index, unit in pairs (japships) do
			if not luaIsInside(unit, luaRemoveDeadsFromTable(Mission.JapTable)) then
-- RELEASE_LOGOFF  				luaLog("  new Japanese "..tostring(unit.Class.Type).." found, inserting it to luaRemoveDeadsFromTable(Mission.JapTable)")
				table.insert(luaRemoveDeadsFromTable(Mission.JapTable), unit)
			end
		end
	end
	if usplanes ~= nil then
		for index, unit in pairs (usplanes) do
			if not luaIsInside(unit, luaRemoveDeadsFromTable(Mission.USTable)) then
-- RELEASE_LOGOFF  				luaLog("  new US "..tostring(unit.Class.Type).." found, inserting it to luaRemoveDeadsFromTable(Mission.USTable)")
				table.insert(luaRemoveDeadsFromTable(Mission.USTable), unit)
			end
		end
	end
	if japplanes ~= nil then
		for index, unit in pairs (japplanes) do
			if not luaIsInside(unit, luaRemoveDeadsFromTable(Mission.JapTable)) then
-- RELEASE_LOGOFF  				luaLog("  new Japanese "..tostring(unit.Class.Type).." found, inserting it to luaRemoveDeadsFromTable(Mission.JapTable)")
				table.insert(luaRemoveDeadsFromTable(Mission.JapTable), unit)
			end
		end
	end
end

function luaManageDeadUnit(deadUnits)

	for idx,unit in pairs(deadUnits) do

		local pointsToCalc

		if unit.Party == PARTY_ALLIED then
			pointsToCalc = Mission.JapaneseCapturePoints
		elseif unit.Party == PARTY_JAPANESE then
			pointsToCalc = Mission.AlliedCapturePoints
		end

		if unit.Class.Type == "BattleShip" then
			pointsToCalc = pointsToCalc + Mission.UnitValue.BattleShip
		elseif unit.Class.Type == "Cruiser" then
			pointsToCalc = pointsToCalc + Mission.UnitValue.Cruiser
		elseif unit.Class.Type == "Destroyer" then
			pointsToCalc = pointsToCalc + Mission.UnitValue.Destroyer
		elseif unit.Class.Type == "MotherShip" then
			pointsToCalc = pointsToCalc + Mission.UnitValue.MotherShip
		elseif unit.Class.Type == "TorpedoBoat" then
			pointsToCalc = pointsToCalc + Mission.UnitValue.TorpedoBoat
		elseif unit.Class.Type == "Submarine"  then
			pointsToCalc = pointsToCalc + Mission.UnitValue.Submarine
		elseif unit.Class.Type == "LandingShip" then
			pointsToCalc = pointsToCalc + Mission.UnitValue.LandingShip
		elseif unit.Class.Type == "Cargo" then
			pointsToCalc = pointsToCalc + Mission.UnitValue.Cargo
		elseif unit.Class.Type == "Fighter" then
			pointsToCalc = pointsToCalc + Mission.UnitValue.Fighter
		elseif unit.Class.Type == "DiveBomber" then
			pointsToCalc = pointsToCalc + Mission.UnitValue.DiveBomber
		elseif unit.Class.Type == "TorpedoBomber" then
			pointsToCalc = pointsToCalc + Mission.UnitValue.TorpedoBomber
		elseif unit.Class.Type == "LevelBomber" then
			pointsToCalc = pointsToCalc + Mission.UnitValue.LevelBomber
		elseif unit.Class.Type == "LargeReconPlane" then
			pointsToCalc = pointsToCalc + Mission.UnitValue.LargeReconPlane
		elseif unit.Class.Type == "SmallReconPlane" then
			pointsToCalc = pointsToCalc + Mission.UnitValue.SmallReconPlane
		elseif unit.Class.Type == "Kamikaze" then
			pointsToCalc = pointsToCalc + Mission.UnitValue.Kamikaze
		end
	end
end

function luaIC14CheckAchievement(winner_party)

	if not Mission.IC3v3 then
		return
	end

	if winner_party == PARTY_ALLIED then

		--if table.getn(luaRemoveDeadsFromTable(Mission.USCVs)) == 2 then
			for idx,playerTbl in pairs(Mission.Players) do
				if playerTbl["party"] == PARTY_ALLIED and not playerTbl["ai"] then
					SetAchievements(playerTbl["playerslot"],"MA_DLC03NW")
-- RELEASE_LOGOFF  					luaLog("Achievement NAME added to playerindex "..tostring(playerTbl["playerindex"]))
				end
			end
		--end

	elseif winner_party == PARTY_JAPANESE then

		--if table.getn(luaRemoveDeadsFromTable(Mission.JPCVs)) == 2 then
			for idx,playerTbl in pairs(Mission.Players) do
				if playerTbl["party"] == PARTY_JAPANESE and not playerTbl["ai"] then
					SetAchievements(playerTbl["playerslot"],"MA_DLC03NW")
-- RELEASE_LOGOFF  					luaLog("Achievement NAME added to playerindex "..tostring(playerTbl["playerindex"]))
				end
			end
		--end

	end

end