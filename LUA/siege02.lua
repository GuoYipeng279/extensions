--SceneFile="Missions\Multi\Scene2.scn"

function luaPrecacheUnits()
	--PrepareClass(38) -- Helldiver
	PrepareClass(108) -- Dauntless
	--PrepareClass(136) -- Dakota
	PrepareClass(116) -- B-17
	PrepareClass(67) -- Mogami
	PrepareClass(68) -- Tone
	PrepareClass(70) -- Kuma
	PrepareClass(150) -- Zero
	PrepareClass(135) -- Warhawk
	PrepareClass(101) -- Wildcat
	PrepareClass(152) -- Gekko
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAS2Mission")
end

function luaInitQAS2Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Siege2"..dateandtime

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

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- globalban hasznalando
	this.Multiplayer = true
	this.ThinkCounter = 0
	Mission.MultiplayerType = "Siege"
	Mission.MultiplayerNumber = 2

	Mission.KeyUnitCounter = 0 -- luaQAS2StartMission()-ben allitjuk be
	--ModifyKeyUnitNumber(Mission.KeyUnitCounter)

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

	-- mission valtozok
	Mission.WaveReady = false
	--Mission.Wave = 1
	Mission.WaveTimer = 5
	Mission.Bombers = {}
	Mission.Filter = {}
	Mission.FilterAllowed = false
	Mission.MogamiDead = false
	Mission.KumaDead = false
	Mission.ToneDead = false
	Mission.LevelBombersAllowed = true
	Mission.ParaBombersAllowed = true

	-- amerikai objektumok
	Mission.SpawnPositions = {}
		table.insert(Mission.SpawnPositions, GetPosition(FindEntity("Siege - US SpawnPoint1")))
		table.insert(Mission.SpawnPositions, GetPosition(FindEntity("Siege - US SpawnPoint2")))
		table.insert(Mission.SpawnPositions, GetPosition(FindEntity("Siege - US SpawnPoint3")))
		table.insert(Mission.SpawnPositions, GetPosition(FindEntity("Siege - US SpawnPoint4")))
	Mission.ExitPoint = GetPosition(FindEntity("Siege - US Exitpoint"))

	Mission.TypeHelldiver = 108 -- dauntless lett belole
	Mission.NameHelldiver = "globals.unitclass_dauntless"
	Mission.TypeDakota = 136 -- nem hasznaljuk
	Mission.NameDakota = "globals.unitclass_douglas"
	Mission.TypeB17 = 116
	Mission.NameB17 = "globals.unitclass_flyingfortress"

	-- japan objektumok
	Mission.HQ = FindEntity("Siege - HQ")
	Mission.TurnToPoint = GetPosition(Mission.HQ)
	Mission.Mogami = FindEntity("Siege - Mogami")
	Mission.Kuma = FindEntity("Siege - Kuma")
	Mission.Tone = FindEntity("Siege - Tone")
	SetSkillLevel(Mission.HQ, SKILL_SPNORMAL)
	SetSkillLevel(Mission.Mogami, SKILL_SPNORMAL)
	SetSkillLevel(Mission.Kuma, SKILL_SPNORMAL)
	SetSkillLevel(Mission.Tone, SKILL_SPNORMAL)
	NavigatorSetTorpedoEvasion(Mission.Mogami, false)
	NavigatorSetAvoidShipCollision(Mission.Mogami, false)
	NavigatorSetAvoidLandCollision(Mission.Mogami, false)
	NavigatorEnable(Mission.Mogami, false)
	NavigatorSetTorpedoEvasion(Mission.Kuma, false)
	NavigatorSetAvoidShipCollision(Mission.Kuma, false)
	NavigatorSetAvoidLandCollision(Mission.Kuma, false)
	NavigatorEnable(Mission.Kuma, false)
	NavigatorSetTorpedoEvasion(Mission.Tone, false)
	NavigatorSetAvoidShipCollision(Mission.Tone, false)
	NavigatorSetAvoidLandCollision(Mission.Tone, false)
	NavigatorEnable(Mission.Tone, false)
--[[
	SetCrewLevel(Mission.Mogami, CREW_ROOKIE)
	SetCrewLevel(Mission.Kuma, CREW_ROOKIE)
	SetCrewLevel(Mission.Tone, CREW_ROOKIE)
]]
	Mission.LandBatteries = {}
		table.insert(Mission.LandBatteries, FindEntity("Siege - Heavy AA 01"))
		table.insert(Mission.LandBatteries, FindEntity("Siege - Heavy AA 02"))
		table.insert(Mission.LandBatteries, FindEntity("Siege - Heavy AA 03"))
		table.insert(Mission.LandBatteries, FindEntity("Siege - Heavy AA 04"))
		table.insert(Mission.LandBatteries, FindEntity("Siege - Heavy AA 05"))
		table.insert(Mission.LandBatteries, FindEntity("Siege - Heavy AA 06"))
		table.insert(Mission.LandBatteries, FindEntity("Siege - Heavy AA 07"))
		table.insert(Mission.LandBatteries, FindEntity("Siege - Heavy AA 08"))
		table.insert(Mission.LandBatteries, FindEntity("Siege - Heavy AA 09"))
		table.insert(Mission.LandBatteries, FindEntity("Siege - Heavy AA 10"))
		table.insert(Mission.LandBatteries, FindEntity("Siege - Heavy AA 11"))
		table.insert(Mission.LandBatteries, FindEntity("Siege - Heavy AA 12"))
		table.insert(Mission.LandBatteries, FindEntity("Siege - Coastal Gun 01"))
		table.insert(Mission.LandBatteries, FindEntity("Siege - Coastal Gun 02"))
		table.insert(Mission.LandBatteries, FindEntity("Siege - Coastal Gun 03"))

	-- pathok

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
	Mission.ResourceUSHelldiver = 8
	Mission.ResourceUSDakota = 8
	Mission.ResourceUSB17 = 16
	Mission.ResourceJapHQ = 3
	Mission.ResourceJapMogami = 1.4
	Mission.ResourceJapTone = 1.4
	Mission.ResourceJapKuma = 1.4
	Mission.ResourcePlayerUnit = 4
	Mission.ResourceJapLandBattery = 4

	Mission.PreviousHPPercentageMogami = 1
	Mission.PreviousHPPercentageKuma = 1
	Mission.PreviousHPPercentageTone = 1
	Mission.PreviousHPPercentageHQ = 1

---------------------------

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua")	-- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_pri_1",
				["Text"] = "mp02.obj_siege_us_p1_text",
				["TextCompleted"] = "mp02.obj_siege_us_p1_comp",
				["TextFailed"] = "mp02.obj_siege_us_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_pri_1",
				["Text"] = "mp02.obj_siege_jap_p1_text",
				["TextCompleted"] = "mp02.obj_siege_jap_p1_comp",
				["TextFailed"] = "mp02.obj_siege_jap_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
--[[
			[3] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_pri_2",
				["Text"] = "At least one of the bombers should survive the air strike!",
				["TextCompleted"] = "You have successfully protected some of the bombers!",
				["TextFailed"] = "You have failed to protect the bombers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_pri_2",
				["Text"] = "Destroy the incoming bomber planes!",
				["TextCompleted"] = "You have destroyed the bombers!",
				["TextFailed"] = "You have failed to destroy the bombers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
]]
		},
		["secondary"] =	{
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_sec_obj_1",
				["Text"] = "mp02.obj_siege_us_s1_text",
				["TextCompleted"] = "mp02.obj_siege_us_s1_comp",
				["TextFailed"] = "mp02.obj_siege_us_s1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 250,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
--[[
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_sec_obj_1",
				["Text"] = "The Mogami has to be destroyed!",
				["TextCompleted"] = "Your forces have destroyed the Mogami!",
				["TextFailed"] = "Your forces failed to destroy the Mogami!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 200,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_sec_obj_1",
				["Text"] = "Protect the Mogami!",
				["TextCompleted"] = "You have protected the Mogami!",
				["TextFailed"] = "You failed to protect the Mogami!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 200,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[3] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_sec_obj_2",
				["Text"] = "The Kuma has to be destroyed!",
				["TextCompleted"] = "Your forces have destroyed the Kuma!",
				["TextFailed"] = "Your forces failed to destroy the Kuma!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 200,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_sec_obj_2",
				["Text"] = "Protect the Kuma!",
				["TextCompleted"] = "You have protected the Kuma!",
				["TextFailed"] = "You failed to protect the Kuma!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 200,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[5] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_sec_obj_3",
				["Text"] = "The Tone has to be destroyed!",
				["TextCompleted"] = "Your forces have destroyed the Tone!",
				["TextFailed"] = "Your forces failed to destroy the Tone!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 200,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[6] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_sec_obj_3",
				["Text"] = "Protect the Tone!",
				["TextCompleted"] = "You have protected the Tone!",
				["TextFailed"] = "You failed to protect the Tone!",
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

    SetThink(this, "luaQAS2Mission_think")
end

function luaQAS2Mission_think(this, msg)
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
		luaQAS2CheckLandBatteries()
		luaQAS2CheckWaves()
		luaQAS2CheckJapUnits()
		luaQAS2FilterBombers()
		luaCheckPlayers()
		luaQAS2CheckMissionEnd()
		luaQAS2HintManager()

	elseif not Mission.Started then
		luaQAS2StartMission()
		luaSetMultiScoreTable()
		luaQAS2SetHQSkill()
	end
end

function luaQAS2StartMission()
-- RELEASE_LOGOFF  	luaLog(" Starting mission...")
	Scoring_RealPlayTimeRunning(true)
	
	luaShowMissionHint()
	
	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	--Countdown("", 0, 1200, "luaQAS2CountDownEnd")
	Mission.CountdownStart = GameTime()

	luaDelay(luaQAS2PermitWave, 7)

	if Mission.Players <= 2 then
		Mission.PlaneToDestroy = 32
	elseif Mission.Players == 3 then
		Mission.PlaneToDestroy = 36
	elseif Mission.Players == 4 then
		Mission.PlaneToDestroy = 36
	elseif Mission.Players == 5 then
		Mission.PlaneToDestroy = 40
	elseif Mission.Players == 6 then
		Mission.PlaneToDestroy = 40
	elseif Mission.Players == 7 then
		Mission.PlaneToDestroy = 44
	elseif Mission.Players == 8 then
		Mission.PlaneToDestroy = 44
	end
-- RELEASE_LOGOFF  	luaLog(" KeyUnitCounter set to "..Mission.PlaneToDestroy)
	Mission.KeyUnitCounter = Mission.PlaneToDestroy
	--ModifyKeyUnitNumber(Mission.KeyUnitCounter)
--[[
	SetRepairEffectivity(Mission.Mogami, 0.5)
	SetRepairEffectivity(Mission.Kuma, 0.5)
	SetRepairEffectivity(Mission.Tone, 0.5)
]]
	luaDelay(luaQAS2DelayedObjectives, 5)

--[[
	luaObj_Add("primary", 1, Mission.HQ)
	luaObj_Add("primary", 2, Mission.HQ)
	luaObj_Add("primary", 3)
	luaObj_Add("primary", 4)
	luaObj_Add("secondary", 1, Mission.Mogami, true)
	luaObj_Add("secondary", 2, Mission.Mogami, true)
	luaObj_Add("secondary", 3, Mission.Kuma, true)
	luaObj_Add("secondary", 4, Mission.Kuma, true)
	luaObj_Add("secondary", 5, Mission.Tone, true)
	luaObj_Add("secondary", 6, Mission.Tone, true)
]]
	Mission.Started = true
end

function luaQAS2DelayedObjectives()
	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2)
	luaObj_Add("secondary", 1)
	Mission.MarkAllowed = true
	
	luaObj_AddUnit("primary", 1, Mission.HQ)
	luaObj_AddUnit("primary", 2, Mission.HQ)
	AISetHintWeight(Mission.HQ, 15)
	luaObj_AddUnit("primary", 1, Mission.Mogami)
	AISetHintWeight(Mission.Mogami, 40)
	luaObj_AddUnit("primary", 1, Mission.Kuma)
	AISetHintWeight(Mission.Kuma, 30)
	luaObj_AddUnit("primary", 1, Mission.Tone)
	AISetHintWeight(Mission.Tone, 25)
	for index, unit in pairs (Mission.Bombers) do
		if not unit.marked then
			luaObj_AddUnit("primary", 2, unit)
			unit.marked = true
		end
	end

	for index, unit in pairs (Mission.LandBatteries) do
		AISetHintWeight(unit, 10)
		luaObj_AddUnit("secondary", 1, unit)
	end
end

function luaQAS2SetHQSkill()
	local planesaroundHQ = luaGetPlanesAroundCoordinate(GetPosition(Mission.HQ), 2000, PARTY_ALLIED, "own")
	local mpskillset = false
	if planesaroundHQ ~= nil then
		for index, unit in pairs (planesaroundHQ) do
			if unit.Class.ID == 116 and not mpskillset then
-- RELEASE_LOGOFF  				luaLog(" setting HQ to MP level")
				mpskillset = true
				SetSkillLevel(Mission.HQ, SKILL_MPNORMAL)
			end
		end
	end
	if not mpskillset then
-- RELEASE_LOGOFF  		luaLog(" setting HQ to SP level")
		SetSkillLevel(Mission.HQ, SKILL_SPNORMAL)
	end
	luaDelay(luaQAS2SetHQSkill, 7)
end

function luaQAS2PermitWave()
	if not Mission.Completed and not Mission.MissionEnd then
		Mission.WaveReady = true
	end
end

function luaQAS2CheckWaves()
	if not Mission.LastWave then
-- RELEASE_LOGOFF  		luaLog(" Checking waves...")
		if Mission.WaveReady then
			--MissionNarrativeParty(0, "Protect the bombers!")
			--MissionNarrativeParty(1, "Bombers incomming, destroy them!")
			for i = 1, 4 do
				local randomnumber = luaRnd(1, 13)
				if randomnumber >= 1 and randomnumber <= 7 then
-- RELEASE_LOGOFF  					luaLog("  randomnumber = "..randomnumber.." | spawning divebombers")
					luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeHelldiver, Mission.NameHelldiver, 3, 1)
				elseif randomnumber >= 8 and randomnumber <= 13 then
					if Mission.LevelBombersAllowed then
-- RELEASE_LOGOFF  						luaLog("  randomnumber = "..randomnumber.." | spawning levelbombers")
						luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeB17, Mission.NameB17, 3, 1)
						Mission.LevelBombersAllowed = false
						--luaDelay(luaQAS2BomberWarning, 5)
					else
-- RELEASE_LOGOFF  						luaLog("  no more levelbombers are allowed in this wave | spawning divebombers")
						luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeHelldiver, Mission.NameHelldiver, 3, 1)
					end
				elseif randomnumber >= 14 and randomnumber <= 15 then
					if Mission.ParaBombersAllowed then
-- RELEASE_LOGOFF  						luaLog("  randomnumber = "..randomnumber.." | spawning levelbombers")
						luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeDakota, Mission.NameDakota, 3, 1)
						Mission.ParaBombersAllowed = false
						luaDelay(luaQAS2BomberWarning, 5)
					else

-- RELEASE_LOGOFF  						luaLog("  no more levelbombers are allowed in this wave | spawning divebombers")
						luaSpawnUnit(Mission.SpawnPositions[i], Mission.TypeHelldiver, Mission.NameHelldiver, 3, 1)
					end
				end
			end
			Mission.LevelBombersAllowed = true
			Mission.ParaBombersAllowed = true
			Mission.WaveReady = false
			luaDelay(luaFilterAllow, 5)
		end
	end
end

function luaSpawnUnit(position, unittype, unitname, wingcount, eqindex)
	if position ~= nil and unittype ~= nil and unitname ~= nil and wingcount ~= nil and eqindex ~= nil then
		SpawnNew({
			["party"] = PARTY_ALLIED,
			["groupMembers"] = {
				{
					["Type"] = unittype,
					["Name"] = unitname,
					["Crew"] = 2,
					["Race"] = 2,
					["WingCount"] = wingcount,
					["Equipment"] = eqindex,
				},
			},
			["area"] = {
				["refPos"] = position,
				["angleRange"] = { DEG(180), DEG(185) },
			},
			["callback"] = "luaQAS2UnitSpawned",
			["excludeRadiusOverride"] = {
				["ownHorizontal"] = 50,
				["enemyHorizontal"] = 50,
				["ownVertical"] = 50,
				["formationHorizontal"] = 50,
				["enemyVertical"] = 50,
				["enemyHorizontal"] = 50,
			},
		})
	else
-- RELEASE_LOGOFF  		luaLog("  spawning is not possible, got nil")
-- RELEASE_LOGOFF  		luaLog(position)
-- RELEASE_LOGOFF  		luaLog(unittype)
-- RELEASE_LOGOFF  		luaLog(unitname)
-- RELEASE_LOGOFF  		luaLog(wingcount)
-- RELEASE_LOGOFF  		luaLog(eqindex)
	end
end

function luaQAS2UnitSpawned(aiunit)
	table.insert(Mission.Bombers, aiunit)
	SetRoleAvailable(aiunit, EROLF_ALL, PLAYER_AI)
	SetSkillLevel(aiunit, SKILL_SPNORMAL)
	--SetCrewLevel(aiunit, DIFF_REGULAR)
	local spawnpos = GetPosition(aiunit)
	local puttopos = {["x"] = spawnpos["x"] , ["y"] = 1000 , ["z"] = spawnpos["z"]}
	PutTo(aiunit, puttopos)
	EntityTurnToEntity(aiunit, Mission.HQ)
	if luaObj_IsActive("primary", 2) and luaObj_GetSuccess("primary", 2) == nil and Mission.MarkAllowed then
		luaObj_AddUnit("primary", 2, aiunit)
		aiunit.marked = true
	end
--[[
	if luaObj_IsActive("primary", 3) and luaObj_GetSuccess("primary", 3) == nil and luaObj_IsActive("primary", 4) and luaObj_GetSuccess("primary", 4) == nil then
		luaObj_AddUnit("primary", 3, aiunit)
		luaObj_AddUnit("primary", 4, aiunit)
		aiunit.marked = true
	end
]]
	local randomnumber = luaRnd(1, 15)
-- RELEASE_LOGOFF  	luaLog("  unit spawned, random: "..randomnumber)
	if aiunit.Class.Type ~= "LevelBomber" then
		AISetHintWeight(aiunit, 10)
		if randomnumber >= 1 and randomnumber <= 4 then
			if Mission.HQ.Party == PARTY_JAPANESE then
				PilotSetTarget(aiunit, Mission.HQ)
			else
				PilotMoveTo(aiunit, Mission.TurnToPoint)
			end
		elseif randomnumber >= 5 and randomnumber <= 15 then
			if not Mission.Mogami.Dead then
				PilotSetTarget(aiunit, Mission.Mogami)
			elseif not Mission.Kuma.Dead then
				PilotSetTarget(aiunit, Mission.Kuma)
			elseif not Mission.Tone.Dead then
				PilotSetTarget(aiunit, Mission.Tone)
			elseif Mission.HQ.Party == PARTY_JAPANESE then
				PilotSetTarget(aiunit, Mission.HQ)
			else
				PilotMoveTo(aiunit, Mission.TurnToPoint)
			end
		end
	elseif aiunit.Class.Type == "LevelBomber" and aiunit.Name ~= Mission.NameDakota then
		AISetHintWeight(aiunit, 30)
		if not Mission.Mogami.Dead then
			PilotSetTarget(aiunit, Mission.Mogami)
		elseif not Mission.Kuma.Dead then
			PilotSetTarget(aiunit, Mission.Kuma)
		elseif not Mission.Tone.Dead then
			PilotSetTarget(aiunit, Mission.Tone)
		elseif Mission.HQ.Party == PARTY_JAPANESE then
			PilotSetTarget(aiunit, Mission.HQ)
		else
			PilotMoveTo(aiunit, Mission.TurnToPoint)
		end
	elseif aiunit.Class.Type == "LevelBomber" and aiunit.Name == Mission.NameDakota then
		AISetHintWeight(aiunit, 30)
		PilotSetTarget(aiunit, Mission.HQ)
	end
end

function luaQAS2BomberWarning()
	if not Mission.Completed and not Mission.MissionEnd then
		--MissionNarrativeParty(1, "Paratrooper bombers spotted, be cautious!")
	end
end

function luaFilterAllow()
	if not Mission.Completed and not Mission.MissionEnd then
		Mission.FilterAllowed = true
	end
end

function luaQAS2FilterBombers()
-- RELEASE_LOGOFF  	luaLog(" Filtering bombers without payload")
	if Mission.FilterAllowed then
		for index, unit in pairs (Mission.Bombers) do
			local by
			if unit.Dead then
				if unit.Class.ID == 108 then
					by = luaCheckPlaneNumber(unit)
					luaResourcePoolReducer("helldiver", by)
				elseif unit.Class.ID == 136 then
					by = luaCheckPlaneNumber(unit)
					luaResourcePoolReducer("dakota", by)
				elseif unit.Class.ID == 116 then
					by = luaCheckPlaneNumber(unit)
					luaResourcePoolReducer("B17", by)
				end
				table.remove(Mission.Bombers, index)
			else
				previouscheck = luaCheckPlaneNumber(unit)
				local planesinsquad = table.getn(GetSquadronPlanes(unit))
				if planesinsquad < previouscheck then
					by = previouscheck - planesinsquad
					if unit.Class.ID == 108 then
						unit.checkednumber = planesinsquad
						luaResourcePoolReducer("helldiver", by)
					elseif unit.Class.ID == 136 then
						unit.checkednumber = planesinsquad
						luaResourcePoolReducer("dakota", by)
					elseif unit.Class.ID == 116 then
						unit.checkednumber = planesinsquad
						luaResourcePoolReducer("B17", by)
					end
				elseif planesinsquad == 3 then
					unit.checkednumber = planesinsquad
				end
			end
		end

		if table.getn(Mission.Bombers) ~= 0 then
			for index, unit in pairs (Mission.Bombers) do
-- RELEASE_LOGOFF  				luaLog("  unit: "..tostring(unit.Name).." | dead?: "..tostring(unit.Dead))
				if not unit.Dead then
-- RELEASE_LOGOFF  					luaLog("  payloads: "..tostring(table.getn(GetPayloads(unit))))
					if table.getn(GetPayloads(unit)) == 0 then
-- RELEASE_LOGOFF  						luaLog("  adding "..unit.Name.." to filter")
						PilotMoveTo(unit, Mission.ExitPoint)
						SquadronSetTravelAlt(unit, 1000)
						AISetHintWeight(unit, 5)
--[[

						if luaObj_IsActive("primary", 2) and luaObj_GetSuccess("primary", 2) == nil then
							luaObj_RemoveUnit("primary", 2, unit)
							unit.marked = false
						end
						if luaObj_IsActive("primary", 3) and luaObj_GetSuccess("primary", 3) == nil and luaObj_IsActive("primary", 4) and luaObj_GetSuccess("primary", 4) == nil and unit.marked then
							luaObj_RemoveUnit("primary", 3, unit)
							luaObj_RemoveUnit("primary", 4, unit)
							unit.marked = false
						end
]]
						table.remove(Mission.Bombers, index)
						table.insert(Mission.Filter, unit)
					elseif UnitGetAttackTarget(unit) == nil then
						if not Mission.Mogami.Dead then
							PilotSetTarget(unit, Mission.Mogami)
						elseif not Mission.Kuma.Dead then
							PilotSetTarget(unit, Mission.Kuma)
						elseif not Mission.Tone.Dead then
							PilotSetTarget(unit, Mission.Tone)
						elseif Mission.HQ.Party == PARTY_JAPANESE then
							PilotSetTarget(unit, Mission.HQ)
						else
							PilotMoveTo(unit, Mission.TurnToPoint)
						end
					end
				end
			end
		elseif table.getn(Mission.Bombers) == 0 then
-- RELEASE_LOGOFF  			luaLog("  no more bombers present, permiting the next wave in "..Mission.WaveTimer.." seconds")
			luaDelay(luaQAS2NextWave, Mission.WaveTimer)
			Mission.FilterAllowed = false
		end
	end

	Mission.Filter = luaRemoveDeadsFromTable(Mission.Filter)
	if table.getn(Mission.Filter) ~= 0 then
		for index, unit in pairs (Mission.Filter) do
			if luaGetDistance(unit, Mission.ExitPoint) < 400 then
-- RELEASE_LOGOFF  				luaLog("  adding "..unit.Name.." to filter")
				table.remove(Mission.Filter, index)
				Kill(unit, true)
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

function luaQAS2NextWave()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Permitting next wave...")
		Mission.WaveReady = true
		--Mission.Wave = Mission.Wave + 1
	end
end

function luaQAS2CheckLandBatteries()
-- RELEASE_LOGOFF  	luaLog(" Checking land batteries...")
	if table.getn(Mission.LandBatteries) ~= 0 then
		for index, unit in pairs (Mission.LandBatteries) do
			if unit.Dead then
				luaResourcePoolReducer("landbattery")
				table.remove(Mission.LandBatteries, index)
			end
		end
	elseif not Mission.S1Complete then
		Mission.S1Complete = true
		luaObj_Completed("secondary", 1)
	end
end

function luaQAS2CheckJapUnits()
-- RELEASE_LOGOFF  	luaLog(" Checking ships...")
	if not Mission.Mogami.Dead then
		local threshold = GetHpPercentage(Mission.Mogami) + 0.01
		if threshold < Mission.PreviousHPPercentageMogami then
			local difference = Mission.PreviousHPPercentageMogami - GetHpPercentage(Mission.Mogami)
			local percentage = difference * 100
			local by = luaRound(percentage)
			luaResourcePoolReducer("mogami", by)
			Mission.PreviousHPPercentageMogami = GetHpPercentage(Mission.Mogami)
		end
	elseif Mission.Mogami.Dead and not Mission.Mogami.ignore then
		Mission.Mogami.ignore = true
		local percentage = Mission.PreviousHPPercentageMogami * 100
		local by = luaRound(percentage)
		luaResourcePoolReducer("mogami", by)
		Mission.PreviousHPPercentageMogami = 0
	end

	if not Mission.Kuma.Dead then
		local threshold = GetHpPercentage(Mission.Kuma) + 0.01
		if threshold < Mission.PreviousHPPercentageKuma then
			local difference = Mission.PreviousHPPercentageKuma - GetHpPercentage(Mission.Kuma)
			local percentage = difference * 100
			local by = luaRound(percentage)
			luaResourcePoolReducer("kuma", by)
			Mission.PreviousHPPercentageKuma = GetHpPercentage(Mission.Kuma)
		end
	elseif Mission.Kuma.Dead and not Mission.Kuma.ignore then
		Mission.Kuma.ignore = true
		local percentage = Mission.PreviousHPPercentageKuma * 100
		local by = luaRound(percentage)
		luaResourcePoolReducer("kuma", by)
		Mission.PreviousHPPercentageKuma = 0
	end

	if not Mission.Tone.Dead then
		local threshold = GetHpPercentage(Mission.Tone) + 0.01
		if threshold < Mission.PreviousHPPercentageTone then
			local difference = Mission.PreviousHPPercentageTone - GetHpPercentage(Mission.Tone)
			local percentage = difference * 100
			local by = luaRound(percentage)
			luaResourcePoolReducer("tone", by)
			Mission.PreviousHPPercentageTone = GetHpPercentage(Mission.Tone)
		end
	elseif Mission.Tone.Dead and not Mission.Tone.ignore then
		Mission.Tone.ignore = true
		local percentage = Mission.PreviousHPPercentageTone * 100
		local by = luaRound(percentage)
		luaResourcePoolReducer("tone", by)
		Mission.PreviousHPPercentageTone = 0
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
		local by
		for index, unit in pairs (Mission.USTable) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead player unit found in Mission.USTable")
				by = luaCheckPlaneNumber(unit)
				if unit.Class.ID == 108 then
					by = by * 2
				end
				luaResourcePoolReducer("usplayer", by)
				table.remove(Mission.USTable, index)
			else
				previouscheck = luaCheckPlaneNumber(unit)
				local planesinsquad = table.getn(GetSquadronPlanes(unit))
				if planesinsquad < previouscheck then
					by = previouscheck - planesinsquad
					unit.checkednumber = planesinsquad
					if unit.Class.ID == 108 then
						by = by * 2
					end
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
			if unit.Class.ID == 101 or unit.Class.ID == 135 then
				if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  					luaLog("  new player unit found, inserting it to Mission.USTable")
					table.insert(Mission.USTable, unit)
				end
			elseif unit.Class.ID == 108 then
				if GetRoleAvailable(unit)[1] <= 7 then
					if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  						luaLog("  new player unit (dauntless) found, inserting it to Mission.USTable")
						table.insert(Mission.USTable, unit)
					end
				end
			end
		end
	end
	if japplanes ~= nil then
		for index, unit in pairs (japplanes) do
			if unit.Class.ID == 150 or unit.Class.ID == 152 then
				if not luaIsInside(unit, Mission.JapTable) then
-- RELEASE_LOGOFF  					luaLog("  new player unit found, inserting it to Mission.JapTable")
					table.insert(Mission.JapTable, unit)
				end
			end
		end
	end
end

function luaResourcePoolReducer(unit, by)
	if unit == "usplayer" then
		local todeduct = Mission.ResourcePlayerUnit * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "helldiver" then
		local todeduct = Mission.ResourceUSHelldiver * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "dakota" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSDakota
	elseif unit == "B17" then
		local todeduct = Mission.ResourceUSB17 * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "japplayer" then
		local todeduct = Mission.ResourcePlayerUnit * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "mogami" then
		local todeduct = Mission.ResourceJapMogami * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "tone" then
		local todeduct = Mission.ResourceJapTone * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "kuma" then
		local todeduct = Mission.ResourceJapKuma * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "HQ" then
		local todeduct = Mission.ResourceJapHQ * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "landbattery" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapLandBattery
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
		luaQAS2MissionEnd()
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" Jap pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaQAS2MissionEnd()
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool < 1 then
-- RELEASE_LOGOFF  		luaLog(" both pools are under 1 point")
		Mission.Randomize = luaRnd(1, 2)
		if Mission.Randomize == 1 then
			for i = 0, 7 do
				MultiScore[i][1] = 0
				MultiScore[i][2] = 1
			end
			Mission.MissionEndCalled = true
			luaQAS2MissionEnd()
		else
			for i = 0, 7 do
				MultiScore[i][1] = 1
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaQAS2MissionEnd()
		end
	end
end

function luaQAS2CheckMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Checking mission end conditions...")
--[[
	if Mission.KeyUnitCounter <= 3 and not Mission.LastWave then
		Mission.LastWave = true
	end

	if Mission.KeyUnitCounter == 0 and not Mission.EndCalled then
		Mission.EndCalled = true
		luaQAS2MissionEnd()
	end		
]]

	if Mission.HQ.Party ~= PARTY_JAPANESE and not Mission.EndCalled then
		Mission.ResourceJapPool = 0
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.EndCalled = true
		luaQAS2MissionEnd()
	end
end

function luaQAS2CountDownEnd()
	if not Mission.EndCalled and not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Countdown ended, checking mission state...")
		if not Mission.LastWave then
			Mission.LastWave = true
		end
	
		Mission.Bombers = luaRemoveDeadsFromTable(Mission.Bombers)
		if table.getn(Mission.Bombers) == 0 and not Mission.EndCalled then
			Mission.EndCalled = true
			--MissionNarrativeParty(0, "No more bombers available.")
			--MissionNarrativeParty(1, "All of the bombers have been destroyed.")
			luaDelay(luaQAS2MissionEnd, 5)
		else
			--MissionNarrativeParty(0, "The enemy fleet is closing, this is the last wave!")
			--MissionNarrativeParty(1, "Our reinforcements are closing, this is the last wave!")
-- RELEASE_LOGOFF  			luaLog("  bombers are still in present, delaying the end of the mission")
			luaDelay(luaQAS2CountDownEnd, 3)
		end
	end
end

function luaQAS2MissionEnd()
	if not Mission.Completed and not Mission.MissionEnd then
		Scoring_RealPlayTimeRunning(false)
		if Mission.ResourceUSPool < 1 and Mission.ResourceJapPool > 0 or Mission.Randomize == 1 then
-- RELEASE_LOGOFF  			luaLog(" Jap side wins")
			Mission.Completed = true
			Mission.MissionEndCalled = true
			luaObj_Failed("primary", 1)
			luaObj_Completed("primary", 2)
			luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_JAPANESE)
		elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 or Mission.Randomize == 2 then
-- RELEASE_LOGOFF  			luaLog(" US side wins")
			Mission.Completed = true
			Mission.MissionEndCalled = true
			luaObj_Completed("primary", 1)
			luaObj_Failed("primary", 2)
			luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_ALLIED)
		end

--[[
		if Mission.HQ.Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  			luaLog("  time is up, Japanese side wins")
			Mission.Completed = true
			luaObj_Failed("primary", 1)
			luaObj_Completed("primary", 2)
			luaObj_Failed("primary", 3)
			luaObj_Completed("primary", 4)

			if not Mission.MogamiDead then
				luaObj_Failed("secondary", 1)
				luaObj_Completed("secondary", 2)
			end
			if not Mission.KumaDead then
				luaObj_Failed("secondary", 3)
				luaObj_Completed("secondary", 4)
			end
			if not Mission.ToneDead then
				luaObj_Failed("secondary", 5)
				luaObj_Completed("secondary", 6)
			end

			luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_JAPANESE)
		elseif Mission.HQ.Party ~= PARTY_JAPANESE then
-- RELEASE_LOGOFF  			luaLog("  the HQ has been neutralized, Allied side wins")
			Mission.Completed = true
			luaObj_Completed("primary", 1)
			luaObj_Failed("primary", 2)
			luaObj_Completed("primary", 3)
			luaObj_Failed("primary", 4)

			luaObj_Completed("secondary", 1)
			luaObj_Failed("secondary", 2)
			luaObj_Completed("secondary", 3)
			luaObj_Failed("secondary", 4)
			luaObj_Completed("secondary", 5)
			luaObj_Failed("secondary", 6)
			luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_ALLIED)
		end
]]
	end
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Siege02")
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

function luaQAS2HintManager()
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
			ShowHint("ID_Hint_Siege01_PK")
			Mission.Hint3Shown = true
		elseif GameTime() > 120 and not Mission.Hint4Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint4Shown")
			ShowHint("ID_Hint_Siege02_LB")
			Mission.Hint4Shown = true
		elseif GameTime() > 150 and not Mission.Hint5Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint5Shown")
			ShowHint("ID_Hint_Siege02_HQ")
			Mission.Hint5Shown = true
		end
	end
end