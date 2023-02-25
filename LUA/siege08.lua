--SceneFile="Missions\Multi\Scene8.scn"

function luaPrecacheUnits()
	PrepareClass(13) -- New York
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAS8Mission")
end

function luaInitQAS8Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Siege8"..dateandtime

	this.HelperLog = false
	this.CustomLog = true
	DamageLog = false

	SETLOG(this, true)
-- RELEASE_LOGOFF  	luaLog("Initiating "..this.Name.."!")
	
	-- lokalizacios feltoltesek
	--AddLockitPathToSelection("missionglobals")
	--LoadSelectedPaths()

	--precache

	-- lobby
-- RELEASE_LOGOFF  	luaLog("----------")
-- RELEASE_LOGOFF  	luaLog(LobbySettings)
-- RELEASE_LOGOFF  	luaLog("----------")

	-- globalban hasznalando
	this.Multiplayer = true
	this.ThinkCounter = 0
	Mission.MultiplayerType = "Siege"
	Mission.MultiplayerNumber = 8

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- mission valtozok
	Mission.KeyUnitCounter = 0 -- luaQAS8StartMission()-ben allitjuk be
	--ModifyKeyUnitNumber(Mission.KeyUnitCounter)

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
	Mission.USIowa = FindEntity("Siege - Iowa")
	Mission.USSouthDakota = FindEntity("Siege - South Dakota")
	--Mission.USSouthDakota2 = FindEntity("Siege - South Dakota 2")
	Mission.USRenown = FindEntity("Siege - Renown")
	--Mission.USRenown2 = FindEntity("Siege - Renown 2")
	--Mission.USRenown3 = FindEntity("Siege - Renown 3")
	Mission.USKingGeorge = FindEntity("Siege - King George")
	--Mission.USKingGeorge2 = FindEntity("Siege - King George 2")

	Kill(FindEntity("Siege - South Dakota 2"), true)
	Kill(FindEntity("Siege - Renown 2"), true)
	Kill(FindEntity("Siege - Renown 3"), true)
	Kill(FindEntity("Siege - King George 2"), true)

	Mission.USBBIDs = {}
		table.insert(Mission.USBBIDs, 7)
		table.insert(Mission.USBBIDs, 9)
		table.insert(Mission.USBBIDs, 10)
		table.insert(Mission.USBBIDs, 13)
		table.insert(Mission.USBBIDs, 15)
	Mission.USBBNames = {}
		table.insert(Mission.USBBNames, "globals.unitclass_renown")
		table.insert(Mission.USBBNames, "globals.unitclass_kinggeorge")
		table.insert(Mission.USBBNames, "globals.unitclass_newyork")
		table.insert(Mission.USBBNames, "globals.unitclass_southdakota")
		table.insert(Mission.USBBNames, "globals.unitclass_iowa")

	Mission.LivingUSShips = {}
		table.insert(Mission.LivingUSShips, Mission.USIowa)
		table.insert(Mission.LivingUSShips, Mission.USSouthDakota)
		table.insert(Mission.LivingUSShips, Mission.USRenown)
		table.insert(Mission.LivingUSShips, Mission.USKingGeorge)
--[[
		table.insert(Mission.LivingUSShips, Mission.USSouthDakota2)
		table.insert(Mission.LivingUSShips, Mission.USRenown2)
		table.insert(Mission.LivingUSShips, Mission.USRenown3)
		table.insert(Mission.LivingUSShips, Mission.USKingGeorge2)
]]
	Mission.USShipTriggerIDs = {}
		table.insert(Mission.USShipTriggerIDs, USTrigger1)
		table.insert(Mission.USShipTriggerIDs, USTrigger2)
		table.insert(Mission.USShipTriggerIDs, USTrigger3)
		table.insert(Mission.USShipTriggerIDs, USTrigger4)
		table.insert(Mission.USShipTriggerIDs, USTrigger5)
		table.insert(Mission.USShipTriggerIDs, USTrigger6)
		table.insert(Mission.USShipTriggerIDs, USTrigger7)
		table.insert(Mission.USShipTriggerIDs, USTrigger8)
	Mission.USShipTriggerFunctions = {}
		table.insert(Mission.USShipTriggerFunctions, "luaQAS8USShip1InPos")
		table.insert(Mission.USShipTriggerFunctions, "luaQAS8USShip2InPos")
		table.insert(Mission.USShipTriggerFunctions, "luaQAS8USShip3InPos")
		table.insert(Mission.USShipTriggerFunctions, "luaQAS8USShip4InPos")
		table.insert(Mission.USShipTriggerFunctions, "luaQAS8USShip5InPos")
		table.insert(Mission.USShipTriggerFunctions, "luaQAS8USShip6InPos")
		table.insert(Mission.USShipTriggerFunctions, "luaQAS8USShip7InPos")
		table.insert(Mission.USShipTriggerFunctions, "luaQAS8USShip8InPos")

	Mission.USBBPositions = {}
	for index, unit in pairs (Mission.LivingUSShips) do
		SetSkillLevel(unit, SKILL_SPNORMAL)
		table.insert(Mission.USBBPositions, GetPosition(unit))
	end

	-- japan objektumok
	Mission.JapYamato = FindEntity("Siege - Yamato")
	Mission.JapFuso = FindEntity("Siege - Fuso")
	Mission.JapKongo = FindEntity("Siege - Kongo")
	Mission.JapFuso2 = FindEntity("Siege - Fuso 2")
--[[
	Mission.JapKongo2 = FindEntity("Siege - Kongo 2")
	Mission.JapKongo3 = FindEntity("Siege - Kongo 3")
	Mission.JapFuso3 = FindEntity("Siege - Fuso 3")
]]

	Kill(FindEntity("Siege - Kongo 2"), true)
	Kill(FindEntity("Siege - Kongo 3"), true)
	Kill(FindEntity("Siege - Fuso 3"), true)

	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("Siege - Headquarter 1"))
		table.insert(Mission.HQs, FindEntity("Siege - Headquarter 2"))

	Mission.JapBBIDs = {}
		table.insert(Mission.JapBBIDs, 60)
		table.insert(Mission.JapBBIDs, 61)
		table.insert(Mission.JapBBIDs, 59)
	Mission.JapBBNames = {}
		table.insert(Mission.JapBBNames, "globals.unitclass_kongo")
		table.insert(Mission.JapBBNames, "globals.unitclass_fuso")
		table.insert(Mission.JapBBNames, "globals.unitclass_yamato")

	Mission.LivingJapShips = {}
		table.insert(Mission.LivingJapShips, Mission.JapYamato)
		table.insert(Mission.LivingJapShips, Mission.JapFuso)
		table.insert(Mission.LivingJapShips, Mission.JapKongo)
		table.insert(Mission.LivingJapShips, Mission.JapFuso2)
--[[
		table.insert(Mission.LivingJapShips, Mission.JapKongo2)
		table.insert(Mission.LivingJapShips, Mission.JapKongo3)
		table.insert(Mission.LivingJapShips, Mission.JapFuso3)
]]
	Mission.JapShipTriggerIDs = {}
		table.insert(Mission.JapShipTriggerIDs, JapTrigger1)
		table.insert(Mission.JapShipTriggerIDs, JapTrigger2)
		table.insert(Mission.JapShipTriggerIDs, JapTrigger3)
		table.insert(Mission.JapShipTriggerIDs, JapTrigger4)
		table.insert(Mission.JapShipTriggerIDs, JapTrigger5)
		table.insert(Mission.JapShipTriggerIDs, JapTrigger6)
		table.insert(Mission.JapShipTriggerIDs, JapTrigger7)
	Mission.JapShipTriggerFunctions = {}
		table.insert(Mission.JapShipTriggerFunctions, "luaQAS8JapShip1InPos")
		table.insert(Mission.JapShipTriggerFunctions, "luaQAS8JapShip2InPos")
		table.insert(Mission.JapShipTriggerFunctions, "luaQAS8JapShip3InPos")
		table.insert(Mission.JapShipTriggerFunctions, "luaQAS8JapShip4InPos")
		table.insert(Mission.JapShipTriggerFunctions, "luaQAS8JapShip5InPos")
		table.insert(Mission.JapShipTriggerFunctions, "luaQAS8JapShip6InPos")
		table.insert(Mission.JapShipTriggerFunctions, "luaQAS8JapShip7InPos")

	Mission.JapBBPositions = {}
	for index, unit in pairs (Mission.LivingJapShips) do
		SetSkillLevel(unit, SKILL_SPNORMAL)
		table.insert(Mission.JapBBPositions, GetPosition(unit))
	end

	-- pathok
	Mission.USIowaPath = FindEntity("Siege - IowaPath")
	Mission.USSouthDakotaPath = FindEntity("Siege - SouthDakotaPath")
	Mission.USRenownPath = FindEntity("Siege - RenownPath")
	Mission.USKingGeorgePath = FindEntity("Siege - KingGeorgePath")
	Mission.JapYamatoPath = FindEntity("Siege - YamatoPath")
	Mission.JapFusoPath = FindEntity("Siege - FusoPath")
	Mission.JapFuso2Path = FindEntity("Siege - Fuso2Path")
	Mission.JapKongoPath = FindEntity("Siege - KongoPath")
	Mission.JapKongo2Path = FindEntity("Siege - Kongo2Path")
	Mission.JapKongo3Path = FindEntity("Siege - Kongo3Path")

	Mission.USPaths = {}
		table.insert(Mission.USPaths, Mission.USIowaPath)
		table.insert(Mission.USPaths, Mission.USSouthDakotaPath)
		table.insert(Mission.USPaths, Mission.USRenownPath)
		table.insert(Mission.USPaths, Mission.USKingGeorgePath)
	Mission.JapPaths = {}
		table.insert(Mission.JapPaths, Mission.JapYamatoPath)
		table.insert(Mission.JapPaths, Mission.JapFusoPath)
		table.insert(Mission.JapPaths, Mission.JapFuso2Path)
		table.insert(Mission.JapPaths, Mission.JapKongoPath)
		table.insert(Mission.JapPaths, Mission.JapKongo2Path)
		table.insert(Mission.JapPaths, Mission.JapKongo3Path)
	Mission.USPathsStartPoints = {}
	for index, path in pairs (Mission.USPaths) do
		table.insert(Mission.USPathsStartPoints, FillPathPoints(Mission.USPaths[index])[1])
	end
	Mission.JapPathsStartPoints = {}
	for index, path in pairs (Mission.JapPaths) do
		table.insert(Mission.JapPathsStartPoints, FillPathPoints(Mission.JapPaths[index])[1])
	end

	-- figyelesek

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
	Mission.ResourceJapHQ = 0,5
	Mission.ResourceBB = 80
	Mission.ResourcePlayerUnit = 40

	Mission.PreviousHPPercentageHQ1 = 1
	Mission.PreviousHPPercentageHQ2 = 1

	Mission.RespawnTime = 30 -- hint van hozzakotve

---------------------------

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_primary_1",
				["Text"] = "mp08.obj_siege_us_p1_text",
				["TextCompleted"] = "mp08.obj_siege_us_p1_comp",
				["TextFailed"] = "mp08.obj_siege_us_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_primary_1",
				["Text"] = "mp08.obj_siege_jap_p1_text",
				["TextCompleted"] = "mp08.obj_siege_jap_p1_comp",
				["TextFailed"] = "mp08.obj_siege_jap_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
--[[
			[3] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_primary_2",
				["Text"] = "At least one battleship must survive!",
				["TextCompleted"] = "You have successfully protected at least one of the battleships!",
				["TextFailed"] = "You have failed to protect the battleships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 600,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_primary_2",
				["Text"] = "Destroy the battleships!",
				["TextCompleted"] = "You have successfully destroyed the battleships!",
				["TextFailed"] = "You have failed to destroy the battleships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 600,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
]]
		},
		["secondary"] = {
--[[
			[1] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_secondary_1",
				["Text"] = "Protect the Yamato!",
				["TextCompleted"] = "You have successfully protected the Yamato!",
				["TextFailed"] = "You have failed to protect the Yamato!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 600,	-- teljesitesert jaro pontszam,
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

    SetThink(this, "luaQAS8Mission_think")
end

function luaQAS8Mission_think(this, msg)
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
		luaQAS8CheckShips()
		--luaQAS8CheckHQs()
		luaQAS8CheckForts()
		luaCheckPlayers()
		luaQAS8HintManager()

	elseif not Mission.Started then
		luaQAS8StartMission()
		luaSetMultiScoreTable()
	end
end

function luaQAS8StartMission()
-- RELEASE_LOGOFF  	luaLog(" Starting mission...")
	Scoring_RealPlayTimeRunning(true)
	
	luaShowMissionHint()
	
	Music_Control_SetLevel(MUSIC_ACTION)

	luaMultiVoiceOverHandler()

	Mission.KeyUnitCounter = table.getn(Mission.LivingUSShips)
	--ModifyKeyUnitNumber(Mission.KeyUnitCounter)
--[[
	for index, unit in pairs (Mission.LivingJapShips) do
		SetRepairEffectivity(unit, 1.3)
	end

	for index, unit in pairs (Mission.LivingUSShips) do
		SetRepairEffectivity(unit, 1.3)
	end
]]
	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2)

	for index, unit in pairs (Mission.LivingJapShips) do
		luaObj_AddUnit("primary", 1, unit)
		luaObj_AddUnit("primary", 2, unit)
		AISetHintWeight(unit, 20)
	end

	for index, unit in pairs (Mission.LivingUSShips) do
		luaObj_AddUnit("primary", 1, unit)
		luaObj_AddUnit("primary", 2, unit)
		SetRepairEffectivity(unit, 1.1)
		AISetHintWeight(unit, 20)
	end

	--luaObj_Add("primary", 3)
	--luaObj_Add("primary", 4)
	--luaObj_Add("secondary", 1, Mission.JapYamato)
--[[
	luaObj_AddUnit("primary", 1, Mission.HQs[1])
	luaObj_AddUnit("primary", 1, Mission.HQs[2])
	luaObj_AddUnit("primary", 2, Mission.HQs[1])
	luaObj_AddUnit("primary", 2, Mission.HQs[2])
	luaObj_AddUnit("primary", 3, Mission.USIowa)
	luaObj_AddUnit("primary", 3, Mission.USRenown)
	luaObj_AddUnit("primary", 3, Mission.USRenown2)
	luaObj_AddUnit("primary", 3, Mission.USRenown3)
	luaObj_AddUnit("primary", 3, Mission.USKingGeorge)
	luaObj_AddUnit("primary", 3, Mission.USKingGeorge2)
	luaObj_AddUnit("primary", 3, Mission.USSouthDakota)
	luaObj_AddUnit("primary", 3, Mission.USSouthDakota2)
	luaObj_AddUnit("primary", 4, Mission.USIowa)
	luaObj_AddUnit("primary", 4, Mission.USRenown)
	luaObj_AddUnit("primary", 4, Mission.USRenown2)
	luaObj_AddUnit("primary", 4, Mission.USRenown3)
	luaObj_AddUnit("primary", 4, Mission.USKingGeorge)
	luaObj_AddUnit("primary", 4, Mission.USKingGeorge2)
	luaObj_AddUnit("primary", 4, Mission.USSouthDakota)
	luaObj_AddUnit("primary", 4, Mission.USSouthDakota2)
]]
	NavigatorMoveOnPath(Mission.JapYamato, Mission.JapYamatoPath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
	--NavigatorMoveOnPath(Mission.JapFuso3, Mission.JapYamatoPath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
	local yamatopathpoints = FillPathPoints(Mission.JapYamatoPath)
	local yamatopathpointsnumber = table.getn(yamatopathpoints)
	AddProximityTrigger(Mission.JapYamato, "YamatoMove", "luaQAS8YamatoInPos", yamatopathpoints[yamatopathpointsnumber], 333)
	--AddProximityTrigger(Mission.JapFuso3, "Fuso3Move", "luaQAS8Fuso3InPos", yamatopathpoints[yamatopathpointsnumber], 333)

	NavigatorMoveOnPath(Mission.JapFuso, Mission.JapFusoPath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
	local fusopathpoints = FillPathPoints(Mission.JapFusoPath)
	local fusopathpointsnumber = table.getn(fusopathpoints)
	AddProximityTrigger(Mission.JapFuso, "FusoMove", "luaQAS8FusoInPos", fusopathpoints[fusopathpointsnumber], 333)

	NavigatorMoveOnPath(Mission.JapKongo, Mission.JapKongoPath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
	local kongopathpoints = FillPathPoints(Mission.JapKongoPath)
	local kongopathpointsnumber = table.getn(kongopathpoints)
	AddProximityTrigger(Mission.JapKongo, "KongoMove", "luaQAS8KongoInPos", kongopathpoints[kongopathpointsnumber], 333)

	NavigatorMoveOnPath(Mission.JapFuso2, Mission.JapFuso2Path, PATH_FM_SIMPLE, PATH_SM_BEGIN)
	local fuso2pathpoints = FillPathPoints(Mission.JapFuso2Path)
	local fuso2pathpointsnumber = table.getn(fuso2pathpoints)
	AddProximityTrigger(Mission.JapFuso2, "Fuso2Move", "luaQAS8Fuso2InPos", fuso2pathpoints[fuso2pathpointsnumber], 333)

	--NavigatorMoveOnPath(Mission.JapKongo2, Mission.JapKongo2Path, PATH_FM_SIMPLE, PATH_SM_BEGIN)
	local kongo2pathpoints = FillPathPoints(Mission.JapKongo2Path)
	local kongo2pathpointsnumber = table.getn(kongo2pathpoints)
	--AddProximityTrigger(Mission.JapKongo2, "Kongo2Move", "luaQAS8Kongo2InPos", kongo2pathpoints[kongo2pathpointsnumber], 333)

	--NavigatorMoveOnPath(Mission.JapKongo3, Mission.JapKongo3Path, PATH_FM_SIMPLE, PATH_SM_BEGIN)
	local kongo3pathpoints = FillPathPoints(Mission.JapKongo3Path)
	local kongo3pathpointsnumber = table.getn(kongo3pathpoints)
	--AddProximityTrigger(Mission.JapKongo3, "Kongo3Move", "luaQAS8Kongo3InPos", kongo3pathpoints[kongo3pathpointsnumber], 333)
	
	NavigatorMoveOnPath(Mission.USIowa, Mission.USIowaPath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
	--NavigatorMoveOnPath(Mission.USRenown3, Mission.USIowaPath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
	local iowapathpoints = FillPathPoints(Mission.USIowaPath)
	local iowapathpointsnumber = table.getn(iowapathpoints)
	AddProximityTrigger(Mission.USIowa, "IowaMove", "luaQAS8IowaInPos", iowapathpoints[iowapathpointsnumber], 333)
	--AddProximityTrigger(Mission.USRenown3, "Renown3Move", "luaQAS8Renown3InPos", iowapathpoints[iowapathpointsnumber], 333)

	NavigatorMoveOnPath(Mission.USRenown, Mission.USRenownPath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
	--NavigatorMoveOnPath(Mission.USRenown2, Mission.USRenownPath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
	local renownpathpoints = FillPathPoints(Mission.USRenownPath)
	local renownpathpointsnumber = table.getn(renownpathpoints)
	AddProximityTrigger(Mission.USRenown, "RenownMove", "luaQAS8RenownInPos", renownpathpoints[renownpathpointsnumber], 333)
	--AddProximityTrigger(Mission.USRenown2, "Renown2Move", "luaQAS8Renown2InPos", renownpathpoints[renownpathpointsnumber], 333)

	NavigatorMoveOnPath(Mission.USKingGeorge, Mission.USKingGeorgePath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
	--NavigatorMoveOnPath(Mission.USKingGeorge2, Mission.USKingGeorgePath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
	local kinggeorgepathpoints = FillPathPoints(Mission.USKingGeorgePath)
	local kinggeorgepathpointsnumber = table.getn(kinggeorgepathpoints)
	AddProximityTrigger(Mission.USKingGeorge, "KingGeorgeMove", "luaQAS8KingGeorgeInPos", kinggeorgepathpoints[kinggeorgepathpointsnumber], 333)
	--AddProximityTrigger(Mission.USKingGeorge2, "KingGeorge2Move", "luaQAS8KingGeorge2InPos", kinggeorgepathpoints[kinggeorgepathpointsnumber], 333)

	NavigatorMoveOnPath(Mission.USSouthDakota, Mission.USSouthDakotaPath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
	--NavigatorMoveOnPath(Mission.USSouthDakota2, Mission.USSouthDakotaPath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
	local southdakotapathpoints = FillPathPoints(Mission.USSouthDakotaPath)
	local southdakotapathpointsnumber = table.getn(southdakotapathpoints)
	AddProximityTrigger(Mission.USSouthDakota, "SouthDakotaMove", "luaQAS8SouthDakotaInPos", southdakotapathpoints[southdakotapathpointsnumber], 333)
	--AddProximityTrigger(Mission.USSouthDakota2, "SouthDakota2Move", "luaQAS8SouthDakota2InPos", southdakotapathpoints[southdakotapathpointsnumber], 333)
	Mission.Started = true
end

function luaQAS8YamatoInPos()
-- RELEASE_LOGOFF  	luaLog(" Yamato is in position")
	if not Mission.LivingJapShips[1].Dead then
		Mission.LivingJapShips[1].inpos = true
		luaQAS8SetTarget(Mission.LivingJapShips[1])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8Fuso3InPos()
-- RELEASE_LOGOFF  	luaLog(" Fuso 3 is in position")
	if not Mission.LivingJapShips[7].Dead then
		Mission.LivingJapShips[7].inpos = true
		luaQAS8SetTarget(Mission.LivingJapShips[7])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8FusoInPos()
-- RELEASE_LOGOFF  	luaLog(" Fuso is in position")
	if not Mission.LivingJapShips[2].Dead then
		Mission.LivingJapShips[2].inpos = true
		luaQAS8SetTarget(Mission.LivingJapShips[2])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8KongoInPos()
-- RELEASE_LOGOFF  	luaLog(" Kongo is in position")
	if not Mission.LivingJapShips[3].Dead then
		Mission.LivingJapShips[3].inpos = true
		luaQAS8SetTarget(Mission.LivingJapShips[3])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8Fuso2InPos()
-- RELEASE_LOGOFF  	luaLog(" Fuso 2 is in position")
	if not Mission.LivingJapShips[4].Dead then
		Mission.LivingJapShips[4].inpos = true
		luaQAS8SetTarget(Mission.LivingJapShips[4])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8Kongo2InPos()
-- RELEASE_LOGOFF  	luaLog(" Kongo 2 is in position")
	if not Mission.LivingJapShips[5].Dead then
		Mission.LivingJapShips[5].inpos = true
		luaQAS8SetTarget(Mission.LivingJapShips[5])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8Kongo3InPos()
-- RELEASE_LOGOFF  	luaLog(" Kongo 3 is in position")
	if not Mission.LivingJapShips[6].Dead then
		Mission.LivingJapShips[6].inpos = true
		luaQAS8SetTarget(Mission.LivingJapShips[6])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8IowaInPos()
-- RELEASE_LOGOFF  	luaLog(" Iowa is in position")
	if not Mission.LivingUSShips[1].Dead then
		Mission.LivingUSShips[1].inpos = true
		luaQAS8SetTarget(Mission.LivingUSShips[1])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8Renown3InPos()
-- RELEASE_LOGOFF  	luaLog(" Renown 3 is in position")
	if not Mission.LivingUSShips[7].Dead then
		Mission.LivingUSShips[7].inpos = true
		luaQAS8SetTarget(Mission.LivingUSShips[7])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8RenownInPos()
-- RELEASE_LOGOFF  	luaLog(" Renown is in position")
	if not Mission.LivingUSShips[3].Dead then
		Mission.LivingUSShips[3].inpos = true
		luaQAS8SetTarget(Mission.LivingUSShips[3])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8Renown2InPos()
-- RELEASE_LOGOFF  	luaLog(" Renown 2 is in position")
	if not Mission.LivingUSShips[6].Dead then
		Mission.LivingUSShips[6].inpos = true
		luaQAS8SetTarget(Mission.LivingUSShips[6])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8KingGeorgeInPos()
-- RELEASE_LOGOFF  	luaLog(" King George is in position")
	if not Mission.LivingUSShips[4].Dead then
		Mission.LivingUSShips[4].inpos = true
		luaQAS8SetTarget(Mission.LivingUSShips[4])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8KingGeorge2InPos()
-- RELEASE_LOGOFF  	luaLog(" King George 2 is in position")
	if not Mission.LivingUSShips[8].Dead then
		Mission.LivingUSShips[8].inpos = true
		luaQAS8SetTarget(Mission.LivingUSShips[8])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8SouthDakotaInPos()
-- RELEASE_LOGOFF  	luaLog(" South Dakota is in position")
	if not Mission.LivingUSShips[2].Dead then
		Mission.LivingUSShips[2].inpos = true
		luaQAS8SetTarget(Mission.LivingUSShips[2])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8SouthDakota2InPos()
-- RELEASE_LOGOFF  	luaLog(" South Dakota 2 is in position")
	if not Mission.LivingUSShips[5].Dead then
		Mission.LivingUSShips[5].inpos = true
		luaQAS8SetTarget(Mission.LivingUSShips[5])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8CheckShips()
-- RELEASE_LOGOFF  	luaLog(" Checking Ships...")
--[[
	if Mission.JapYamato.Dead then
		luaObj_Failed("secondary", 1)
	end
]]
	luaQAS8DeadBBFinder()

	--Mission.LivingUSShips = luaRemoveDeadsFromTable(Mission.LivingUSShips)
	--Mission.KeyUnitCounter = table.getn(Mission.LivingUSShips)
	--ModifyKeyUnitNumber(Mission.KeyUnitCounter)
	if table.getn(Mission.LivingUSShips) ~= 0 then
		for index, unit in pairs (Mission.LivingUSShips) do
			if not unit.Dead then
				if unit.inpos and UnitGetAttackTarget(unit) == nil then
-- RELEASE_LOGOFF  					luaLog("  "..unit.Name.." doesn't have a target, possible ships targets found, picking random from the Jap table")
					luaQAS8SetTarget(unit)
				end
			end
		end
	end
--[[
	elseif not Mission.MissionEndCalled then
		Mission.MissionEndCalled = true
		luaQAS8MissionEnd()
	end
]]
	--Mission.LivingJapShips = luaRemoveDeadsFromTable(Mission.LivingJapShips)
	if table.getn(Mission.LivingJapShips) ~= 0 then
		for index, unit in pairs (Mission.LivingJapShips) do
			if not unit.Dead then
				if unit.inpos and UnitGetAttackTarget(unit) == nil then
-- RELEASE_LOGOFF  					luaLog("  "..unit.Name.." doesn't have a target, possible ships targets found, picking random from the US table")
					luaQAS8SetTarget(unit)
				end
			end
		end
	end
end

function luaQAS8SetTarget(unit)
	local targettable = {}
	local nearestcruiser = luaGetNearestEnemy(unit, "cruiser")
	local nearestbattleship = luaGetNearestEnemy(unit, "battleship")
	if nearestcruiser ~= nil then
		table.insert(targettable, nearestcruiser)
	end
	if nearestbattleship ~= nil then
		table.insert(targettable, nearestbattleship)
	end
	if table.getn(targettable) ~= 0 then
		local target = luaPickRnd(targettable)
		NavigatorAttackMove(unit, target, {})
	elseif table.getn(targettable) == 0 and unit.Party == PARTY_ALLIED then
		if Mission.HQs[1].Party == PARTY_JAPANESE then
			NavigatorAttackMove(unit, Mission.HQs[1], {})
		elseif Mission.HQs[2].Party == PARTY_JAPANESE then
			NavigatorAttackMove(unit, Mission.HQs[2], {})
		end
	end
end

function luaQAS8DeadBBFinder()
	for index, unit in pairs (Mission.LivingUSShips) do
		if unit.Dead and not Mission.USBBRespawnDisabled then
-- RELEASE_LOGOFF  			luaLog("  dead US BB found, delaying replacement")
			Mission.USBBRespawnDisabled = true
			if not unit.poolreduced then
				unit.poolreduced = true
				luaResourcePoolReducer("USBB")
			end
			luaDelay(luaQAS8SpawnUSBB, Mission.RespawnTime, "index", index)
		elseif unit.Dead and not unit.poolreduced then
-- RELEASE_LOGOFF  			luaLog("  dead US BB found, respawn disabled")
			unit.poolreduced = true
			luaResourcePoolReducer("USBB")
		elseif unit.Dead then
-- RELEASE_LOGOFF  			luaLog("  dead US BB found, respawn disabled")
		end
	end

	for index, unit in pairs (Mission.LivingJapShips) do
		if unit.Dead and not Mission.JapBBRespawnDisabled then
-- RELEASE_LOGOFF  			luaLog("  dead Jap BB found, delaying replacement")
			Mission.JapBBRespawnDisabled = true
			if not unit.poolreduced then
				unit.poolreduced = true
				luaResourcePoolReducer("JapBB")
			end
			luaDelay(luaQAS8SpawnJapBB, Mission.RespawnTime, "index", index)
		elseif unit.Dead and not unit.poolreduced then
-- RELEASE_LOGOFF  			luaLog("  dead Jap BB found, respawn disabled")
			unit.poolreduced = true
			luaResourcePoolReducer("JapBB")
		elseif unit.Dead then
-- RELEASE_LOGOFF  			luaLog("  dead Jap BB found, respawn disabled")
		end
	end
end

function luaQAS8SpawnUSBB(timerthis)
	Mission.USBBindex = timerthis.ParamTable.index
	local shiprandomizer = random(1, 20)
	if shiprandomizer <= 5 then
		luaQAS8SpawnUnit(Mission.USBBPositions[Mission.USBBindex], Mission.USBBIDs[1], Mission.USBBNames[1], PARTY_ALLIED, USA)
	elseif shiprandomizer <= 10 then
		luaQAS8SpawnUnit(Mission.USBBPositions[Mission.USBBindex], Mission.USBBIDs[2], Mission.USBBNames[2], PARTY_ALLIED, USA)
	elseif shiprandomizer <= 14 then
		luaQAS8SpawnUnit(Mission.USBBPositions[Mission.USBBindex], Mission.USBBIDs[3], Mission.USBBNames[3], PARTY_ALLIED, USA)
	elseif shiprandomizer <= 17 then
		luaQAS8SpawnUnit(Mission.USBBPositions[Mission.USBBindex], Mission.USBBIDs[4], Mission.USBBNames[4], PARTY_ALLIED, USA)
	elseif shiprandomizer <= 20 then
		luaQAS8SpawnUnit(Mission.USBBPositions[Mission.USBBindex], Mission.USBBIDs[5], Mission.USBBNames[5], PARTY_ALLIED, USA)
	end
end

function luaQAS8SpawnJapBB(timerthis)
	Mission.JapBBindex = timerthis.ParamTable.index
	local shiprandomizer = random(1, 20)
	if shiprandomizer <= 11 then
		luaQAS8SpawnUnit(Mission.JapBBPositions[Mission.JapBBindex], Mission.JapBBIDs[1], Mission.JapBBNames[1], PARTY_JAPANESE, JAPAN)
	elseif shiprandomizer <= 19 then
		luaQAS8SpawnUnit(Mission.JapBBPositions[Mission.JapBBindex], Mission.JapBBIDs[2], Mission.JapBBNames[2], PARTY_JAPANESE, JAPAN)
	elseif shiprandomizer <= 20 then
		luaQAS8SpawnUnit(Mission.JapBBPositions[Mission.JapBBindex], Mission.JapBBIDs[3], Mission.JapBBNames[3], PARTY_JAPANESE, JAPAN)
	end
end

function luaQAS8CheckHQs()
-- RELEASE_LOGOFF  	luaLog(" Checking headquarters...")
	if Mission.HQs[1].Party ~= PARTY_JAPANESE and Mission.HQs[1].Party ~= PARTY_JAPANESE and not Mission.MissionEndCalled then
		Mission.MissionEndCalled = true
		luaQAS8MissionEnd()
	end
end

function luaQAS8MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Ending mission...")
--[[
	if not Mission.JapYamato.Dead then
		luaObj_Completed("secondary", 1)
	end
]]
	Scoring_RealPlayTimeRunning(false)
	if Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 or Mission.Randomize == 1 then
-- RELEASE_LOGOFF  		luaLog(" Japanese side wins!")
		luaObj_Failed("primary", 1)
		luaObj_Completed("primary", 2)
		local possibleEndUnits = luaRemoveDeadsFromTable(Mission.LivingJapShips)
		luaMissionCompletedNew(luaPickRnd(possibleEndUnits), "", nil, nil, nil, PARTY_JAPANESE)
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 or Mission.Randomize == 2 then
-- RELEASE_LOGOFF  		luaLog(" US side wins!")
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		local possibleEndUnits = luaRemoveDeadsFromTable(Mission.LivingUSShips)
		luaMissionCompletedNew(luaPickRnd(possibleEndUnits), "", nil, nil, nil, PARTY_ALLIED)
	end
--[[
	if Mission.HQs[1].Party == PARTY_JAPANESE or Mission.HQs[1].Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  		luaLog("  an HQ is still in Japanese hands, Japanese side wins")
		luaObj_Failed("primary", 1)
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 3)
		luaObj_Completed("primary", 4)
		luaMissionCompletedNew(luaPickRnd(Mission.HQs), "", nil, nil, nil, PARTY_JAPANESE)
	else
-- RELEASE_LOGOFF  		luaLog("  the HQs is not under Japanese control, Allied side wins")
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaObj_Completed("primary", 3)
		luaObj_Failed("primary", 4)
		luaMissionCompletedNew(luaPickRnd(Mission.HQs), "", nil, nil, nil, PARTY_ALLIED)
	end
]]
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Siege08")
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
	elseif unit == "USBB" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceBB
	elseif unit == "JapBB" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceBB
	elseif unit == "HQ" then
		local todeduct = Mission.ResourceJapHQ * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "fortresslong" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapFortressLong
	elseif unit == "fortressmain" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapFortressMain
	elseif unit == "fortresstower" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapFortressTower
	elseif unit == "coastdef" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapCoastDef
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
		luaQAS8MissionEnd()
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" Jap pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaQAS8MissionEnd()
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool < 1 then
-- RELEASE_LOGOFF  		luaLog(" both pools are under 1 point")
		Mission.Randomize = luaRnd(1, 2)
		if Mission.Randomize == 1 then
			for i = 0, 7 do
				MultiScore[i][1] = 0
				MultiScore[i][2] = 1
			end
			Mission.MissionEndCalled = true
			luaQAS8MissionEnd()
		else
			for i = 0, 7 do
				MultiScore[i][1] = 1
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaQAS8MissionEnd()
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
				luaResourcePoolReducer("usplayer")
				table.remove(Mission.USTable, index)
			end
		end
	end

	if table.getn(Mission.JapTable) ~= 0 then
		for index, unit in pairs (Mission.JapTable) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead player unit found in Mission.JapTable")
				luaResourcePoolReducer("japplayer")
				table.remove(Mission.JapTable, index)
			end
		end
	end

	local usships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	local japships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")

	if usships ~= nil then
		for index, unit in pairs (usships) do
			if unit.Class.Type == "Cruiser" and not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  				luaLog("  new player unit found, inserting it to Mission.USTable")
				AISetHintWeight(unit, 10)
				table.insert(Mission.USTable, unit)
			end
		end
	end

	if japships ~= nil then
		for index, unit in pairs (japships) do
			if unit.Class.Type == "Cruiser" and not luaIsInside(unit, Mission.JapTable) then
-- RELEASE_LOGOFF  				luaLog("  new player unit found, inserting it to Mission.JapTable")
				AISetHintWeight(unit, 10)
				table.insert(Mission.JapTable, unit)
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

function luaQAS8CheckForts()
-- RELEASE_LOGOFF  	luaLog(" Checking fortresses..")
--[[
	for index, unit in pairs (Mission.Fortresses) do
		if unit.Dead and not unit.ignore then
-- RELEASE_LOGOFF  			luaLog("  dead fortress found")
			if unit.Class.ID == 66 then
				luaResourcePoolReducer("fortresslong")
			elseif unit.Class.ID == 72 then
				luaResourcePoolReducer("fortressmain")
			elseif unit.Class.ID == 84 then
				luaResourcePoolReducer("fortresstower")
			end
			unit.ignore = true
		end
	end

	for index, unit in pairs (Mission.CoastDefs) do
		if unit.Dead and not unit.ignore then
-- RELEASE_LOGOFF  			luaLog("  dead fortress found")
			luaResourcePoolReducer("coastdef")
			unit.ignore = true
		end
	end
]]
	local threshold1 = GetHpPercentage(Mission.HQs[1]) + 0.01
	if threshold1 < Mission.PreviousHPPercentageHQ1 then
		local difference = Mission.PreviousHPPercentageHQ1 - GetHpPercentage(Mission.HQs[1])
		local percentage = difference * 100
		local by = luaRound(percentage)
		luaResourcePoolReducer("HQ", by)
		Mission.PreviousHPPercentageHQ1 = GetHpPercentage(Mission.HQs[1])
	end

	local threshold2 = GetHpPercentage(Mission.HQs[2]) + 0.01
	if threshold2 < Mission.PreviousHPPercentageHQ2 then
		local difference = Mission.PreviousHPPercentageHQ2 - GetHpPercentage(Mission.HQs[2])
		local percentage = difference * 100
		local by = luaRound(percentage)
		luaResourcePoolReducer("HQ", by)
		Mission.PreviousHPPercentageHQ2 = GetHpPercentage(Mission.HQs[2])
	end
end

function luaQAS8SpawnUnit(position, unittype, unitname, unitparty, unitrace)
	if unittype ~= nil and unitname ~= nil then
		SpawnNew({
			["party"] = unitparty,
			["groupMembers"] = {
				{
					["Type"] = unittype,
					["Name"] = unitname,
					["Crew"] = 1,
					["Race"] = unitrace,
					["WingCount"] = 1,
					["Equipment"] = 0,
					["OwnerPlayer"] = PLAYER_AI,
				},
			},
			["area"] = {
				["refPos"] = position,
				["angleRange"] = { DEG(180), DEG(185) },
			},
			["callback"] = "luaQAS8UnitSpawned",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 50,
				["ownVertical"] = 50,
				["formationHorizontal"] = 50,
				["enemyVertical"] = 50,
				["enemyHorizontal"] = 50,
			},
		})
	end
end

function luaQAS8UnitSpawned(unit)
	if luaObj_IsActive("primary", 1) and luaObj_GetSuccess("primary", 1) == nil and luaObj_IsActive("primary", 2) and luaObj_GetSuccess("primary", 2) == nil then
		luaObj_AddUnit("primary", 1, unit)
		luaObj_AddUnit("primary", 2, unit)
	end

	if unit.Party == PARTY_ALLIED then
-- RELEASE_LOGOFF  		luaLog("  inserting US BB index "..tostring(Mission.USBBindex).." to LivingUSShips")
		Mission.USBBRespawnDisabled = false
		local closestpathindex
		local closestdist = 1000000
		for index, position in pairs (Mission.USPathsStartPoints) do
			local dist = luaGetDistance(unit, position)
			if dist < closestdist then
				closestdist = dist
				closestpathindex = index
			end
		end
		MissionNarrativeParty(PARTY_ALLIED, "mp08.nar_siege_usbb")
		MissionNarrativeParty(PARTY_JAPANESE, "mp08.nar_siege_usbb")
		EntityTurnToPosition(unit, Mission.USPathsStartPoints[closestpathindex])
		NavigatorMoveOnPath(unit, Mission.USPaths[closestpathindex])
		local pathpoints = FillPathPoints(Mission.USPaths[closestpathindex])
		local lastpoint = table.getn(pathpoints)
		AddProximityTrigger(unit, Mission.USShipTriggerIDs[Mission.USBBindex], Mission.USShipTriggerFunctions[Mission.USBBindex], pathpoints[lastpoint], 333)
		SetSkillLevel(unit, SKILL_SPNORMAL)
		Mission.LivingUSShips[Mission.USBBindex] = unit
		AISetHintWeight(unit, 20)
	elseif unit.Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  		luaLog("  inserting Jap BB index "..tostring(Mission.JapBBindex).." to LivingJapShips")
		Mission.JapBBRespawnDisabled = false
		local closestpathindex
		local closestdist = 1000000
		for index, position in pairs (Mission.JapPathsStartPoints) do
			local dist = luaGetDistance(unit, position)
			if dist < closestdist then
				closestdist = dist
				closestpathindex = index
			end
		end
		MissionNarrativeParty(PARTY_ALLIED, "mp08.nar_siege_japbb")
		MissionNarrativeParty(PARTY_JAPANESE, "mp08.nar_siege_japbb")
		EntityTurnToPosition(unit, Mission.JapPathsStartPoints[closestpathindex])
		NavigatorMoveOnPath(unit, Mission.JapPaths[closestpathindex])
		local pathpoints = FillPathPoints(Mission.JapPaths[closestpathindex])
		local lastpoint = table.getn(pathpoints)
		AddProximityTrigger(unit, Mission.JapShipTriggerIDs[Mission.JapBBindex], Mission.JapShipTriggerFunctions[Mission.JapBBindex], pathpoints[lastpoint], 333)
		SetSkillLevel(unit, SKILL_SPNORMAL)
		Mission.LivingJapShips[Mission.JapBBindex] = unit
		AISetHintWeight(unit, 20)
	end
end

function luaQAS8USShip1InPos()
-- RELEASE_LOGOFF  	luaLog(" Mission.LivingUSShips[1] is in position")
	if not Mission.LivingUSShips[1].Dead then
		Mission.LivingUSShips[1].inpos = true
		luaQAS8SetTarget(Mission.LivingUSShips[1])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8USShip2InPos()
-- RELEASE_LOGOFF  	luaLog(" Mission.LivingUSShips[2] is in position")
	if not Mission.LivingUSShips[2].Dead then
		Mission.LivingUSShips[2].inpos = true
		luaQAS8SetTarget(Mission.LivingUSShips[2])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8USShip3InPos()
-- RELEASE_LOGOFF  	luaLog(" Mission.LivingUSShips[3] is in position")
	if not Mission.LivingUSShips[3].Dead then
		Mission.LivingUSShips[3].inpos = true
		luaQAS8SetTarget(Mission.LivingUSShips[3])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8USShip4InPos()
-- RELEASE_LOGOFF  	luaLog(" Mission.LivingUSShips[4] is in position")
	if not Mission.LivingUSShips[4].Dead then
		Mission.LivingUSShips[4].inpos = true
		luaQAS8SetTarget(Mission.LivingUSShips[4])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8USShip5InPos()
-- RELEASE_LOGOFF  	luaLog(" Mission.LivingUSShips[5] is in position")
	if not Mission.LivingUSShips[5].Dead then
		Mission.LivingUSShips[5].inpos = true
		luaQAS8SetTarget(Mission.LivingUSShips[5])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8USShip6InPos()
-- RELEASE_LOGOFF  	luaLog(" Mission.LivingUSShips[6] is in position")
	if not Mission.LivingUSShips[6].Dead then
		Mission.LivingUSShips[6].inpos = true
		luaQAS8SetTarget(Mission.LivingUSShips[6])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8USShip7InPos()
-- RELEASE_LOGOFF  	luaLog(" Mission.LivingUSShips[7] is in position")
	if not Mission.LivingUSShips[7].Dead then
		Mission.LivingUSShips[7].inpos = true
		luaQAS8SetTarget(Mission.LivingUSShips[7])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8USShip8InPos()
-- RELEASE_LOGOFF  	luaLog(" Mission.LivingUSShips[8] is in position")
	if not Mission.LivingUSShips[8].Dead then
		Mission.LivingUSShips[8].inpos = true
		luaQAS8SetTarget(Mission.LivingUSShips[8])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8JapShip1InPos()
-- RELEASE_LOGOFF  	luaLog(" Mission.LivingJapShips[1] is in position")
	if not Mission.LivingJapShips[1].Dead then
		Mission.LivingJapShips[1].inpos = true
		luaQAS8SetTarget(Mission.LivingJapShips[1])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8JapShip2InPos()
-- RELEASE_LOGOFF  	luaLog(" Mission.LivingJapShips[2] is in position")
	if not Mission.LivingJapShips[2].Dead then
		Mission.LivingJapShips[2].inpos = true
		luaQAS8SetTarget(Mission.LivingJapShips[2])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8JapShip3InPos()
-- RELEASE_LOGOFF  	luaLog(" Mission.LivingJapShips[3] is in position")
	if not Mission.LivingJapShips[3].Dead then
		Mission.LivingJapShips[3].inpos = true
		luaQAS8SetTarget(Mission.LivingJapShips[3])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8JapShip4InPos()
-- RELEASE_LOGOFF  	luaLog(" Mission.LivingJapShips[4] is in position")
	if not Mission.LivingJapShips[4].Dead then
		Mission.LivingJapShips[4].inpos = true
		luaQAS8SetTarget(Mission.LivingJapShips[4])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8JapShip5InPos()
-- RELEASE_LOGOFF  	luaLog(" Mission.LivingJapShips[5] is in position")
	if not Mission.LivingJapShips[5].Dead then
		Mission.LivingJapShips[5].inpos = true
		luaQAS8SetTarget(Mission.LivingJapShips[5])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8JapShip6InPos()
-- RELEASE_LOGOFF  	luaLog(" Mission.LivingJapShips[6] is in position")
	if not Mission.LivingJapShips[6].Dead then
		Mission.LivingJapShips[6].inpos = true
		luaQAS8SetTarget(Mission.LivingJapShips[6])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8JapShip7InPos()
-- RELEASE_LOGOFF  	luaLog(" Mission.LivingJapShips[7] is in position")
	if not Mission.LivingJapShips[7].Dead then
		Mission.LivingJapShips[7].inpos = true
		luaQAS8SetTarget(Mission.LivingJapShips[7])
	else
-- RELEASE_LOGOFF  		luaLog("  but it's dead...")
	end
end

function luaQAS8HintManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 30 and not Mission.Hint1Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint1Shown")
			ShowHint("ID_Hint_Siege08_ships")
			Mission.Hint1Shown = true
		elseif GameTime() > 60 and not Mission.Hint2Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint2Shown")
			ShowHint("ID_Hint_Siege08_BB")
			Mission.Hint2Shown = true
		elseif GameTime() > 90 and not Mission.Hint3Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint3Shown")
			ShowHint("ID_Hint_Siege08_critical")
			Mission.Hint3Shown = true
		elseif GameTime() > 120 and not Mission.Hint4Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint4Shown")
			ShowHint("ID_Hint_Siege08_torpedo")
			Mission.Hint4Shown = true
		end
	end
end