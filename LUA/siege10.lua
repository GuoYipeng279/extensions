--SceneFile="Missions\Multi\Scene1.scn"

function luaPrecacheUnits()
	PrepareClass(234)	-- US troop transport DLC1
	PrepareClass(40)	-- Higgings DLC1
	
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAS10Mission")
end

function luaInitQAS10Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Siege10"..dateandtime

	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.."!")

	-- lobby
-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")

	-- globalban hasznalando
	this.Multiplayer = true
	this.ThinkCounter = 0
	Mission.MultiplayerType = "Siege"
	Mission.MultiplayerNumber = 10

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- mission valtozok
	Mission.MissionPhase = 0

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
	--[[	table.insert(Mission.SpawnPoints2, FindEntity("Siege - US SP2 1"))
		table.insert(Mission.SpawnPoints2, FindEntity("Siege - US SP2 2"))
		table.insert(Mission.SpawnPoints2, FindEntity("Siege - US SP2 3"))
		table.insert(Mission.SpawnPoints2, FindEntity("Siege - US SP2 4"))]]
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
		local slotID = index + 3
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

	-- amerikai objektumok
	Mission.USBB = FindEntity("Siege - Iowa")
	Mission.USTTs = {}
	Mission.USTTTemplates = {}
		table.insert(Mission.USTTTemplates, luaFindHidden("Siege - USTroopTransport 1"))
		table.insert(Mission.USTTTemplates, luaFindHidden("Siege - USTroopTransport 2"))
		table.insert(Mission.USTTTemplates, luaFindHidden("Siege - USTroopTransport 3"))
		table.insert(Mission.USTTTemplates, luaFindHidden("Siege - USTroopTransport 4"))

	Mission.USLandingUnits = {}
	Mission.USLandingUnits[1] = {}
	Mission.USLandingUnits[2] = {}
	Mission.USLandingUnits[3] = {}
	Mission.USLandingUnits[4] = {}
	
	Mission.USLandingTemplate = luaFindHidden("Siege - Higgins template")
--[[
	Mission.USLandingBoats01 = {}
		table.insert(Mission.USLandingBoats01, luaFindHidden("Siege - Higgins template 01"))
		table.insert(Mission.USLandingBoats01, luaFindHidden("Siege - Higgins template 02"))
		table.insert(Mission.USLandingBoats01, luaFindHidden("Siege - Higgins template 03"))
		table.insert(Mission.USLandingBoats01, luaFindHidden("Siege - Higgins template 04"))
	Mission.USLandingBoats02 = {}
		table.insert(Mission.USLandingBoats02, luaFindHidden("Siege - Higgins template 05"))
		table.insert(Mission.USLandingBoats02, luaFindHidden("Siege - Higgins template 06"))
		table.insert(Mission.USLandingBoats02, luaFindHidden("Siege - Higgins template 07"))
		table.insert(Mission.USLandingBoats02, luaFindHidden("Siege - Higgins template 08"))
	Mission.USLandingBoats03 = {}
		table.insert(Mission.USLandingBoats03, luaFindHidden("Siege - Higgins template 09"))
		table.insert(Mission.USLandingBoats03, luaFindHidden("Siege - Higgins template 10"))
		table.insert(Mission.USLandingBoats03, luaFindHidden("Siege - Higgins template 11"))
		table.insert(Mission.USLandingBoats03, luaFindHidden("Siege - Higgins template 12"))
	Mission.USLandingBoats04 = {}
		table.insert(Mission.USLandingBoats04, luaFindHidden("Siege - Higgins template 13"))
		table.insert(Mission.USLandingBoats04, luaFindHidden("Siege - Higgins template 14"))
		table.insert(Mission.USLandingBoats04, luaFindHidden("Siege - Higgins template 15"))
		table.insert(Mission.USLandingBoats04, luaFindHidden("Siege - Higgins template 16"))
	Mission.USLandingTemplates = {}
		table.insert(Mission.USLandingTemplates, Mission.USLandingBoats01)
		table.insert(Mission.USLandingTemplates, Mission.USLandingBoats02)
		table.insert(Mission.USLandingTemplates, Mission.USLandingBoats03)
		table.insert(Mission.USLandingTemplates, Mission.USLandingBoats04)
]]

	Mission.Iowa = {}
		table.insert(Mission.Iowa, FindEntity("Siege - Iowa"))

	-- japan objektumok
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("Siege - HQ 03"))
		table.insert(Mission.HQs, FindEntity("Siege - HQ 04"))
	Mission.Fortresses = {}
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 01"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 02"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 03"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 04"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 05"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 06"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 07"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 08"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 09"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 10"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 11"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 12"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 13"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 14"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 15"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 16"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 17"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 18"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 19"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 20"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 21"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 22"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 23"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 24"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 25"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 26"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 27"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 28"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 29"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 30"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 31"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 32"))
		table.insert(Mission.Fortresses, FindEntity("SiegeGunner 33"))
		--AA gunok
		table.insert(Mission.Fortresses, FindEntity("Siege_Heavy AA, Japanese 01"))
		table.insert(Mission.Fortresses, FindEntity("Siege_Heavy AA, Japanese 02"))
		table.insert(Mission.Fortresses, FindEntity("Siege_Heavy AA, Japanese 03"))
		table.insert(Mission.Fortresses, FindEntity("Siege_Heavy AA, Japanese 04"))
		table.insert(Mission.Fortresses, FindEntity("Siege_Heavy AA, Japanese 05"))
		table.insert(Mission.Fortresses, FindEntity("Siege_Heavy AA, Japanese 06"))
		table.insert(Mission.Fortresses, FindEntity("Siege_Heavy AA, Japanese 07"))
		table.insert(Mission.Fortresses, FindEntity("Siege_Heavy AA, Japanese 08"))
		table.insert(Mission.Fortresses, FindEntity("Siege_Heavy AA, Japanese 09"))
		table.insert(Mission.Fortresses, FindEntity("Siege_Heavy AA, Japanese 10"))
		table.insert(Mission.Fortresses, FindEntity("Siege_Heavy AA, Japanese 11"))
		table.insert(Mission.Fortresses, FindEntity("Siege_Heavy AA, Japanese 12"))
		table.insert(Mission.Fortresses, FindEntity("Siege_Heavy AA, Japanese 13"))
		table.insert(Mission.Fortresses, FindEntity("Siege_Heavy AA, Japanese 14"))
		table.insert(Mission.Fortresses, FindEntity("Siege_Heavy AA, Japanese 15"))
		table.insert(Mission.Fortresses, FindEntity("Siege_Heavy AA, Japanese 16"))

	Mission.FortressesBig = {}
		table.insert(Mission.FortressesBig, FindEntity("Siege - Fortress 01"))
		table.insert(Mission.FortressesBig, FindEntity("Siege - Fortress 02"))
		table.insert(Mission.FortressesBig, FindEntity("Siege - Fortress 03"))
		table.insert(Mission.FortressesBig, FindEntity("Siege - Fortress 04"))
		table.insert(Mission.FortressesBig, FindEntity("Siege - Fortress 05"))
		table.insert(Mission.FortressesBig, FindEntity("Siege - Fortress 06"))
		table.insert(Mission.FortressesBig, FindEntity("Siege - Fortress 07"))
		table.insert(Mission.FortressesBig, FindEntity("Siege - Fortress 08"))

	-- pathok, navpontok
	Mission.USTTPaths = {}
		table.insert(Mission.USTTPaths, FindEntity("Siege - USTTPath 1"))
		table.insert(Mission.USTTPaths, FindEntity("Siege - USTTPath 2"))
		table.insert(Mission.USTTPaths, FindEntity("Siege - USTTPath 3"))
		table.insert(Mission.USTTPaths, FindEntity("Siege - USTTPath 4"))
	Mission.USLandingPoints = {}
	Mission.USLandingPoints[1] = {}
		table.insert(Mission.USLandingPoints[1], GetPosition(FindEntity("Siege - LPB 1")))
		table.insert(Mission.USLandingPoints[1], GetPosition(FindEntity("Siege - LPB 2")))
		table.insert(Mission.USLandingPoints[1], GetPosition(FindEntity("Siege - LPB 3")))
		table.insert(Mission.USLandingPoints[1], GetPosition(FindEntity("Siege - LPB 4")))
		table.insert(Mission.USLandingPoints[1], GetPosition(FindEntity("Siege - LPB 17")))
		table.insert(Mission.USLandingPoints[1], GetPosition(FindEntity("Siege - LPB 18")))
		table.insert(Mission.USLandingPoints[1], GetPosition(FindEntity("Siege - LPB 19")))
		table.insert(Mission.USLandingPoints[1], GetPosition(FindEntity("Siege - LPB 20")))
	Mission.USLandingPoints[2] = {}
		table.insert(Mission.USLandingPoints[2], GetPosition(FindEntity("Siege - LPB 5")))
		table.insert(Mission.USLandingPoints[2], GetPosition(FindEntity("Siege - LPB 6")))
		table.insert(Mission.USLandingPoints[2], GetPosition(FindEntity("Siege - LPB 7")))
		table.insert(Mission.USLandingPoints[2], GetPosition(FindEntity("Siege - LPB 8")))
		table.insert(Mission.USLandingPoints[2], GetPosition(FindEntity("Siege - LPB 21")))
		table.insert(Mission.USLandingPoints[2], GetPosition(FindEntity("Siege - LPB 22")))
		table.insert(Mission.USLandingPoints[2], GetPosition(FindEntity("Siege - LPB 23")))
		table.insert(Mission.USLandingPoints[2], GetPosition(FindEntity("Siege - LPB 24")))
	Mission.USLandingPoints[3] = {}
		table.insert(Mission.USLandingPoints[3], GetPosition(FindEntity("Siege - LPB 9")))
		table.insert(Mission.USLandingPoints[3], GetPosition(FindEntity("Siege - LPB 10")))
		table.insert(Mission.USLandingPoints[3], GetPosition(FindEntity("Siege - LPB 11")))
		table.insert(Mission.USLandingPoints[3], GetPosition(FindEntity("Siege - LPB 12")))
		table.insert(Mission.USLandingPoints[3], GetPosition(FindEntity("Siege - LPB 25")))
		table.insert(Mission.USLandingPoints[3], GetPosition(FindEntity("Siege - LPB 26")))
		table.insert(Mission.USLandingPoints[3], GetPosition(FindEntity("Siege - LPB 27")))
		table.insert(Mission.USLandingPoints[3], GetPosition(FindEntity("Siege - LPB 28")))
	Mission.USLandingPoints[4] = {}
		table.insert(Mission.USLandingPoints[4], GetPosition(FindEntity("Siege - LPB 13")))
		table.insert(Mission.USLandingPoints[4], GetPosition(FindEntity("Siege - LPB 14")))
		table.insert(Mission.USLandingPoints[4], GetPosition(FindEntity("Siege - LPB 15")))
		table.insert(Mission.USLandingPoints[4], GetPosition(FindEntity("Siege - LPB 16")))
		table.insert(Mission.USLandingPoints[4], GetPosition(FindEntity("Siege - LPB 29")))
		table.insert(Mission.USLandingPoints[4], GetPosition(FindEntity("Siege - LPB 30")))
		table.insert(Mission.USLandingPoints[4], GetPosition(FindEntity("Siege - LPB 31")))
		table.insert(Mission.USLandingPoints[4], GetPosition(FindEntity("Siege - LPB 32")))

	-- egyeb
	Mission.USTTTriggerID = {}
		table.insert(Mission.USTTTriggerID, TT1Watch)
		table.insert(Mission.USTTTriggerID, TT2Watch)
		table.insert(Mission.USTTTriggerID, TT3Watch)
		table.insert(Mission.USTTTriggerID, TT4Watch)
	Mission.USTTTriggerFunction = {}
		table.insert(Mission.USTTTriggerFunction, "luaQAS10USTT1InPos")
		table.insert(Mission.USTTTriggerFunction, "luaQAS10USTT2InPos")
		table.insert(Mission.USTTTriggerFunction, "luaQAS10USTT3InPos")
		table.insert(Mission.USTTTriggerFunction, "luaQAS10USTT4InPos")

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
	Mission.Resource = {}
	Mission.Resource.PlayerUnit			= 6
	Mission.Resource.USHQ						= 3
	Mission.Resource.USIowa					= 4
	Mission.Resource.USTT						= 60
	Mission.Resource.USLandingBoat	= 2
	Mission.Resource.JAPSiegeGunner	= 6
	Mission.Resource.JAPAAGun				= 6
	Mission.Resource.JAPFort				= 50

	Mission.RespawnTime							= 30
	--Mission.HP_HQ										= 10000

	Mission.Iowa[1].PreviousHPPercentage = 1
	for index, unit in pairs (Mission.HQs) do
		unit.PreviousHPPercentage = 1
	end
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
		},
		["secondary"] =	{
			[1] = {
				["Party"] = PARTY_ALLIED,
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
		},
		["hidden"] = {
		}
	}
	Scoring_SetFinalScoringFunctionName("luaObj_DoScoring")

	--SetRocketAirGroundTypeDifferent(false)

	--AISetSpawnSceneUnitsWeightMul(0)

	luaInitNewSystems()

    SetThink(this, "luaQAS10Mission_think")
end

function luaQAS10Mission_think(this, msg)
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
		luaQAS10CheckObjUnits()
		luaQAS10CheckLanding()
		luaCheckPlayers()
		luaQAS10HintManager()
	elseif not Mission.Started then
		luaQAS10StartMission()
		luaSetMultiScoreTable()
	end
end

function luaQAS10StartMission()
-- RELEASE_LOGOFF  	luaLog(" Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()

	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)
	AISetTargetWeight(26, 428, false, 7.5) -- Hellcat vs Fortress small
	AISetTargetWeight(104, 428, false, 7.5) -- Lightning vs Fortress small
	AISetTargetWeight(26, 403, false, 15) -- Hellcat vs Bunker-med
	AISetTargetWeight(104, 403, false, 15) -- Lightning vs Bunker-med
	AISetTargetWeight(26, 452, false, 15) -- Hellcat vs Heavy AA jap
	AISetTargetWeight(104, 452, false, 15) -- Lightning vs Heavy AA jap
	AISetTargetWeight(151, 234, false, 0) -- Raiden vs TT
	AISetTargetWeight(152, 234, false, 0) -- Gekko vs TT
	AISetTargetWeight(159, 234, false, 10) -- Judy vs TT
	AISetTargetWeight(151, 40, false, 15) -- Raiden vs Higgins
	AISetTargetWeight(152, 40, false, 15) -- Gekko vs Higgins
	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2)
	for index, unit in pairs (Mission.HQs) do
		luaObj_AddUnit("primary", 1, unit)
		luaObj_AddUnit("primary", 2, unit)
	end
	luaObj_Add("secondary", 1)
	for index, unit in pairs (Mission.FortressesBig) do
		luaObj_AddUnit("secondary", 1, unit)
		AISetHintWeight(unit, 5)
		SetSkillLevel(unit, SKILL_SPNORMAL)
	end
	for index, unit in pairs (Mission.Fortresses) do
		AISetHintWeight(unit, 5)
	end
	for index, unit in pairs (Mission.USTTTemplates) do
-- RELEASE_LOGOFF  		luaLog("  generating TT "..index.."...")
		local transport = GenerateObject(unit.Name)
		transport.group = index
		NavigatorMoveOnPath(transport, Mission.USTTPaths[index])
		local pathpoints = FillPathPoints(Mission.USTTPaths[index])
		AddProximityTrigger(transport, Mission.USTTTriggerID[index], Mission.USTTTriggerFunction[index], pathpoints[2], 250)
		NavigatorSetAvoidLandCollision(transport, false)
		NavigatorSetTorpedoEvasion(transport, false)
		NavigatorSetAvoidShipCollision(transport, false)
		table.insert(Mission.USTTs, transport)
	end
	NavigatorSetAvoidLandCollision(Mission.Iowa[1], false)
	NavigatorSetTorpedoEvasion(Mission.Iowa[1], false)
	NavigatorSetAvoidShipCollision(Mission.Iowa[1], false)
--[[
	for index, unit in pairs (Mission.HQs) do
		OverrideHP(unit, Mission.HP_HQ)
	end
]]
	Mission.Started = true
end

function luaQAS10CheckObjUnits()
-- RELEASE_LOGOFF  	luaLog(" Checking objective units...")
	--Fortresses
	local index = table.getn(Mission.Fortresses)
	while (index > 0) do
		local unit = Mission.Fortresses[index]
		if (unit.Dead) then
			if (unit.Class.ID == 403) then
-- RELEASE_LOGOFF  				luaLog("A SiegeGunner is down, reducing japanese pool")
				luaResourcePoolReducer("siegegunner")
			elseif (unit.Class.ID == 452) then
-- RELEASE_LOGOFF  				luaLog("An AAGun is down, reducing japanese pool")
				luaResourcePoolReducer("AAGun")
			end
			table.remove(Mission.Fortresses, index)
		end
		index = index - 1
	end

	if table.getn(Mission.FortressesBig) ~= 0 then
		local index = table.getn(Mission.FortressesBig)
		while (index > 0) do
			local unit = Mission.FortressesBig[index]
			if (unit.Dead) then
-- RELEASE_LOGOFF  				luaLog("a fortress is down, reducing japanese pool")
				luaResourcePoolReducer("fortress")
				table.remove(Mission.FortressesBig, index)
			end
			index = index - 1
		end
	elseif luaObj_GetSuccess("secondary", 1) == nil and luaObj_IsActive("secondary", 1) then
-- RELEASE_LOGOFF  		luaLog(" secondary 1 completed")
		luaObj_Completed("secondary", 1)
	end
	
	if (table.getn(Mission.Iowa) > 0) and (not Mission.Iowa[1].Dead) then
		local threshold = GetHpPercentage(Mission.Iowa[1]) + 0.01
		if threshold < Mission.Iowa[1].PreviousHPPercentage then
			local difference = Mission.Iowa[1].PreviousHPPercentage - GetHpPercentage(Mission.Iowa[1])
			local percentage = difference * 100
			local by = luaRound(percentage)
			luaResourcePoolReducer("USIowa", by)
			Mission.Iowa[1].PreviousHPPercentage = GetHpPercentage(Mission.Iowa[1])
		end
	end
	
	--HQs
	for index, unit in pairs (Mission.HQs) do
		if unit.Party == PARTY_JAPANESE then
			local threshold = GetHpPercentage(unit) + 0.01
			if threshold < unit.PreviousHPPercentage then
				local difference = unit.PreviousHPPercentage - GetHpPercentage(unit)
				local percentage = difference * 100
				local by = luaRound(percentage)
				luaResourcePoolReducer("HQ", by)
				unit.PreviousHPPercentage = GetHpPercentage(unit)
			end
		elseif not Mission.MissionEndCalled then
-- RELEASE_LOGOFF  			luaLog("  HQ lost, calling MissionEnd")
			Mission.MissionEndCalled = true
			luaQAS10MissionEnd()
		end
	end
end

function luaQAS10CheckLanding()
-- RELEASE_LOGOFF  	luaLog(" Checking landing units...")
	if table.getn(Mission.USTTs) ~= 0 then
		for index, unit in pairs (Mission.USTTs) do
			if unit.Dead and not unit.respawnset then
-- RELEASE_LOGOFF  				luaLog("  dead transport found index "..tostring(index))
				unit.respawntime = GameTime() + Mission.RespawnTime
				unit.respawnset = true
				luaResourcePoolReducer("transport")
				--table.remove(Mission.USTTs, index)
			elseif unit.respawnset and unit.respawntime < GameTime() then
-- RELEASE_LOGOFF  				luaLog("  replacing dead transport")
				Mission.USTTs[index] = GenerateObject(Mission.USTTTemplates[index].Name)
				MissionNarrativeParty(1, "mp01.nar_siege_us_tr_arrive")
				MissionNarrativeParty(0, "mp01.nar_siege_jap_tr_arrive")
				Mission.USTTs[index].group = index
				unit.respawnset = false
				NavigatorMoveOnPath(Mission.USTTs[index], Mission.USTTPaths[index])
				local pathpoints = FillPathPoints(Mission.USTTPaths[index])
				AddProximityTrigger(Mission.USTTs[index], Mission.USTTTriggerID[index], Mission.USTTTriggerFunction[index], pathpoints[2], 250)
				NavigatorSetAvoidLandCollision(Mission.USTTs[index], false)
				NavigatorSetTorpedoEvasion(Mission.USTTs[index], false)
				NavigatorSetAvoidShipCollision(Mission.USTTs[index], false)
			elseif not unit.Dead and unit.inpos and not unit.landingalive then
-- RELEASE_LOGOFF  				luaLog("  transport in position, sending landing units")
				unit.landingalive = true
				for i = 1, 8 do
					local landingunit = GenerateObject(Mission.USLandingTemplate.Name, Mission.USLandingPoints[index][i])
					--NEM szabad PutTo-t hasznalni multiban!
					--PutTo(landingunit, Mission.USLandingPoints[index][i])
					--if (not Mission.HQs[1].Dead) and (not Mission.HQs[2].Dead) then
						EntityTurnToPosition(landingunit, {["x"] = 2114.54, ["y"] = 0, ["z"] = -2014.54})
						if (unit.group < 3) then
							--EntityTurnToEntity(landingunit, Mission.HQs[2])
							NavigatorMoveToRange(landingunit, Mission.HQs[2])
						else
							--EntityTurnToEntity(landingunit, Mission.HQs[1])
							NavigatorMoveToRange(landingunit, Mission.HQs[1])
						end
					--end
					NavigatorSetAvoidLandCollision(landingunit, false)
					NavigatorSetTorpedoEvasion(landingunit, false)
					NavigatorSetAvoidShipCollision(landingunit, false)
					ArtilleryEnable(landingunit, false)
					AAEnable(landingunit, false)
					table.insert(Mission.USLandingUnits[index], landingunit)
				end
				--[[for idx = 1, 4 do
					local landingunit = GenerateObject(Mission.USLandingTemplates[index][idx].Name)
					if (not Mission.HQs[1].Dead) and (not Mission.HQs[2].Dead) then
						if (unit.group < 3) then
							NavigatorMoveToRange(landingunit, Mission.HQs[2])
						else
							NavigatorMoveToRange(landingunit, Mission.HQs[1])
						end
					end
					table.insert(Mission.USLandingUnits[index], landingunit)
				end]]--
			end
		end
	end

	for idx, tbl in pairs (Mission.USLandingUnits) do
		if table.getn(Mission.USLandingUnits[idx]) ~= 0 then
			--for index, unit in pairs (Mission.USLandingUnits[idx]) do
			local index = table.getn(Mission.USLandingUnits[idx])
			while (index > 0) do
				local unit = Mission.USLandingUnits[idx][index]
				if unit.Dead then
-- RELEASE_LOGOFF  					luaLog("  dead landing boat found")
					luaResourcePoolReducer("landingboat")
					table.remove(Mission.USLandingUnits[idx], index)
				end
				index = index - 1
			end
		else
-- RELEASE_LOGOFF  			luaLog("  no more landing boats alive of the previous wave...")
			Mission.USTTs[idx].landingalive = false
		end
	end
	
	if (not Mission.HQs[1].Dead) and (not Mission.HQs[2].Dead) then
		local tLandingBoats01 = luaGetShipsAroundCoordinate(GetPosition(Mission.HQs[1]), 2400, PARTY_ALLIED, "own")
		local tLandingBoats02 = luaGetShipsAroundCoordinate(GetPosition(Mission.HQs[2]), 2400, PARTY_ALLIED, "own")
		if (tLandingBoats01 ~= nil) and (table.getn(tLandingBoats01) > 0) then
			for i, pBoat in pairs (tLandingBoats01) do
				if (not pBoat.Dead) and (pBoat.IsLanding == nil) then
					local err = StartLanding2(pBoat)
-- RELEASE_LOGOFF  					luaLog("(luaQAS10CheckLanding): elkezdte a landinget: "..pBoat.Name)
					pBoat.IsLanding = true
				end
			end
		end
		if (tLandingBoats02 ~= nil) and (table.getn(tLandingBoats02) > 0) then
			for i, pBoat in pairs (tLandingBoats02) do
				if (not pBoat.Dead) and (pBoat.IsLanding == nil) then
					local err = StartLanding2(pBoat)
-- RELEASE_LOGOFF  					luaLog("(luaQAS10CheckLanding): elkezdte a landinget: "..pBoat.Name)
					pBoat.IsLanding = true
				end
			end
		end
	end
end

function luaQAS10MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	Scoring_RealPlayTimeRunning(false)
	Mission.FortressesBig = luaRemoveDeadsFromTable(Mission.FortressesBig)
	if table.getn(Mission.FortressesBig) == 0 and luaObj_GetSuccess("secondary", 1) == nil and luaObj_IsActive("secondary", 1) then
-- RELEASE_LOGOFF  		luaLog("  fortesses down, secondary 1 completed")
		luaObj_Completed("secondary", 1)
	elseif luaObj_GetSuccess("secondary", 1) == nil and luaObj_IsActive("secondary", 1) then
		luaObj_Failed("secondary", 1)
	end
	if Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 or Mission.Randomize == 1 then
-- RELEASE_LOGOFF  		luaLog("  Japanese side wins")
		Mission.Completed = true
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		luaMissionCompletedNew(luaPickRnd(Mission.HQs), "", nil, nil, nil, PARTY_JAPANESE)
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 or Mission.Randomize == 2 then
-- RELEASE_LOGOFF  		luaLog("  Allied side wins")
		Mission.Completed = true
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaMissionCompletedNew(luaPickRnd(Mission.HQs), "", nil, nil, nil, PARTY_ALLIED)
	elseif (Mission.HQs[1].Party ~= PARTY_JAPANESE) or (Mission.HQs[2].Party ~= PARTY_JAPANESE) then
-- RELEASE_LOGOFF  		luaLog("  Allied side wins")
		Mission.ResourceJapPool = 0
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.Completed = true
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		if (Mission.HQs[1].Party ~= PARTY_JAPANESE) then
			local pTarget = Mission.HQs[1]
		else
			local pTarget = Mission.HQs[2]
		end
		luaMissionCompletedNew(pTarget, "", nil, nil, nil, PARTY_ALLIED)
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Siege10")
	-- mode description hint overlay
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
		local todeduct = Mission.Resource.PlayerUnit * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "japplayer" then
		local todeduct = Mission.Resource.PlayerUnit * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "transport" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Resource.USTT
	elseif unit == "landingboat" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.Resource.USLandingBoat
	elseif unit == "HQ" then
		local todeduct = Mission.Resource.USHQ * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "Iowa" then
		local todeduct = Mission.Resource.USIowa * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "siegegunner" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Resource.JAPSiegeGunner
	elseif unit == "AAGun" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Resource.JAPAAGun
	elseif unit == "fortress" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.Resource.JAPFort
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
		luaQAS10MissionEnd()
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" Jap pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaQAS10MissionEnd()
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool < 1 then
-- RELEASE_LOGOFF  		luaLog(" both pools are under 1 point")
		Mission.Randomize = luaRnd(1, 2)
		if Mission.Randomize == 1 then
			for i = 0, 7 do
				MultiScore[i][1] = 0
				MultiScore[i][2] = 1
			end
			Mission.MissionEndCalled = true
			luaQAS10MissionEnd()
		else
			for i = 0, 7 do
				MultiScore[i][1] = 1
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaQAS10MissionEnd()
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

function luaQAS10HintManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 30 and not Mission.Hint1Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint1Shown")
			ShowHint("ID_Hint_Siege01_OP")
			Mission.Hint1Shown = true
		elseif GameTime() > 60 and not Mission.Hint2Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint2Shown")
			ShowHint("ID_Hint_Siege10_LCVP")
			ShowHint("ID_Hint_Siege10_LB")
			Mission.Hint2Shown = true
		elseif GameTime() > 90 and not Mission.Hint3Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint3Shown")
			ShowHint("ID_Hint_Siege10_Fort")
			ShowHint("ID_Hint_Siege10_TR")
			Mission.Hint3Shown = true
		elseif GameTime() > 120 and not Mission.Hint4Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint4Shown")
			ShowHint("ID_Hint_Siege01_PK")
			Mission.Hint4Shown = true
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

	DisplayScores(1, 0, "mp01.score_siege_resource_att".."| #MultiScore.0.1#", "mp01.score_siege_resource_def".."| #MultiScore.0.2#", 2, 1)
	DisplayScores(1, 1, "mp01.score_siege_resource_att".."| #MultiScore.1.1#", "mp01.score_siege_resource_def".."| #MultiScore.1.2#", 2, 1)
	DisplayScores(1, 2, "mp01.score_siege_resource_att".."| #MultiScore.2.1#", "mp01.score_siege_resource_def".."| #MultiScore.2.2#", 2, 1)
	DisplayScores(1, 3, "mp01.score_siege_resource_att".."| #MultiScore.3.1#", "mp01.score_siege_resource_def".."| #MultiScore.3.2#", 2, 1)
	DisplayScores(1, 4, "mp01.score_siege_resource_att".."| #MultiScore.4.1#", "mp01.score_siege_resource_def".."| #MultiScore.4.2#", 2, 1)
	DisplayScores(1, 5, "mp01.score_siege_resource_att".."| #MultiScore.5.1#", "mp01.score_siege_resource_def".."| #MultiScore.5.2#", 2, 1)
	DisplayScores(1, 6, "mp01.score_siege_resource_att".."| #MultiScore.6.1#", "mp01.score_siege_resource_def".."| #MultiScore.6.2#", 2, 1)
	DisplayScores(1, 7, "mp01.score_siege_resource_att".."| #MultiScore.7.1#", "mp01.score_siege_resource_def".."| #MultiScore.7.2#", 2, 1)
end

function luaQAS10USTT1InPos()
-- RELEASE_LOGOFF  	luaLog(" USTT 1 pulled the trigger!")
	if not Mission.USTTs[1].Dead then
		Mission.USTTs[1].inpos = true
	end
end

function luaQAS10USTT2InPos()
-- RELEASE_LOGOFF  	luaLog(" USTT 2 pulled the trigger!")
	if not Mission.USTTs[2].Dead then
		Mission.USTTs[2].inpos = true
	end
end

function luaQAS10USTT3InPos()
-- RELEASE_LOGOFF  	luaLog(" USTT 3 pulled the trigger!")
	if not Mission.USTTs[3].Dead then
		Mission.USTTs[3].inpos = true
	end
end

function luaQAS10USTT4InPos()
-- RELEASE_LOGOFF  	luaLog(" USTT 4 pulled the trigger!")
	if not Mission.USTTs[4].Dead then
		Mission.USTTs[4].inpos = true
	end
end
