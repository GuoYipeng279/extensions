--SceneFile="Missions\Multi\Scene3.scn"

function luaPrecacheUnits()
	PrepareClass(23) -- Fletcher
	PrepareClass(25) -- Clemson
	PrepareClass(58) -- Shimakaze
	PrepareClass(73) -- Fubuki
	PrepareClass(75) -- Minekaze
	PrepareClass(104) -- P-38
	PrepareClass(12) -- LSM (spec QA)
	PrepareClass(41) -- LST (spec QA)
	PrepareClass(152) -- Gekko
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAS3Mission")
end

function luaInitQAS3Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Siege3"..dateandtime

	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.."!")
	
	-- lokalizacios feltoltesek
	--AddLockitPathToSelection("missionglobals")
	--LoadSelectedPaths()

	--precache

	-- globalban hasznalando
	this.Multiplayer = true
	this.ThinkCounter = 0
	Mission.MultiplayerType = "Siege"
	Mission.MultiplayerNumber = 2

	-- mission valtozok
	Mission.Completed = false
	Mission.HQ1Down = false
	Mission.HQ2Down = false
	Mission.HQ1RecapPossible = false
	Mission.HQ2RecapPossible = false
	Mission.ZeroDown = 0
	Mission.HellcatDown = 0
	--Mission.LSMDown = 0

	-- lobby
-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")

	-- globalban hasznalando
	this.Multiplayer = true
	this.ThinkCounter = 0
	Mission.MultiplayerType = "Siege"

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	Mission.KeyUnitCounter = 0 -- luaQAS3StartMission()-ben allitjuk be
	--ModifyKeyUnitNumber(Mission.KeyUnitCounter)
	Mission.LandingShipToSpawn = 0 -- luaQAS3StartMission()-ben allitjuk be
	Mission.DelayedSpawn = 6

	-- spawn pontok
	Mission.SpawnPoints1 = {}
		table.insert(Mission.SpawnPoints1, FindEntity("Siege - US SP1 1"))
		table.insert(Mission.SpawnPoints1, FindEntity("Siege - US SP1 2"))
		table.insert(Mission.SpawnPoints1, FindEntity("Siege - US SP1 3"))
		table.insert(Mission.SpawnPoints1, FindEntity("Siege - US SP1 4"))
		table.insert(Mission.SpawnPoints1, FindEntity("Siege - Jap SP1 1"))
		table.insert(Mission.SpawnPoints1, FindEntity("Siege - Jap SP1 2"))
		table.insert(Mission.SpawnPoints1, FindEntity("Siege - Jap SP1 3"))
		table.insert(Mission.SpawnPoints1, FindEntity("Siege - Jap SP1 4"))
	Mission.SpawnPoints2 = {}
		table.insert(Mission.SpawnPoints2, FindEntity("Siege - US SP2 1"))
		table.insert(Mission.SpawnPoints2, FindEntity("Siege - US SP2 2"))
		table.insert(Mission.SpawnPoints2, FindEntity("Siege - US SP2 3"))
		table.insert(Mission.SpawnPoints2, FindEntity("Siege - US SP2 4"))
		table.insert(Mission.SpawnPoints2, FindEntity("Siege - Jap SP2 1"))
		table.insert(Mission.SpawnPoints2, FindEntity("Siege - Jap SP2 2"))
		table.insert(Mission.SpawnPoints2, FindEntity("Siege - Jap SP2 3"))
		table.insert(Mission.SpawnPoints2, FindEntity("Siege - Jap SP2 4"))
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
	for index, entity in pairs (Mission.SpawnPoints1) do
		local slotID = index - 1
		for index2, value in pairs (Mission.SlotIDTable) do
			if slotID == value then
-- RELEASE_LOGOFF  				luaLog(" activating SP1ID "..index.." for slotID "..value)
				ActivateSpawnpoint(entity, value)
			else
				DeactivateSpawnpoint(entity, value)
			end
		end	
	end
	for index, entity in pairs (Mission.SpawnPoints2) do
		local slotID = index - 1
		for index2, value in pairs (Mission.SlotIDTable) do
			if slotID == value then
-- RELEASE_LOGOFF  				luaLog(" activating SP2ID "..index.." for slotID "..value)
				ActivateSpawnpoint(entity, value)
			else
				DeactivateSpawnpoint(entity, value)
			end
		end	
	end
-- RELEASE_LOGOFF  	luaLog("-- end of spawnpoint activation --")

	-- mission tablak
	Mission.JapMissileASpawnFlag = {}
		table.insert(Mission.JapMissileASpawnFlag, false)
		table.insert(Mission.JapMissileASpawnFlag, false)
		table.insert(Mission.JapMissileASpawnFlag, false)
	Mission.MissileATriggerID = {}
		table.insert(Mission.MissileATriggerID, ShipA1Watch)
		table.insert(Mission.MissileATriggerID, ShipA2Watch)
		table.insert(Mission.MissileATriggerID, ShipA3Watch)
	Mission.MissileATriggerFunction = {}
		table.insert(Mission.MissileATriggerFunction, "luaQAS3ShipA1InPos")
		table.insert(Mission.MissileATriggerFunction, "luaQAS3ShipA2InPos")
		table.insert(Mission.MissileATriggerFunction, "luaQAS3ShipA3InPos")
	Mission.MissileAbTriggerFunction = {}
		table.insert(Mission.MissileAbTriggerFunction, "luaQAS3ShipAb1InPos")
		table.insert(Mission.MissileAbTriggerFunction, "luaQAS3ShipAb2InPos")
		table.insert(Mission.MissileAbTriggerFunction, "luaQAS3ShipAb3InPos")
	Mission.JapMissileBSpawnFlag = {}
		table.insert(Mission.JapMissileBSpawnFlag, false)
		table.insert(Mission.JapMissileBSpawnFlag, false)
		table.insert(Mission.JapMissileBSpawnFlag, false)
	Mission.MissileBTriggerID = {}
		table.insert(Mission.MissileBTriggerID, ShipB1Watch)
		table.insert(Mission.MissileBTriggerID, ShipB2Watch)
		table.insert(Mission.MissileBTriggerID, ShipB3Watch)
	Mission.MissileBTriggerFunction = {}
		table.insert(Mission.MissileBTriggerFunction, "luaQAS3ShipB1InPos")
		table.insert(Mission.MissileBTriggerFunction, "luaQAS3ShipB2InPos")
		table.insert(Mission.MissileBTriggerFunction, "luaQAS3ShipB3InPos")
	Mission.MissileBbTriggerFunction = {}
		table.insert(Mission.MissileBbTriggerFunction, "luaQAS3ShipBb1InPos")
		table.insert(Mission.MissileBbTriggerFunction, "luaQAS3ShipBb2InPos")
		table.insert(Mission.MissileBbTriggerFunction, "luaQAS3ShipBb3InPos")
	Mission.USDestroyerSpawnFlag = {}
		table.insert(Mission.USDestroyerSpawnFlag, false)
		table.insert(Mission.USDestroyerSpawnFlag, false)
		table.insert(Mission.USDestroyerSpawnFlag, false)
		table.insert(Mission.USDestroyerSpawnFlag, false)
	Mission.JapDestroyerSpawnFlag = {}
		table.insert(Mission.JapDestroyerSpawnFlag, false)
		table.insert(Mission.JapDestroyerSpawnFlag, false)
		table.insert(Mission.JapDestroyerSpawnFlag, false)
		table.insert(Mission.JapDestroyerSpawnFlag, false)
	Mission.USPlaneSpawnFlag = {}
		table.insert(Mission.USPlaneSpawnFlag, false)
		table.insert(Mission.USPlaneSpawnFlag, false)
		table.insert(Mission.USPlaneSpawnFlag, false)
		table.insert(Mission.USPlaneSpawnFlag, false)
	Mission.JapPlaneSpawnFlag = {}
		table.insert(Mission.JapPlaneSpawnFlag, false)
		table.insert(Mission.JapPlaneSpawnFlag, false)
		table.insert(Mission.JapPlaneSpawnFlag, false)
		table.insert(Mission.JapPlaneSpawnFlag, false)
	Mission.LSTSpawnFlag = {}
		table.insert(Mission.LSTSpawnFlag, false)
		table.insert(Mission.LSTSpawnFlag, false)
		table.insert(Mission.LSTSpawnFlag, false)
		table.insert(Mission.LSTSpawnFlag, false)
	Mission.NavPoints = {}
		table.insert(Mission.NavPoints, GetPosition(FindEntity("Siege - Navpoint 01")))
		table.insert(Mission.NavPoints, GetPosition(FindEntity("Siege - Navpoint 02")))
	Mission.MissileShipAInPos = {}
		table.insert(Mission.MissileShipAInPos, false)
		table.insert(Mission.MissileShipAInPos, false)
		table.insert(Mission.MissileShipAInPos, false)
	Mission.MissileShipBInPos = {}
		table.insert(Mission.MissileShipBInPos, false)
		table.insert(Mission.MissileShipBInPos, false)
		table.insert(Mission.MissileShipBInPos, false)
	Mission.USSpawnAllowed = {}
		table.insert(Mission.USSpawnAllowed, true)
		table.insert(Mission.USSpawnAllowed, true)
		table.insert(Mission.USSpawnAllowed, true)
		table.insert(Mission.USSpawnAllowed, true)
	Mission.JapSpawnAllowed = {}	
		table.insert(Mission.JapSpawnAllowed, true)
		table.insert(Mission.JapSpawnAllowed, true)
		table.insert(Mission.JapSpawnAllowed, true)
		table.insert(Mission.JapSpawnAllowed, true)
	Mission.LSTSpawnAllowed = {}	
		table.insert(Mission.LSTSpawnAllowed, true)
		table.insert(Mission.LSTSpawnAllowed, true)
		table.insert(Mission.LSTSpawnAllowed, true)
		table.insert(Mission.LSTSpawnAllowed, true)

	Mission.LSTProximityIDTable = {}
		table.insert(Mission.LSTProximityIDTable, "LST1ProximityTrigger")
		table.insert(Mission.LSTProximityIDTable, "LST2ProximityTrigger")
		table.insert(Mission.LSTProximityIDTable, "LST3ProximityTrigger")
		table.insert(Mission.LSTProximityIDTable, "LST4ProximityTrigger")
	Mission.LSTProximityFunctionTable = {}
		table.insert(Mission.LSTProximityFunctionTable, "luaLST1Trigger")
		table.insert(Mission.LSTProximityFunctionTable, "luaLST2Trigger")
		table.insert(Mission.LSTProximityFunctionTable, "luaLST3Trigger")
		table.insert(Mission.LSTProximityFunctionTable, "luaLST4Trigger")

	-- amerikai objektumok
	Mission.USDestroyerTemplates = {}
		table.insert(Mission.USDestroyerTemplates, luaFindHidden("Siege - Clemson 1"))
		table.insert(Mission.USDestroyerTemplates, luaFindHidden("Siege - Fletcher 1"))
		table.insert(Mission.USDestroyerTemplates, luaFindHidden("Siege - Clemson 2"))
		table.insert(Mission.USDestroyerTemplates, luaFindHidden("Siege - Fletcher 2"))
	Mission.USDestroyers = {}
	Mission.MissileShipsATemplates = {}
		table.insert(Mission.MissileShipsATemplates, luaFindHidden("Siege - LSM a1"))
		table.insert(Mission.MissileShipsATemplates, luaFindHidden("Siege - LSM a2"))
		table.insert(Mission.MissileShipsATemplates, luaFindHidden("Siege - LSM a3"))
	Mission.MissileShipsA = {}
	Mission.MissileShipsBTemplates = {}
		table.insert(Mission.MissileShipsBTemplates, luaFindHidden("Siege - LSM b1"))
		table.insert(Mission.MissileShipsBTemplates, luaFindHidden("Siege - LSM b2"))
		table.insert(Mission.MissileShipsBTemplates, luaFindHidden("Siege - LSM b3"))
	Mission.MissileShipsB = {}
--[[
	Mission.USSpawnPoints = {}
		table.insert(Mission.USSpawnPoints, FindEntity("Siege - SpawnPoint 03"))
		table.insert(Mission.USSpawnPoints, FindEntity("Siege - SpawnPoint 04"))
]]
	Mission.USPlaneTemplates = {}
		table.insert(Mission.USPlaneTemplates, luaFindHidden("Siege - Lightning 01"))
		table.insert(Mission.USPlaneTemplates, luaFindHidden("Siege - Lightning 02"))
		table.insert(Mission.USPlaneTemplates, luaFindHidden("Siege - Lightning 03"))
		table.insert(Mission.USPlaneTemplates, luaFindHidden("Siege - Lightning 04"))
	Mission.USPlanes = {}

	Mission.USLSTs = {}
	Mission.USLSTTemplates = {}
		table.insert(Mission.USLSTTemplates, luaFindHidden("Siege - LST A1"))
		table.insert(Mission.USLSTTemplates, luaFindHidden("Siege - LST A2"))
		table.insert(Mission.USLSTTemplates, luaFindHidden("Siege - LST B1"))
		table.insert(Mission.USLSTTemplates, luaFindHidden("Siege - LST B2"))

	Mission.USLSTPaths = {}
		table.insert(Mission.USLSTPaths, FindEntity("Siege - LST A2 Path"))
		table.insert(Mission.USLSTPaths, FindEntity("Siege - LST A1 Path"))
		table.insert(Mission.USLSTPaths, FindEntity("Siege - LST B1 Path"))
		table.insert(Mission.USLSTPaths, FindEntity("Siege - LST B2 Path"))

	-- japan objektumok
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("Siege - HQ 1"))
		table.insert(Mission.HQs, FindEntity("Siege - HQ 2"))
	Mission.JapDestroyerTemplates = {}
		table.insert(Mission.JapDestroyerTemplates, luaFindHidden("Siege - Fubuki 2"))
		table.insert(Mission.JapDestroyerTemplates, luaFindHidden("Siege - Minekaze 1"))
		table.insert(Mission.JapDestroyerTemplates, luaFindHidden("Siege - Minekaze 2"))
		table.insert(Mission.JapDestroyerTemplates, luaFindHidden("Siege - Fubuki 1"))
	Mission.JapDestroyers = {}
--[[
	Mission.JPSpawnPoints = {}
		table.insert(Mission.JPSpawnPoints, FindEntity("Siege - SpawnPoint 01"))
		table.insert(Mission.JPSpawnPoints, FindEntity("Siege - SpawnPoint 02"))
]]
	Mission.JapPlaneTemplates = {}
		table.insert(Mission.JapPlaneTemplates, luaFindHidden("Siege - Gekko 01"))
		table.insert(Mission.JapPlaneTemplates, luaFindHidden("Siege - Gekko 02"))
		table.insert(Mission.JapPlaneTemplates, luaFindHidden("Siege - Gekko 03"))
		table.insert(Mission.JapPlaneTemplates, luaFindHidden("Siege - Gekko 04"))
	Mission.JapPlanes = {}

	-- pathok
	Mission.MissileAPaths = {}
		table.insert(Mission.MissileAPaths, FindEntity("Siege - MissileAPath 1"))
		table.insert(Mission.MissileAPaths, FindEntity("Siege - MissileAPath 2"))
		table.insert(Mission.MissileAPaths, FindEntity("Siege - MissileAPath 3"))
	Mission.MissileBPaths = {}
		table.insert(Mission.MissileBPaths, FindEntity("Siege - MissileBPath 1"))
		table.insert(Mission.MissileBPaths, FindEntity("Siege - MissileBPath 2"))
		table.insert(Mission.MissileBPaths, FindEntity("Siege - MissileBPath 3"))
	Mission.MissileAbPaths = {}
		table.insert(Mission.MissileAbPaths, FindEntity("Siege - MissileAPath 1b"))
		table.insert(Mission.MissileAbPaths, FindEntity("Siege - MissileAPath 2b"))
		table.insert(Mission.MissileAbPaths, FindEntity("Siege - MissileAPath 3b"))
	Mission.MissileBbPaths = {}
		table.insert(Mission.MissileBbPaths, FindEntity("Siege - MissileBPath 1b"))
		table.insert(Mission.MissileBbPaths, FindEntity("Siege - MissileBPath 2b"))
		table.insert(Mission.MissileBbPaths, FindEntity("Siege - MissileBPath 3b"))

	-- figyelesek

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
	Mission.ResourceUSLST = 25
	Mission.ResourceUSLSM = 40
	Mission.ResourceUSPlane = 5
	Mission.ResourceUSDestroyer = 30
	Mission.ResourceJapHQ = 1.75
	Mission.ResourceJapDestroyer = 30
	Mission.ResourceJapPlane = 5
	Mission.ResourceJapShinyo = 5
	Mission.ResourcePlayerUnit = 12

	Mission.PreviousHPPercentageHQ1 = 1
	Mission.PreviousHPPercentageHQ2 = 1

	Mission.LSMSkillLevel = 1

---------------------------

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_pri_obj_1",
				["Text"] = "mp03.obj_siege_us_p1_text",
				["TextCompleted"] = "mp03.obj_siege_us_p1_comp",
				["TextFailed"] = "mp03.obj_siege_us_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_pri_obj_1",
				["Text"] = "mp01.obj_siege_us_p1_text",
				["TextCompleted"] = "mp01.obj_siege_us_p1_comp",
				["TextFailed"] = "mp01.obj_siege_us_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
--[[
			[3] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_pri_obj_2",
				["Text"] = "At least one of the landing ships should survive!",
				["TextCompleted"] = "You have successfully protected some landing ships!",
				["TextFailed"] = "You have failed to protect the landing ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 600,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_pri_obj_2",
				["Text"] = "Destroy the landing ships!",
				["TextCompleted"] = "You have successfully destroyed the landing ships!",
				["TextFailed"] = "You have failed to destroy the landing ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 600,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
]]
		},
		["secondary"] =	{
--[[
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_sec_obj_1",
				["Text"] = ".",
				["TextCompleted"] = ".",
				["TextFailed"] = ".",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 200,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_sec_obj_1",
				["Text"] = "Sink 20 missile ships!",
				["TextCompleted"] = "You have sunk 20 missile ships!",
				["TextFailed"] = "You have failed to sink 20 missile ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 200,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[3] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_sec_obj_2",
				["Text"] = "Destroy 20 Zero fighter planes!",
				["TextCompleted"] = "Your forces have destroyed 20 Zero fighter planes!",
				["TextFailed"] = "Your forces have failed to destroy 20 Zero fighter planes!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 200,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "us_sec_obj_2",
				["Text"] = "Destroy 20 Hellcat fighter planes!",
				["TextCompleted"] = "Your forces have destroyed 20 Hellcat fighter planes!",
				["TextFailed"] = "Your forces have failed to destroy 20 Hellcat fighter planes!",
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

	SetRocketAirGroundTypeDifferent(false)

	AISetSpawnSceneUnitsWeightMul(0)

	luaInitNewSystems()

    SetThink(this, "luaQAS3Mission_think")
end

function luaQAS3Mission_think(this, msg)
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
		luaQAS3CheckObjectives()
		luaQAS3CheckShips()
		luaQAS3CheckPlanes()
		luaCheckPlayers()
		luaQAS3CheckMissionEnd()
		luaQAS3HintManager()

	elseif not Mission.Started then
		luaQAS3StartMission()
		luaSetMultiScoreTable()
		luaQAS3SetLSMSkillLevel()
	end
end

function luaQAS3StartMission()
-- RELEASE_LOGOFF  	luaLog(" Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()
	
	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	--Countdown("", 0, 1200, "luaQAS3MissionEnd")

	if Mission.Players <= 2 then
		Mission.LandingShipToDestroy = 12
	elseif Mission.Players == 3 then
		Mission.LandingShipToDestroy = 13
	elseif Mission.Players == 4 then
		Mission.LandingShipToDestroy = 14
	elseif Mission.Players == 5 then
		Mission.LandingShipToDestroy = 15
	elseif Mission.Players == 6 then
		Mission.LandingShipToDestroy = 16
	elseif Mission.Players == 7 then
		Mission.LandingShipToDestroy = 17
	elseif Mission.Players == 8 then
		Mission.LandingShipToDestroy = 18
	end
	--Mission.LandingShipToSpawn = 3
	Mission.LandingShipToSpawn = 2
-- RELEASE_LOGOFF  	luaLog(" KeyUnitCounter set to "..Mission.LandingShipToDestroy)
	Mission.KeyUnitCounter = Mission.LandingShipToDestroy
	--ModifyKeyUnitNumber(Mission.KeyUnitCounter)

	--luaObj_Add("primary", 1, Mission.HQs)
	--luaObj_Add("primary", 2, Mission.HQs)
	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2)
	luaObj_AddUnit("primary", 1, Mission.HQs[1])
	luaObj_AddUnit("primary", 1, Mission.HQs[2])
	luaObj_AddUnit("primary", 2, Mission.HQs[1])
	luaObj_AddUnit("primary", 2, Mission.HQs[2])
	--luaObj_Add("primary", 3)
	--luaObj_Add("primary", 4)
	--luaObj_Add("secondary", 1, {}, true)
	--luaObj_Add("secondary", 2, {}, true)
	--luaObj_Add("secondary", 3, {}, true)
	--luaObj_Add("secondary", 4, {}, true)

	--for i = 1, 6 do -- 5-6 kivagva, 2-4-ig spawnolhatnak
	for i = 1, Mission.LandingShipToSpawn do
		luaQAS3JapMissileASpawn(0, i)
	end

	--for i = 1, 6 do -- 5-6 kivagva, 2-4-ig spawnolhatnak
	for i = 1, Mission.LandingShipToSpawn do
		luaQAS3JapMissileBSpawn(0, i)
	end

	for i = 1, 4 do
		luaQAS3USPlaneSpawn(0, i)
	end

	for i = 1, 4 do
		luaQAS3JapPlaneSpawn(0, i)
	end

	for i = 1, 4 do
		luaQAS3USDestroyerSpawn(0, i)
	end

	for i = 1, 4 do
		luaQAS3JapDestroyerSpawn(0, i)
	end

	for i = 1, 4 do
		luaQAS3USLSTSpawn(0, i)
	end

	luaDelay(luaAllowNarratives, 20)
	Mission.Started = true
	--luaSetInvincibility() -- csak a drafthoz
end

function luaAllowNarratives()
	Mission.NarrativesAllowed = true
end

function luaSetInvincibility()
	if Mission.ElapsedTime ~= 0 then
		local invincibility = (1000 - Mission.ElapsedTime) / 1000
		invincibility = math.floor(invincibility * 100) / 100
		if invincibility <= 0.1 then
			invincibility = 0
		end
		for index, unit in pairs (Mission.HQs) do
			SetInvincible(unit, invincibility)
		end
		luaDelay(luaSetInvincibility, 1)
	end
end

function luaQAS3CheckObjectives()
-- RELEASE_LOGOFF  	luaLog(" Checking objectives...")
--[[
	if luaObj_IsActive("secondary", 2) and luaObj_GetSuccess("secondary", 2) == nil then
		if Mission.LSMDown >= 20 then
-- RELEASE_LOGOFF  			luaLog("  secondary 2 completed")
			for index, unit in pairs (Mission.MissileShipsA) do
				if not unit.Dead then
					if unit.marked then
-- RELEASE_LOGOFF  						luaLog("  "..unit.Name.." marked, removing mark")
						unit.marked = false
						luaObj_RemoveUnit("secondary", 2, unit)
					end
				end
			end
			for index, unit in pairs (Mission.MissileShipsB) do
				if not unit.Dead then
					if unit.marked then
-- RELEASE_LOGOFF  						luaLog("  "..unit.Name.." marked, removing mark")
						unit.marked = false
						luaObj_RemoveUnit("secondary", 2, unit)
					end
				end
			end
			luaObj_Completed("secondary", 2)
		end
	end

	if luaObj_IsActive("secondary", 3) and luaObj_GetSuccess("secondary", 3) == nil then
		if Mission.ZeroDown >= 20 then
-- RELEASE_LOGOFF  			luaLog("  secondary 3 completed")
			for index, unit in pairs (Mission.JapPlanes) do
				if not unit.Dead then
					if unit.marked then
-- RELEASE_LOGOFF  						luaLog("  "..unit.Name.." marked, removing mark")
						unit.marked = false
						luaObj_RemoveUnit("secondary", 3, unit)
					end
				end
			end
			luaObj_Completed("secondary", 3)
		end
	end
	if luaObj_IsActive("secondary", 4) and luaObj_GetSuccess("secondary", 4) == nil  then
		if Mission.HellcatDown >= 20 then
-- RELEASE_LOGOFF  			luaLog("  secondary 4 completed")
			for index, unit in pairs (Mission.USPlanes) do
				if not unit.Dead then
					if unit.marked then
-- RELEASE_LOGOFF  						luaLog("  "..unit.Name.." marked, removing mark")
						unit.marked = false
						luaObj_RemoveUnit("secondary", 4, unit)
					end
				end
			end
			luaObj_Completed("secondary", 4)
		end
	end
]]
	if not Mission.MissionEndCalled then
		if Mission.HQs[1].Party == PARTY_JAPANESE then
			local threshold = GetHpPercentage(Mission.HQs[1]) + 0.01
			if threshold < Mission.PreviousHPPercentageHQ1 then
				local difference = Mission.PreviousHPPercentageHQ1 - GetHpPercentage(Mission.HQs[1])
				local percentage = difference * 100
				local by = luaRound(percentage)
				luaResourcePoolReducer("HQ", by)
				Mission.PreviousHPPercentageHQ1 = GetHpPercentage(Mission.HQs[1])
			end
		end
		if Mission.HQs[2].Party == PARTY_JAPANESE then
			local threshold = GetHpPercentage(Mission.HQs[2]) + 0.01
			if threshold < Mission.PreviousHPPercentageHQ2 then
				local difference = Mission.PreviousHPPercentageHQ2 - GetHpPercentage(Mission.HQs[2])
				local percentage = difference * 100
				local by = luaRound(percentage)
				luaResourcePoolReducer("HQ", by)
				Mission.PreviousHPPercentageHQ2 = GetHpPercentage(Mission.HQs[2])
			end
		end

		if Mission.HQs[1].Party ~= PARTY_JAPANESE and not Mission.HQ1Down then
-- RELEASE_LOGOFF  			luaLog("  HQ1 down, deactivating spawnpoint")
			Mission.HQ1Down = true
			Mission.HQ1RecapPossible = true
			Mission.JapSpawnAllowed[1] = false
			Mission.JapSpawnAllowed[2] = false
			for i = 5, 8 do
				local slotID = i - 1
				for index2, value in pairs (Mission.SlotIDTable) do
					if slotID == value then
-- RELEASE_LOGOFF  						luaLog(" deactivating SP1ID "..i.." for slotID "..value)
						DeactivateSpawnpoint(Mission.SpawnPoints1[i], value)
					end
				end
			end
		elseif Mission.HQ1RecapPossible and Mission.HQs[1].Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  			luaLog("  HQ1 recapped, activating spawnpoint")
			Mission.HQ1Down = false
			Mission.HQ1RecapPossible = false
			Mission.JapSpawnAllowed[1] = true
			Mission.JapSpawnAllowed[2] = true
			for i = 5, 8 do
				local slotID = i - 1
				for index2, value in pairs (Mission.SlotIDTable) do
					if slotID == value then
-- RELEASE_LOGOFF  						luaLog(" deactivating SP1ID "..i.." for slotID "..value)
						ActivateSpawnpoint(Mission.SpawnPoints1[i], value)
					end
				end
			end
		end

		if Mission.HQs[2].Party ~= PARTY_JAPANESE and not Mission.HQ2Down then
-- RELEASE_LOGOFF  			luaLog("  HQ2 down, deactivating spawnpoint")
			Mission.HQ2Down = true
			Mission.HQ2RecapPossible = true
			Mission.JapSpawnAllowed[3] = false
			Mission.JapSpawnAllowed[4] = false
			for i = 5, 8 do
				local slotID = i - 1
				for index2, value in pairs (Mission.SlotIDTable) do
					if slotID == value then
-- RELEASE_LOGOFF  						luaLog(" deactivating SP1ID "..i.." for slotID "..value)
						DeactivateSpawnpoint(Mission.SpawnPoints2[i], value)
					end
				end
			end
		elseif Mission.HQ1RecapPossible and Mission.HQs[2].Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  			luaLog("  HQ2 recapped, activating spawnpoint")
			Mission.HQ2Down = false
			Mission.HQ2RecapPossible = false
			Mission.JapSpawnAllowed[3] = true
			Mission.JapSpawnAllowed[4] = true
			for i = 5, 8 do
				local slotID = i- 1
				for index2, value in pairs (Mission.SlotIDTable) do
					if slotID == value then
-- RELEASE_LOGOFF  						luaLog(" deactivating SP1ID "..i.." for slotID "..value)
						ActivateSpawnpoint(Mission.SpawnPoints2[i], value)
					end
				end
			end
		end

		if Mission.HQ1Down or Mission.HQ2Down then
-- RELEASE_LOGOFF  			luaLog("  both HQs are down, calling missionEnd...")
			Mission.ResourceJapPool = 0
			for i = 0, 7 do
				MultiScore[i][1] = Mission.ResourceUSPool
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaQAS3MissionEnd()
		end
	else
-- RELEASE_LOGOFF  		luaLog("  mission is over...")
	end
end

function luaQAS3CheckShips()
-- RELEASE_LOGOFF  	luaLog(" Checking ships...")
	for index, unit in pairs (Mission.USDestroyers) do
		if Mission.USDestroyers[index].Dead and not Mission.USDestroyerSpawnFlag[index] then
-- RELEASE_LOGOFF  			luaLog("  "..index..". US destroyer down, delaying respawn")
			Mission.USDestroyerSpawnFlag[index] = true
			local randomtime = luaRnd(30, 55)
			local delaytime = randomtime + 0.1 * index
			luaDelay(luaQAS3USDestroyerSpawn, delaytime, "index", index)
			luaResourcePoolReducer("usdestroyer")
		elseif not Mission.USDestroyers[index].Dead then
			if UnitGetAttackTarget(Mission.USDestroyers[index]) == nil then
				local unitparty = "US"
				local unitindex = index
				luaQAS3SetShipTarget(unitparty, unitindex)
			end
		end
	end

	for index, unit in pairs (Mission.JapDestroyers) do
		if Mission.JapDestroyers[index].Dead and not Mission.JapDestroyerSpawnFlag[index] then
-- RELEASE_LOGOFF  			luaLog("  "..index..". Jap destroyer down, delaying respawn")
			Mission.JapDestroyerSpawnFlag[index] = true
			local randomtime = luaRnd(30, 55)
			local delaytime = randomtime + 0.1 * index
			luaDelay(luaQAS3JapDestroyerSpawn, delaytime, "index", index)
			luaResourcePoolReducer("japdestroyer")
		elseif not Mission.JapDestroyers[index].Dead then
			if UnitGetAttackTarget(Mission.JapDestroyers[index]) == nil then
				local unitparty = "Jap"
				local unitindex = index
				luaQAS3SetShipTarget(unitparty, unitindex)
			end
		end
	end

	for index, unit in pairs (Mission.USLSTs) do
		if Mission.USLSTs[index].Dead and not Mission.LSTSpawnFlag[index] then
-- RELEASE_LOGOFF  			luaLog("  "..index..". US LST down, delaying respawn")
			Mission.LSTSpawnFlag[index] = true
			local randomtime = luaRnd(30, 55)
			local delaytime = randomtime + 0.1 * index
			luaDelay(luaQAS3USLSTSpawn, delaytime, "index", index)
			luaResourcePoolReducer("LST")
		end
	end

	for index, unit in pairs (Mission.MissileShipsA) do
		if unit.Dead and not Mission.JapMissileASpawnFlag[index] then
-- RELEASE_LOGOFF  			luaLog("  "..index..". missileshipA down, delaying respawn")
			Mission.JapMissileASpawnFlag[index] = true
			Mission.MissileShipAInPos[index] = false
			--Mission.LSMDown = Mission.LSMDown + 1
			local randomtime = luaRnd(30, 40)
			local delaytime = randomtime + 0.1 * index
			luaResourcePoolReducer("LSM")
			if not Mission.SpawnDenied then
				luaDelay(luaQAS3JapMissileASpawn, delaytime, "index", index)
				Mission.KeyUnitCounter = Mission.KeyUnitCounter - 1
				--ModifyKeyUnitNumber(Mission.KeyUnitCounter)
			elseif not unit.deduted then
				unit.deduted = true
				Mission.KeyUnitCounter = Mission.KeyUnitCounter - 1
				--ModifyKeyUnitNumber(Mission.KeyUnitCounter)
			end
		elseif not unit.Dead and Mission.MissileShipAInPos[index] then
			local scripttarget = luaGetScriptTarget(unit)
			if scripttarget == nil then
				NavigatorMoveOnPath(Mission.MissileShipsA[index], Mission.MissileAbPaths[index])
				NavigatorSetTorpedoEvasion(Mission.MissileShipsA[index], false)
				NavigatorSetAvoidShipCollision(Mission.MissileShipsA[index], false)
				NavigatorSetAvoidLandCollision(Mission.MissileShipsA[index], false)
				ArtilleryEnable(Mission.MissileShipsA[index], false)
				local pathpoints = FillPathPoints(Mission.MissileAbPaths[index])
				AddProximityTrigger(Mission.MissileShipsA[index], Mission.MissileATriggerID[index], Mission.MissileAbTriggerFunction[index], pathpoints[2], 100)
			elseif scripttarget.Party == PARTY_NEUTRAL then
				NavigatorMoveOnPath(Mission.MissileShipsA[index], Mission.MissileAbPaths[index])
				NavigatorSetTorpedoEvasion(Mission.MissileShipsA[index], false)
				NavigatorSetAvoidShipCollision(Mission.MissileShipsA[index], false)
				NavigatorSetAvoidLandCollision(Mission.MissileShipsA[index], false)
				ArtilleryEnable(Mission.MissileShipsA[index], false)
				local pathpoints = FillPathPoints(Mission.MissileAbPaths[index])
				AddProximityTrigger(Mission.MissileShipsA[index], Mission.MissileATriggerID[index], Mission.MissileAbTriggerFunction[index], pathpoints[2], 100)
			end
		end
	end

	for index, unit in pairs (Mission.MissileShipsB) do
		if unit.Dead and not Mission.JapMissileBSpawnFlag[index] then
-- RELEASE_LOGOFF  			luaLog("  "..index..". missileshipB down, delaying respawn")
			Mission.JapMissileBSpawnFlag[index] = true
			Mission.MissileShipBInPos[index] = false
			--Mission.LSMDown = Mission.LSMDown + 1
			local randomtime = luaRnd(30, 40)
			local delaytime = randomtime + 0.1 * index
			luaResourcePoolReducer("LSM")
			if not Mission.SpawnDenied then
				luaDelay(luaQAS3JapMissileBSpawn, delaytime, "index", index)
				Mission.KeyUnitCounter = Mission.KeyUnitCounter - 1
				--ModifyKeyUnitNumber(Mission.KeyUnitCounter)
			elseif not unit.deduted then
				unit.deduted = true
				Mission.KeyUnitCounter = Mission.KeyUnitCounter - 1
				--ModifyKeyUnitNumber(Mission.KeyUnitCounter)
			end
		elseif not unit.Dead and Mission.MissileShipBInPos[index] then
			local scripttarget = luaGetScriptTarget(unit)
			if scripttarget == nil then
				NavigatorMoveOnPath(Mission.MissileShipsB[index], Mission.MissileBbPaths[index])
				NavigatorSetTorpedoEvasion(Mission.MissileShipsB[index], false)
				NavigatorSetAvoidShipCollision(Mission.MissileShipsB[index], false)
				NavigatorSetAvoidLandCollision(Mission.MissileShipsB[index], false)
				ArtilleryEnable(Mission.MissileShipsB[index], false)
				local pathpoints = FillPathPoints(Mission.MissileBbPaths[index])
				AddProximityTrigger(Mission.MissileShipsB[index], Mission.MissileBTriggerID[index], Mission.MissileBbTriggerFunction[index], pathpoints[2], 100)
			elseif scripttarget.Party == PARTY_NEUTRAL then
				NavigatorMoveOnPath(Mission.MissileShipsB[index], Mission.MissileBbPaths[index])
				NavigatorSetTorpedoEvasion(Mission.MissileShipsB[index], false)
				NavigatorSetAvoidShipCollision(Mission.MissileShipsB[index], false)
				NavigatorSetAvoidLandCollision(Mission.MissileShipsB[index], false)
				ArtilleryEnable(Mission.MissileShipsB[index], false)
				local pathpoints = FillPathPoints(Mission.MissileBbPaths[index])
				AddProximityTrigger(Mission.MissileShipsB[index], Mission.MissileBTriggerID[index], Mission.MissileBbTriggerFunction[index], pathpoints[2], 100)
			end			
		end
	end
end

function luaQAS3JapMissileASpawn(timerthis, index)
	if not Mission.Completed and not Mission.MissionEnd then
		if not Mission.SpawnDenied then
			local missileships = 0
			for index, unit in pairs (Mission.MissileShipsA) do
				if not unit.Dead then
					missileships = missileships + 1
				end
			end
			for index, unit in pairs (Mission.MissileShipsB) do
				if not unit.Dead then
					missileships = missileships + 1
				end
			end
		
			if missileships == Mission.KeyUnitCounter then
-- RELEASE_LOGOFF  				luaLog(" Mission.SpawnDenied = true")
				Mission.SpawnDenied = true
				return
			end
		
			if type(index) == "table" or index == nil then
				index = timerthis.ParamTable.index
			end
			if not Mission.Completed then
-- RELEASE_LOGOFF  				luaLog("  -> SPAWNING MISSILE SHIP A"..index.." <-")
				Mission.MissileShipsA[index] = GenerateObject(Mission.MissileShipsATemplates[index].Name)
				AISetHintWeight(Mission.MissileShipsA[index], 10)
				SetSkillLevel(Mission.MissileShipsA[index], SKILL_STUN)
				Mission.JapMissileASpawnFlag[index] = false
				if not Mission.HQ1Down then
					NavigatorMoveOnPath(Mission.MissileShipsA[index], Mission.MissileAPaths[index])
					NavigatorSetTorpedoEvasion(Mission.MissileShipsA[index], false)
					NavigatorSetAvoidLandCollision(Mission.MissileShipsA[index], false)
					NavigatorSetAvoidShipCollision(Mission.MissileShipsA[index], false)
					ArtilleryEnable(Mission.MissileShipsA[index], false)
					local pathpoints = FillPathPoints(Mission.MissileAPaths[index])
					AddProximityTrigger(Mission.MissileShipsA[index], Mission.MissileATriggerID[index], Mission.MissileATriggerFunction[index], pathpoints[2], 100)
				else
					NavigatorMoveOnPath(Mission.MissileShipsA[index], Mission.MissileAbPaths[index])
					NavigatorSetTorpedoEvasion(Mission.MissileShipsA[index], false)
					NavigatorSetAvoidLandCollision(Mission.MissileShipsA[index], false)
					NavigatorSetAvoidShipCollision(Mission.MissileShipsA[index], false)
					ArtilleryEnable(Mission.MissileShipsA[index], false)
					local pathpoints = FillPathPoints(Mission.MissileAbPaths[index])
					AddProximityTrigger(Mission.MissileShipsA[index], Mission.MissileATriggerID[index], Mission.MissileAbTriggerFunction[index], pathpoints[2], 100)
				end
--[[
				if luaObj_IsActive("primary", 3) and luaObj_GetSuccess("primary", 3) == nil and luaObj_IsActive("primary", 4) and luaObj_GetSuccess("primary", 4) == nil then
-- RELEASE_LOGOFF  					luaLog("   primary 3 and 4 is still active, marking...")
					luaObj_AddUnit("primary", 3, Mission.MissileShipsA[index])
					luaObj_AddUnit("primary", 4, Mission.MissileShipsA[index])
					Mission.MissileShipsA[index].marked = true
				end
]]
			end
		end
	end
end

function luaQAS3JapMissileBSpawn(timerthis, index)
	if not Mission.Completed and not Mission.MissionEnd then
		if not Mission.SpawnDenied then
			local missileships = 0
			for index, unit in pairs (Mission.MissileShipsA) do
				if not unit.Dead then
					missileships = missileships + 1
				end
			end
			for index, unit in pairs (Mission.MissileShipsB) do
				if not unit.Dead then
					missileships = missileships + 1
				end
			end
		
			if missileships == Mission.KeyUnitCounter then
-- RELEASE_LOGOFF  				luaLog(" Mission.SpawnDenied = true")
				Mission.SpawnDenied = true
				return
			end
		
			if type(index) == "table" or index == nil then
				index = timerthis.ParamTable.index
			end
			if not Mission.Completed then
-- RELEASE_LOGOFF  				luaLog("  -> SPAWNING MISSILE SHIP B"..index.." <-")
				Mission.MissileShipsB[index] = GenerateObject(Mission.MissileShipsBTemplates[index].Name)
				AISetHintWeight(Mission.MissileShipsB[index], 10)
				SetSkillLevel(Mission.MissileShipsB[index], SKILL_STUN)
				Mission.JapMissileBSpawnFlag[index] = false
				if not Mission.HQ2Down then
					NavigatorMoveOnPath(Mission.MissileShipsB[index], Mission.MissileBPaths[index])
					NavigatorSetTorpedoEvasion(Mission.MissileShipsB[index], false)
					NavigatorSetAvoidLandCollision(Mission.MissileShipsB[index], false)
					NavigatorSetAvoidShipCollision(Mission.MissileShipsB[index], false)
					ArtilleryEnable(Mission.MissileShipsB[index], false)
					local pathpoints = FillPathPoints(Mission.MissileBPaths[index])
					AddProximityTrigger(Mission.MissileShipsB[index], Mission.MissileBTriggerID[index], Mission.MissileBTriggerFunction[index], pathpoints[2], 100)
				else
					NavigatorMoveOnPath(Mission.MissileShipsB[index], Mission.MissileBbPaths[index])
					NavigatorSetTorpedoEvasion(Mission.MissileShipsB[index], false)
					NavigatorSetAvoidLandCollision(Mission.MissileShipsB[index], false)
					NavigatorSetAvoidShipCollision(Mission.MissileShipsB[index], false)
					ArtilleryEnable(Mission.MissileShipsB[index], false)
					local pathpoints = FillPathPoints(Mission.MissileBbPaths[index])
					AddProximityTrigger(Mission.MissileShipsB[index], Mission.MissileBTriggerID[index], Mission.MissileBbTriggerFunction[index], pathpoints[2], 100)
				end
--[[
				if luaObj_IsActive("primary", 3) and luaObj_GetSuccess("primary", 3) == nil and luaObj_IsActive("primary", 4) and luaObj_GetSuccess("primary", 4) == nil then
-- RELEASE_LOGOFF  					luaLog("   primary 3 and 4 is still active, marking...")
					luaObj_AddUnit("primary", 3, Mission.MissileShipsB[index])
					luaObj_AddUnit("primary", 4, Mission.MissileShipsB[index])
					Mission.MissileShipsB[index].marked = true
				end
]]
			end
		end
	end
end

function luaQAS3USDestroyerSpawn(timerthis, index)
	if not Mission.Completed and not Mission.MissionEnd then
		if type(index) == "table" or index == nil then
			index = timerthis.ParamTable.index
		end
		if Mission.USSpawnAllowed[index] then
-- RELEASE_LOGOFF  			luaLog("  -> SPAWNING US DESTROYER "..index.." <-")
			Mission.USDestroyers[index] = GenerateObject(Mission.USDestroyerTemplates[index].Name)
			if Mission.NarrativesAllowed then
				MissionNarrativeParty(PARTY_ALLIED, "mp03.nar_siege_usdestroyer")
				MissionNarrativeParty(PARTY_JAPANESE, "mp03.nar_siege_usdestroyer")
			end
			AISetHintWeight(Mission.USDestroyers[index], 10)
			SetSkillLevel(Mission.USDestroyers[index], SKILL_SPNORMAL)
			TorpedoEnable(Mission.USDestroyers[index], true)
			Mission.USDestroyerSpawnFlag[index] = false
			local unitparty = "US"
			local unitindex = index
			luaQAS3SetShipTarget(unitparty, unitindex)
		end
	end
end

function luaQAS3JapDestroyerSpawn(timerthis, index)
	if not Mission.Completed and not Mission.MissionEnd then
		if type(index) == "table" or index == nil then
			index = timerthis.ParamTable.index
		end
		if Mission.JapSpawnAllowed[index] then
-- RELEASE_LOGOFF  			luaLog("  -> SPAWNING JAP DESTROYER "..index.." <-")
			Mission.JapDestroyers[index] = GenerateObject(Mission.JapDestroyerTemplates[index].Name)
			if Mission.NarrativesAllowed then
				MissionNarrativeParty(PARTY_ALLIED, "mp03.nar_siege_japdestroyer")
				MissionNarrativeParty(PARTY_JAPANESE, "mp03.nar_siege_japdestroyer")
			end
			AISetHintWeight(Mission.JapDestroyers[index], 10)
			SetSkillLevel(Mission.JapDestroyers[index], SKILL_SPNORMAL)
			TorpedoEnable(Mission.JapDestroyers[index], true)
			Mission.JapDestroyerSpawnFlag[index] = false
			local unitparty = "Jap"
			local unitindex = index
			luaQAS3SetShipTarget(unitparty, unitindex)
		end
	end
end

function luaQAS3SetShipTarget(unitparty, unitindex)
	if Mission.Started then
		if unitparty == "US" then
			if unitindex == 1 or unitindex == 2 then
				if not Mission.JapDestroyers[1].Dead then
-- RELEASE_LOGOFF  					luaLog("  sending US destroyer "..unitindex.." against Jap destroyer 1")
					NavigatorAttackMove(Mission.USDestroyers[unitindex], Mission.JapDestroyers[1], {})
				elseif not Mission.JapDestroyers[2].Dead then
-- RELEASE_LOGOFF  					luaLog("  sending US destroyer "..unitindex.." against Jap destroyer 2")
					NavigatorAttackMove(Mission.USDestroyers[unitindex], Mission.JapDestroyers[2], {})
				else
					if Mission.HQs[1].Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  						luaLog("  sending US destroyer "..unitindex.." against Jap HQ 1")
						NavigatorAttackMove(Mission.USDestroyers[unitindex], Mission.HQs[1], {})
					elseif Mission.HQs[2].Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  						luaLog("  sending US destroyer "..unitindex.." against Jap HQ 2")
						NavigatorAttackMove(Mission.USDestroyers[unitindex], Mission.HQs[2], {})
					end
				end
			else
				if not Mission.JapDestroyers[3].Dead then
-- RELEASE_LOGOFF  					luaLog("  sending US destroyer "..unitindex.." against Jap destroyer 3")
					NavigatorAttackMove(Mission.USDestroyers[unitindex], Mission.JapDestroyers[3], {})
				elseif not Mission.JapDestroyers[4].Dead then
-- RELEASE_LOGOFF  					luaLog("  sending US destroyer "..unitindex.." against Jap destroyer 4")
					NavigatorAttackMove(Mission.USDestroyers[unitindex], Mission.JapDestroyers[4], {})
				else
					if Mission.HQs[2].Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  						luaLog("  sending US destroyer "..unitindex.." against Jap HQ 2")
						NavigatorAttackMove(Mission.USDestroyers[unitindex], Mission.HQs[2], {})
					elseif Mission.HQs[1].Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  						luaLog("  sending US destroyer "..unitindex.." against Jap HQ 1")
						NavigatorAttackMove(Mission.USDestroyers[unitindex], Mission.HQs[1], {})
					end
				end
			end
		elseif unitparty == "Jap" then
			if unitindex == 1 or unitindex == 2 then
				if not Mission.USDestroyers[1].Dead then
-- RELEASE_LOGOFF  					luaLog("  sending Jap destroyer "..unitindex.." against US destroyer 1")
					NavigatorAttackMove(Mission.JapDestroyers[unitindex], Mission.USDestroyers[1], {})
				elseif not Mission.USDestroyers[2].Dead then
-- RELEASE_LOGOFF  					luaLog("  sending Jap destroyer "..unitindex.." against US destroyer 2")
					NavigatorAttackMove(Mission.JapDestroyers[unitindex], Mission.USDestroyers[2], {})
				else
					local shipAtable = luaRemoveDeadsFromTable(Mission.MissileShipsA)
					local randomship = luaPickRnd(shipAtable)
					if randomship ~= nil then
-- RELEASE_LOGOFF  						luaLog("  sending Jap destroyer "..unitindex.." against the missileships")
						NavigatorAttackMove(Mission.JapDestroyers[unitindex], randomship, {})
					end
				end
			else
				if not Mission.USDestroyers[3].Dead then
-- RELEASE_LOGOFF  					luaLog("  sending Jap destroyer "..unitindex.." against US destroyer 3")
					NavigatorAttackMove(Mission.JapDestroyers[unitindex], Mission.USDestroyers[3], {})
				elseif not Mission.USDestroyers[4].Dead then
-- RELEASE_LOGOFF  					luaLog("  sending Jap destroyer "..unitindex.." against US destroyer 4")
					NavigatorAttackMove(Mission.JapDestroyers[unitindex], Mission.USDestroyers[4], {})
				else
					local shipAtable = luaRemoveDeadsFromTable(Mission.MissileShipsB)
					local randomship = luaPickRnd(shipAtable)
					if randomship ~= nil then 
-- RELEASE_LOGOFF  						luaLog("  sending Jap destroyer "..unitindex.." against the missileships")
						NavigatorAttackMove(Mission.JapDestroyers[unitindex], randomship, {})
					end
				end
			end
		end
	end
end

function luaQAS3USLSTSpawn(timerthis, index)
	if not Mission.Completed and not Mission.MissionEnd then
		if type(index) == "table" or index == nil then
			index = timerthis.ParamTable.index
		end
		if Mission.LSTSpawnAllowed[index] then
-- RELEASE_LOGOFF  			luaLog("  -> SPAWNING US LST "..index.." <-")
			Mission.USLSTs[index] = GenerateObject(Mission.USLSTTemplates[index].Name)
			AISetHintWeight(Mission.USLSTs[index], 5)
			SetSkillLevel(Mission.USLSTs[index], SKILL_SPNORMAL)
			Mission.LSTSpawnFlag[index] = false
			NavigatorMoveOnPath(Mission.USLSTs[index], Mission.USLSTPaths[index])
			NavigatorSetTorpedoEvasion(Mission.USLSTs[index], false)
			NavigatorSetAvoidLandCollision(Mission.USLSTs[index], false)
			local pathpoints = FillPathPoints(Mission.USLSTPaths[index])
			local pathpointsnumber = table.getn(pathpoints)
			AddProximityTrigger(Mission.USLSTs[index], Mission.LSTProximityIDTable[index], Mission.LSTProximityFunctionTable[index], pathpoints[pathpointsnumber], 200)
		end
	end
end

function luaLST1Trigger()
-- RELEASE_LOGOFF  	luaLog(" LST1Trigger")
	StartLanding2(Mission.USLSTs[1])
end

function luaLST2Trigger()
-- RELEASE_LOGOFF  	luaLog(" LST2Trigger")
	StartLanding2(Mission.USLSTs[2])
end

function luaLST3Trigger()
-- RELEASE_LOGOFF  	luaLog(" LST3Trigger")
	StartLanding2(Mission.USLSTs[3])
end

function luaLST4Trigger()
-- RELEASE_LOGOFF  	luaLog(" LST4Trigger")
	StartLanding2(Mission.USLSTs[4])
end

function luaQAS3CheckPlanes()
-- RELEASE_LOGOFF  	luaLog(" Checking planes...")
	for index, unit in pairs (Mission.USPlanes) do
		if unit.Dead and not Mission.USPlaneSpawnFlag[index] then
-- RELEASE_LOGOFF  			luaLog("  "..index..". US down, delaying respawn")
			Mission.USPlaneSpawnFlag[index] = true
			Mission.HellcatDown = Mission.HellcatDown + 1
			local randomtime = luaRnd(50, 75)
			local delaytime = randomtime + 0.1 * index
			by = luaCheckPlaneNumber(unit)
			luaResourcePoolReducer("usplane", by)
			luaDelay(luaQAS3USPlaneSpawn, delaytime, "index", index)
		elseif not unit.Dead then
			previouscheck = luaCheckPlaneNumber(unit)
			local planesinsquad = table.getn(GetSquadronPlanes(unit))
			if planesinsquad < previouscheck then
				by = previouscheck - planesinsquad
				unit.checkednumber = planesinsquad
				luaResourcePoolReducer("usplane", by)
			elseif planesinsquad == 3 then
				unit.checkednumber = planesinsquad
			end
			if UnitGetAttackTarget(unit) == nil then
				
			end
		end
	end

	for index, unit in pairs (Mission.JapPlanes) do
		if unit.Dead and not Mission.JapPlaneSpawnFlag[index] then
-- RELEASE_LOGOFF  			luaLog("  "..index..". US down, delaying respawn")
			Mission.JapPlaneSpawnFlag[index] = true
			Mission.ZeroDown = Mission.ZeroDown + 1
			local randomtime = luaRnd(50, 75)
			local delaytime = randomtime + 0.1 * index
			by = luaCheckPlaneNumber(unit)
			luaResourcePoolReducer("japplane", by)
			luaDelay(luaQAS3JapPlaneSpawn, delaytime, "index", index)
		elseif not unit.Dead then
			previouscheck = luaCheckPlaneNumber(unit)
			local planesinsquad = table.getn(GetSquadronPlanes(unit))
			if planesinsquad < previouscheck then
				by = previouscheck - planesinsquad
				unit.checkednumber = planesinsquad
				luaResourcePoolReducer("japplane", by)
			elseif planesinsquad == 3 then
				unit.checkednumber = planesinsquad
			end
			if UnitGetAttackTarget(unit) == nil then
				
			end
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

function luaQAS3USPlaneSpawn(timerthis, index)
	if not Mission.Completed and not Mission.MissionEnd then
		if type(index) == "table" or index == nil then
			index = timerthis.ParamTable.index
		end
		if Mission.USSpawnAllowed[index] then
-- RELEASE_LOGOFF  			luaLog("  -> SPAWNING US PLANE "..index.." <-")
			Mission.USPlanes[index] = GenerateObject(Mission.USPlaneTemplates[index].Name)
			if Mission.NarrativesAllowed then
				MissionNarrativeParty(PARTY_ALLIED, "mp03.nar_siege_usplane")
				MissionNarrativeParty(PARTY_JAPANESE, "mp03.nar_siege_usplane")
			end
			AISetHintWeight(Mission.USPlanes[index], 0)
			SetSkillLevel(Mission.USPlanes[index], SKILL_SPNORMAL)
			Mission.USPlaneSpawnFlag[index] = false
			if index == 1 or index == 2 then
				if not Mission.HQ1Down then
					PilotMoveToRange(Mission.USPlanes[index], Mission.NavPoints[1], 200)
				else
					PilotMoveToRange(Mission.USPlanes[index], Mission.NavPoints[2], 200)
				end
			else
				if not Mission.HQ2Down then
					PilotMoveToRange(Mission.USPlanes[index], Mission.NavPoints[2], 200)
				else
					PilotMoveToRange(Mission.USPlanes[index], Mission.NavPoints[1], 200)
				end
			end
			SquadronSetTravelAlt(Mission.USPlanes[index], 100)
			SquadronSetAttackAlt(Mission.USPlanes[index], 100)
--[[
			if luaObj_IsActive("secondary", 4) and luaObj_GetSuccess("secondary", 4) == nil then
-- RELEASE_LOGOFF  				luaLog("   secondary 4 is still active, marking...")
				luaObj_AddUnit("secondary", 4, Mission.USPlanes[index])
				Mission.USPlanes[index].marked = true
			end
]]
		end
	end
end

function luaQAS3JapPlaneSpawn(timerthis, index)
	if not Mission.Completed and not Mission.MissionEnd then
		if type(index) == "table" or index == nil then
			index = timerthis.ParamTable.index
		end
		if Mission.JapSpawnAllowed[index] then
-- RELEASE_LOGOFF  			luaLog("  -> SPAWNING JAP PLANE "..index.." <-")
			Mission.JapPlanes[index] = GenerateObject(Mission.JapPlaneTemplates[index].Name)
			if Mission.NarrativesAllowed then
				MissionNarrativeParty(PARTY_ALLIED, "mp03.nar_siege_japplane")
				MissionNarrativeParty(PARTY_JAPANESE, "mp03.nar_siege_japplane")
			end
			AISetHintWeight(Mission.JapPlanes[index], 0)
			SetSkillLevel(Mission.JapPlanes[index], SKILL_SPNORMAL)
			Mission.JapPlaneSpawnFlag[index] = false
			if index == 1 or index == 2 then
				PilotMoveToRange(Mission.JapPlanes[index], Mission.NavPoints[1], 200)
			else
				PilotMoveToRange(Mission.JapPlanes[index], Mission.NavPoints[2], 200)
			end
			SquadronSetTravelAlt(Mission.JapPlanes[index], 100)
			SquadronSetAttackAlt(Mission.JapPlanes[index], 100)
--[[
			if luaObj_IsActive("secondary", 3) and luaObj_GetSuccess("secondary", 3) == nil then
-- RELEASE_LOGOFF  				luaLog("   secondary 3 is still active, marking...")
				luaObj_AddUnit("secondary", 3, Mission.JapPlanes[index])
				Mission.JapPlanes[index].marked = true
			end
]]
		end
	end
end

function luaQAS3ShipA1InPos()
	if not Mission.Completed and not Mission.MissileShipsA[1].Dead then
-- RELEASE_LOGOFF  		luaLog("  -> ShipA1InPos <-")
		ArtilleryEnable(Mission.MissileShipsA[1], true)
		luaSetScriptTarget(Mission.MissileShipsA[1], Mission.HQs[1])
		Mission.MissileShipAInPos[1] = true
	end
end

function luaQAS3ShipAb1InPos()
	if not Mission.Completed and not Mission.MissileShipsA[1].Dead then
-- RELEASE_LOGOFF  		luaLog("  -> ShipAb1InPos <-")
		ArtilleryEnable(Mission.MissileShipsA[1], true)
		luaSetScriptTarget(Mission.MissileShipsA[1], Mission.HQs[2])
		Mission.MissileShipAInPos[1] = true
	end
end

function luaQAS3ShipA2InPos()
	if not Mission.Completed and not Mission.MissileShipsA[2].Dead then
-- RELEASE_LOGOFF  		luaLog("  -> ShipA2InPos <-")
		ArtilleryEnable(Mission.MissileShipsA[2], true)
		luaSetScriptTarget(Mission.MissileShipsA[2], Mission.HQs[1])
		Mission.MissileShipAInPos[2] = true
	end
end

function luaQAS3ShipAb2InPos()
	if not Mission.Completed and not Mission.MissileShipsA[2].Dead then
-- RELEASE_LOGOFF  		luaLog("  -> ShipAb2InPos <-")
		ArtilleryEnable(Mission.MissileShipsA[2], true)
		luaSetScriptTarget(Mission.MissileShipsA[2], Mission.HQs[2])
		Mission.MissileShipAInPos[2] = true
	end
end

function luaQAS3ShipA3InPos()
	if not Mission.Completed and not Mission.MissileShipsA[3].Dead then
-- RELEASE_LOGOFF  		luaLog("  -> ShipA3InPos <-")
		ArtilleryEnable(Mission.MissileShipsA[3], true)
		luaSetScriptTarget(Mission.MissileShipsA[3], Mission.HQs[1])
		Mission.MissileShipAInPos[3] = true
	end
end

function luaQAS3ShipAb3InPos()
	if not Mission.Completed and not Mission.MissileShipsA[3].Dead then
-- RELEASE_LOGOFF  		luaLog("  -> ShipAb3InPos <-")
		ArtilleryEnable(Mission.MissileShipsA[3], true)
		luaSetScriptTarget(Mission.MissileShipsA[3], Mission.HQs[2])
		Mission.MissileShipAInPos[3] = true
	end
end

function luaQAS3ShipB1InPos()
	if not Mission.Completed and not Mission.MissileShipsB[1].Dead then
-- RELEASE_LOGOFF  		luaLog("  -> ShipB1InPos <-")
		ArtilleryEnable(Mission.MissileShipsB[1], true)
		luaSetScriptTarget(Mission.MissileShipsB[1], Mission.HQs[2])
		Mission.MissileShipBInPos[1] = true
	end
end

function luaQAS3ShipBb1InPos()
	if not Mission.Completed and not Mission.MissileShipsB[1].Dead then
-- RELEASE_LOGOFF  		luaLog("  -> ShipBb1InPos <-")
		ArtilleryEnable(Mission.MissileShipsB[1], true)
		luaSetScriptTarget(Mission.MissileShipsB[1], Mission.HQs[1])
		Mission.MissileShipBInPos[1] = true
	end
end

function luaQAS3ShipB2InPos()
	if not Mission.Completed and not Mission.MissileShipsB[2].Dead then
-- RELEASE_LOGOFF  		luaLog("  -> ShipB2InPos <-")
		ArtilleryEnable(Mission.MissileShipsB[2], true)
		luaSetScriptTarget(Mission.MissileShipsB[2], Mission.HQs[2])
		Mission.MissileShipBInPos[2] = true
	end
end

function luaQAS3ShipBb2InPos()
	if not Mission.Completed and not Mission.MissileShipsB[2].Dead then
-- RELEASE_LOGOFF  		luaLog("  -> ShipBb2InPos <-")
		ArtilleryEnable(Mission.MissileShipsB[2], true)
		luaSetScriptTarget(Mission.MissileShipsB[2], Mission.HQs[1])
		Mission.MissileShipBInPos[2] = true
	end
end

function luaQAS3ShipB3InPos()
	if not Mission.Completed and not Mission.MissileShipsB[3].Dead then
-- RELEASE_LOGOFF  		luaLog("  -> ShipB3InPos <-")
		ArtilleryEnable(Mission.MissileShipsB[3], true)
		luaSetScriptTarget(Mission.MissileShipsB[3], Mission.HQs[2])
		Mission.MissileShipBInPos[3] = true
	end
end

function luaQAS3ShipBb3InPos()
	if not Mission.Completed and not Mission.MissileShipsB[3].Dead then
-- RELEASE_LOGOFF  		luaLog("  -> ShipBb3InPos <-")
		ArtilleryEnable(Mission.MissileShipsB[3], true)
		luaSetScriptTarget(Mission.MissileShipsB[3], Mission.HQs[1])
		Mission.MissileShipBInPos[3] = true
	end
end

function luaQAS3CheckMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Checking mission end...")
	if Mission.KeyUnitCounter == 0 and not Mission.MissionEndCalled then
		Mission.MissionEndCalled = true
		for i = 1, 4 do
			Mission.USSpawnAllowed[i] = false
		end
		--luaObj_Completed("primary", 4)
		--luaObj_Failed("primary", 3)
		luaQAS3MissionEnd()
	end
end

function luaQAS3MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Ending mission...")
	if not Mission.Completed and not Mission.MissionEnd then
		Scoring_RealPlayTimeRunning(false)
		if Mission.HQ1Down and Mission.HQ2Down then
-- RELEASE_LOGOFF  			luaLog("  US forces won")
			Mission.Completed = true
			luaObj_Completed("primary", 1)
			luaObj_Failed("primary", 2)
--[[
			if luaObj_IsActive("primary", 3) and luaObj_GetSuccess("primary", 3) == nil and luaObj_IsActive("primary", 4) and luaObj_GetSuccess("primary", 4) == nil then
				luaObj_Completed("primary", 3)
				luaObj_Failed("primary", 4)
			end
]]
			luaMissionCompletedNew(luaPickRnd(Mission.HQs), "", nil, nil, nil, PARTY_ALLIED)
		elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 or Mission.Randomize == 1 then
-- RELEASE_LOGOFF  			luaLog(" Jap side wins")
			Mission.Completed = true
			Mission.MissionEndCalled = true
			luaObj_Failed("primary", 1)
			luaObj_Completed("primary", 2)
			luaMissionCompletedNew(luaPickRnd(Mission.HQs), "", nil, nil, nil, PARTY_JAPANESE)
		elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 or Mission.Randomize == 2 then
-- RELEASE_LOGOFF  			luaLog(" US side wins")
			Mission.Completed = true
			Mission.MissionEndCalled = true
			luaObj_Completed("primary", 1)
			luaObj_Failed("primary", 2)
			luaMissionCompletedNew(luaPickRnd(Mission.HQs), "", nil, nil, nil, PARTY_ALLIED)
		end
--[[
		if luaObj_IsActive("secondary", 1) then
			luaObj_Failed("secondary", 1)
		end
		if luaObj_IsActive("secondary", 2) then
			luaObj_Failed("secondary", 2)
		end
		if luaObj_IsActive("secondary", 3) then
			luaObj_Failed("secondary", 3)
		end
		if luaObj_IsActive("secondary", 4) then
			luaObj_Failed("secondary", 4)
		end

		luaMissionCompletedNew(luaPickRnd(Mission.HQs), "", nil, nil, nil, PARTY_ALLIED)
	else
-- RELEASE_LOGOFF  		luaLog("  Japanese forces won")
		Mission.Completed = true
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)

		if luaObj_IsActive("secondary", 1) then
			luaObj_Failed("secondary", 1)
		end
		if luaObj_IsActive("secondary", 2) then
			luaObj_Failed("secondary", 2)
		end
		if luaObj_IsActive("secondary", 3) then
			luaObj_Failed("secondary", 3)
		end
		if luaObj_IsActive("secondary", 4) then
			luaObj_Failed("secondary", 4)
		end

		luaMissionCompletedNew(luaPickRnd(Mission.HQs), "", nil, nil, nil, PARTY_JAPANESE)
]]
	end
end

function luaCheat()
	for index, unit in pairs (Mission.MissileShipsA) do
		if not unit.Dead then
			Kill(unit, true)
		end
	end
	for index, unit in pairs (Mission.MissileShipsB) do
		if not unit.Dead then
			Kill(unit, true)
		end
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Siege03")
	-- mode description hint overlay
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

	DisplayScores(1, 0, "mp01.score_siege_resource_att".."| #MultiScore.0.1#", "mp01.score_siege_resource_def".."| #MultiScore.0.2#", 2, 1)
	DisplayScores(1, 1, "mp01.score_siege_resource_att".."| #MultiScore.1.1#", "mp01.score_siege_resource_def".."| #MultiScore.1.2#", 2, 1)
	DisplayScores(1, 2, "mp01.score_siege_resource_att".."| #MultiScore.2.1#", "mp01.score_siege_resource_def".."| #MultiScore.2.2#", 2, 1)
	DisplayScores(1, 3, "mp01.score_siege_resource_att".."| #MultiScore.3.1#", "mp01.score_siege_resource_def".."| #MultiScore.3.2#", 2, 1)
	DisplayScores(1, 4, "mp01.score_siege_resource_att".."| #MultiScore.4.1#", "mp01.score_siege_resource_def".."| #MultiScore.4.2#", 2, 1)
	DisplayScores(1, 5, "mp01.score_siege_resource_att".."| #MultiScore.5.1#", "mp01.score_siege_resource_def".."| #MultiScore.5.2#", 2, 1)
	DisplayScores(1, 6, "mp01.score_siege_resource_att".."| #MultiScore.6.1#", "mp01.score_siege_resource_def".."| #MultiScore.6.2#", 2, 1)
	DisplayScores(1, 7, "mp01.score_siege_resource_att".."| #MultiScore.7.1#", "mp01.score_siege_resource_def".."| #MultiScore.7.2#", 2, 1)
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

function luaResourcePoolReducer(unit, by)
-- RELEASE_LOGOFF  	luaLog(" luaResourcePoolReducer: "..unit)
	if unit == "usplayer" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourcePlayerUnit
	elseif unit == "japplayer" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourcePlayerUnit
	elseif unit == "shinyo" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapShinyo
	elseif unit == "LSM" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSLSM
	elseif unit == "LST" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSLST
	elseif unit == "usplane" then
		local todeduct = Mission.ResourceUSPlane * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "japplane" then
		local todeduct = Mission.ResourceJapPlane * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "usdestroyer" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSDestroyer
	elseif unit == "japdestroyer" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapDestroyer
	elseif unit == "HQ" then
		local todeduct = Mission.ResourceJapHQ * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	end

	Mission.ResourceUSPool = luaRound(Mission.ResourceUSPool)
	Mission.ResourceJapPool = luaRound(Mission.ResourceJapPool)

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
		luaQAS3MissionEnd()
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" Jap pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaQAS3MissionEnd()
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool < 1 then
-- RELEASE_LOGOFF  		luaLog(" both pools are under 1 point")
		Mission.Randomize = luaRnd(1, 2)
		if Mission.Randomize == 1 then
			for i = 0, 7 do
				MultiScore[i][1] = 0
				MultiScore[i][2] = 1
			end
			Mission.MissionEndCalled = true
			luaQAS3MissionEnd()
		else
			for i = 0, 7 do
				MultiScore[i][1] = 1
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaQAS3MissionEnd()
		end
	end
end

function luaCheckPlayers()
-- RELEASE_LOGOFF  	luaLog(" Checking players...")
	if not Mission.IDTableInitiated then
		Mission.USTable = {}
		Mission.JapTable = {}
		Mission.IDTableInitiated = true
	end

	if table.getn(Mission.USTable) ~= 0 then
		for index, unit in pairs (Mission.USTable) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead player unit found in Mission.USTable")
				if unit.Class.ID == 27 then
					luaResourcePoolReducer("usplayer")
				elseif unit.Class.ID == 239 then
					luaResourcePoolReducer("LST")
				end
				table.remove(Mission.USTable, index)
			end
		end
	end

	if table.getn(Mission.JapTable) ~= 0 then
		for index, unit in pairs (Mission.JapTable) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead player unit found in Mission.JapTable")
				if unit.Class.ID == 77 then
					luaResourcePoolReducer("japplayer")
				elseif unit.Class.ID == 43 then
					luaResourcePoolReducer("shinyo")
				end
				table.remove(Mission.JapTable, index)
			end
		end
	end

	local usships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	local japships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
	if usships ~= nil then
		for index, unit in pairs (usships) do
			local ownerID = GetRoleAvailable(unit)[1]
			if unit.Class.ID == 27 or ownerID >= 0 and ownerID <= 7 then
				if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  					luaLog("  new player unit found, inserting it to Mission.USTable")
					table.insert(Mission.USTable, unit)
				end
			end
		end
	end
	if japships ~= nil then
		for index, unit in pairs (japships) do
			local ownerID = GetRoleAvailable(unit)[1]
			if unit.Class.ID == 77 or unit.Class.ID == 43 then
				if not luaIsInside(unit, Mission.JapTable) then
-- RELEASE_LOGOFF  					luaLog("  new player unit found, inserting it to Mission.JapTable")
					table.insert(Mission.JapTable, unit)
				end
			end
		end
	end
end

function luaQAS3HintManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 30 and not Mission.Hint1Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint1Shown")
			ShowHint("ID_Hint_Siege03_islands")
			Mission.Hint1Shown = true
		elseif GameTime() > 60 and not Mission.Hint2Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint2Shown")
			ShowHint("ID_Hint_Siege03_DP")
			Mission.Hint2Shown = true
		elseif GameTime() > 90 and not Mission.Hint3Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint3Shown")
			ShowHint("ID_Hint_Siege03_LST")
			Mission.Hint3Shown = true
		end
	end
end

function luaQAS3SetLSMSkillLevel()
-- RELEASE_LOGOFF  	luaLog(" Setting LSM's skill level...")
	if not Mission.Completed and not Mission.MissionEnd then
		if Mission.LSMSkillLevel == 1 then
			for index, unit in pairs (Mission.MissileShipsA) do
				if not unit.Dead then
					SetSkillLevel(unit, SKILL_SPNORMAL)
				end
			end
			for index, unit in pairs (Mission.MissileShipsB) do
				if not unit.Dead then
					SetSkillLevel(unit, SKILL_SPNORMAL)
				end
			end
			Mission.LSMSkillLevel = 2
			luaDelay(luaQAS3SetLSMSkillLevel, 20)
		else
			for index, unit in pairs (Mission.MissileShipsA) do
				if not unit.Dead then
					SetSkillLevel(unit, SKILL_STUN)
				end
			end
			for index, unit in pairs (Mission.MissileShipsB) do
				if not unit.Dead then
					SetSkillLevel(unit, SKILL_STUN)
				end
			end
			Mission.LSMSkillLevel = 1
			luaDelay(luaQAS3SetLSMSkillLevel, 13)
		end
	end
end