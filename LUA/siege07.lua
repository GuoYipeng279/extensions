--SceneFile="Missions\Multi\Scene7.scn"

function luaPrecacheUnits()
	PrepareClass(12) -- LSM (spec QAS7)
	PrepareClass(41) -- LST (spec QAS7)
	PrepareClass(108) -- Dauntless
	PrepareClass(77) -- JapPT
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAS7Mission")
end

function luaInitQAS7Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Siege7"..dateandtime

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
	Mission.MultiplayerNumber = 7

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- mission valtozok
	Mission.KeyUnitCounter = 2 -- 2 CV
	--ModifyKeyUnitNumber(Mission.KeyUnitCounter)

	Mission.LSMTriggerID = {}
		table.insert(Mission.LSMTriggerID, LSM1)
		table.insert(Mission.LSMTriggerID, LSM2)
		table.insert(Mission.LSMTriggerID, LSM3)
	Mission.LSMTriggerFunction = {}
		table.insert(Mission.LSMTriggerFunction, "luaQAS7LSM1InPos")
		table.insert(Mission.LSMTriggerFunction, "luaQAS7LSM2InPos")
		table.insert(Mission.LSMTriggerFunction, "luaQAS7LSM3InPos")

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
	Mission.CVs = {}
		table.insert(Mission.CVs, FindEntity("Siege - Yorktown"))
		table.insert(Mission.CVs, FindEntity("Siege - Lexington"))
	Mission.DefShips = {}
		table.insert(Mission.DefShips, FindEntity("Siege - Northampton"))
		table.insert(Mission.DefShips, FindEntity("Siege - Cleveland"))
		table.insert(Mission.DefShips, FindEntity("Siege - ASW Fletcher"))
		table.insert(Mission.DefShips, FindEntity("Siege - ASW Fletcher 01"))
		--table.insert(Mission.DefShips, FindEntity("Siege - ASW Fletcher 02"))
		--table.insert(Mission.DefShips, FindEntity("Siege - ASW Fletcher 03"))
	Mission.LSTs = {}
	Mission.LSTTMPL = luaFindHidden("Siege - LST TMPL")
	Mission.LSMs = {}
	Mission.LSMTMPL = luaFindHidden("Siege - LSM TMPL")
	Mission.Dauntlesses = {}
	Mission.DauntlessTMPL = luaFindHidden("Siege - Dauntless TMPL")

	AISetHintWeight(Mission.CVs[1], 75)
	AISetHintWeight(Mission.CVs[2], 75)
	AISetHintWeight(Mission.DefShips[1], 75)
	AISetHintWeight(Mission.DefShips[2], 75)
	AISetHintWeight(Mission.DefShips[3], 75)
	AISetHintWeight(Mission.DefShips[4], 75)
	--AISetHintWeight(Mission.DefShips[5], 75)
	--AISetHintWeight(Mission.DefShips[6], 75)

	-- japan objektumok
	Mission.HQ = FindEntity("Siege - Headquarter")
	Mission.Fortresses = {}
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 1"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 2"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 3"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 4"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 5"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 6"))
	Mission.CoastDefs = {}
		table.insert(Mission.CoastDefs, FindEntity("Siege - Coastal Gun 01"))
		table.insert(Mission.CoastDefs, FindEntity("Siege - Coastal Gun 02"))
		table.insert(Mission.CoastDefs, FindEntity("Siege - Coastal Gun 03"))
		table.insert(Mission.CoastDefs, FindEntity("Siege - Heavy AA 01"))
		table.insert(Mission.CoastDefs, FindEntity("Siege - Heavy AA 02"))
		table.insert(Mission.CoastDefs, FindEntity("Siege - Heavy AA 03"))
	Mission.PTs = {}
	Mission.PTTMPL = luaFindHidden("Siege - JapPT TMPL")

	AISetHintWeight(Mission.HQ, 0)
	for index, unit in pairs (Mission.Fortresses) do
		AISetHintWeight(unit, 40)
	end
	for index, unit in pairs (Mission.CoastDefs) do
		AISetHintWeight(unit, 80)
	end

	-- HQ
	AISetTargetWeight(104, 241, false, 0)
	AISetTargetWeight(108, 241, false, 0)
	AISetTargetWeight(134, 241, false, 0)
	-- fortress long
	AISetTargetWeight(104, 249, false, 44)
	AISetTargetWeight(108, 249, false, 0)
	AISetTargetWeight(134, 249, false, 44)
	-- fortress main
	AISetTargetWeight(104, 267, false, 40)
	AISetTargetWeight(108, 267, false, 0)
	AISetTargetWeight(134, 267, false, 40)
	-- fortress left tower
	AISetTargetWeight(104, 268, false, 48)
	AISetTargetWeight(108, 268, false, 0)
	AISetTargetWeight(134, 268, false, 48)

	-- pathok, navpontok
	Mission.LSTSpawnPoints = {}
		table.insert(Mission.LSTSpawnPoints, GetPosition(FindEntity("Siege - LST Navpoint 1")))
		table.insert(Mission.LSTSpawnPoints, GetPosition(FindEntity("Siege - LST Navpoint 2")))
		table.insert(Mission.LSTSpawnPoints, GetPosition(FindEntity("Siege - LST Navpoint 3")))
		table.insert(Mission.LSTSpawnPoints, GetPosition(FindEntity("Siege - LST Navpoint 4")))
		table.insert(Mission.LSTSpawnPoints, GetPosition(FindEntity("Siege - LST Navpoint 5")))
		table.insert(Mission.LSTSpawnPoints, GetPosition(FindEntity("Siege - LST Navpoint 6")))
	Mission.LSMSpawnPoints = {}
		table.insert(Mission.LSMSpawnPoints, GetPosition(FindEntity("Siege - LSM Navpoint 1")))
		table.insert(Mission.LSMSpawnPoints, GetPosition(FindEntity("Siege - LSM Navpoint 2")))
		table.insert(Mission.LSMSpawnPoints, GetPosition(FindEntity("Siege - LSM Navpoint 3")))
	Mission.LSMLaunchPoints = {}
		table.insert(Mission.LSMLaunchPoints, GetPosition(FindEntity("Siege - LSM LaunchPoint 1")))
		table.insert(Mission.LSMLaunchPoints, GetPosition(FindEntity("Siege - LSM LaunchPoint 2")))
		table.insert(Mission.LSMLaunchPoints, GetPosition(FindEntity("Siege - LSM LaunchPoint 3")))
	Mission.EscapePoint = GetPosition(FindEntity("Siege - EscapePoint"))
	Mission.JapPTPoints = {}
		table.insert(Mission.JapPTPoints, GetPosition(FindEntity("Siege - PTpoint 01")))
		table.insert(Mission.JapPTPoints, GetPosition(FindEntity("Siege - PTpoint 02")))
		table.insert(Mission.JapPTPoints, GetPosition(FindEntity("Siege - PTpoint 03")))
		table.insert(Mission.JapPTPoints, GetPosition(FindEntity("Siege - PTpoint 04")))

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
	Mission.ResourceUSLST = 20
	Mission.ResourceUSLSM = 30
	Mission.ResourceUSCV = 150
	Mission.ResourceUSDD = 50
	Mission.ResourceUSCL = 80
	Mission.ResourceUSCA = 100
	Mission.ResourceJapHQ = 3
	Mission.ResourceJapFortressLong = 100
	Mission.ResourceJapFortressMain = 150
	Mission.ResourceJapFortressTower = 50
	Mission.ResourceJapCoastDef = 8
	Mission.ResourceJapPT = 15
	Mission.ResourcePlayerUnitUS = 6
	Mission.ResourcePlayerUnitJap = 6
	Mission.ResourcePlayerUnitJapKamikaze = 4

	Mission.PreviousHPPercentageHQ = 1

	Mission.RespawnTime = 30

---------------------------

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_primary_1",
				["Text"] = "mp07.obj_siege_us_p1_text",
				["TextCompleted"] = "mp07.obj_siege_us_p1_comp",
				["TextFailed"] = "mp07.obj_siege_us_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_primary_1",
				["Text"] = "mp07.obj_siege_jap_p1_text",
				["TextCompleted"] = "mp07.obj_siege_jap_p1_comp",
				["TextFailed"] = "mp07.obj_siege_jap_p1_fail",
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
				["Text"] = "At least one of the carriers should survive!",
				["TextCompleted"] = "You have successfully protected at least one of the carriers!",
				["TextFailed"] = "You have failed to protect at least one carrier!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 600,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_primary_2",
				["Text"] = "Destroy the carriers!",
				["TextCompleted"] = "You have successfully destroyed the carriers!",
				["TextFailed"] = "You have failed to destroy the carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 600,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
]]
		},
		["secondary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_sec1",
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
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_secondary_1",
				["Text"] = "Destroy the landing ships!",
				["TextCompleted"] = "Your forces have successfully destroyed the landing ships!",
				["TextFailed"] = "Your forces have failed to destroy the landing ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 200,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[3] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_secondary_2",
				["Text"] = "Protect the bombers!",
				["TextCompleted"] = "You have successfully protected some of the bombers!",
				["TextFailed"] = "You failed to protect the bombers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 200,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_secondary_2",
				["Text"] = "Destroy the bombers!",
				["TextCompleted"] = "Your forces have successfully destroyed the bombers!",
				["TextFailed"] = "Your forces have failed to destroy the bombers!",
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

	--AISetSpawnSceneUnitsWeightMul(0)

	luaInitNewSystems()

    SetThink(this, "luaQAS7Mission_think")
end

function luaQAS7Mission_think(this, msg)
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
		luaCheckPlayers()
		luaQAS7CheckInvasion()
		luaQAS7CheckForts()
		--luaQAS7CheckObjectiveUnits()
		luaQAS7HintManager()

	elseif not Mission.Started then
		luaQAS7StartMission()
		luaSetMultiScoreTable()
	end
end

function luaQAS7StartMission()
-- RELEASE_LOGOFF  	luaLog(" Starting mission...")
	Scoring_RealPlayTimeRunning(true)
	
	luaShowMissionHint()
	
	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2)
	luaObj_AddUnit("primary", 1, Mission.HQ)
	luaObj_AddUnit("primary", 2, Mission.HQ)
	--luaObj_Add("primary", 1, Mission.HQ)
	--luaObj_Add("primary", 2, Mission.HQ)
	--luaObj_Add("primary", 3)
	--luaObj_Add("primary", 4)
	--luaObj_Add("secondary", 1)
	--luaObj_Add("secondary", 2)
	--luaObj_Add("secondary", 3)
	--luaObj_Add("secondary", 4)

	for index, unit in pairs (Mission.CVs) do
		SetSkillLevel(unit, SKILL_SPNORMAL)
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		NavigatorSetAvoidShipCollision(unit, false)
		NavigatorEnable(unit, false)
	end

	for index, unit in pairs (Mission.DefShips) do
		if index < 2 then
			SetSkillLevel(unit, SKILL_SPNORMAL)
		elseif index < 4 then
			SetSkillLevel(unit, SKILL_SPNORMAL)
		else
			SetSkillLevel(unit, SKILL_STUN)
		end
		NavigatorSetTorpedoEvasion(unit, false)
		NavigatorSetAvoidLandCollision(unit, false)
		NavigatorSetAvoidShipCollision(unit, false)
		NavigatorEnable(unit, false)
	end

	luaObj_Add("secondary", 1)

	for index, unit in pairs (Mission.Fortresses) do
		luaObj_AddUnit("secondary", 1, unit)
		SetSkillLevel(unit, SKILL_SPNORMAL)
	end

	for index, unit in pairs (Mission.CoastDefs) do
		luaObj_AddUnit("secondary", 1, unit)
		SetSkillLevel(unit, SKILL_SPVETERAN)
	end

--[[
	for index, unit in pairs (Mission.CVs) do
		luaObj_AddUnit("primary", 3, unit)
		luaObj_AddUnit("primary", 4, unit)
		unit.marked = true
	end
]]
	--for i = 1, 6 do
	for i = 1, 5 do
-- RELEASE_LOGOFF  		luaLog(" generating LST")
		local lst = GenerateObject(Mission.LSTTMPL.Name, Mission.LSTSpawnPoints[i])
		SetSkillLevel(lst, SKILL_SPNORMAL)
		AISetHintWeight(lst, 8.7)
		EntityTurnToEntity(lst, Mission.HQ)
		NavigatorMoveToRange(lst, Mission.HQ)
		NavigatorSetTorpedoEvasion(lst, false)
		NavigatorSetAvoidLandCollision(lst, false)
		--luaObj_AddUnit("secondary", 1, lst)
		--luaObj_AddUnit("secondary", 2, lst)
		--lst.marked = true
		table.insert(Mission.LSTs, lst)
	end

	--for i = 1, 3 do
	for i = 1, 2 do
-- RELEASE_LOGOFF  		luaLog(" generating LSM")
		local lsm = GenerateObject(Mission.LSMTMPL.Name, Mission.LSMSpawnPoints[i])
		SetSkillLevel(lsm, SKILL_SPNORMAL)
		AISetHintWeight(lsm, 9.1)
		EntityTurnToEntity(lsm, Mission.HQ)
		NavigatorMoveToPos(lsm, Mission.LSMLaunchPoints[i])
		NavigatorSetTorpedoEvasion(lsm, false)
		NavigatorSetAvoidLandCollision(lsm, false)
		NavigatorSetAvoidShipCollision(lsm, false)
		ArtilleryEnable(lsm, false)
		AddProximityTrigger(lsm, Mission.LSMTriggerID[i], Mission.LSMTriggerFunction[i], Mission.LSMLaunchPoints[i], 100)
		--luaObj_AddUnit("secondary", 1, lsm)
		--luaObj_AddUnit("secondary", 2, lsm)
		--lsm.marked = true
		table.insert(Mission.LSMs, lsm)
	end

	--for i = 1, 4 do
	for i = 1, 3 do
-- RELEASE_LOGOFF  		luaLog(" generating PT boat")
		local PT = GenerateObject(Mission.PTTMPL.Name, Mission.JapPTPoints[i])
		SetSkillLevel(PT, SKILL_SPVETERAN)
		AISetHintWeight(PT, 2)
		local turn = 5 - i
		NavigatorMoveToRange(PT, Mission.LSTSpawnPoints[turn])
		TorpedoEnable(PT, true)
		--luaLog(Mission.PTPoints[i])
		table.insert(Mission.PTs, PT)
	end

	--luaDelay(luaQAS7SpawnDauntlesses, 4)
	Mission.Started = true
end

function luaQAS7SpawnDauntlesses()
	if not Mission.Completed and not Mission.MissionEnd then
		for i = 1, 4 do
-- RELEASE_LOGOFF  			luaLog(" generating Dauntless")
			local pos = luaQAS7CheckPos(i, i)
			--luaLog(pos)
			local dauntless = GenerateObject(Mission.DauntlessTMPL.Name, pos)
			AISetHintWeight(dauntless, 10)
			EntityTurnToEntity(dauntless, Mission.HQ)
			PilotSetTarget(dauntless, Mission.HQ)
			--luaObj_AddUnit("secondary", 3, dauntless)
			--luaObj_AddUnit("secondary", 4, dauntless)
			--dauntless.marked = true
			table.insert(Mission.Dauntlesses, dauntless)
		end
	end
end

function luaQAS7CheckInvasion()
-- RELEASE_LOGOFF  	luaLog(" Checking invading forces...")
	for index, unit in pairs (Mission.CVs) do
		if unit.Dead and not unit.ignore then
-- RELEASE_LOGOFF  			luaLog("  dead CV found")
			luaResourcePoolReducer("CV")
			unit.ignore = true
		end
	end

	for index, unit in pairs (Mission.DefShips) do
		if unit.Dead and not unit.ignore then
-- RELEASE_LOGOFF  			luaLog("  dead defender ships found")
			if unit.Class.Type == "Destroyer" then
				luaResourcePoolReducer("DD")
			elseif unit.Class.ID == 316 then
				luaResourcePoolReducer("CL")
			elseif unit.Class.ID == 317 then
				luaResourcePoolReducer("CA")
			end				
			unit.ignore = true
		end
	end

	if table.getn(Mission.LSTs) ~= 0 then
		for index, unit in pairs (Mission.LSTs) do
			if unit.Dead and Mission.KeyUnitCounter ~= 0 and Mission.HQ.Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  				luaLog("  generating LST")
				luaResourcePoolReducer("LST")
				Mission.LSTs[index] = GenerateObject(Mission.LSTTMPL.Name, Mission.LSTSpawnPoints[index])
				SetSkillLevel(Mission.LSTs[index], SKILL_SPNORMAL)
				AISetHintWeight(Mission.LSTs[index], 8.7)
				EntityTurnToEntity(Mission.LSTs[index], Mission.HQ)
				NavigatorMoveToRange(Mission.LSTs[index], Mission.HQ)
--[[
				if luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary", 1) == nil and luaObj_IsActive("secondary", 2) and luaObj_GetSuccess("secondary", 2) == nil then
					luaObj_AddUnit("secondary", 1, Mission.LSTs[index])
					luaObj_AddUnit("secondary", 2, Mission.LSTs[index])
					Mission.LSTs[index].marked = true
				end
]]
			elseif not unit.Dead and not unit.landing then
				if luaGetDistance(unit, Mission.HQ) < 1250 then
-- RELEASE_LOGOFF  					luaLog("  LST starting to land")
					unit.landing = true
					StartLanding2(unit)
				end
			end
		end
	end

	if table.getn(Mission.LSMs) ~= 0 then
		for index, unit in pairs (Mission.LSMs) do
			if unit.Dead and Mission.KeyUnitCounter ~= 0 and Mission.HQ.Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  				luaLog("  generating LSM")
				luaResourcePoolReducer("LSM")
				Mission.LSMs[index] = GenerateObject(Mission.LSMTMPL.Name, Mission.LSMSpawnPoints[index])
				SetSkillLevel(Mission.LSMs[index], SKILL_SPNORMAL)
				AISetHintWeight(Mission.LSMs[index], 9.1)
				EntityTurnToEntity(Mission.LSMs[index], Mission.HQ)
				NavigatorMoveToPos(Mission.LSMs[index], Mission.LSMLaunchPoints[index])
				ArtilleryEnable(Mission.LSMs[index], false)
				AddProximityTrigger(Mission.LSMs[index], Mission.LSMTriggerID[index], Mission.LSMTriggerFunction[index], Mission.LSMLaunchPoints[index], 100)
--[[
				if luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary", 1) == nil and luaObj_IsActive("secondary", 2) and luaObj_GetSuccess("secondary", 2) == nil then
					luaObj_AddUnit("secondary", 1, Mission.LSMs[index])
					luaObj_AddUnit("secondary", 2, Mission.LSMs[index])
					Mission.LSMs[index].marked = true
				end
]]
			elseif luaGetScriptTarget(unit) == nil then
				luaQAS7SetLSMTarget(unit)
			elseif luaGetScriptTarget(unit).Dead then
				luaQAS7SetLSMTarget(unit)
			end
		end
	end
--[[
	if table.getn(Mission.Dauntlesses) ~= 0 then
		local posmod = 0
		for index, unit in pairs (Mission.Dauntlesses) do
			if unit.Dead and Mission.KeyUnitCounter ~= 0 and Mission.HQ.Party == PARTY_JAPANESE or unit.needstobereplaced and Mission.KeyUnitCounter ~= 0 and Mission.HQ.Party == PARTY_JAPANESE then
				local pos = luaQAS7CheckPos(index, posmod)
				if pos ~= 0 then
-- RELEASE_LOGOFF  					luaLog("  generating Dauntless")
					if not unit.Dead then
-- RELEASE_LOGOFF  						luaLog("  previous killed")
						Kill(unit, true)
					end
					Mission.Dauntlesses[index] = GenerateObject(Mission.DauntlessTMPL.Name, pos)
-- RELEASE_LOGOFF  					luaLog("  is it dead? "..tostring(Mission.Dauntlesses[index].Dead))
-- RELEASE_LOGOFF  					luaLog("  HQ party?: "..tostring(Mission.HQ.Party))
					EntityTurnToEntity(Mission.Dauntlesses[index], Mission.HQ)
					PilotSetTarget(Mission.Dauntlesses[index], Mission.HQ)
					if luaObj_IsActive("secondary", 3) and luaObj_GetSuccess("secondary", 3) == nil and luaObj_IsActive("secondary", 4) and luaObj_GetSuccess("secondary", 4) == nil then
						luaObj_AddUnit("secondary", 3, Mission.Dauntlesses[index])
						luaObj_AddUnit("secondary", 4, Mission.Dauntlesses[index])
						Mission.Dauntlesses[index].marked = true
					end
					posmod = posmod + 1
				else
-- RELEASE_LOGOFF  					luaLog("  Dauntless spawn denied")
				end
			elseif not unit.Dead then
				if table.getn(GetPayloads(unit)) == 0 and not unit.retreating then
					unit.retreating = true
					local pos = luaQAS7CheckPos(index, 0)
					if pos ~= 0 then
						PilotMoveToRange(unit, pos)
					else
-- RELEASE_LOGOFF  						luaLog("  ordering Dauntless to go to the escape point")
						unit.movingtoescapepoint = true
						PilotMoveToRange(unit, Mission.EscapePoint)
						SquadronSetTravelAlt(unit, 800)
					end
				elseif unit.retreating then
					local pos = luaQAS7CheckPos(index, 0)
					if pos ~= 0 then
						if luaGetDistance(unit, pos) < 200 and not unit.needstobereplaced then
-- RELEASE_LOGOFF  							luaLog("  a Dauntless needs to be replaced")
							unit.needstobereplaced = true
						elseif luaGetDistance(unit, pos) < 750 and not unit.travelaltchanged then
-- RELEASE_LOGOFF  							luaLog("  retreating Dauntless going down to 100")
							unit.travelaltchanged = true
							SquadronSetTravelAlt(unit, 150)
						end
					else
						if not unit.movingtoescapepoint then
-- RELEASE_LOGOFF  							luaLog("  ordering Dauntless to go to the escape point")
							unit.movingtoescapepoint = true
							PilotMoveToRange(unit, Mission.EscapePoint)
							SquadronSetTravelAlt(unit, 800)
						elseif luaGetDistance(unit, Mission.EscapePoint) < 200 then
-- RELEASE_LOGOFF  							luaLog("  Dauntless reached the escape point")
							Kill(unit, true)
						end
					end
				end
			end
		end
	end
]]

	if table.getn(Mission.PTs) ~= 0 then
		for index, unit in pairs (Mission.PTs) do
			if unit.Dead and not unit.respawnset then
-- RELEASE_LOGOFF  				luaLog("  dead PT found")
				luaResourcePoolReducer("PT")
				unit.respawntime = GameTime() + Mission.RespawnTime
				unit.respawnset = true
			elseif unit.respawnset and GameTime() > unit.respawntime then
-- RELEASE_LOGOFF  				luaLog("  respawning PT")
				Mission.PTs[index] = GenerateObject(Mission.PTTMPL.Name, Mission.JapPTPoints[index])
				SetSkillLevel(Mission.PTs[index], SKILL_SPVETERAN)
				TorpedoEnable(Mission.PTs[index], true)
				AISetHintWeight(Mission.PTs[index], 2)
			elseif not unit.Dead then
				if UnitGetAttackTarget(unit) == nil then
-- RELEASE_LOGOFF  					luaLog("  PT doesn't have a target")
					local landingship = luaGetNearestEnemy(unit, "landingship")
					if landingship ~= nil then
-- RELEASE_LOGOFF  						luaLog("  new target found")
						NavigatorAttackMove(unit, landingship, {})
					end
				end
			end
		end
	end
end

function luaQAS7CheckPos(index, posmod)
	local modifier = 0
	if posmod ~= 0 then
		modifier = 75 * posmod
	end
	--luaLog(index)
	--luaLog(posmod)
	--luaLog(modifier)
	if index <= 2 and not Mission.CVs[1].ignore then
		local cv1pos = GetPosition(Mission.CVs[1])
		if modifier ~= 0 then
			pos = {["x"] = cv1pos.x + modifier, ["y"] = 150, ["z"] = cv1pos.z + modifier}
			--luaLog(pos)
			return pos
		else
			pos = {["x"] = cv1pos.x, ["y"] = 150, ["z"] = cv1pos.z}
			--luaLog(pos)
			return pos
		end			
	elseif index == 3 and not Mission.CVs[2].ignore or index == 4 and not Mission.CVs[2].ignore then
		local cv2pos = GetPosition(Mission.CVs[2])
		if modifier ~= 0 then
			pos = {["x"] = cv2pos.x + modifier, ["y"] = 150, ["z"] = cv2pos.z + modifier}
			--luaLog(pos)
			return pos
		else
			pos = {["x"] = cv2pos.x, ["y"] = 150, ["z"] = cv2pos.z}
			--luaLog(pos)
			return pos
		end			
	else
		--luaLog("pos = 0")
		return 0
	end
end

function luaQAS7LSM1InPos()
-- RELEASE_LOGOFF  	luaLog(" LSM1 reached launching position")
	if not Mission.Completed and not Mission.LSMs[1].Dead then
		ArtilleryEnable(Mission.LSMs[1], true)
		--NavigatorEnable(Mission.LSMs[1], false)
		luaQAS7SetLSMTarget(Mission.LSMs[1])
	end
end

function luaQAS7LSM2InPos()
-- RELEASE_LOGOFF  	luaLog(" LSM2 reached launching position")
	if not Mission.Completed and not Mission.LSMs[2].Dead then
		ArtilleryEnable(Mission.LSMs[2], true)
		--NavigatorEnable(Mission.LSMs[2], false)
		luaQAS7SetLSMTarget(Mission.LSMs[2])
	end
end

function luaQAS7LSM3InPos()
-- RELEASE_LOGOFF  	luaLog(" LSM3 reached launching position")
	if not Mission.Completed and not Mission.LSMs[3].Dead then
		ArtilleryEnable(Mission.LSMs[3], true)
		--NavigatorEnable(Mission.LSMs[3], false)
		luaQAS7SetLSMTarget(Mission.LSMs[3])
	end
end

function luaQAS7SetLSMTarget(unit)
-- RELEASE_LOGOFF  	luaLog("  setting target...")
	if not Mission.Fortresses[1].Dead then
-- RELEASE_LOGOFF  		luaLog("   Mission.Fortresses[1]")
		--NavigatorAttackMove(unit, Mission.Fortresses[1], {})
		luaSetScriptTarget(unit, Mission.Fortresses[1])
	elseif not Mission.Fortresses[2].Dead then
-- RELEASE_LOGOFF  		luaLog("   Mission.Fortresses[2]")
		--NavigatorAttackMove(unit, Mission.Fortresses[2], {})
		luaSetScriptTarget(unit, Mission.Fortresses[2])
	elseif not Mission.Fortresses[3].Dead then
-- RELEASE_LOGOFF  		luaLog("   Mission.Fortresses[3]")
		--NavigatorAttackMove(unit, Mission.Fortresses[3], {})
		luaSetScriptTarget(unit, Mission.Fortresses[3])
	elseif not Mission.Fortresses[4].Dead then
-- RELEASE_LOGOFF  		luaLog("   Mission.Fortresses[4]")
		--NavigatorAttackMove(unit, Mission.Fortresses[4], {})
		luaSetScriptTarget(unit, Mission.Fortresses[4])
	elseif not Mission.Fortresses[5].Dead then
-- RELEASE_LOGOFF  		luaLog("   Mission.Fortresses[5]")
		--NavigatorAttackMove(unit, Mission.Fortresses[5], {})
		luaSetScriptTarget(unit, Mission.Fortresses[5])
	elseif not Mission.Fortresses[6].Dead then
-- RELEASE_LOGOFF  		luaLog("   Mission.Fortresses[6]")
		--NavigatorAttackMove(unit, Mission.Fortresses[6], {})
		luaSetScriptTarget(unit, Mission.Fortresses[6])
	elseif Mission.HQ.Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  		luaLog("   Mission.HQ")
		--NavigatorAttackMove(unit, Mission.HQ, {})
		luaSetScriptTarget(unit, Mission.HQ)
	end
end

function luaQAS7CheckObjectiveUnits()
-- RELEASE_LOGOFF  	luaLog(" Checking objective units...")
	for index, unit in pairs (Mission.CVs) do
		if unit.Dead and not unit.ignore then
			unit.ignore = true
			Mission.KeyUnitCounter = Mission.KeyUnitCounter - 1
			--ModifyKeyUnitNumber(Mission.KeyUnitCounter)
		end
	end

	if Mission.KeyUnitCounter == 0 and not Mission.MissionEndCalled then
-- RELEASE_LOGOFF  		luaLog("  no more CV's alive, calling mission end")
		Mission.MissionEndCalled = true
		luaQAS7MissionEnd()
	end

	if Mission.HQ.Party ~= PARTY_JAPANESE and not Mission.MissionEndCalled then
		Mission.ResourceJapPool = 0
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaQAS7MissionEnd()
	end
end

function luaQAS7MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Ending mission...")
--[[
	Mission.LSMs = luaRemoveDeadsFromTable(Mission.LSMs)
	for index, unit in pairs (Mission.LSMs) do
		if unit.marked then
			luaObj_RemoveUnit("secondary", 1, unit)
			luaObj_RemoveUnit("secondary", 2, unit)
		end
	end
	Mission.LSTs = luaRemoveDeadsFromTable(Mission.LSTs)
	for index, unit in pairs (Mission.LSTs) do
		if unit.marked then
			luaObj_RemoveUnit("secondary", 1, unit)
			luaObj_RemoveUnit("secondary", 2, unit)
		end
	end
	Mission.Dauntlesses = luaRemoveDeadsFromTable(Mission.Dauntlesses)
	for index, unit in pairs (Mission.Dauntlesses) do
		if unit.marked then
			luaObj_RemoveUnit("secondary", 3, unit)
			luaObj_RemoveUnit("secondary", 4, unit)
		end
	end
]]
	Scoring_RealPlayTimeRunning(false)
	Mission.Completed = true

	if not Mission.S1Done then
		Mission.Fortresses = luaRemoveDeadsFromTable(Mission.Fortresses)
		Mission.CoastDefs = luaRemoveDeadsFromTable(Mission.CoastDefs)
		Mission.S1Done = true
		if table.getn(Mission.Fortresses) == 0 and table.getn(Mission.CoastDefs) == 0 then
-- RELEASE_LOGOFF  			luaLog("  fortesses down, secondary 1 completed")
			luaObj_Completed("secondary", 1)
		elseif not Mission.S2Failed then
-- RELEASE_LOGOFF  			luaLog("  fortesses still up, secondary 1 failed")
			luaObj_Failed("secondary", 1)
		end
	end

	if Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 or Mission.Randomize == 1 then
-- RELEASE_LOGOFF  		luaLog(" Japanese side wins!")
		luaObj_Failed("primary", 1)
		luaObj_Completed("primary", 2)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_JAPANESE)
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 or Mission.Randomize == 2 then
-- RELEASE_LOGOFF  		luaLog(" US side wins!")
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_ALLIED)
	end
--[[
	if Mission.HQ.Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  		luaLog("  the HQ is still in Japanese hands, Japanese side wins")
		luaObj_Failed("primary", 1)
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 3)
		luaObj_Completed("primary", 4)
		luaObj_Failed("secondary", 1)
		luaObj_Completed("secondary", 2)
		luaObj_Failed("secondary", 3)
		luaObj_Completed("secondary", 4)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_JAPANESE)
	else
-- RELEASE_LOGOFF  		luaLog("  the HQ is not under Japanese control, Allied side wins")
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaObj_Completed("primary", 3)
		luaObj_Failed("primary", 4)
		luaObj_Completed("secondary", 1)
		luaObj_Failed("secondary", 2)
		luaObj_Completed("secondary", 3)
		luaObj_Failed("secondary", 4)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_ALLIED)
	end
]]
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Siege07")
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
		local todeduct = Mission.ResourcePlayerUnitUS * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "japplayer" then
		local todeduct = Mission.ResourcePlayerUnitJap * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "japplayerkamikaze" then
		local todeduct = Mission.ResourcePlayerUnitJapKamikaze * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "LST" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSLST
	elseif unit == "LSM" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSLSM
	elseif unit == "PT" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapPT
	elseif unit == "CV" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSCV
	elseif unit == "DD" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSDD
	elseif unit == "CL" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSCL
	elseif unit == "CA" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSCA
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
		luaQAS7MissionEnd()
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" Jap pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaQAS7MissionEnd()
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool < 1 then
-- RELEASE_LOGOFF  		luaLog(" both pools are under 1 point")
		Mission.Randomize = luaRnd(1, 2)
		if Mission.Randomize == 1 then
			for i = 0, 7 do
				MultiScore[i][1] = 0
				MultiScore[i][2] = 1
			end
			Mission.MissionEndCalled = true
			luaQAS7MissionEnd()
		else
			for i = 0, 7 do
				MultiScore[i][1] = 1
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaQAS7MissionEnd()
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
		for index, unit in pairs (Mission.JapTable) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead player unit found in Mission.JapTable")
				by = luaCheckPlaneNumber(unit)
				if unit.Class.ID == 100 then
					luaResourcePoolReducer("japplayerkamikaze", by)
				else
					luaResourcePoolReducer("japplayer", by)
				end
				table.remove(Mission.JapTable, index)
			else
				previouscheck = luaCheckPlaneNumber(unit)
				local planesinsquad = table.getn(GetSquadronPlanes(unit))
				if planesinsquad < previouscheck then
					by = previouscheck - planesinsquad
					unit.checkednumber = planesinsquad
					if unit.Class.ID == 100 then
						luaResourcePoolReducer("japplayerkamikaze", by)
					else
						luaResourcePoolReducer("japplayer", by)
					end
				elseif planesinsquad == 3 then
					unit.checkednumber = planesinsquad
				end
			end
		end
	end

	local usplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	local japplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")

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

function luaCheckPlaneNumber(unit)
	if unit.checkednumber == nil then
		by = 3
	else
		by = unit.checkednumber
	end
	return by
end

function luaQAS7CheckForts()
-- RELEASE_LOGOFF  	luaLog(" Checking fortresses..")
	for index, unit in pairs (Mission.Fortresses) do
		if unit.Dead and not unit.ignore then
-- RELEASE_LOGOFF  			luaLog("  dead fortress found")
			if unit.Class.ID == 249 then
				luaResourcePoolReducer("fortresslong")
			elseif unit.Class.ID == 817 then
				luaResourcePoolReducer("fortressmain")
			elseif unit.Class.ID == 818 then
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

	if not Mission.S1Done then
		local fortsandguns = 0
		for index, unit in pairs (Mission.Fortresses) do
			if not unit.Dead then
				fortsandguns = fortsandguns + 1
			end
		end

		for index, unit in pairs (Mission.CoastDefs) do
			if not unit.Dead then
				fortsandguns = fortsandguns + 1
			end
		end

		if fortsandguns == 0 then
-- RELEASE_LOGOFF  			luaLog("  fortesses down, secondary 1 completed")
			Mission.S1Done = true
			luaObj_Completed("secondary", 1)
		end
	end

	if Mission.HQ.Party == PARTY_JAPANESE then
		local threshold = GetHpPercentage(Mission.HQ) + 0.01
		if threshold < Mission.PreviousHPPercentageHQ then
			local difference = Mission.PreviousHPPercentageHQ - GetHpPercentage(Mission.HQ)
			local percentage = difference * 100
			local by = luaRound(percentage)
			luaResourcePoolReducer("HQ", by)
			Mission.PreviousHPPercentageHQ = GetHpPercentage(Mission.HQ)
		end
	elseif not Mission.Completed and not Mission.MissionEndCalled then
-- RELEASE_LOGOFF  		luaLog("  HQ down, ending mission...")
		Mission.ResourceJapPool = 0
		Mission.MissionEndCalled = true
		luaQAS7MissionEnd()
	end
end

function luaQAS7HintManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 30 and not Mission.Hint1Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint1Shown")
			ShowHint("ID_Hint_Siege01_OP")
			Mission.Hint1Shown = true
		elseif GameTime() > 60 and not Mission.Hint2Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint2Shown")
			ShowHint("ID_Hint_Siege07_Fort")
			ShowHint("ID_Hint_Siege03_LST")
			Mission.Hint2Shown = true
		elseif GameTime() > 90 and not Mission.Hint3Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint3Shown")
			ShowHint("ID_Hint_Siege01_PK")
			Mission.Hint3Shown = true
		elseif GameTime() > 120 and not Mission.Hint4Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint4Shown")
			ShowHint("ID_Hint_Siege07_PT")
			Mission.Hint4Shown = true
		end
	end
end