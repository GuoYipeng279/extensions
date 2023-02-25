--SceneFile="Missions\Multi\Scene11.scn"

function luaPrecacheUnits()
	
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitEscort11")
end

function luaInitEscort11(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Escort11"..dateandtime

	DamageLog = false
	Mission.HelperLog = false
	Mission.CustomLog = true

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.."!")

	-- lobby
-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")

	Music_Control_SetLevel(MUSIC_TENSION)
	Mission.Multiplayer = true
	this.ThinkCounter = 0

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- japan egysegek
	Mission.Keyunits = {}
		table.insert(Mission.Keyunits, FindEntity("Escort - Fuso"))
		table.insert(Mission.Keyunits, FindEntity("Escort - Kongo"))
	Mission.Fuso = FindEntity("Escort - Fuso")
	Mission.Kongo = FindEntity("Escort - Kongo")

	Mission.BBPath = FindEntity("Escort - BB Path")

	-- amerikai egysegek

	-- spawn pontok
	Mission.US = {}
	Mission.Jap = {}
	Mission.US.SP = FindEntity("Escort - US SP")
	Mission.Jap.SP = FindEntity("Escort - Jap SP")
	Mission.CurrentSP = 0
	Mission.PreviousSP = 0

	Mission.US.PutToPoint = {}
		table.insert(Mission.US.PutToPoint, GetPosition(FindEntity("Escort - US PutToPoint 1")))
		table.insert(Mission.US.PutToPoint, GetPosition(FindEntity("Escort - US PutToPoint 2")))
		table.insert(Mission.US.PutToPoint, GetPosition(FindEntity("Escort - US PutToPoint 3")))
		table.insert(Mission.US.PutToPoint, GetPosition(FindEntity("Escort - US PutToPoint 4")))
		table.insert(Mission.US.PutToPoint, GetPosition(FindEntity("Escort - US PutToPoint 5")))
		table.insert(Mission.US.PutToPoint, GetPosition(FindEntity("Escort - US PutToPoint 6")))
		table.insert(Mission.US.PutToPoint, GetPosition(FindEntity("Escort - US PutToPoint 7")))
	Mission.Jap.PutToPoint = {}
		table.insert(Mission.Jap.PutToPoint, GetPosition(FindEntity("Escort - Jap PutToPoint 1")))
		table.insert(Mission.Jap.PutToPoint, GetPosition(FindEntity("Escort - Jap PutToPoint 2")))
		table.insert(Mission.Jap.PutToPoint, GetPosition(FindEntity("Escort - Jap PutToPoint 3")))
		table.insert(Mission.Jap.PutToPoint, GetPosition(FindEntity("Escort - Jap PutToPoint 4")))
		table.insert(Mission.Jap.PutToPoint, GetPosition(FindEntity("Escort - Jap PutToPoint 5")))
		table.insert(Mission.Jap.PutToPoint, GetPosition(FindEntity("Escort - Jap PutToPoint 6")))
		table.insert(Mission.Jap.PutToPoint, GetPosition(FindEntity("Escort - Jap PutToPoint 7")))

	-- jatekosok
	Mission.PlayersTable = GetPlayerDetails()
-- RELEASE_LOGOFF  	luaLog("-- start of playertable --")
-- RELEASE_LOGOFF  	luaLog(Mission.PlayersTable)
-- RELEASE_LOGOFF  	luaLog("-- end of playertable --")
	Mission.Players = 0
	for index, value in pairs (Mission.PlayersTable) do
		Mission.Players = Mission.Players + 1
	end
-- RELEASE_LOGOFF  	luaLog("  -> Players total: "..Mission.Players)

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")
	this.Objectives =
	{
		["primary"] =
		{
			[1] =
			{
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj1",
				["Text"] = "mp.obj_es_des",
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
				["Text"] = "mp.obj_es_def",
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
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")
	
	Mission.MissionEnd = false	
		
	--idojaras
	SetDayTime(10)							-- de 10-kor kezdodik
	SetWeather("Clear")						-- tiszta idoben

	luaInitNewSystems()

    SetThink(this, "luaEscort11_think")


	MultiScore =	{
		[0]= {
			[1] = 100,
			[2] = 100,
		},
		[1]= {
			[1] = 100,
			[2] = 100,
		},
		[2]= {
			[1] = 100,
			[2] = 100,
		},
		[3]= {
			[1] = 100,
			[2] = 100,
		},
		[4]= {
			[1] = 100,
			[2] = 100,
		},
		[5]= {
			[1] = 100,
			[2] = 100,
		},
		[6]= {
			[1] = 100,
			[2] = 100,
		},
		[7]= {
			[1] = 100,
			[2] = 100,
		},
	}

	DisplayScores(1, 0,"mp11.score_fuso_hp".."| |#MultiScore.0.1#| |%", "mp11.score_kongo_hp".."| |#MultiScore.0.2#| |%", 1, 1)
	DisplayScores(1, 1,"mp11.score_fuso_hp".."| |#MultiScore.1.1#| |%", "mp11.score_kongo_hp".."| |#MultiScore.1.2#| |%", 1, 1)
	DisplayScores(1, 2,"mp11.score_fuso_hp".."| |#MultiScore.2.1#| |%", "mp11.score_kongo_hp".."| |#MultiScore.2.2#| |%", 1, 1)
	DisplayScores(1, 3,"mp11.score_fuso_hp".."| |#MultiScore.3.1#| |%", "mp11.score_kongo_hp".."| |#MultiScore.3.2#| |%", 1, 1)
	DisplayScores(1, 4,"mp11.score_fuso_hp".."| |#MultiScore.4.1#| |%", "mp11.score_kongo_hp".."| |#MultiScore.4.2#| |%", 1, 1)
	DisplayScores(1, 5,"mp11.score_fuso_hp".."| |#MultiScore.5.1#| |%", "mp11.score_kongo_hp".."| |#MultiScore.5.2#| |%", 1, 1)
	DisplayScores(1, 6,"mp11.score_fuso_hp".."| |#MultiScore.6.1#| |%", "mp11.score_kongo_hp".."| |#MultiScore.6.2#| |%", 1, 1)
	DisplayScores(1, 7,"mp11.score_fuso_hp".."| |#MultiScore.7.1#| |%", "mp11.score_kongo_hp".."| |#MultiScore.7.2#| |%", 1, 1)

	Scoring_RealPlayTimeRunning(true)
end

function luaEscort11_think(this, msg)
	this.ElapsedTime = math.floor(GameTime())
	this.ThinkCounter = this.ThinkCounter + 1
-- RELEASE_LOGOFF  	luaLog("- Think "..this.ThinkCounter.." started | Elapsed time: "..this.ElapsedTime.."s -")

	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	if Mission.Started and not Mission.MissionEnd then
		luaQAE11CheckKeyUnits()
		luaQAE11CheckSpawnPoints()

	elseif not Mission.Started then
		luaQAE11StartMission()
	end
end

function luaQAE11StartMission()
-- RELEASE_LOGOFF  	luaLog(" Starting mission...")
	luaShowMissionHint()

	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2)
	for index, unit in pairs (Mission.Keyunits) do
		luaObj_AddUnit("primary", 1, unit)
		luaObj_AddUnit("primary", 2, unit)
	end

	JoinFormation(Mission.Keyunits[2], Mission.Keyunits[1])
	NavigatorMoveOnPath(Mission.Keyunits[1], Mission.BBPath, PATH_FM_SIMPLE, PATH_SM_JOIN)
	local pathpoints = FillPathPoints(Mission.BBPath)
	local pathpointsnumber = table.getn(pathpoints)
	AddProximityTrigger(Mission.Keyunits[1], "BB1Trigger", "luaQAE11BB1InPos", pathpoints[pathpointsnumber], 450)
	AddProximityTrigger(Mission.Keyunits[2], "BB2Trigger", "luaQAE11BB2InPos", pathpoints[pathpointsnumber], 450)
	Mission.TurnToPoint = pathpoints[pathpointsnumber]
	Mission.MoveToOverride = {["x"] = Mission.TurnToPoint.x + 100, ["y"] = 0, ["z"] = Mission.TurnToPoint.z - 100}
	Mission.FusoMoveToOverRide = 30
	Mission.KongoMoveToOverRide = 30
	luaObj_AddUnit("primary", 1, GetPosition(FindEntity("Escort - ExitPoint")))
	luaObj_AddUnit("primary", 2, GetPosition(FindEntity("Escort - ExitPoint")))
	OverrideHP(Mission.Keyunits[1], 15000)
	OverrideHP(Mission.Keyunits[2], 13500)

	-- SP athelyezes
	AddProximityTrigger(Mission.Keyunits[1], "SP11Trigger", "luaQAE11SP1", pathpoints[2], 400)
	AddProximityTrigger(Mission.Keyunits[2], "SP12Trigger", "luaQAE11SP1", pathpoints[2], 400)
	AddProximityTrigger(Mission.Keyunits[1], "SP21Trigger", "luaQAE11SP2", pathpoints[3], 400)
	AddProximityTrigger(Mission.Keyunits[2], "SP22Trigger", "luaQAE11SP2", pathpoints[3], 400)
	AddProximityTrigger(Mission.Keyunits[1], "SP31Trigger", "luaQAE11SP3", pathpoints[4], 600)
	AddProximityTrigger(Mission.Keyunits[2], "SP32Trigger", "luaQAE11SP3", pathpoints[4], 600)
	AddProximityTrigger(Mission.Keyunits[1], "SP41Trigger", "luaQAE11SP4", pathpoints[5], 400)
	AddProximityTrigger(Mission.Keyunits[2], "SP42Trigger", "luaQAE11SP4", pathpoints[5], 400)
	AddProximityTrigger(Mission.Keyunits[1], "SP51Trigger", "luaQAE11SP5", pathpoints[6], 400)
	AddProximityTrigger(Mission.Keyunits[2], "SP52Trigger", "luaQAE11SP5", pathpoints[6], 400)
	AddProximityTrigger(Mission.Keyunits[1], "SP61Trigger", "luaQAE11SP6", pathpoints[7], 600)
	AddProximityTrigger(Mission.Keyunits[2], "SP62Trigger", "luaQAE11SP6", pathpoints[7], 600)
	AddProximityTrigger(Mission.Keyunits[1], "SP71Trigger", "luaQAE11SP7", pathpoints[8], 400)
	AddProximityTrigger(Mission.Keyunits[2], "SP72Trigger", "luaQAE11SP7", pathpoints[8], 400)

	if Mission.Players < 3 then
		SetSkillLevel(Mission.Keyunits[1], SKILL_STUN)
		SetSkillLevel(Mission.Keyunits[2], SKILL_STUN)
		SetShipSpeed(Mission.Keyunits[1], GetShipMaxSpeed(Mission.Keyunits[1])*0.85)
		SetShipSpeed(Mission.Keyunits[2], GetShipMaxSpeed(Mission.Keyunits[2])*0.85)
		SetShipMaxSpeed(Mission.Keyunits[1], GetShipMaxSpeed(Mission.Keyunits[1])*0.85)
		SetShipMaxSpeed(Mission.Keyunits[2], GetShipMaxSpeed(Mission.Keyunits[1])*0.85)
		SetRepairEffectivity(Mission.Keyunits[1], 0.4)
		SetRepairEffectivity(Mission.Keyunits[2], 0.4)
	elseif Mission.Players < 5 then
		SetSkillLevel(Mission.Keyunits[1], SKILL_SPNORMAL)
		SetSkillLevel(Mission.Keyunits[2], SKILL_STUN)
		SetShipSpeed(Mission.Keyunits[1], GetShipMaxSpeed(Mission.Keyunits[1])*0.9)
		SetShipSpeed(Mission.Keyunits[2], GetShipMaxSpeed(Mission.Keyunits[2])*0.9)
		SetShipMaxSpeed(Mission.Keyunits[1], GetShipMaxSpeed(Mission.Keyunits[1])*0.9)
		SetShipMaxSpeed(Mission.Keyunits[2], GetShipMaxSpeed(Mission.Keyunits[1])*0.9)
		SetRepairEffectivity(Mission.Keyunits[1], 0.5)
		SetRepairEffectivity(Mission.Keyunits[2], 0.5)
	elseif Mission.Players < 7 then
		SetSkillLevel(Mission.Keyunits[1], SKILL_SPVETERAN)
		SetSkillLevel(Mission.Keyunits[2], SKILL_SPVETERAN)
		SetShipSpeed(Mission.Keyunits[1], GetShipMaxSpeed(Mission.Keyunits[1])*0.95)
		SetShipSpeed(Mission.Keyunits[2], GetShipMaxSpeed(Mission.Keyunits[2])*0.95)
		SetShipMaxSpeed(Mission.Keyunits[1], GetShipMaxSpeed(Mission.Keyunits[1])*0.95)
		SetShipMaxSpeed(Mission.Keyunits[2], GetShipMaxSpeed(Mission.Keyunits[1])*0.95)
		SetRepairEffectivity(Mission.Keyunits[1], 0.6)
		SetRepairEffectivity(Mission.Keyunits[2], 0.6)
	else
		SetSkillLevel(Mission.Keyunits[1], SKILL_MPNORMAL)
		SetSkillLevel(Mission.Keyunits[2], SKILL_SPVETERAN)
		SetShipMaxSpeed(Mission.Keyunits[2], GetShipMaxSpeed(Mission.Keyunits[1]))
		SetRepairEffectivity(Mission.Keyunits[1], 0.66)
		SetRepairEffectivity(Mission.Keyunits[2], 0.66)
	end

	AISetTargetWeight(316, 67, false, 13) -- Cleveland vs Mogami
	AISetTargetWeight(316, 69, false, 13) -- Cleveland vs Takao
	AISetTargetWeight(316, 70, false, 13) -- Cleveland vs Kuma
	AISetTargetWeight(316, 71, false, 13) -- Cleveland vs Agano
	AISetTargetWeight(317, 67, false, 16) -- Northampton vs Mogami
	AISetTargetWeight(317, 69, false, 16) -- Northampton vs Takao
	AISetTargetWeight(317, 70, false, 16) -- Northampton vs Kuma
	AISetTargetWeight(317, 71, false, 16) -- Northampton vs Agano
	AISetTargetWeight(20, 67, false, 0) -- De Ruyter vs Mogami
	AISetTargetWeight(20, 69, false, 0) -- De Ruyter vs Takao
	AISetTargetWeight(20, 70, false, 0) -- De Ruyter vs Kuma
	AISetTargetWeight(20, 71, false, 0) -- De Ruyter vs Agano
	AISetTargetWeight(21, 67, false, 15) -- York vs Mogami
	AISetTargetWeight(21, 69, false, 15) -- York vs Takao
	AISetTargetWeight(21, 70, false, 15) -- York vs Kuma
	AISetTargetWeight(21, 71, false, 15) -- York vs Agano

	AISetTargetWeight(67, 316, false, 16) -- Mogami vs Cleveland
	AISetTargetWeight(67, 317, false, 16) -- Mogami vs Northampton
	AISetTargetWeight(67, 20, false, 16) -- Mogami vs De Ruyter
	AISetTargetWeight(67, 21, false, 16) -- Mogami vs York
	AISetTargetWeight(69, 316, false, 16) -- Takao vs Cleveland
	AISetTargetWeight(69, 317, false, 16) -- Takao vs Northampton
	AISetTargetWeight(69, 20, false, 16) -- Takao vs De Ruyter
	AISetTargetWeight(69, 21, false, 16) -- Takao vs York
	AISetTargetWeight(70, 316, false, 0) -- Kuma vs Cleveland
	AISetTargetWeight(70, 317, false, 0) -- Kuma vs Northampton
	AISetTargetWeight(70, 20, false, 0) -- Kuma vs De Ruyter
	AISetTargetWeight(70, 21, false, 0) -- Kuma vs York
	AISetTargetWeight(71, 316, false, 15) -- Agano vs Cleveland
	AISetTargetWeight(71, 317, false, 15) -- Agano vs Northampton
	AISetTargetWeight(71, 20, false, 15) -- Agano vs De Ruyter
	AISetTargetWeight(71, 21, false, 15) -- Agano vs York

	Mission.Started = true
end

function luaQAE11BB1InPos()
-- RELEASE_LOGOFF  	luaLog(" BB1 reached mission end position")
	if not Mission.MissionEnd then
		luaMissionCompletedNew(Mission.Keyunits[1], "", nil, nil, nil, PARTY_JAPANESE)
		Scoring_RealPlayTimeRunning(false)
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		Mission.MissionEnd = true
	end
end

function luaQAE11BB2InPos()
-- RELEASE_LOGOFF  	luaLog(" BB2 reached mission end position")
	if not Mission.MissionEnd then
		luaMissionCompletedNew(Mission.Keyunits[2], "", nil, nil, nil, PARTY_JAPANESE)
		Scoring_RealPlayTimeRunning(false)
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		Mission.MissionEnd = true
	end
end

function luaQAE11CheckKeyUnits()
-- RELEASE_LOGOFF  	luaLog(" Checking key units...")
	if table.getn(luaRemoveDeadsFromTable(Mission.Keyunits)) == 0 then
		lastbanto = Mission.Keyunits[1].LastBanto
		luaMissionCompletedNew(lastbanto, "", nil, nil, nil, PARTY_ALLIED)
		Scoring_RealPlayTimeRunning(false)
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		Mission.MissionEnd = true
	else
		luaRemoveDeadsFromTable(Mission.Keyunits)
	end

	local PlayersInGame = GetPlayerDetails()
	if not Mission.Fuso0 then
		if Mission.Fuso.Dead then
-- RELEASE_LOGOFF  			luaLog("  the Fuso is sinking")
			for index, value in pairs (PlayersInGame) do
				MultiScore[index][1] = 0
			end
			Mission.Fuso0 = true
		else
			local unitHP = GetHpPercentage(Mission.Fuso) * 100
			unitHP = luaRound(unitHP)
-- RELEASE_LOGOFF  			luaLog("  the Fuso on "..tostring(unitHP).."% HP")
			for index, value in pairs (PlayersInGame) do
				MultiScore[index][1] = unitHP
			end
			if GameTime() > Mission.FusoMoveToOverRide and GetShipSpeed(Mission.Fuso) < 2 then
-- RELEASE_LOGOFF  				luaLog("  the Fuso needed MoveToOverride")
				Mission.FusoMoveToOverRide = GameTime() + 20
				NavigatorMoveToPos(Mission.Fuso, Mission.MoveToOverride)
			end
		end
	end
	if not Mission.Kongo0 then
		if Mission.Kongo.Dead then
-- RELEASE_LOGOFF  			luaLog("  the Kongo is sinking")
			for index, value in pairs (PlayersInGame) do
				MultiScore[index][2] = 0
			end
			Mission.Kongo0 = true
		else
			local unitHP = GetHpPercentage(Mission.Kongo) * 100
			unitHP = luaRound(unitHP)
-- RELEASE_LOGOFF  			luaLog("  the Kongo on "..tostring(unitHP).."% HP")
			for index, value in pairs (PlayersInGame) do
				MultiScore[index][2] = unitHP
			end
			if GameTime() > Mission.KongoMoveToOverRide and GetShipSpeed(Mission.Kongo) < 2 then
-- RELEASE_LOGOFF  				luaLog("  the Kongo needed MoveToOverride")
				Mission.KongoMoveToOverRide = GameTime() + 20
				NavigatorMoveToPos(Mission.Kongo, Mission.MoveToOverride)
			end
		end
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Escort11")
end

function luaQAE11CheckSpawnPoints()
-- RELEASE_LOGOFF  	luaLog(" Checking spawn points...")
	if Mission.CurrentSP > Mission.PreviousSP and Mission.CurrentSP < 8 then
-- RELEASE_LOGOFF  		luaLog("  replacing SP's to SP"..tostring(Mission.CurrentSP))
		PutTo(Mission.Jap.SP, Mission.Jap.PutToPoint[Mission.CurrentSP])
		PutTo(Mission.US.SP, Mission.US.PutToPoint[Mission.CurrentSP])
--[[
		if table.getn(Mission.Keyunits) ~= 0 then
			EntityTurnToPosition(Mission.Jap.SP, Mission.TurnToPoint)
			EntityTurnToPosition(Mission.US.SP, Mission.TurnToPoint)
		end
]]
		Mission.CurrentSP = Mission.PreviousSP
	end
end

function luaQAE11SP1()
-- RELEASE_LOGOFF  	luaLog(" Allowing SP1 replacement")
	Mission.CurrentSP = 1
end

function luaQAE11SP2()
-- RELEASE_LOGOFF  	luaLog(" Allowing SP2 replacement")
	Mission.CurrentSP = 2
end

function luaQAE11SP3()
-- RELEASE_LOGOFF  	luaLog(" Allowing SP3 replacement")
	Mission.CurrentSP = 3
end

function luaQAE11SP4()
-- RELEASE_LOGOFF  	luaLog(" Allowing SP4 replacement")
	Mission.CurrentSP = 4
end

function luaQAE11SP5()
-- RELEASE_LOGOFF  	luaLog(" Allowing SP5 replacement")
	Mission.CurrentSP = 5
end

function luaQAE11SP6()
-- RELEASE_LOGOFF  	luaLog(" Allowing SP6 replacement")
	Mission.CurrentSP = 6
end

function luaQAE11SP7()
-- RELEASE_LOGOFF  	luaLog(" Allowing SP7 replacement")
	Mission.CurrentSP = 7
end
