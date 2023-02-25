--SceneFile="Missions\Multi\Scene1.scn"

function luaPrecacheUnits()
	PrepareClass(224) -- Japanese Troop Transport
	PrepareClass(27) -- Elco PT
	PrepareClass(91) -- Landing Ship (QA spec)
	PrepareClass(90) -- Daihatsu LCVP
	PrepareClass(151) -- Raiden
	PrepareClass(150) -- Zero
	PrepareClass(102) -- Corsair
	PrepareClass(101) -- Wildcat
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAS1Mission")
end

function luaInitQAS1Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Siege1"..dateandtime

	this.HelperLog = false
	this.CustomLog = true
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

	-- globalban hasznalando
	this.Multiplayer = true
	this.ThinkCounter = 0
	Mission.MultiplayerType = "Siege"
	Mission.MultiplayerNumber = 1

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- mission valtozok
	Mission.MissionPhase = 0

	Mission.KeyUnitCounter = 0 -- luaQAS1StartMission()-ben allitjuk be
	--ModifyKeyUnitNumber(Mission.KeyUnitCounter)

	--Mission.LandingShipSpawned = 0 -- az aktualis hajo ami landing boatokat kuld
	--Mission.LandingShipToDestroy = 0 -- az aktualis hajo szama ami landing boatokat kuld

	Mission.LandingBoats1 = {} -- a partraszallok tablaja
	Mission.LandingBoats2 = {} -- a partraszallok tablaja
	Mission.LandingBoats3 = {} -- a partraszallok tablaja
	Mission.LandingBoats4 = {} -- a partraszallok tablaja
	Mission.LandingBoats5 = {} -- a partraszallok tablaja

	Mission.NextJTT1LandingPath = 1
	Mission.NextJTT2LandingPath = 1
	Mission.NextJTT3LandingPath = 1
	Mission.NextJTT4LandingPath = 1
	Mission.NextJTT5LandingPath = 1

	Mission.Transport1SendingReady = true
	--Mission.Transport2SendingReady = true
	Mission.Transport3SendingReady = true
	--Mission.Transport4SendingReady = true
	Mission.Transport5SendingReady = true

	Mission.Transport1 = nil
	--Mission.Transport2 = nil
	Mission.Transport3 = nil
	--Mission.Transport4 = nil
	Mission.Transport5 = nil
	Mission.LSTs = {}

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

	-- spawn pontok
	Mission.SpawnPoints = {}
		table.insert(Mission.SpawnPoints, FindEntity("Siege - US SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - US SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - US SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - US SP 4"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - Jap SP 1"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - Jap SP 2"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - Jap SP 3"))
		table.insert(Mission.SpawnPoints, FindEntity("Siege - Jap SP 4"))
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
	Mission.HQ = FindEntity("Siege - Headquarter")
	Mission.CheckPoints = {}
		table.insert(Mission.CheckPoints, {["x"] = 270, ["y"] = 0, ["z"] = -235})
		table.insert(Mission.CheckPoints, {["x"] = 560, ["y"] = 0, ["z"] = -260})
		table.insert(Mission.CheckPoints, {["x"] = 806, ["y"] = 0, ["z"] = -390})
		table.insert(Mission.CheckPoints, {["x"] = 1065, ["y"] = 0, ["z"] = -415})
		table.insert(Mission.CheckPoints, {["x"] = 1218, ["y"] = 0, ["z"] = -570})
	Mission.PTs = {}
		table.insert(Mission.PTs, luaFindHidden("Siege - PT 01"))
		table.insert(Mission.PTs, luaFindHidden("Siege - PT 02"))
		table.insert(Mission.PTs, luaFindHidden("Siege - PT 03"))
		table.insert(Mission.PTs, luaFindHidden("Siege - PT 04"))
	Mission.PTPaths = {}
		table.insert(Mission.PTPaths, FindEntity("Siege - PT1 - Path"))
		table.insert(Mission.PTPaths, FindEntity("Siege - PT2 - Path"))
		table.insert(Mission.PTPaths, FindEntity("Siege - PT3 - Path"))
		table.insert(Mission.PTPaths, FindEntity("Siege - PT4 - Path"))
	Mission.Fortresses = {}
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 01"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 02"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 03"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 04"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 05"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 06"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 07"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Coastal Gun, US 01"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Coastal Gun, US 02"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Coastal Gun, US 03"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Coastal Gun, US 04"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Coastal Gun, US 05"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Coastal Gun, US 06"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Heavy AA 01"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Heavy AA 02"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Heavy AA 03"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Heavy AA 04"))

	-- japan objektumok
	Mission.LST1TMPL = luaFindHidden("Siege - Type1 1")
	Mission.LST2TMPL = luaFindHidden("Siege - Type1 2")
	Mission.LST3TMPL = luaFindHidden("Siege - Type1 3")
	Mission.LST4TMPL = luaFindHidden("Siege - Type1 4")
	Mission.Transport1TMPL = luaFindHidden("Siege - JTT 1")
	--Mission.Transport2TMPL = luaFindHidden("Siege - JTT 2")
	Mission.Transport3TMPL = luaFindHidden("Siege - JTT 3")
	--Mission.Transport4TMPL = luaFindHidden("Siege - JTT 4")
	Mission.Transport5TMPL = luaFindHidden("Siege - JTT 5")
	Mission.Daihatsus1 = {}
		table.insert(Mission.Daihatsus1, luaFindHidden("Siege - Daihatsu LCVP 01"))
		table.insert(Mission.Daihatsus1, luaFindHidden("Siege - Daihatsu LCVP 02"))
		table.insert(Mission.Daihatsus1, luaFindHidden("Siege - Daihatsu LCVP 03"))
		table.insert(Mission.Daihatsus1, luaFindHidden("Siege - Daihatsu LCVP 04"))
	Mission.Daihatsus2 = {}
		table.insert(Mission.Daihatsus2, luaFindHidden("Siege - Daihatsu LCVP 05"))
		table.insert(Mission.Daihatsus2, luaFindHidden("Siege - Daihatsu LCVP 06"))
		table.insert(Mission.Daihatsus2, luaFindHidden("Siege - Daihatsu LCVP 07"))
		table.insert(Mission.Daihatsus2, luaFindHidden("Siege - Daihatsu LCVP 08"))
	Mission.Daihatsus3 = {}
		table.insert(Mission.Daihatsus3, luaFindHidden("Siege - Daihatsu LCVP 09"))
		table.insert(Mission.Daihatsus3, luaFindHidden("Siege - Daihatsu LCVP 10"))
		table.insert(Mission.Daihatsus3, luaFindHidden("Siege - Daihatsu LCVP 11"))
		table.insert(Mission.Daihatsus3, luaFindHidden("Siege - Daihatsu LCVP 12"))
	Mission.Daihatsus4 = {}
		table.insert(Mission.Daihatsus4, luaFindHidden("Siege - Daihatsu LCVP 13"))
		table.insert(Mission.Daihatsus4, luaFindHidden("Siege - Daihatsu LCVP 14"))
		table.insert(Mission.Daihatsus4, luaFindHidden("Siege - Daihatsu LCVP 15"))
		table.insert(Mission.Daihatsus4, luaFindHidden("Siege - Daihatsu LCVP 16"))
	Mission.Daihatsus5 = {}
		table.insert(Mission.Daihatsus5, luaFindHidden("Siege - Daihatsu LCVP 17"))
		table.insert(Mission.Daihatsus5, luaFindHidden("Siege - Daihatsu LCVP 18"))
		table.insert(Mission.Daihatsus5, luaFindHidden("Siege - Daihatsu LCVP 19"))
		table.insert(Mission.Daihatsus5, luaFindHidden("Siege - Daihatsu LCVP 20"))
	Mission.JapCapturePoints = {}
		table.insert(Mission.JapCapturePoints, GetPosition(FindEntity("Siege - Jap CapturePoint1")))
		table.insert(Mission.JapCapturePoints, GetPosition(FindEntity("Siege - Jap CapturePoint2")))
		table.insert(Mission.JapCapturePoints, GetPosition(FindEntity("Siege - Jap CapturePoint3")))
		table.insert(Mission.JapCapturePoints, GetPosition(FindEntity("Siege - Jap CapturePoint4")))
		table.insert(Mission.JapCapturePoints, GetPosition(FindEntity("Siege - Jap CapturePoint5")))
		table.insert(Mission.JapCapturePoints, GetPosition(FindEntity("Siege - Jap CapturePoint6")))
	Mission.LandingBoatsCapturing = {}

	-- pathok
	Mission.JTTPaths = {}
		table.insert(Mission.JTTPaths, FindEntity("Siege - JTT1 Path"))
		table.insert(Mission.JTTPaths, FindEntity("Siege - JTT2 Path"))
		table.insert(Mission.JTTPaths, FindEntity("Siege - JTT3 Path"))
		table.insert(Mission.JTTPaths, FindEntity("Siege - JTT4 Path"))
		table.insert(Mission.JTTPaths, FindEntity("Siege - JTT5 Path"))
	Mission.JTT1LandingPaths = {}
		table.insert(Mission.JTT1LandingPaths, FindEntity("Siege - JTT1 - Path1"))
		table.insert(Mission.JTT1LandingPaths, FindEntity("Siege - JTT1 - Path2"))
		table.insert(Mission.JTT1LandingPaths, FindEntity("Siege - JTT1 - Path3"))
		table.insert(Mission.JTT1LandingPaths, FindEntity("Siege - JTT1 - Path4"))
	Mission.JTT3LandingPaths = {}
		table.insert(Mission.JTT3LandingPaths, FindEntity("Siege - JTT3 - Path1"))
		table.insert(Mission.JTT3LandingPaths, FindEntity("Siege - JTT3 - Path2"))
		table.insert(Mission.JTT3LandingPaths, FindEntity("Siege - JTT3 - Path3"))
		table.insert(Mission.JTT3LandingPaths, FindEntity("Siege - JTT3 - Path4"))
	Mission.JTT5LandingPaths = {}
		table.insert(Mission.JTT5LandingPaths, FindEntity("Siege - JTT5 - Path1"))
		table.insert(Mission.JTT5LandingPaths, FindEntity("Siege - JTT5 - Path2"))
		table.insert(Mission.JTT5LandingPaths, FindEntity("Siege - JTT5 - Path3"))
		table.insert(Mission.JTT5LandingPaths, FindEntity("Siege - JTT5 - Path4"))

----- resource dolgok -----

	if Mission.Players <= 2 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 2")
		Mission.ResourcePoolBase = 500
		Mission.ResourceUSPool = 500
		Mission.ResourceJapPool = 500
	elseif Mission.Players <= 4 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 4")
		Mission.ResourcePoolBase = 750
		Mission.ResourceUSPool = 750
		Mission.ResourceJapPool = 750
	elseif Mission.Players <= 6 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 6")
		Mission.ResourcePoolBase = 900
		Mission.ResourceUSPool = 900
		Mission.ResourceJapPool = 900
	elseif Mission.Players <= 8 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 8")
		Mission.ResourcePoolBase = 1000
		Mission.ResourceUSPool = 1000
		Mission.ResourceJapPool = 1000
	else
-- RELEASE_LOGOFF  		luaLog(" FAIL!!! unhandled Mission.Players: "..Mission.Players)
		Mission.ResourcePoolBase = 1000
		Mission.ResourceUSPool = 1000
		Mission.ResourceJapPool = 1000
	end
	Mission.ResourceUSPT = 5
	Mission.ResourceUSCoastal = 3
	Mission.ResourceUSAA = 3
	Mission.ResourceUSFortressBig = 150
	Mission.ResourceUSFortressMedium = 80
	Mission.ResourceUSFortressSmall = 40
	Mission.ResourceUSHQ = 2
	Mission.ResourceJapJTT = 50
	Mission.ResourceJapDaihatsu = 1
	Mission.ResourceJapSB = 20
	Mission.ResourcePlayerUnit = 5

	Mission.HQPreviousHPPercentage = 1

---------------------------

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_pri1",
				["Text"] = "mp01.obj_siege_us_p1_text",
				["TextCompleted"] = "mp01.obj_siege_us_p1_comp",
				["TextFailed"] = "mp01.obj_siege_us_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_pri1",
				["Text"] = "mp01.obj_siege_jap_p1_text",
				["TextCompleted"] = "mp01.obj_siege_jap_p1_comp",
				["TextFailed"] = "mp01.obj_siege_jap_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
--[[
			[3] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_pri2",
				["Text"] = "mp01.obj_siege_us_p2_text",
				["TextCompleted"] = "mp01.obj_siege_us_p2_comp",
				["TextFailed"] = "mp01.obj_siege_us_p2_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 600,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_pri2",
				["Text"] = "mp01.obj_siege_jap_p2_text",
				["TextCompleted"] = "mp01.obj_siege_jap_p2_comp",
				["TextFailed"] = "mp01.obj_siege_jap_p2_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 600,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
]]
		},
		["secondary"] =	{
			[1] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_sec1",
				["Text"] = "mp01.obj_siege_jap_s1_text",
				["TextCompleted"] = "mp01.obj_siege_jap_s1_comp",
				["TextFailed"] = "mp01.obj_siege_jap_s1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
--[[
			[3] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_sec2",
				["Text"] = "Destroy at least 30 LSTs!",
				["TextCompleted"] = "Your forces have successfully destroyed 30 LSTs!",
				["TextFailed"] = "Your forces have failed to destroy 30 LSTs!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 200,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_sec2",
				["Text"] = "Destroy at least 30 patrol boats!",
				["TextCompleted"] = "Your forces have destroyed 30 patrol boats!",
				["TextFailed"] = "Your forces have failed to destroy 30 patrol boats!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 200,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
]]
		},
		["hidden"] = {
		}
	}
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	--SetRocketAirGroundTypeDifferent(false)

	--AISetSpawnSceneUnitsWeightMul(0)

	luaInitNewSystems()

    SetThink(this, "luaQAS1Mission_think")
end

function luaQAS1Mission_think(this, msg)
	this.ElapsedTime = math.floor(GameTime())
	this.ThinkCounter = this.ThinkCounter + 1
-- RELEASE_LOGOFF  	luaLog("- Think "..this.ThinkCounter.." started | Elapsed time: "..this.ElapsedTime.."s -")
-- RELEASE_LOGOFF  	luaLog(" Mission.ResourceJapPool: "..tostring(Mission.ResourceJapPool).." | Mission.ResourceUSPool: "..tostring(Mission.ResourceUSPool))

	if luaMessageHandler(this, msg) == "killed" then
		return
	end

	if Mission.Completed or Mission.MissionEnd then
		return
	end

	if Mission.Started then
		luaQAS1CheckingFlags()
		luaQAS1CheckingShips()
		luaQAS1CheckPTsLSTs()
		luaQAS1CheckLandingRange()
		luaQAS1CheckObjUnits()
		luaCheckPlayers()
		luaQAS1HintManager()
		--luaUpdateCounters()

	elseif not Mission.Started then
		luaQAS1StartMission()
		luaSetMultiScoreTable()
	end
end

function luaQAS1StartMission()
-- RELEASE_LOGOFF  	luaLog(" Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()

	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	-- fortress long
	AISetTargetWeight(150, 66, false, 7)
	AISetTargetWeight(151, 66, false, 7)
	-- fortress small
	AISetTargetWeight(150, 63, false, 4)
	AISetTargetWeight(151, 63, false, 4)
	-- fortress right tower
	AISetTargetWeight(150, 89, false, 6)
	AISetTargetWeight(151, 89, false, 6)
	-- coastal gun us
	AISetTargetWeight(150, 460, false, 7)
	AISetTargetWeight(151, 460, false, 7)
	-- heavy aa us
	AISetTargetWeight(150, 462, false, 7)
	AISetTargetWeight(151, 462, false, 7)

	--Countdown("", 0, 1200, "luaQAS1MissionEnd")
	--luaDelay(luaQAS1AddObjectives, 11)
	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2)
	luaObj_AddUnit("primary", 1, Mission.HQ)
	luaObj_AddUnit("primary", 2, Mission.HQ)
	luaObj_Add("secondary", 1)

	for index, unit in pairs (Mission.Fortresses) do
		luaObj_AddUnit("secondary", 1, unit)
		if unit.Class.ID == 66 then
			AISetHintWeight(unit, 7)
		elseif unit.Class.ID == 63 then
			AISetHintWeight(unit, 4)
		elseif unit.Class.ID == 89 then
			AISetHintWeight(unit, 6)
		else
			AISetHintWeight(unit, 7)
		end
	end

--[[
	if Mission.Players <= 2 then
		Mission.LandingShipToDestroy = 10
	elseif Mission.Players == 3 then
		Mission.LandingShipToDestroy = 10
	elseif Mission.Players == 4 then
		Mission.LandingShipToDestroy = 10
	elseif Mission.Players == 5 then
		Mission.LandingShipToDestroy = 11
	elseif Mission.Players == 6 then
		Mission.LandingShipToDestroy = 11
	elseif Mission.Players == 7 then
		Mission.LandingShipToDestroy = 12
	elseif Mission.Players == 8 then
		Mission.LandingShipToDestroy = 12
	end
-- RELEASE_LOGOFF  	luaLog(" KeyUnitCounter set to "..Mission.LandingShipToDestroy)
	Mission.KeyUnitCounter = Mission.LandingShipToDestroy
	--ModifyKeyUnitNumber(Mission.KeyUnitCounter)
]]
--[[
	Mission.S1MarkAllowed = true
	Mission.S3MarkAllowed = true
	Mission.S4MarkAllowed = true
]]

	luaQAS1FirstSpawn()
	luaQAS1SpawnPT1()
	--luaQAS1SpawnPT2() -- OPTIMALIZACIO
	--luaQAS1SpawnPT3() -- OPTIMALIZACIO
	luaQAS1SpawnPT4()
	luaQAS1SpawnLST1()
	--luaQAS1SpawnLST2() -- OPTIMALIZACIO
	--luaQAS1SpawnLST3() -- OPTIMALIZACIO
	luaQAS1SpawnLST4()

	--luaInitCounters(Mission.LandingShipToDestroy)
	Mission.Started = true
end

function luaQAS1FirstSpawn()
-- RELEASE_LOGOFF  	luaLog("  first spawn")
	Mission.Transport1 = GenerateObject(Mission.Transport1TMPL.Name)
	AISetHintWeight(Mission.Transport1, 25)
	NavigatorMoveOnPath(Mission.Transport1, Mission.JTTPaths[1], PATH_FM_SIMPLE, PATH_SM_JOIN)
	NavigatorSetTorpedoEvasion(Mission.Transport1, false)
	NavigatorSetAvoidShipCollision(Mission.Transport1, false)
	NavigatorSetAvoidLandCollision(Mission.Transport1, false)

	Mission.Transport3 = GenerateObject(Mission.Transport3TMPL.Name)
	AISetHintWeight(Mission.Transport3, 25)
	NavigatorMoveOnPath(Mission.Transport3, Mission.JTTPaths[3], PATH_FM_SIMPLE, PATH_SM_JOIN)
	NavigatorSetTorpedoEvasion(Mission.Transport3, false)
	NavigatorSetAvoidShipCollision(Mission.Transport3, false)
	NavigatorSetAvoidLandCollision(Mission.Transport3, false)

	Mission.Transport5 = GenerateObject(Mission.Transport5TMPL.Name)
	AISetHintWeight(Mission.Transport5, 25)
	NavigatorMoveOnPath(Mission.Transport5, Mission.JTTPaths[5], PATH_FM_SIMPLE, PATH_SM_JOIN)
	NavigatorSetTorpedoEvasion(Mission.Transport5, false)
	NavigatorSetAvoidShipCollision(Mission.Transport5, false)
	NavigatorSetAvoidLandCollision(Mission.Transport5, false)
end

function luaQAS1CheckingFlags()
-- RELEASE_LOGOFF  	luaLog(" Checking flags...")
	if Mission.Transport1 ~= nil then
		if not Mission.Transport1.Dead and not Mission.Transport1InPos then
			local pathpoints = FillPathPoints(Mission.JTTPaths[1])
			if luaGetDistance(Mission.Transport1, pathpoints[2]) < 215 then
-- RELEASE_LOGOFF  				luaLog("  TR1 in position")
				NavigatorStop(Mission.Transport1)
				NavigatorEnable(Mission.Transport1, false)
				SetShipMaxSpeed(Mission.Transport1, 0)
				SetShipSpeed(Mission.Transport1, 0)
				Mission.Transport1InPos = true
			end
		elseif Mission.Transport1.Dead and Mission.Transport1InPos then
-- RELEASE_LOGOFF  			luaLog("  TR1 dead")
			Mission.Transport1InPos = false
		end
	end

	if Mission.Transport3 ~= nil then
		if not Mission.Transport3.Dead and not Mission.Transport3InPos then
			local pathpoints = FillPathPoints(Mission.JTTPaths[3])
			if luaGetDistance(Mission.Transport3, pathpoints[2]) < 215 then
-- RELEASE_LOGOFF  				luaLog("  TR3 in position")
				NavigatorStop(Mission.Transport3)
				NavigatorEnable(Mission.Transport3, false)
				SetShipMaxSpeed(Mission.Transport3, 0)
				SetShipSpeed(Mission.Transport3, 0)
				Mission.Transport3InPos = true
			end
		elseif Mission.Transport3.Dead and Mission.Transport3InPos then
-- RELEASE_LOGOFF  			luaLog("  TR3 dead")
			Mission.Transport3InPos = false
		end
	end

	if Mission.Transport5 ~= nil then
		if not Mission.Transport5.Dead and not Mission.Transport5InPos then
			local pathpoints = FillPathPoints(Mission.JTTPaths[5])
			if luaGetDistance(Mission.Transport5, pathpoints[2]) < 215 then
-- RELEASE_LOGOFF  				luaLog("  TR5 in position")
				NavigatorStop(Mission.Transport5)
				NavigatorEnable(Mission.Transport5, false)
				SetShipMaxSpeed(Mission.Transport5, 0)
				SetShipSpeed(Mission.Transport5, 0)
				Mission.Transport5InPos = true
			end
		elseif Mission.Transport5.Dead and Mission.Transport5InPos then
-- RELEASE_LOGOFF  			luaLog("  TR5 dead")
			Mission.Transport5InPos = false
		end
	end
end

function luaQAS1AddObjectives()
-- RELEASE_LOGOFF  	luaLog(" Adding objectives...")
	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2)
	luaObj_AddUnit("primary", 1, Mission.HQ)
	luaObj_AddUnit("primary", 2, Mission.HQ)
	--luaObj_Add("primary", 1, Mission.HQ, false)
	--luaObj_Add("primary", 2, Mission.HQ, false)
	--luaObj_Add("primary", 3)
	--luaObj_Add("primary", 4)
	--luaObj_Add("secondary", 1)
	luaObj_Add("secondary", 1)

	SetSkillLevel(Mission.HQ, SKILL_SPNORMAL)

	for index, unit in pairs (Mission.Fortresses) do
		luaObj_AddUnit("secondary", 1, unit)
		--AISetHintWeight(unit, 100)
		SetSkillLevel(unit, SKILL_SPNORMAL)
	end

	if not Mission.Transport1.Dead and not Mission.Transport1.marked then
		--luaObj_AddUnit("secondary", 1, Mission.Transport1)
		--luaObj_AddUnit("primary", 3, Mission.Transport1)
		--luaObj_AddUnit("primary", 4, Mission.Transport1)
		Mission.Transport1.marked = true
	end
	if not Mission.Transport3.Dead and not Mission.Transport3.marked then
		--luaObj_AddUnit("secondary", 1, Mission.Transport3)
		--luaObj_AddUnit("primary", 3, Mission.Transport3)
		--luaObj_AddUnit("primary", 4, Mission.Transport3)
		Mission.Transport3.marked = true
	end
	if not Mission.Transport5.Dead and not Mission.Transport5.marked then
		--luaObj_AddUnit("secondary", 1, Mission.Transport5)
		--luaObj_AddUnit("primary", 3, Mission.Transport5)
		--luaObj_AddUnit("primary", 4, Mission.Transport5)
		Mission.Transport3.marked = true
	end

	if not Mission.LST1.Dead and not Mission.LST1.marked then
		--luaObj_AddUnit("secondary", 1, Mission.LST1)
		Mission.LST1.marked = true
	end
--[[
	if not Mission.LST2.Dead and not Mission.LST2.marked then
		--luaObj_AddUnit("secondary", 1, Mission.LST2)
		Mission.LST2.marked = true
	end
	if not Mission.LST3.Dead and not Mission.LST3.marked then
		--luaObj_AddUnit("secondary", 1, Mission.LST3)
		Mission.LST3.marked = true
	end
]]
	if not Mission.LST4.Dead and not Mission.LST4.marked then
		--luaObj_AddUnit("secondary", 1, Mission.LST4)
		Mission.LST4.marked = true
	end
end

function luaQAS1CheckingShips()
-- RELEASE_LOGOFF  	luaLog(" Checking landing ships...")
	if not Mission.Transport1.Dead and Mission.Transport1InPos and Mission.Transport1SendingReady then
-- RELEASE_LOGOFF  		luaLog("  TR1 sending boats")
		Mission.Transport1SendingReady = false
		for index, value in pairs(Mission.Daihatsus1) do
			local unit = GenerateObject(Mission.Daihatsus1[index].Name)
			AISetHintWeight(unit, 0.3)
			unit.ChosenPath = index
			NavigatorMoveOnPath(unit, Mission.JTT1LandingPaths[index])
			NavigatorSetTorpedoEvasion(unit, false)
			NavigatorSetAvoidShipCollision(unit, false)
			NavigatorSetAvoidLandCollision(unit, false)
			SetShipSpeed(unit, GetShipMaxSpeed(unit)*0.60)
			table.insert(Mission.LandingBoats1, unit)
--[[
			if luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary", 1) == nil then
				luaObj_AddUnit("secondary", 1, unit)
			end
]]
		end
	elseif Mission.Transport1.Dead and not Mission.TR1SpawnSet then
-- RELEASE_LOGOFF  		luaLog("  TR1 down, replacement needed")
		luaResourcePoolReducer("JTT")
		Mission.TR1SpawnSet = true
		luaDelay(luaQAS1SpawnTR1, 30)
	end

	if not Mission.Transport3.Dead and Mission.Transport3InPos and Mission.Transport3SendingReady then
-- RELEASE_LOGOFF  		luaLog("  TR3 sending boats")
		Mission.Transport3SendingReady = false
		for index, value in pairs(Mission.Daihatsus3) do
			local unit = GenerateObject(Mission.Daihatsus3[index].Name)
			AISetHintWeight(unit, 0.3)
			unit.ChosenPath = index
			NavigatorMoveOnPath(unit, Mission.JTT3LandingPaths[index])
			NavigatorSetTorpedoEvasion(unit, false)
			NavigatorSetAvoidShipCollision(unit, false)
			NavigatorSetAvoidLandCollision(unit, false)
			SetShipSpeed(unit, GetShipMaxSpeed(unit)*0.60)
			table.insert(Mission.LandingBoats3, unit)
--[[
			if luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary", 1) == nil then
				luaObj_AddUnit("secondary", 1, unit)
			end
]]
		end
	elseif Mission.Transport3.Dead and not Mission.TR3SpawnSet then
-- RELEASE_LOGOFF  		luaLog("  TR3 down, replacement needed")
		luaResourcePoolReducer("JTT")
		Mission.TR3SpawnSet = true
		luaDelay(luaQAS1SpawnTR3, 31)
	end

	if not Mission.Transport5.Dead and Mission.Transport5InPos and Mission.Transport5SendingReady then
-- RELEASE_LOGOFF  		luaLog("  TR5 sending boats")
		Mission.Transport5SendingReady = false
		for index, value in pairs(Mission.Daihatsus5) do
			local unit = GenerateObject(Mission.Daihatsus5[index].Name)
			AISetHintWeight(unit, 0.3)
			unit.ChosenPath = index
			NavigatorMoveOnPath(unit, Mission.JTT5LandingPaths[index])
			NavigatorSetTorpedoEvasion(unit, false)
			NavigatorSetAvoidShipCollision(unit, false)
			NavigatorSetAvoidLandCollision(unit, false)
			SetShipSpeed(unit, GetShipMaxSpeed(unit)*0.60)
			table.insert(Mission.LandingBoats5, unit)
--[[
			if luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary", 1) == nil then
				luaObj_AddUnit("secondary", 1, unit)
			end
]]
		end
	elseif Mission.Transport5.Dead and not Mission.TR5SpawnSet then
-- RELEASE_LOGOFF  		luaLog("  TR5 down, replacement needed")
		luaResourcePoolReducer("JTT")
		Mission.TR5SpawnSet = true
		luaDelay(luaQAS1SpawnTR5, 32)
	end
end

function luaQAS1SpawnTR1()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog("  -> SPAWNING TR1 <-")
		Mission.Transport1 = GenerateObject(Mission.Transport1TMPL.Name)
		if Mission.Started then
			MissionNarrativeParty(0, "mp01.nar_siege_us_tr_arrive")
			MissionNarrativeParty(1, "mp01.nar_siege_jap_tr_arrive")
		end
		NavigatorSetTorpedoEvasion(Mission.Transport1, false)
		NavigatorSetAvoidShipCollision(Mission.Transport1, false)
		NavigatorSetAvoidLandCollision(Mission.Transport1, false)
		luaQAS1NewTransportOrders(Mission.Transport1, 1)
		Mission.TR1SpawnSet = false
		--luaObj_AddUnit("secondary", 1, Mission.Transport1)
		--luaObj_AddUnit("primary", 3, Mission.Transport1)
		--luaObj_AddUnit("primary", 4, Mission.Transport1)
	end
end

function luaQAS1SpawnTR3()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog("  -> SPAWNING TR3 <-")
		Mission.Transport3 = GenerateObject(Mission.Transport3TMPL.Name)
		if Mission.Started then
			MissionNarrativeParty(0, "mp01.nar_siege_us_tr_arrive")
			MissionNarrativeParty(1, "mp01.nar_siege_jap_tr_arrive")
		end
		NavigatorSetTorpedoEvasion(Mission.Transport3, false)
		NavigatorSetAvoidShipCollision(Mission.Transport3, false)
		NavigatorSetAvoidLandCollision(Mission.Transport3, false)
		luaQAS1NewTransportOrders(Mission.Transport3, 3)
		Mission.TR3SpawnSet = false
		--luaObj_AddUnit("secondary", 1, Mission.Transport3)
		--luaObj_AddUnit("primary", 3, Mission.Transport3)
		--luaObj_AddUnit("primary", 4, Mission.Transport3)
	end
end

function luaQAS1SpawnTR5()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog("  -> SPAWNING TR5 <-")
		Mission.Transport5 = GenerateObject(Mission.Transport5TMPL.Name)
		if Mission.Started then
			MissionNarrativeParty(0, "mp01.nar_siege_us_tr_arrive")
			MissionNarrativeParty(1, "mp01.nar_siege_jap_tr_arrive")
		end
		NavigatorSetTorpedoEvasion(Mission.Transport5, false)
		NavigatorSetAvoidShipCollision(Mission.Transport5, false)
		NavigatorSetAvoidLandCollision(Mission.Transport5, false)
		luaQAS1NewTransportOrders(Mission.Transport5, 5)
		Mission.TR5SpawnSet = false
		--luaObj_AddUnit("secondary", 1, Mission.Transport5)
		--luaObj_AddUnit("primary", 3, Mission.Transport5)
		--luaObj_AddUnit("primary", 4, Mission.Transport5)
	end
end

function luaQAS1NewTransportOrders(unit, pathindex)
-- RELEASE_LOGOFF  	luaLog("-- new unit: "..unit.Name)
-- RELEASE_LOGOFF  	luaLog("-- pathindex: "..pathindex)
	AISetHintWeight(unit, 25)
	NavigatorMoveOnPath(unit, Mission.JTTPaths[pathindex], PATH_FM_SIMPLE, PATH_SM_JOIN)
	--Mission.LandingShipSpawned = Mission.LandingShipSpawned + 1
end

function luaQAS1CheckLandingRange()
-- RELEASE_LOGOFF  	luaLog(" Checking landing range...")
	for index, unit in pairs (Mission.LandingBoats1) do
		if unit.Dead then
			luaResourcePoolReducer("daihatsu")
			table.remove(Mission.LandingBoats1, index)
		end
	end
	if table.getn(Mission.LandingBoats1) ~= 0 then
		for index, unit in pairs(Mission.LandingBoats1) do
			if unit.Dead then
				luaResourcePoolReducer("daihatsu")
				table.remove(Mission.LandingBoats1, index)
			else
				local landingpath = Mission.JTT1LandingPaths[unit.ChosenPath]
				local landingpoints = FillPathPoints(landingpath)
				local lastpoint = table.getn(landingpoints)
				if luaGetDistance(unit, landingpoints[lastpoint]) < 150 then
-- RELEASE_LOGOFF  					luaLog("  "..unit.Name.." is in the landing zone, giving order to land")
					local err = StartLanding2(unit)
					table.remove(Mission.LandingBoats1, index)
					table.insert(Mission.LandingBoatsCapturing, unit)
	--[[
					local errTbl = {}
					errTbl["0"] = "Big landing ship elindult partraszállni"
					errTbl["1"] = "1 kislandig elindult"
					errTbl["2"] = "2 kislandig elindult"
					errTbl["3"] = "3 kislandig elindult"
					errTbl["4"] = "4 kislandig elindult"
					errTbl["5"] = "5 kislandig elindult"
					errTbl["-1"] = "Nincs beállítva, hogy milyen landingship-et szállít"
					errTbl["-2"] = "Nincs beállítva, hogy mennyi landingship-et szállít"
					errTbl["-3"] = "Nemrég indított már, és még cooldown van"
					errTbl["-4"] = "A legközelebbi ellenséges command buildingnek nincs szabad landing pointja"
					errTbl["-5"] = "Nincs command building a pályán"
					errTbl["-6"] = "Csak saját command building van a pályán"
					errTbl["-7"] = "Túl messze van a legközelebbi ellenséges command building"
-- RELEASE_LOGOFF  					luaLog(errTbl[tostring(err)])
	]]
				end
			end
		end
	elseif table.getn(Mission.LandingBoats1) == 0 and not Mission.Transport1SendingReady then
-- RELEASE_LOGOFF  		luaLog("  LandingBoats1 is empty")
		Mission.Transport1SendingReady = true
	end
--[[
	for index, unit in pairs (Mission.LandingBoats3) do
		if unit.Dead then
			luaResourcePoolReducer("daihatsu")
			table.remove(Mission.LandingBoats3, index)
		end
	end
]]
	if table.getn(Mission.LandingBoats3) ~= 0 then
		for index, unit in pairs(Mission.LandingBoats3) do
			if unit.Dead then
				luaResourcePoolReducer("daihatsu")
				table.remove(Mission.LandingBoats3, index)
			else
				local landingpath = Mission.JTT3LandingPaths[unit.ChosenPath]
				local landingpoints = FillPathPoints(landingpath)
				local lastpoint = table.getn(landingpoints)
				if luaGetDistance(unit, landingpoints[lastpoint]) < 150 then
-- RELEASE_LOGOFF  					luaLog("  "..unit.Name.." is in the landing zone, giving order to land")
					local err = StartLanding2(unit)
					table.remove(Mission.LandingBoats3, index)
					table.insert(Mission.LandingBoatsCapturing, unit)
				end
			end
		end
	elseif table.getn(Mission.LandingBoats3) == 0 and not Mission.Transport3SendingReady then
-- RELEASE_LOGOFF  		luaLog("  LandingBoats3 is empty")
		Mission.Transport3SendingReady = true
	end

--[[
	for index, unit in pairs (Mission.LandingBoats5) do
		if unit.Dead then
			luaResourcePoolReducer("daihatsu")
			table.remove(Mission.LandingBoats5, index)
		end
	end
]]
	if table.getn(Mission.LandingBoats5) ~= 0 then
		for index, unit in pairs(Mission.LandingBoats5) do
			if unit.Dead then
				luaResourcePoolReducer("daihatsu")
				table.remove(Mission.LandingBoats5, index)
			else
				local landingpath = Mission.JTT5LandingPaths[unit.ChosenPath]
				local landingpoints = FillPathPoints(landingpath)
				local lastpoint = table.getn(landingpoints)
				if luaGetDistance(unit, landingpoints[lastpoint]) < 150 then
-- RELEASE_LOGOFF  					luaLog("  "..unit.Name.." is in the landing zone, giving order to land")
					local err = StartLanding2(unit)
					table.remove(Mission.LandingBoats5, index)
					table.insert(Mission.LandingBoatsCapturing, unit)
				end
			end
		end
	elseif table.getn(Mission.LandingBoats5) == 0 and not Mission.Transport5SendingReady then
-- RELEASE_LOGOFF  		luaLog("  LandingBoats5 is empty")
		Mission.Transport5SendingReady = true
	end

	Mission.LSTs = luaRemoveDeadsFromTable(Mission.LSTs)
	if table.getn(Mission.LSTs) ~= 0 then
		for index, unit in pairs(Mission.LSTs) do
--			for index2, value2 in pairs(Mission.JapCapturePoints) do
				if luaGetDistance(unit, Mission.JapCapturePoints[unit.ChosenPath]) < 300 then
-- RELEASE_LOGOFF  					luaLog("  "..unit.Name.." reached the capture point, giving order to land")
					local err = StartLanding2(unit)
--[[
					local errTbl = {}
					errTbl["0"] = "Big landing ship elindult partraszállni"
					errTbl["1"] = "1 kislandig elindult"
					errTbl["2"] = "2 kislandig elindult"
					errTbl["3"] = "3 kislandig elindult"
					errTbl["4"] = "4 kislandig elindult"
					errTbl["5"] = "5 kislandig elindult"
					errTbl["-1"] = "Nincs beállítva, hogy milyen landingship-et szállít"
					errTbl["-2"] = "Nincs beállítva, hogy mennyi landingship-et szállít"
					errTbl["-3"] = "Nemrég indított már, és még cooldown van"
					errTbl["-4"] = "A legközelebbi ellenséges command buildingnek nincs szabad landing pointja"
					errTbl["-5"] = "Nincs command building a pályán"
					errTbl["-6"] = "Csak saját command building van a pályán"
					errTbl["-7"] = "Túl messze van a legközelebbi ellenséges command building"
-- RELEASE_LOGOFF  					luaLog(errTbl[tostring(err)])
]]
					table.remove(Mission.LSTs, index)
					table.insert(Mission.LandingBoatsCapturing, unit)
				end

--			end
		end
	end
end

function luaQAS1CheckObjUnits()
-- RELEASE_LOGOFF  	luaLog(" Checking objective units...")
	for index, unit in pairs (Mission.Fortresses) do
		if unit.Dead then
			if unit.Class.ID == 460 then
-- RELEASE_LOGOFF  				luaLog("  a coastal gun is down, reducing US pool")
				luaResourcePoolReducer("coastal")
			elseif unit.Class.ID == 66 then
-- RELEASE_LOGOFF  				luaLog("  a big fort is down, reducing US pool")
				luaResourcePoolReducer("bigfort")
			elseif unit.Class.ID == 89 then
-- RELEASE_LOGOFF  				luaLog("  a medium fort is down, reducing US pool")
				luaResourcePoolReducer("mediumfort")
			elseif unit.Class.ID == 63 then
-- RELEASE_LOGOFF  				luaLog("  a small fort is down, reducing US pool")
				luaResourcePoolReducer("smallfort")
			elseif unit.Class.ID == 462 then
-- RELEASE_LOGOFF  				luaLog("  a heavy AA is down, reducing US pool")
				luaResourcePoolReducer("AA")
			else
-- RELEASE_LOGOFF  				luaLog("  FAIL!!! unhandled ID found: "..unit.Class.ID)
			end
			table.remove(Mission.Fortresses, index)
		end
	end
	if table.getn(Mission.Fortresses) == 0 and not Mission.S2Done then
-- RELEASE_LOGOFF  		luaLog("  fortesses down, secondary 2 completed")
		Mission.S2Done = true
		luaObj_Completed("secondary", 1)
	end

--[[
	if Mission.TransportDown >= 9 and not Mission.S1Done then
-- RELEASE_LOGOFF  		luaLog("  9 transports down, secondary 1 completed")
		Mission.S1Done = true
		Mission.S1MarkAllowed = false
		if not Mission.Transport1.Dead and Mission.Transport1.marked then
			luaObj_RemoveUnit("secondary", 1, Mission.Transport1)
		end
		if not Mission.Transport3.Dead and Mission.Transport3.marked then
			luaObj_RemoveUnit("secondary", 1, Mission.Transport3)
		end
		if not Mission.Transport5.Dead and Mission.Transport5.marked then
			luaObj_RemoveUnit("secondary", 1, Mission.Transport5)
		end
		luaObj_Completed("secondary", 1)
	end

	Mission.Fortresses = luaRemoveDeadsFromTable(Mission.Fortresses)
	if table.getn(Mission.Fortresses) == 0 and not Mission.S2Done then
-- RELEASE_LOGOFF  		luaLog("  fortesses down, secondary 2 completed")
		Mission.S2Done = true
		luaObj_Completed("secondary", 2)
	end

	if Mission.LSTDown >= 30 and not Mission.S3Done then
-- RELEASE_LOGOFF  		luaLog("  30 LST down, secondary 3 completed")
		Mission.S3Done = true
		Mission.S3MarkAllowed = false
		if not Mission.LST1.Dead and Mission.LST1.marked then
			luaObj_RemoveUnit("secondary", 3, Mission.LST1)
		end
		if not Mission.LST2.Dead and Mission.LST2.marked then
			luaObj_RemoveUnit("secondary", 3, Mission.LST2)
		end
		if not Mission.LST3.Dead and Mission.LST3.marked then
			luaObj_RemoveUnit("secondary", 3, Mission.LST3)
		end
		if not Mission.LST4.Dead and Mission.LST4.marked then
			luaObj_RemoveUnit("secondary", 3, Mission.LST4)
		end
		luaObj_Completed("secondary", 3)
	end

	if Mission.PTDown >= 30 and not Mission.S4Done then
-- RELEASE_LOGOFF  		luaLog("  30 LST down, secondary 4 completed")
		Mission.S4Done = true
		Mission.S4MarkAllowed = false
		if not Mission.PT1.Dead and Mission.PT1.marked then
			luaObj_RemoveUnit("secondary", 4, Mission.PT1)
		end
		if not Mission.PT2.Dead and Mission.PT2.marked then
			luaObj_RemoveUnit("secondary", 4, Mission.PT2)
		end
		if not Mission.PT3.Dead and Mission.PT3.marked then
			luaObj_RemoveUnit("secondary", 4, Mission.PT3)
		end
		if not Mission.PT4.Dead and Mission.PT4.marked then
			luaObj_RemoveUnit("secondary", 4, Mission.PT4)
		end
		luaObj_Completed("secondary", 4)
	end

	if Mission.KeyUnitCounter == 0 and not Mission.ObjectivesSet then
		Mission.ObjectivesSet = true
		luaObj_Completed("primary", 3)
		luaObj_Failed("primary", 4)
	end
]]

	local threshold = GetHpPercentage(Mission.HQ) + 0.01
	if threshold < Mission.HQPreviousHPPercentage then
		local difference = Mission.HQPreviousHPPercentage - GetHpPercentage(Mission.HQ)
		local percentage = difference * 100
		local by = luaRound(percentage)
		luaResourcePoolReducer("HQ", by)
		Mission.HQPreviousHPPercentage = GetHpPercentage(Mission.HQ)
	end

	if not Mission.MissionEndCalled and Mission.HQ.Party ~= PARTY_ALLIED then
-- RELEASE_LOGOFF  		luaLog("  HQ lost, calling MissionEnd")
		Mission.MissionEndCalled = true
		--CountdownCancel()
		luaQAS1MissionEnd()
	end
--[[
	if not Mission.MissionEndCalled and Mission.KeyUnitCounter == 0 then
-- RELEASE_LOGOFF  		luaLog("  no more transports are allowed")
		Mission.LandingBoatsCapturing = luaRemoveDeadsFromTable(Mission.LandingBoatsCapturing)
		local boats1 = {}
		local boats2 = {}
		local boats3 = {}
		local boats4 = {}
		local boats5 = {}
		local LSTs = {}
		local boats1 = luaRemoveDeadsFromTable(Mission.LandingBoats1)
		local boats2 = luaRemoveDeadsFromTable(Mission.LandingBoats2)
		local boats3 = luaRemoveDeadsFromTable(Mission.LandingBoats3)
		local boats4 = luaRemoveDeadsFromTable(Mission.LandingBoats4)
		local boats5 = luaRemoveDeadsFromTable(Mission.LandingBoats5)
		local LSTs = luaRemoveDeadsFromTable(Mission.LSTs)
		if table.getn(boats1) == 0 and table.getn(boats2) == 0 and table.getn(boats3) == 0 and table.getn(boats4) == 0 and table.getn(boats5) == 0 and table.getn(LSTs) == 0 and table.getn(Mission.LandingBoatsCapturing) == 0 then
-- RELEASE_LOGOFF  			luaLog("   calling MissionEnd")
			Mission.MissionEndCalled = true
			Mission.JTTsDown = true
			--CountdownCancel()
			luaQAS1MissionEnd()
		else
			if not Mission.LastWaveAnnounced then
				MissionNarrativeParty(0, "mp01.nar_siege_us_remaining")
				MissionNarrativeParty(1, "mp01.nar_siege_jap_remaining")
				Mission.LastWaveAnnounced = true
			end
		end
	end
]]
end

function luaQAS1CheckPTsLSTs()
-- RELEASE_LOGOFF  	luaLog(" Checking PTsLSTs...")
	local targettable = {}
	if Mission.Transport1 ~= nil then
		table.insert(targettable, Mission.Transport1)
	end
	if Mission.Transport3 ~= nil then
		table.insert(targettable, Mission.Transport3)
	end
	if Mission.Transport5 ~= nil then
		table.insert(targettable, Mission.Transport5)
	end
	for index, unit in pairs (Mission.LSTs) do
		table.insert(targettable, unit)
	end
	targettable = luaRemoveDeadsFromTable(targettable)

	if Mission.PT1 ~= nil then
		if not Mission.PT1.Dead then
			local currenttarget = luaGetScriptTarget(Mission.PT1)
			if table.getn(targettable) ~= 0 then
				if currenttarget == nil then
					local randomtarget = luaPickRnd(targettable)
					luaQAS1PTAttack(Mission.PT1, randomtarget)
					Mission.PT1Patrolling = false
				elseif currenttarget.Dead then
					local randomtarget = luaPickRnd(targettable)
					luaQAS1PTAttack(Mission.PT1, randomtarget)
					Mission.PT1Patrolling = false
				end
			elseif not Mission.PT1Patrolling then
-- RELEASE_LOGOFF  				luaLog("  sending PT1 to patrol")
				Mission.PT1Patrolling = true
				NavigatorMoveOnPath(Mission.PT1, Mission.PTPaths[1], PATH_FM_CIRCLE, PATH_SM_JOIN)
				NavigatorSetAvoidLandCollision(Mission.PT1, false)
				NavigatorSetTorpedoEvasion(Mission.PT1, false)
			end
		elseif Mission.PT1.Dead and not Mission.PT1SpawnSet then
-- RELEASE_LOGOFF  			luaLog("   PT1 down, replacement needed")
			--Mission.PTDown = Mission.PTDown + 1
			luaResourcePoolReducer("PT")
			Mission.PT1SpawnSet = true
			luaDelay(luaQAS1SpawnPT1, 40)
		end
	end

	if Mission.PT2 ~= nil then
		if not Mission.PT2.Dead then
			local currenttarget = luaGetScriptTarget(Mission.PT2)
			if table.getn(targettable) ~= 0 then
				if currenttarget == nil then
					local randomtarget = luaPickRnd(targettable)
					luaQAS1PTAttack(Mission.PT2, randomtarget)
					Mission.PT2Patrolling = false
				elseif currenttarget.Dead then
					local randomtarget = luaPickRnd(targettable)
					luaQAS1PTAttack(Mission.PT2, randomtarget)
					Mission.PT2Patrolling = false
				end
			elseif not Mission.PT2Patrolling then
-- RELEASE_LOGOFF  				luaLog("  sending PT2 to patrol")
				Mission.PT2Patrolling = true
				NavigatorMoveOnPath(Mission.PT2, Mission.PTPaths[2], PATH_FM_CIRCLE, PATH_SM_JOIN)
				NavigatorSetAvoidLandCollision(Mission.PT2, false)
				NavigatorSetTorpedoEvasion(Mission.PT2, false)
			end
		elseif Mission.PT2.Dead and not Mission.PT2SpawnSet then
-- RELEASE_LOGOFF  			luaLog("   PT2 down, replacement needed")
			--Mission.PTDown = Mission.PTDown + 1
			luaResourcePoolReducer("PT")
			Mission.PT2SpawnSet = true
			luaDelay(luaQAS1SpawnPT2, 42)
		end
	end

	if Mission.PT3 ~= nil then
		if not Mission.PT3.Dead then
			local currenttarget = luaGetScriptTarget(Mission.PT3)
			if table.getn(targettable) ~= 0 then
				if currenttarget == nil then
					local randomtarget = luaPickRnd(targettable)
					luaQAS1PTAttack(Mission.PT3, randomtarget)
					Mission.PT3Patrolling = false
				elseif currenttarget.Dead then
					local randomtarget = luaPickRnd(targettable)
					luaQAS1PTAttack(Mission.PT3, randomtarget)
					Mission.PT3Patrolling = false
				end
			elseif not Mission.PT3Patrolling then
-- RELEASE_LOGOFF  				luaLog("  sending PT3 to patrol")
				Mission.PT3Patrolling = true
				NavigatorMoveOnPath(Mission.PT3, Mission.PTPaths[3], PATH_FM_CIRCLE, PATH_SM_JOIN)
				NavigatorSetAvoidLandCollision(Mission.PT3, false)
				NavigatorSetTorpedoEvasion(Mission.PT3, false)
			end
		elseif Mission.PT3.Dead and not Mission.PT3SpawnSet then
-- RELEASE_LOGOFF  			luaLog("   PT3 down, replacement needed")
			--Mission.PTDown = Mission.PTDown + 1
			luaResourcePoolReducer("PT")
			Mission.PT3SpawnSet = true
			luaDelay(luaQAS1SpawnPT3, 44)
		end
	end

	if Mission.PT4 ~= nil then
		if not Mission.PT4.Dead then
			local currenttarget = luaGetScriptTarget(Mission.PT4)
			if table.getn(targettable) ~= 0 then
				if currenttarget == nil then
					local randomtarget = luaPickRnd(targettable)
					luaQAS1PTAttack(Mission.PT4, randomtarget)
					Mission.PT4Patrolling = false
				elseif currenttarget.Dead then
					local randomtarget = luaPickRnd(targettable)
					luaQAS1PTAttack(Mission.PT4, randomtarget)
					Mission.PT4Patrolling = false
				end
			elseif not Mission.PT4Patrolling then
-- RELEASE_LOGOFF  				luaLog("  sending PT4 to patrol")
				Mission.PT4Patrolling = true
				NavigatorMoveOnPath(Mission.PT4, Mission.PTPaths[4], PATH_FM_CIRCLE, PATH_SM_JOIN)
				NavigatorSetAvoidLandCollision(Mission.PT4, false)
				NavigatorSetTorpedoEvasion(Mission.PT4, false)
			end
		elseif Mission.PT4.Dead and not Mission.PT4SpawnSet then
-- RELEASE_LOGOFF  			luaLog("   PT4 down, replacement needed")
			--Mission.PTDown = Mission.PTDown + 1
			luaResourcePoolReducer("PT")
			Mission.PT4SpawnSet = true
			luaDelay(luaQAS1SpawnPT4, 46)
		end
	end

	if Mission.LST1 ~= nil then
		if Mission.LST1.Dead and not Mission.LST1SpawnSet then
-- RELEASE_LOGOFF  			luaLog("   LST1 down, replacement needed")
			--Mission.LSTDown = Mission.LSTDown + 1
			luaResourcePoolReducer("SB")
			Mission.LST1SpawnSet = true
			luaDelay(luaQAS1SpawnLST1, 30.8)
		end
	end

	if Mission.LST2 ~= nil then
		if Mission.LST2.Dead and not Mission.LST2SpawnSet then
-- RELEASE_LOGOFF  			luaLog("   LST2 down, replacement needed")
			--Mission.LSTDown = Mission.LSTDown + 1
			luaResourcePoolReducer("SB")
			Mission.LST2SpawnSet = true
			luaDelay(luaQAS1SpawnLST2, 30.9)
		end
	end

	if Mission.LST3 ~= nil then
		if Mission.LST3.Dead and not Mission.LST3SpawnSet then
-- RELEASE_LOGOFF  			luaLog("   LST3 down, replacement needed")
			--Mission.LSTDown = Mission.LSTDown + 1
			luaResourcePoolReducer("SB")
			Mission.LST3SpawnSet = true
			luaDelay(luaQAS1SpawnLST3, 31)
		end
	end

	if Mission.LST4 ~= nil then
		if Mission.LST4.Dead and not Mission.LST4SpawnSet then
-- RELEASE_LOGOFF  			luaLog("   LST4 down, replacement needed")
			--Mission.LSTDown = Mission.LSTDown + 1
			luaResourcePoolReducer("SB")
			Mission.LST4SpawnSet = true
			luaDelay(luaQAS1SpawnLST4, 31.1)
		end
	end
end

function luaQAS1PTAttack(unit, target)
	luaSetScriptTarget(unit, target)
	NavigatorAttackMove(unit, target, {})
end

function luaQAS1SpawnPT1()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog("  -> SPAWNING PT1 <-")
		--luaLog(Mission.PT1)
		Mission.PT1 = GenerateObject(Mission.PTs[1].Name)
		if Mission.Started then
			MissionNarrativeParty(0, "mp01.nar_siege_us_pt_arrive")
			MissionNarrativeParty(1, "mp01.nar_siege_jap_pt_arrive")
		end
		AISetHintWeight(Mission.PT1, 1)
		if Mission.PT1 ~= nil then
			--luaLog(Mission.PT1)
			if not Mission.PT1.Dead then
				NavigatorMoveOnPath(Mission.PT1, Mission.PTPaths[1], PATH_FM_CIRCLE, PATH_SM_JOIN)
				TorpedoEnable(Mission.PT1, true)
			else
-- RELEASE_LOGOFF  				luaLog("   spawning failed, previous PT1 is still dead!")
			end
		else
-- RELEASE_LOGOFF  			luaLog("   spawning failed, PT1 is nil or function!")
-- RELEASE_LOGOFF  			luaLog(tostring(Mission.PT1))
		end
		Mission.PT1SpawnSet = false
	end
end

function luaQAS1SpawnPT2()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog("  -> SPAWNING PT2 <-")
		--luaLog(Mission.PT2)
		Mission.PT2 = GenerateObject(Mission.PTs[2].Name)
		if Mission.Started then
			MissionNarrativeParty(0, "mp01.nar_siege_us_pt_arrive")
			MissionNarrativeParty(1, "mp01.nar_siege_jap_pt_arrive")
		end
		AISetHintWeight(Mission.PT2, 1)
		if Mission.PT2 ~= nil then
			--luaLog(Mission.PT2)
			if not Mission.PT2.Dead then
				NavigatorMoveOnPath(Mission.PT2, Mission.PTPaths[2], PATH_FM_CIRCLE, PATH_SM_JOIN)
				TorpedoEnable(Mission.PT2, true)
			else
-- RELEASE_LOGOFF  				luaLog("   spawning failed, previous PT2 is still dead!")
			end
		else
-- RELEASE_LOGOFF  			luaLog("   spawning failed, PT2 is nil or function!")
-- RELEASE_LOGOFF  			luaLog(tostring(Mission.PT2))
		end
		Mission.PT2SpawnSet = false
	end
end

function luaQAS1SpawnPT3()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog("  -> SPAWNING PT3 <-")
		--luaLog(Mission.PT3)
		Mission.PT3 = GenerateObject(Mission.PTs[3].Name)
		if Mission.Started then
			MissionNarrativeParty(0, "mp01.nar_siege_us_pt_arrive")
			MissionNarrativeParty(1, "mp01.nar_siege_jap_pt_arrive")
		end
		AISetHintWeight(Mission.PT3, 1)
		if Mission.PT3 ~= nil then
			--luaLog(Mission.PT3)
			if not Mission.PT3.Dead then
				NavigatorMoveOnPath(Mission.PT3, Mission.PTPaths[3], PATH_FM_CIRCLE, PATH_SM_JOIN)
				TorpedoEnable(Mission.PT3, true)
			else
-- RELEASE_LOGOFF  				luaLog("   spawning failed, previous PT3 is still dead!")
			end
		else
-- RELEASE_LOGOFF  			luaLog("   spawning failed, PT3 is nil or function!")
-- RELEASE_LOGOFF  			luaLog(tostring(Mission.PT3))
		end
		Mission.PT3SpawnSet = false
	end
end

function luaQAS1SpawnPT4()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog("  -> SPAWNING PT4 <-")
		--luaLog(Mission.PT4)
		Mission.PT4 = GenerateObject(Mission.PTs[4].Name)
		if Mission.Started then
			MissionNarrativeParty(0, "mp01.nar_siege_us_pt_arrive")
			MissionNarrativeParty(1, "mp01.nar_siege_jap_pt_arrive")
		end
		AISetHintWeight(Mission.PT4, 1)
		if Mission.PT4 ~= nil then
			--luaLog(Mission.PT4)
			if not Mission.PT4.Dead then
				NavigatorMoveOnPath(Mission.PT4, Mission.PTPaths[4], PATH_FM_CIRCLE, PATH_SM_JOIN)
				TorpedoEnable(Mission.PT4, true)
			else
-- RELEASE_LOGOFF  				luaLog("   spawning failed, previous PT4 is still dead!")
			end
		else
-- RELEASE_LOGOFF  			luaLog("   spawning failed, PT4 is nil! or function!")
-- RELEASE_LOGOFF  			luaLog(tostring(Mission.PT4))
		end
		Mission.PT4SpawnSet = false
	end
end

function luaQAS1SpawnLST1()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog("  -> SPAWNING LST1 <-")
		Mission.LST1 = GenerateObject(Mission.LST1TMPL.Name)
		if Mission.Started then
			MissionNarrativeParty(0, "mp01.nar_siege_us_lst_arrive")
			MissionNarrativeParty(1, "mp01.nar_siege_jap_lst_arrive")
		end
		AISetHintWeight(Mission.LST1, 8.2)
		SetSkillLevel(Mission.LST1, SKILL_SPVETERAN)
		NavigatorSetTorpedoEvasion(Mission.LST1, false)
		NavigatorSetAvoidShipCollision(Mission.LST1, false)
		NavigatorSetAvoidLandCollision(Mission.LST1, false)
--[[
		if luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary", 1) == nil then
			luaObj_AddUnit("secondary", 1, Mission.LST1)
		end
]]
		if Mission.LST1 ~= nil then
			--luaLog(Mission.LST1)
			if not Mission.LST1.Dead then
				NavigatorMoveToPos(Mission.LST1, Mission.JapCapturePoints[2])
				Mission.LST1.ChosenPath = 2
				table.insert(Mission.LSTs, Mission.LST1)
			else
-- RELEASE_LOGOFF  				luaLog("   spawning failed, previous LST1 is still dead!")
			end
		else
-- RELEASE_LOGOFF  			luaLog("   spawning failed, LST1 is nil or function!")
-- RELEASE_LOGOFF  			luaLog(tostring(Mission.LST1))
		end
		Mission.LST1SpawnSet = false
	end
end

function luaQAS1SpawnLST2()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog("  -> SPAWNING LST2 <-")
		--luaLog(Mission.LST2)
		Mission.LST2 = GenerateObject(Mission.LST2TMPL.Name)
		if Mission.Started then
			MissionNarrativeParty(0, "mp01.nar_siege_us_lst_arrive")
			MissionNarrativeParty(1, "mp01.nar_siege_jap_lst_arrive")
		end
--[[
		if luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary", 1) == nil then
			luaObj_AddUnit("secondary", 1, Mission.LST2)
		end
]]
		AISetHintWeight(Mission.LST2, 8.2)
		SetSkillLevel(Mission.LST2, SKILL_SPVETERAN)
		NavigatorSetTorpedoEvasion(Mission.LST2, false)
		NavigatorSetAvoidShipCollision(Mission.LST2, false)
		NavigatorSetAvoidLandCollision(Mission.LST1, false)
		if Mission.LST2 ~= nil then
			--luaLog(Mission.LST2)
			if not Mission.LST2.Dead then
				NavigatorMoveToPos(Mission.LST2, Mission.JapCapturePoints[4])
				Mission.LST2.ChosenPath = 4
				table.insert(Mission.LSTs, Mission.LST2)
			else
-- RELEASE_LOGOFF  				luaLog("   spawning failed, previous LST2 is still dead!")
			end
		else
-- RELEASE_LOGOFF  			luaLog("   spawning failed, LST2 is nil or function!")
-- RELEASE_LOGOFF  			luaLog(tostring(Mission.LST2))
		end
		Mission.LST2SpawnSet = false
	end
end

function luaQAS1SpawnLST3()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog("  -> SPAWNING LST3 <-")
		--luaLog(Mission.LST3)
		Mission.LST3 = GenerateObject(Mission.LST3TMPL.Name)
		if Mission.Started then
			MissionNarrativeParty(0, "mp01.nar_siege_us_lst_arrive")
			MissionNarrativeParty(1, "mp01.nar_siege_jap_lst_arrive")
		end
		AISetHintWeight(Mission.LST3, 8.2)
		SetSkillLevel(Mission.LST3, SKILL_SPVETERAN)
		NavigatorSetTorpedoEvasion(Mission.LST3, false)
		NavigatorSetAvoidShipCollision(Mission.LST3, false)
		NavigatorSetAvoidLandCollision(Mission.LST1, false)
--[[
		if luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary", 1) == nil then
			luaObj_AddUnit("secondary", 1, Mission.LST3)
		end
]]
		if Mission.LST3 ~= nil then
			--luaLog(Mission.LST3)
			if not Mission.LST3.Dead then
				NavigatorMoveToPos(Mission.LST3, Mission.JapCapturePoints[5])
				Mission.LST3.ChosenPath = 5
				table.insert(Mission.LSTs, Mission.LST3)
			else
-- RELEASE_LOGOFF  				luaLog("   spawning failed, previous LST3 is still dead!")
			end
		else
-- RELEASE_LOGOFF  			luaLog("   spawning failed, LST3 is nil or function!")
-- RELEASE_LOGOFF  			luaLog(tostring(Mission.LST3))
		end
		Mission.LST3SpawnSet = false
	end
end

function luaQAS1SpawnLST4()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog("  -> SPAWNING LST4 <-")
		--luaLog(Mission.LST4)
		Mission.LST4 = GenerateObject(Mission.LST4TMPL.Name)
		if Mission.Started then
			MissionNarrativeParty(0, "mp01.nar_siege_us_lst_arrive")
			MissionNarrativeParty(1, "mp01.nar_siege_jap_lst_arrive")
		end
		AISetHintWeight(Mission.LST4, 8.2)
		SetSkillLevel(Mission.LST4, SKILL_SPVETERAN)
		NavigatorSetTorpedoEvasion(Mission.LST4, false)
		NavigatorSetAvoidShipCollision(Mission.LST4, false)
		NavigatorSetAvoidLandCollision(Mission.LST1, false)
--[[
		if luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary", 1) == nil then
			luaObj_AddUnit("secondary", 1, Mission.LST4)
		end
]]
		if Mission.LST4 ~= nil then
			--luaLog(Mission.LST4)
			if not Mission.LST4.Dead then
				NavigatorMoveToPos(Mission.LST4, Mission.JapCapturePoints[6])
				Mission.LST4.ChosenPath = 6
				table.insert(Mission.LSTs, Mission.LST4)
			else
-- RELEASE_LOGOFF  				luaLog("   spawning failed, previous LST4 is still dead!")
			end
		else
-- RELEASE_LOGOFF  			luaLog("   spawning failed, LST4 is nil or function!")
-- RELEASE_LOGOFF  			luaLog(tostring(Mission.LST4))
		end
		Mission.LST4SpawnSet = false
	end
end

function luaQAS1MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	Mission.Fortresses = luaRemoveDeadsFromTable(Mission.Fortresses)
	if table.getn(Mission.Fortresses) == 0 and not Mission.S2Done then
-- RELEASE_LOGOFF  		luaLog("  fortesses down, secondary 1 completed")
		Mission.S2Done = true
		luaObj_Completed("secondary", 1)
	elseif not Mission.S2Failed then
		Mission.S2Failed = true
		luaObj_Failed("secondary", 1)
	end
--[[
	if Mission.KeyUnitCounter == 0 and not Mission.ObjectivesSet then
		Mission.ObjectivesSet = true
		luaObj_Completed("primary", 3)
		luaObj_Failed("primary", 4)
	elseif not Mission.ObjectivesSet then
		Mission.ObjectivesSet = true
		luaObj_Failed("primary", 3)
		luaObj_Completed("primary", 4)
	end
]]
	Scoring_RealPlayTimeRunning(false)
	if Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 or Mission.Randomize == 1 then
-- RELEASE_LOGOFF  		luaLog("  Japanese side wins")
		Mission.Completed = true
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		--luaObj_Failed("secondary", 1)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_JAPANESE)
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 or Mission.Randomize == 2 then
-- RELEASE_LOGOFF  		luaLog("  Allied side wins")
		Mission.Completed = true
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		--luaObj_Completed("secondary", 1)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_ALLIED)
	elseif Mission.HQ.Party ~= PARTY_ALLIED then
-- RELEASE_LOGOFF  		luaLog("  Japanese side wins")
		Mission.ResourceUSPool = 0
		for i = 0, 7 do
			MultiScore[i][1] = 0
			MultiScore[i][2] = Mission.ResourceJapPool
		end
		Mission.Completed = true
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		--luaObj_Failed("secondary", 1)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_JAPANESE)
	end

--[[
	if Mission.HQ.Party == PARTY_ALLIED then
-- RELEASE_LOGOFF  		luaLog(" the HQ is still in Allied hands, Allied side wins")
		Mission.Completed = true
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaObj_Completed("secondary", 1)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_ALLIED)
	elseif Mission.HQ.Party ~= PARTY_ALLIED then
-- RELEASE_LOGOFF  		luaLog("  the HQ has been neutralized, Japanese side wins")
		Mission.Completed = true
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		luaObj_Failed("secondary", 1)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_JAPANESE)
	elseif Mission.JTTsDown then
-- RELEASE_LOGOFF  		luaLog("  all transports are down, Allied side wins")
		Mission.Completed = true
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_ALLIED)
	end
]]
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Siege01")
	-- mode description hint overlay
end

function luaInitCounters(keyunitnumber)
-- RELEASE_LOGOFF  	luaLog(" Initializing counters...")
	Mission.Defenders = {}
		table.insert(Mission.Defenders, Mission.HQ)
	for index, unit in pairs (Mission.Fortresses) do
		table.insert(Mission.Defenders, unit)
	end
	Mission.SumDefendersHPBase = 0
	for index, unit in pairs (Mission.Defenders) do
		Mission.SumDefendersHPBase = Mission.SumDefendersHPBase + unit.Class.HP
	end
	Mission.SumDefendersHP = Mission.SumDefendersHPBase
	Mission.SumDefendersHPPercentage = math.floor((Mission.SumDefendersHP / Mission.SumDefendersHPBase) * 100)

	Mission.TTSampleHP = Mission.Transport1.Class.HP
	Mission.SumAttackersHPBase = Mission.TTSampleHP * keyunitnumber 
	Mission.SumAttackersHP = Mission.SumAttackersHPBase
	Mission.SumAttackersHPPercentage = math.floor((Mission.SumAttackersHP / Mission.SumAttackersHPBase) * 100)
end

function luaCheckPlayers()
-- RELEASE_LOGOFF  	luaLog(" Checking players...")
	if not Mission.IDTableInitiated then
		Mission.USTable = {}
		Mission.JapTable = {}
		Mission.IDTableInitiated = true
	end

	if table.getn(Mission.USTable) ~= 0 then
		local by
		for index, unit in pairs (Mission.USTable) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead player unit found in Mission.USTable")
				by = luaCheckPlaneNumber(unit)
				luaResourcePoolReducer("usplayer", by)
				table.remove(Mission.USTable, index)
			else
				previouscheck = luaCheckPlaneNumber(unit)
				local planesinsquad = table.getn(GetSquadronPlanes(unit))
				if planesinsquad < previouscheck then
					by = previouscheck - planesinsquad
					unit.checkednumber = planesinsquad
					luaResourcePoolReducer("usplayer", by)
				elseif planesinsquad == 3 then
					unit.checkednumber = planesinsquad
				end
			end
		end
	end

	if table.getn(Mission.JapTable) ~= 0 then
		local by
		for index, unit in pairs (Mission.JapTable) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead player unit found in Mission.JapTable")
				by = luaCheckPlaneNumber(unit)
				luaResourcePoolReducer("japplayer", by)
				table.remove(Mission.JapTable, index)
			else
				previouscheck = luaCheckPlaneNumber(unit)
				local planesinsquad = table.getn(GetSquadronPlanes(unit))
				if planesinsquad < previouscheck then
					by = previouscheck - planesinsquad
					unit.checkednumber = planesinsquad
					luaResourcePoolReducer("japplayer", by)
				elseif planesinsquad == 3 then
					unit.checkednumber = planesinsquad
				end
			end
		end
	end

	local japplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 20000, PARTY_JAPANESE, "own")
	local usplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 20000, PARTY_ALLIED, "own")
	if usplanes ~= nil then
		for index, unit in pairs (usplanes) do
			if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  				luaLog("  new player unit found, inserting it to Mission.USTable")
				table.insert(Mission.USTable, unit)
			end
		end
	end
	if japplanes ~= nil then
		for index, unit in pairs (japplanes) do
			if not luaIsInside(unit, Mission.JapTable) then
-- RELEASE_LOGOFF  				luaLog("  new player unit found, inserting it to Mission.JapTable")
				table.insert(Mission.JapTable, unit)
			end
		end
	end
end

function luaResourcePoolReducer(unit, by)
-- RELEASE_LOGOFF  	luaLog(" luaResourcePoolReducer called | unit: "..tostring(unit).." | by: "..tostring(by))
	if unit == "usplayer" then
		local todeduct = Mission.ResourcePlayerUnit * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "PT" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSPT
	elseif unit == "coastal" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSCoastal
	elseif unit == "AA" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSAA
	elseif unit == "bigfort" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSFortressBig
	elseif unit == "mediumfort" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSFortressMedium
	elseif unit == "smallfort" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSFortressSmall
	elseif unit == "japplayer" then
		local todeduct = Mission.ResourcePlayerUnit * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "JTT" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapJTT
	elseif unit == "daihatsu" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapDaihatsu
	elseif unit == "SB" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapSB
	elseif unit == "HQ" then
		local todeduct = Mission.ResourceUSHQ * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	end

	if Mission.ResourceUSPool > 0 and Mission.ResourceJapPool > 0 then
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = Mission.ResourceJapPool
		end
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" US pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = 0
			MultiScore[i][2] = Mission.ResourceJapPool
		end
		Mission.MissionEndCalled = true
		luaQAS1MissionEnd()
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" Jap pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaQAS1MissionEnd()
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool < 1 then
-- RELEASE_LOGOFF  		luaLog(" both pools are under 1 point")
		Mission.Randomize = luaRnd(1, 2)
		if Mission.Randomize == 1 then
			for i = 0, 7 do
				MultiScore[i][1] = 0
				MultiScore[i][2] = 1
			end
			Mission.MissionEndCalled = true
			luaQAS1MissionEnd()
		else
			for i = 0, 7 do
				MultiScore[i][1] = 1
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaQAS1MissionEnd()
		end
	end
end

function luaCheckPlaneNumber(unit)
	if unit.checkednumber == nil then
		by = 3
	else
		by = unit.checkednumber
	end
	return by
end

function luaQAS1HintManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 30 and not Mission.Hint1Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint1Shown")
			ShowHint("ID_Hint_Siege01_OP")
			Mission.Hint1Shown = true
		elseif GameTime() > 60 and not Mission.Hint2Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint2Shown")
			ShowHint("ID_Hint_Siege01_LCVP")
			ShowHint("ID_Hint_Siege01_LB")
			Mission.Hint2Shown = true
		elseif GameTime() > 90 and not Mission.Hint3Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint3Shown")
			ShowHint("ID_Hint_Siege01_LST")
			ShowHint("ID_Hint_Siege01_PT")
			Mission.Hint3Shown = true
		elseif GameTime() > 120 and not Mission.Hint4Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint4Shown")
			ShowHint("ID_Hint_Siege01_TR")
			ShowHint("ID_Hint_Siege01_Fort")
			Mission.Hint4Shown = true
		elseif GameTime() > 150 and not Mission.Hint5Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint5Shown")
			ShowHint("ID_Hint_Siege01_TR")
			ShowHint("ID_Hint_Siege01_Fort")
			Mission.Hint5Shown = true
		elseif GameTime() > 180 and not Mission.Hint6Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint6Shown")
			ShowHint("ID_Hint_Siege01_PK")
			Mission.Hint6Shown = true
		elseif GameTime() > 210 and not Mission.Hint7Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint7Shown")
			ShowHint("ID_Hint_Siege01_HQ")
			Mission.Hint7Shown = true
		end
	end
end

function luaUpdateCounters()
-- RELEASE_LOGOFF  	luaLog(" Updating counters...")
	Mission.Defenders = luaRemoveDeadsFromTable(Mission.Defenders)
	Mission.SumDefendersHP = 0
	for index, unit in pairs (Mission.Defenders) do
		local HPActual = GetHpPercentage(unit) * unit.Class.HP
		Mission.SumDefendersHP = Mission.SumDefendersHP + HPActual
	end
	if Mission.HQ.Party == PARTY_ALLIED and Mission.SumDefendersHPPercentage <= 1 then
		Mission.SumDefendersHPPercentage = 1
	elseif Mission.SumDefendersHP ~= 0 then
		Mission.SumDefendersHPPercentage = math.floor((Mission.SumDefendersHP / Mission.SumDefendersHPBase) * 100)
	else
		Mission.SumDefendersHPPercentage = 0
	end

	Mission.SumAttackersHP = Mission.TTSampleHP * Mission.KeyUnitCounter

	if Mission.Transport1 ~= nil then
		if not Mission.Transport1.Dead then
			local HPActual = Mission.TTSampleHP * GetHpPercentage(Mission.Transport1)
			Mission.SumAttackersHP = Mission.SumAttackersHP - Mission.TTSampleHP + HPActual
		end
	end
	if Mission.Transport3 ~= nil then
		if not Mission.Transport3.Dead then
			local HPActual = Mission.TTSampleHP * GetHpPercentage(Mission.Transport3)
			Mission.SumAttackersHP = Mission.SumAttackersHP - Mission.TTSampleHP + HPActual
		end
	end
	if Mission.Transport5 ~= nil then
		if not Mission.Transport5.Dead then
			local HPActual = Mission.TTSampleHP * GetHpPercentage(Mission.Transport5)
			Mission.SumAttackersHP = Mission.SumAttackersHP - Mission.TTSampleHP + HPActual
		end
	end

	if not Mission.Transport1.Dead and Mission.SumAttackersHPPercentage <= 1 or not Mission.Transport3.Dead and Mission.SumAttackersHPPercentage <= 1 or not Mission.Transport5.Dead and Mission.SumAttackersHPPercentage <= 1 then
		Mission.SumAttackersHPPercentage = 1
	elseif Mission.SumAttackersHP ~= 0 then
		Mission.SumAttackersHPPercentage = math.floor((Mission.SumAttackersHP / Mission.SumAttackersHPBase) * 100)
	elseif Mission.JTTsDown then
		Mission.SumAttackersHPPercentage = 0
	else
		Mission.SumAttackersHPPercentage = 1
	end

	if table.getn(MultiScore) ~= 0 then
		for i = 0, 7 do
			MultiScore[i][1] = Mission.SumDefendersHPPercentage
			MultiScore[i][2] = Mission.SumAttackersHPPercentage
		end
	end
end

function luaSetMultiScoreTable()
-- RELEASE_LOGOFF  	luaLog(" Initializing counters...")
	MultiScore=	{
		[0]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[1]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[2]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[3]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[4]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[5]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[6]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
		[7]= {
			[1] = Mission.ResourceUSPool,
			[2] = Mission.ResourceJapPool,
		},
	}

	DisplayScores(1, 0, "mp01.score_siege_resource_att".."| #MultiScore.0.2#", "mp01.score_siege_resource_def".."| #MultiScore.0.1#", 1, 2)
	DisplayScores(1, 1, "mp01.score_siege_resource_att".."| #MultiScore.1.2#", "mp01.score_siege_resource_def".."| #MultiScore.1.1#", 1, 2)
	DisplayScores(1, 2, "mp01.score_siege_resource_att".."| #MultiScore.2.2#", "mp01.score_siege_resource_def".."| #MultiScore.2.1#", 1, 2)
	DisplayScores(1, 3, "mp01.score_siege_resource_att".."| #MultiScore.3.2#", "mp01.score_siege_resource_def".."| #MultiScore.3.1#", 1, 2)
	DisplayScores(1, 4, "mp01.score_siege_resource_att".."| #MultiScore.4.2#", "mp01.score_siege_resource_def".."| #MultiScore.4.1#", 1, 2)
	DisplayScores(1, 5, "mp01.score_siege_resource_att".."| #MultiScore.5.2#", "mp01.score_siege_resource_def".."| #MultiScore.5.1#", 1, 2)
	DisplayScores(1, 6, "mp01.score_siege_resource_att".."| #MultiScore.6.2#", "mp01.score_siege_resource_def".."| #MultiScore.6.1#", 1, 2)
	DisplayScores(1, 7, "mp01.score_siege_resource_att".."| #MultiScore.7.2#", "mp01.score_siege_resource_def".."| #MultiScore.7.1#", 1, 2)
--[[
	DisplayScores(1, 0, "mp01.score_siege_resource".."| #MultiScore.0.1#", "mp01.score_siege_resource".."| #MultiScore.0.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 1, "mp01.score_siege_resource".."| #MultiScore.1.1#", "mp01.score_siege_resource".."| #MultiScore.1.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 2, "mp01.score_siege_resource".."| #MultiScore.2.1#", "mp01.score_siege_resource".."| #MultiScore.2.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 3, "mp01.score_siege_resource".."| #MultiScore.3.1#", "mp01.score_siege_resource".."| #MultiScore.3.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 4, "mp01.score_siege_resource".."| #MultiScore.4.1#", "mp01.score_siege_resource".."| #MultiScore.4.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 5, "mp01.score_siege_resource".."| #MultiScore.5.1#", "mp01.score_siege_resource".."| #MultiScore.5.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 6, "mp01.score_siege_resource".."| #MultiScore.6.1#", "mp01.score_siege_resource".."| #MultiScore.6.2#", PARTY_ALLIED, PARTY_JAPANESE)
	DisplayScores(1, 7, "mp01.score_siege_resource".."| #MultiScore.7.1#", "mp01.score_siege_resource".."| #MultiScore.7.2#", PARTY_ALLIED, PARTY_JAPANESE)
]]
end