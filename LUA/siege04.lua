--SceneFile="Missions\Multi\Scene4.scn"

function luaPrecacheUnits()
	PrepareClass(32) -- Betty + Ohka
	PrepareClass(46) -- Kamikaze Val
	PrepareClass(150) -- Zero
	PrepareClass(152) -- Gekko
	PrepareClass(154) -- Oscar
	PrepareClass(101) -- Wildcat
	PrepareClass(102) -- Corsair
	PrepareClass(133) -- Buffalo
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAS4Mission")
end

function luaInitQAS4Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Siege4"..dateandtime

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
	Mission.MultiplayerNumber = 4

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- mission valtozok
	--Mission.BomberKillCounter = 0
	--Mission.BomberSquadsToKill = 30

	Mission.KeyUnitCounter = 0 -- luaQAS4StartMission()-ben allitjuk be
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

	-- japan objektumok

	Mission.KamikazeTMPL = luaFindHidden("Siege - Kamikaze Val")
	Mission.BettyTMPL = luaFindHidden("Siege - Betty")
	Mission.Kamikazes = {}
	Mission.JapBombers = {}
	Mission.JapBomberFilter = {}

	Mission.JapSpawnPoints = {}
		table.insert(Mission.JapSpawnPoints, GetPosition(FindEntity("Siege - Navpoint 01")))
		table.insert(Mission.JapSpawnPoints, GetPosition(FindEntity("Siege - Navpoint 02")))
		table.insert(Mission.JapSpawnPoints, GetPosition(FindEntity("Siege - Navpoint 03")))
		table.insert(Mission.JapSpawnPoints, GetPosition(FindEntity("Siege - Navpoint 04")))
		table.insert(Mission.JapSpawnPoints, GetPosition(FindEntity("Siege - Navpoint 05")))
		table.insert(Mission.JapSpawnPoints, GetPosition(FindEntity("Siege - Navpoint 06")))
	Mission.JapExitPoint = GetPosition(FindEntity("Siege - Navpoint 07"))

	-- amerikai objektumok
	Mission.HQ = FindEntity("Siege - HQ")
	Mission.USShips = {}
		table.insert(Mission.USShips, FindEntity("Siege - King George"))
		table.insert(Mission.USShips, FindEntity("Siege - South Dakota"))
		table.insert(Mission.USShips, FindEntity("Siege - Yorktown"))
		table.insert(Mission.USShips, FindEntity("Siege - Northampton"))
		table.insert(Mission.USShips, FindEntity("Siege - Fletcher"))
		table.insert(Mission.USShips, FindEntity("Siege - DeRuyter"))
		table.insert(Mission.USShips, FindEntity("Siege - Lexington"))
		table.insert(Mission.USShips, FindEntity("Siege - Renown"))
		table.insert(Mission.USShips, FindEntity("Siege - Atlanta"))
		table.insert(Mission.USShips, FindEntity("Siege - Cleveland"))

	Mission.USShipsReducerName = {}
		table.insert(Mission.USShipsReducerName, "kinggeorge")
		table.insert(Mission.USShipsReducerName, "southdakota")
		table.insert(Mission.USShipsReducerName, "yorktown")
		table.insert(Mission.USShipsReducerName, "northampton")
		table.insert(Mission.USShipsReducerName, "fletcher")
		table.insert(Mission.USShipsReducerName, "deruyter")
		table.insert(Mission.USShipsReducerName, "lexington")
		table.insert(Mission.USShipsReducerName, "renown")
		table.insert(Mission.USShipsReducerName, "atlanta")
		table.insert(Mission.USShipsReducerName, "cleveland")

--[[
	Mission.ShipFilter = {}
	Mission.ShipOnMoveOut = {}
	Mission.JapShipPaths = {}
		table.insert(Mission.JapShipPaths, FindEntity("Siege - USShipPath 1"))
		table.insert(Mission.JapShipPaths, FindEntity("Siege - USShipPath 2"))
		table.insert(Mission.JapShipPaths, FindEntity("Siege - USShipPath 3"))
		table.insert(Mission.JapShipPaths, FindEntity("Siege - USShipPath 4"))
		table.insert(Mission.JapShipPaths, FindEntity("Siege - USShipPath 5"))
		table.insert(Mission.JapShipPaths, FindEntity("Siege - USShipPath 6"))
		table.insert(Mission.JapShipPaths, FindEntity("Siege - USShipPath 7"))
		table.insert(Mission.JapShipPaths, FindEntity("Siege - USShipPath 8"))
		table.insert(Mission.JapShipPaths, FindEntity("Siege - USShipPath 9"))
		table.insert(Mission.JapShipPaths, FindEntity("Siege - USShipPath 10"))
		table.insert(Mission.JapShipPaths, FindEntity("Siege - USShipPath 11"))
		table.insert(Mission.JapShipPaths, FindEntity("Siege - USShipPath 12"))
	Mission.JapMoveOutPath = FindEntity("Siege - USMoveOutPath")
	Mission.JapMoveOutPathPoints = FillPathPoints(Mission.JapMoveOutPath)
]]
	-- pathok

	-- figyelesek

----- resource dolgok -----

	if Mission.Players <= 2 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 2")
		Mission.ResourcePoolBase = 500
		Mission.ResourceUSPool = 500
		Mission.ResourceJapPool = 500
		Mission.AllowedKamikazes = 4
		Mission.AllowedOhkas = 1
	elseif Mission.Players <= 4 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 4")
		Mission.ResourcePoolBase = 750
		Mission.ResourceUSPool = 750
		Mission.ResourceJapPool = 750
		Mission.AllowedKamikazes = 4
		Mission.AllowedOhkas = 2
	elseif Mission.Players <= 6 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 6")
		Mission.ResourcePoolBase = 900
		Mission.ResourceUSPool = 900
		Mission.ResourceJapPool = 900
		Mission.AllowedKamikazes = 6
		Mission.AllowedOhkas = 3
	elseif Mission.Players <= 8 then
-- RELEASE_LOGOFF  		luaLog(" Mission.Players <= 8")
		Mission.ResourcePoolBase = 1000
		Mission.ResourceUSPool = 1000
		Mission.ResourceJapPool = 1000
		Mission.AllowedKamikazes = 6
		Mission.AllowedOhkas = 3
	else
-- RELEASE_LOGOFF  		luaLog(" FAIL!!! unhandled Mission.Players: "..Mission.Players)
		Mission.ResourcePoolBase = 1000
		Mission.ResourceUSPool = 1000
		Mission.ResourceJapPool = 1000
		Mission.AllowedKamikazes = 6
		Mission.AllowedOhkas = 3
	end
	Mission.ResourceUSSouthDakota = 1.2
	Mission.ResourceUSRenown = 1.2
	Mission.ResourceUSAtlanta = 1.2
	Mission.ResourceUSCleveland = 1.2
	Mission.ResourceUSDeRuyter = 1.2
	Mission.ResourceUSYorktown = 1.2
	Mission.ResourceUSKingGeorge = 1.2
	Mission.ResourceUSNorthampton = 1.2
	Mission.ResourceUSLexiongton = 1.2
	Mission.ResourceUSFletcher = 1.2
	Mission.ResourceJapKamikaze = 5
	Mission.ResourceJapBetty = 10
	Mission.ResourceJapOhka = 7
	Mission.ResourcePlayerUnit = 3

	for index, unit in pairs (Mission.USShips) do
		unit.previouspercentage = 1
	end

---------------------------

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_primary_1",
				["Text"] = "mp04.obj_siege_us_p1_text",
				["TextCompleted"] = "mp04.obj_siege_us_p1_comp",
				["TextFailed"] = "mp04.obj_siege_us_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_primary_1",
				["Text"] = "mp04.obj_siege_jap_p1_text",
				["TextCompleted"] = "mp04.obj_siege_jap_p1_comp",
				["TextFailed"] = "mp04.obj_siege_jap_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
--[[
			[3] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_primary_2",
				["Text"] = "Destroy the kamikaze planes before they sink half of the ships!",
				["TextCompleted"] = "You have destroyed the kamikaze planes!",
				["TextFailed"] = "You have failed to destroy the kamikaze planes!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_primary_2",
				["Text"] = "Aid the kamikaze planes to destroy more than half of the ships!",
				["TextCompleted"] = "You have successfully aided the kamikazes!",
				["TextFailed"] = "You failed to aid the kamikaze planes!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,
				["ScoreFailed"] = 0
			},
]]
		},
		["secondary"] = {
--[[
			[1] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_secondary_1",
				["Text"] = "At least 30 bombers must be destroyed before they release their equipment!",
				["TextCompleted"] = "You have successfully protected on ship at least!",
				["TextFailed"] = "The fleet is no more!",
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

    SetThink(this, "luaQAS4Mission_think")
end

function luaQAS4Mission_think(this, msg)
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
		--luaQAS4CheckUSPlanes()
		--luaQAS4CheckUSShips()
		luaQAS4CheckObjPlanes()
		luaQAS4CheckObjShips()
		luaQAS4CheckKeyCounter()
		luaCheckPlayers()
		luaQAS4HintManager()

	elseif not Mission.Started then
		luaQAS4StartMission()
		luaSetMultiScoreTable()
	end
end

function luaQAS4StartMission()
-- RELEASE_LOGOFF  	luaLog(" Starting mission...")
	Scoring_RealPlayTimeRunning(true)
	
	luaShowMissionHint()
	
	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	for index, unit in pairs (Mission.USShips) do
		SetRepairEffectivity(unit, 0.25)
	end

	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2)
	--luaObj_Add("primary", 3)
	--luaObj_Add("primary", 4)

	for index, unit in pairs (Mission.USShips) do
		luaObj_AddUnit("primary", 1, unit)
		luaObj_AddUnit("primary", 2, unit)
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidShipCollision(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		NavigatorEnable(unit, false)
		ArtilleryEnable(unit, false)
		AAEnable(unit, false)
		TorpedoEnable(unit, false)
		--luaObj_AddUnit("primary", 1, unit)
		--luaObj_AddUnit("primary", 2, unit)
	end
--[[
	if Mission.Players <= 2 then
		Mission.KamikazeToDestroy = 36
	elseif Mission.Players == 3 then
		Mission.KamikazeToDestroy = 42
	elseif Mission.Players == 4 then
		Mission.KamikazeToDestroy = 48
	elseif Mission.Players == 5 then
		Mission.KamikazeToDestroy = 54
	elseif Mission.Players == 6 then
		Mission.KamikazeToDestroy = 60
	elseif Mission.Players == 7 then
		Mission.KamikazeToDestroy = 66
	elseif Mission.Players == 8 then
		Mission.KamikazeToDestroy = 72
	end
-- RELEASE_LOGOFF  	luaLog(" KeyUnitCounter set to "..Mission.KamikazeToDestroy)
]]
	Mission.KamikazeToDestroy = 10000
	Mission.KeyUnitCounter = Mission.KamikazeToDestroy
	--ModifyKeyUnitNumber(Mission.KeyUnitCounter)

	local randomtimer = luaRnd(60, 90)
	luaDelay(luaQAS4PermitOhkas, randomtimer)
	Mission.Started = true
end

function luaQAS4CheckObjectives()
-- RELEASE_LOGOFF  	luaLog(" Checking Objectives...")
--[[
	Mission.JapShips = luaRemoveDeadsFromTable(Mission.JapShips)
	if table.getn(Mission.JapShips) ~= 0 then
		
	elseif table.getn(Mission.JapShips) == 0 and not Mission.MissionEndCalled then
-- RELEASE_LOGOFF  		luaLog("  all ships have been destroyed, calling mission end...")
		Mission.MissionEndCalled = true
		CountdownCancel()
		luaQAS4MissionEnd()
	end

	if Mission.BomberKillCounter >= Mission.BomberSquadsToKill and luaObj_GetSuccess("secondary", 1) == nil then
-- RELEASE_LOGOFF  		luaLog("  secondary 1 requirements reached...")
		Mission.USBombers = luaRemoveDeadsFromTable(Mission.USBombers)
		for index, unit in pairs (Mission.USBombers) do
			if unit.marked then
-- RELEASE_LOGOFF  				luaLog("   removing mark from unit ID: "..unit.ID)
				unit.marked = false
				luaObj_RemoveUnit("secondary", 1, unit)
			end
		end
		luaObj_Completed("secondary", 1)
	end
]]
end
--[[
function luaQAS4CheckUSPlanes()
-- RELEASE_LOGOFF  	luaLog(" Checking US planes...")
	if Mission.USDiveBomberingPermit then
		Mission.USDiveBomberingPermit = false
		luaQAS4SpawnBombers(Mission.USDiveBomberTemplate, luaRnd(2, 3))
		local randomtimer = luaRnd(50, 70)
		luaDelay(luaQAC3PermitDiveBombers, randomtimer)
	end

	if Mission.USLevelBomberingPermit then
		Mission.USLevelBomberingPermit = false
		luaQAS4SpawnBombers(Mission.USLevelBomberTemplate, luaRnd(1, 2))
		local randomtimer = luaRnd(80, 100)
		luaDelay(luaQAC3PermitLevelBombers, randomtimer)
	end

	if Mission.USTorpedoBomberingPermit then
		Mission.USTorpedoBomberingPermit = false
		luaQAS4SpawnBombers(Mission.USTorpedoBomberTemplate, luaRnd(1, 2))
		local randomtimer = luaRnd(65, 85)
		luaDelay(luaQAC3PermitTorpedoBombers, randomtimer)
	end

	if table.getn(Mission.USBombers) ~= 0 then
		for index, unit in pairs (Mission.USBombers) do
			if unit.Dead then
				table.remove(Mission.USBombers, index)
				Mission.BomberKillCounter = Mission.BomberKillCounter + 1

			elseif table.getn(GetPayloads(unit)) == 0 then
-- RELEASE_LOGOFF  				luaLog("  bomber found without payload")
				PilotMoveTo(unit, Mission.USExitPoint)
				SquadronSetTravelAlt(unit, 800)
				if unit.marked then
-- RELEASE_LOGOFF  					luaLog("   removing mark from unit ID: "..unit.ID)
					unit.marked = false
					luaObj_RemoveUnit("secondary", 1, unit)
				end
				table.remove(Mission.USBombers, index)
				table.insert(Mission.USBomberFilter, unit)
			end
		end
	end
	
	Mission.USBomberFilter = luaRemoveDeadsFromTable(Mission.USBomberFilter)
	if table.getn(Mission.USBomberFilter) ~= 0 then
		for index, unit in pairs (Mission.USBomberFilter) do
			if luaGetDistance(unit, Mission.USExitPoint) < 250 then
-- RELEASE_LOGOFF  				luaLog("  bomber reached the exitpoint")
				Kill(unit, true)
			end
		end
	end
end
]]

function luaQAS4CheckObjPlanes()
-- RELEASE_LOGOFF  	luaLog(" Checking bomber planes...")
	if table.getn(Mission.Kamikazes) ~= 0 then
		for index, unit in pairs (Mission.Kamikazes) do
			if unit.Dead then
				Mission.KeyUnitCounter = Mission.KeyUnitCounter - 1
				--ModifyKeyUnitNumber(Mission.KeyUnitCounter)
				if unit.Class.ID == 156 then
					luaResourcePoolReducer("ohka")
				else
					luaResourcePoolReducer("kamikaze")
				end
				table.remove(Mission.Kamikazes, index)
			elseif UnitGetAttackTarget(unit) == nil then
-- RELEASE_LOGOFF  				luaLog(" Kamikaze without target found")
				luaQAS4SetAttackTarget(unit)
			end
		end
	elseif table.getn(Mission.Kamikazes) == 0 then
-- RELEASE_LOGOFF  		luaLog("  no kamikazes found, calling spawn...")
--[[
		local allowedplanes = 0
		if Mission.KeyUnitCounter >= 6 then
			allowedplanes = 6
-- RELEASE_LOGOFF  			luaLog("  spawning 6 kamikaze planes...")
		else
			allowedplanes = Mission.KeyUnitCounter
-- RELEASE_LOGOFF  			luaLog("  spawning "..tostring(Mission.KeyUnitCounter).." kamikaze planes...")
		end
		for i = 1, allowedplanes do
]]
		for i = 1, Mission.AllowedKamikazes do
			local kamikazespawn = GenerateObject(Mission.KamikazeTMPL.Name, Mission.JapSpawnPoints[i])
			SetSkillLevel(kamikazespawn, SKILL_MPVETERAN)
			local kamikazespeed = kamikazespawn.Class.MaxSpd * 0.85
			SquadronSetTravelSpeed(kamikazespawn, kamikazespeed)
			if luaObj_IsActive("primary", 1) and luaObj_GetSuccess("primary", 1) == nil then
			--if luaObj_IsActive("primary", 3) and luaObj_GetSuccess("primary", 3) == nil and luaObj_IsActive("primary", 4) and luaObj_GetSuccess("primary", 4) == nil then
				luaObj_AddUnit("primary", 1, kamikazespawn)
				--luaObj_AddUnit("primary", 4, kamikazespawn)
			end
			AISetHintWeight(kamikazespawn, 10)
			--PutTo(kamikazespawn, Mission.JapSpawnPoints[i])
			luaQAS4SetAttackTarget(kamikazespawn)
			table.insert(Mission.Kamikazes, kamikazespawn)
		end
		Mission.JapPlaneSpawnDenied = true
		luaDelay(luaQAS4PermitJapPlaneSpawn, 7)
	end

	if Mission.PermitOhkas and not Mission.JapPlaneSpawnDenied then
-- RELEASE_LOGOFF  		luaLog("  spawning Ohka carrier planes")
		Mission.PermitOhkas = false
		local firstpos = luaRnd(1, 3)
		if Mission.KeyUnitCounter == table.getn(Mission.Kamikazes) then
-- RELEASE_LOGOFF  			luaLog("  spawn denied")
		else
			for i = 1, Mission.AllowedOhkas do
				local pos = firstpos + i
				local ohkacarrier = GenerateObject(Mission.BettyTMPL.Name, Mission.JapSpawnPoints[pos])
				MissionNarrativeParty(PARTY_ALLIED, "mp04.nar_siege_ohka")
				SetSkillLevel(ohkacarrier, SKILL_MPVETERAN)
				if luaObj_IsActive("primary", 1) and luaObj_GetSuccess("primary", 1) == nil then
				--if luaObj_IsActive("primary", 3) and luaObj_GetSuccess("primary", 3) == nil and luaObj_IsActive("primary", 4) and luaObj_GetSuccess("primary", 4) == nil then
					luaObj_AddUnit("primary", 1, ohkacarrier)
					--luaObj_AddUnit("primary", 4, ohkacarrier)
				end
				AISetHintWeight(ohkacarrier, 20)
				--PutTo(ohkacarrier, Mission.JapSpawnPoints[pos])
				luaQAS4SetAttackTarget(ohkacarrier)
				table.insert(Mission.JapBombers, ohkacarrier)
			end
			local randomtimer = luaRnd(80, 100)
			luaDelay(luaQAS4PermitOhkas, randomtimer)
		end
	end

	if table.getn(Mission.JapBombers) ~= 0 then
		for index, unit in pairs (Mission.JapBombers) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead Betty found")
				Mission.KeyUnitCounter = Mission.KeyUnitCounter - 1
				--ModifyKeyUnitNumber(Mission.KeyUnitCounter)
				luaResourcePoolReducer("betty")
				table.remove(Mission.JapBombers, index)
			elseif table.getn(GetPayloads(unit)) == 0 then
-- RELEASE_LOGOFF  				luaLog("  Betty without payload found")
				PilotMoveTo(unit, Mission.JapExitPoint)
				if luaObj_IsActive("primary", 1) and luaObj_GetSuccess("primary", 1) == nil then
				--if luaObj_IsActive("primary", 3) and luaObj_GetSuccess("primary", 3) == nil and luaObj_IsActive("primary", 4) and luaObj_GetSuccess("primary", 4) == nil then
					luaObj_RemoveUnit("primary", 1, unit)
					--luaObj_RemoveUnit("primary", 4, unit)
				end
				table.remove(Mission.JapBombers, index)
				table.insert(Mission.JapBomberFilter, unit)
			elseif UnitGetAttackTarget(unit) == nil then
-- RELEASE_LOGOFF  				luaLog(" JapBomber without target found")
				luaQAS4SetAttackTarget(unit)
			end
		end
	end

	local planesinscene = luaGetPlanesAroundCoordinate(GetPosition(Mission.HQ), 20000, PARTY_JAPANESE, "own")
	if planesinscene ~= nil then
		for index, unit in pairs (planesinscene) do
			if unit.Class.ID == 156 and not unit.marked then
				unit.marked = true
				SetSkillLevel(unit, SKILL_ELITE)
				luaObj_AddUnit("primary", 1, unit)
				--luaObj_AddUnit("primary", 4, unit)
				table.insert(Mission.Kamikazes, unit)
			end
		end
	end

	if table.getn(Mission.JapBomberFilter) ~= 0 then
		for index, unit in pairs (Mission.JapBomberFilter) do
			if unit.Dead then
				luaResourcePoolReducer("betty")
				table.remove(Mission.JapBomberFilter, index)
			elseif not unit.Dead then
				if luaGetDistance(unit, Mission.JapExitPoint) < 300 then
-- RELEASE_LOGOFF  					luaLog("  killing filtered bomber")
					Kill(unit, true)
				end
			end
		end
	end
end

function luaQAS4SetAttackTarget(unit)
	local possibletargets = {}
	for index, unit in pairs (Mission.USShips) do
		if not unit.Dead then
			table.insert(possibletargets, unit)
		end
	end
	if table.getn(possibletargets) ~= 0 then
		local randomtarget = luaPickRnd(possibletargets)
		--luaLog(randomtarget)
		PilotSetTarget(unit, randomtarget)
	end
end


--[[
function luaQAC3PermitDiveBombers()
-- RELEASE_LOGOFF  	luaLog(" Permiting divebombers")
	Mission.USDiveBomberingPermit = true
end

function luaQAC3PermitLevelBombers()
-- RELEASE_LOGOFF  	luaLog(" Permiting level bombers")
	Mission.USLevelBomberingPermit = true
end

function luaQAC3PermitTorpedoBombers()
-- RELEASE_LOGOFF  	luaLog(" Permiting torpedo bombers")
	Mission.USTorpedoBomberingPermit = true
end

function luaQAS4SpawnBombers(planetype, planecount)
	if not Mission.Completed then
-- RELEASE_LOGOFF  		luaLog(" -> SPAWNING "..tostring(planecount).." "..tostring(planetype.Name).." <-")
		local posindex = luaRnd(1, 6)
		Mission.JapShips = luaRemoveDeadsFromTable(Mission.JapShips)
		local randomtarget = luaPickRnd(Mission.JapShips)
		for i = 1, planecount do
			local bomber = GenerateObject(planetype.Name)
			local puttomod = 150 * i
			local coordinate = Mission.USSpawnPoints[posindex]
			AISetHintWeight(bomber, 10)
			PutTo(bomber, {["x"] = coordinate.x + puttomod, ["y"] = coordinate.y, ["z"] = coordinate.z + puttomod})
			PilotSetTarget(bomber, randomtarget)
			EntityTurnToEntity(bomber, randomtarget)
			SquadronSetTravelAlt(bomber, 800)
			if luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary", 1) == nil then
				luaObj_AddUnit("secondary", 1, bomber)
				bomber.marked = true
			end
			table.insert(Mission.USBombers, bomber)
		end
	end
end
]]
function luaQAS4CheckUSShips()
-- RELEASE_LOGOFF  	luaLog(" Checking US ships...")
--[[
	if Mission.USShipOpPermit then
		Mission.ShipFilter = luaRemoveDeadsFromTable(Mission.ShipFilter)
		if table.getn(Mission.ShipFilter) ~= 0 then
			local shipop = luaPickRnd(Mission.ShipFilter)
-- RELEASE_LOGOFF  			luaLog("  "..shipop.Name.." is operational")
			MissionNarrativeParty(0, "WARNING! "..shipop.Name.." is operational!")
			MissionNarrativeParty(1, shipop.Name.." is operational!")
			NavigatorEnable(shipop, true)
			ArtilleryEnable(shipop, true)
			AAEnable(shipop, true)
			TorpedoEnable(shipop, true)
			NavigatorMoveOnPath(shipop, Mission.JapMoveOutPath, PATH_FM_SIMPLE, PATH_SM_BEGIN)
			SetShipSpeed(shipop, Mission.SlowestSpeed)
			for index, unit in pairs (Mission.ShipFilter) do
				if shipop.ID == unit.ID then
					table.remove(Mission.ShipFilter, index)
					table.insert(Mission.ShipOnMoveOut, shipop)
				end
			end
		end		
		Mission.USShipOpPermit = false
		randomtimer = luaRnd(90, 120)
		luaDelay(luaQAS4PermitShipOp, randomtimer)
	end

	Mission.ShipOnMoveOut = luaRemoveDeadsFromTable(Mission.ShipOnMoveOut)
	if table.getn(Mission.ShipOnMoveOut) ~= 0 then
		for index, unit in pairs (Mission.ShipOnMoveOut) do
			if luaGetDistance(unit, Mission.JapMoveOutPathPoints[5]) < 300 then
				local randompath = luaPickRnd(Mission.JapShipPaths)
				NavigatorMoveOnPath(unit, randompath, PATH_FM_CIRCLE, PATH_SM_BEGIN)
				SetShipSpeed(unit, Mission.SlowestSpeed)
			end
		end
	end
]]
end
--[[
function luaQAS4PermitShipOp()
-- RELEASE_LOGOFF  	luaLog(" Permiting ships operation...")
	Mission.USShipOpPermit = true
end
]]

function luaQAS4PermitOhkas()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Permiting Ohka strike...")
		Mission.PermitOhkas = true
	end
end

function luaQAS4PermitJapPlaneSpawn()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Plane spawns permited...")
		Mission.JapPlaneSpawnDenied = false
	end
end

function luaQAS4CheckObjShips()
-- RELEASE_LOGOFF  	luaLog(" Checking ojective units...")
	for index, unit in pairs (Mission.USShips) do
		if not unit.Dead then
			local threshold = GetHpPercentage(unit) + 0.0001
			if threshold < unit.previouspercentage then
				local difference = unit.previouspercentage - GetHpPercentage(unit)
				local percentage = difference * 100
				local by = luaRound(percentage)
				luaResourcePoolReducer(Mission.USShipsReducerName[index], by)
				unit.previouspercentage = GetHpPercentage(unit)
			end
		elseif unit.Dead and not unit.ignore then
			unit.ignore = true
			local percentage = unit.previouspercentage * 100
			local by = luaRound(percentage)
			luaResourcePoolReducer(Mission.USShipsReducerName[index], by)
			unit.previouspercentage = 0
		end
	end

--[[
	Mission.USShips = luaRemoveDeadsFromTable(Mission.USShips)
	if table.getn(Mission.USShips) <= 5 and not Mission.MissionEndCalled then
		Mission.MissionEndCalled = true
		luaQAS4MissionEnd()
	end
]]
end

function luaQAS4CheckKeyCounter()
-- RELEASE_LOGOFF  	luaLog(" Checking key counter...")
	if Mission.KeyUnitCounter == 0 and not Mission.MissionEndCalled then
		Mission.MissionEndCalled = true
		luaQAS4MissionEnd()
	end
end

function luaQAS4MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	Mission.Completed = true
	--Mission.USShips = luaRemoveDeadsFromTable(Mission.USShips)
	Scoring_RealPlayTimeRunning(false)
	if Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 then
-- RELEASE_LOGOFF  		luaLog("  Japanese side won!")
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		luaMissionCompletedNew(luaPickRnd(Mission.USShips), "", nil, nil, nil, PARTY_JAPANESE)
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 then
-- RELEASE_LOGOFF  		luaLog("  US side won!")
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaMissionCompletedNew(luaPickRnd(Mission.USShips), "", nil, nil, nil, PARTY_ALLIED)
	end
--[[
	if table.getn(Mission.USShips) <= 5 then
-- RELEASE_LOGOFF  		luaLog("  Japanese side won!")
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 1)
		--luaObj_Completed("primary", 4)
		--luaObj_Failed("primary", 3)
		luaMissionCompletedNew(luaPickRnd(Mission.USShips), "", nil, nil, nil, PARTY_JAPANESE)
	else
-- RELEASE_LOGOFF  		luaLog("  US side won!")
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		--luaObj_Completed("primary", 3)
		--luaObj_Failed("primary", 4)
		luaMissionCompletedNew(luaPickRnd(Mission.USShips), "", nil, nil, nil, PARTY_ALLIED)
	end
]]
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Siege04")
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

	local usplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 20000, PARTY_ALLIED, "own")
	local japplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 20000, PARTY_JAPANESE, "own")
	if usplanes ~= nil then
		for index, unit in pairs (usplanes) do
			if unit.Class.ID == 101 or unit.Class.ID == 133 then
				if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  					luaLog("  new player unit found, inserting it to Mission.USTable")
					table.insert(Mission.USTable, unit)
				end
			end
		end
	end
	if japplanes ~= nil then
		for index, unit in pairs (japplanes) do
			if unit.Class.ID == 150 or unit.Class.ID == 152 or unit.Class.ID == 154 then
				if not luaIsInside(unit, Mission.JapTable) then
-- RELEASE_LOGOFF  					luaLog("  new player unit found, inserting it to Mission.JapTable")
					table.insert(Mission.JapTable, unit)
				end
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

function luaResourcePoolReducer(unit, by)
-- RELEASE_LOGOFF  	luaLog(" luaResourcePoolReducer called")
-- RELEASE_LOGOFF  	luaLog(unit)
-- RELEASE_LOGOFF  	luaLog(by)
	if unit == "usplayer" then
		local todeduct = Mission.ResourcePlayerUnit * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "japplayer" then
		local todeduct = Mission.ResourcePlayerUnit * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "dakota" then
		local todeduct = Mission.ResourceUSSouthDakota * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "renown" then
		local todeduct = Mission.ResourceUSRenown * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "atlanta" then
		local todeduct = Mission.ResourceUSAtlanta * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "cleveland" then
		local todeduct = Mission.ResourceUSCleveland * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "deruyter" then
		local todeduct = Mission.ResourceUSDeRuyter * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "yorktown" then
		local todeduct = Mission.ResourceUSYorktown * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "kinggeorge" then
		local todeduct = Mission.ResourceUSKingGeorge * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "northampton" then
		local todeduct = Mission.ResourceUSNorthampton * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "lexington" then
		local todeduct = Mission.ResourceUSLexiongton * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "fletcher" then
		local todeduct = Mission.ResourceUSFletcher * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "kamikaze" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapKamikaze
	elseif unit == "betty" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapBetty
	elseif unit == "ohka" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapOhka
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
		luaQAS4MissionEnd()
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" Jap pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaQAS4MissionEnd()
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool < 1 then
-- RELEASE_LOGOFF  		luaLog(" both pools are under 1 point")
		Mission.Randomize = luaRnd(1, 2)
		if Mission.Randomize == 1 then
			for i = 0, 7 do
				MultiScore[i][1] = 0
				MultiScore[i][2] = 1
			end
			Mission.MissionEndCalled = true
			luaQAS4MissionEnd()
		else
			for i = 0, 7 do
				MultiScore[i][1] = 1
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaQAS4MissionEnd()
		end
	end
end

function luaQAS4HintManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 30 and not Mission.Hint1Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint1Shown")
			ShowHint("ID_Hint_Siege01_OP")
			Mission.Hint1Shown = true
		elseif GameTime() > 60 and not Mission.Hint2Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint2Shown")
			ShowHint("ID_Hint_Siege02_ships")
			Mission.Hint2Shown = true
		elseif GameTime() > 90 and not Mission.Hint3Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint3Shown")
			ShowHint("ID_Hint_Siege04_betty")
			Mission.Hint3Shown = true
		end
	end
end