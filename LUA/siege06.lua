--SceneFile="Missions\Multi\Scene6.scn"

function luaPrecacheUnits()
	PrepareClass(91) -- Type1 (spec QA)
	PrepareClass(316) -- Cleveland
	PrepareClass(20) -- DeRuyter
	PrepareClass(133) -- Buffalo
	PrepareClass(125) -- Catalina
	PrepareClass(71) -- Agano
	PrepareClass(70) -- Kuma
	PrepareClass(27) -- Elco
	PrepareClass(108) -- Dauntless
	PrepareClass(25) -- Clemson
	PrepareClass(75) -- Minekaze
	PrepareClass(154) -- Oscar
	PrepareClass(166) -- Nell
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAS6Mission")
end

function luaInitQAS6Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Siege6"..dateandtime

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
	Mission.MultiplayerNumber = 6

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- mission valtozok
	Mission.KeyUnitCounter = 0 -- luaQAS6StartMission()-ben allitjuk be
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
	Mission.HQ = FindEntity("Siege - Headquarter")

	Mission.Fortresses = {}
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 1"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 2"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 3"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 4"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 5"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 6"))

	Mission.Dauntlesses = {}
	Mission.DauntlessTMPL = luaFindHidden("Siege - Dauntless TMPL")
	Mission.Clemsons = {}
	Mission.ClemsonTMPL = luaFindHidden("Siege - Clemson TMPL")

	-- japan objektumok
	Mission.LSTs = {}
	Mission.LSTTMPL = luaFindHidden("Siege - Type1 TMPL")
	Mission.Minekazes = {}
	Mission.MinekazeTMPL = luaFindHidden("Siege - Minekaze TMPL")
	Mission.PTs = {}
	Mission.PTTMPL = luaFindHidden("Siege - PTBoat TMPL")

	-- pathok, navpointok
	Mission.LSTSpawnPositions = {}
		table.insert(Mission.LSTSpawnPositions, GetPosition(FindEntity("Siege - LST SpawnPoint 1")))
		table.insert(Mission.LSTSpawnPositions, GetPosition(FindEntity("Siege - LST SpawnPoint 2")))
		table.insert(Mission.LSTSpawnPositions, GetPosition(FindEntity("Siege - LST SpawnPoint 3")))
		table.insert(Mission.LSTSpawnPositions, GetPosition(FindEntity("Siege - LST SpawnPoint 4")))
		table.insert(Mission.LSTSpawnPositions, GetPosition(FindEntity("Siege - LST SpawnPoint 5")))
		table.insert(Mission.LSTSpawnPositions, GetPosition(FindEntity("Siege - LST SpawnPoint 6")))
	Mission.MinekazePoints = {}
		table.insert(Mission.MinekazePoints, GetPosition(FindEntity("Siege - Jap DD SpawnPoint 01")))
		table.insert(Mission.MinekazePoints, GetPosition(FindEntity("Siege - Jap DD SpawnPoint 02")))
		table.insert(Mission.MinekazePoints, GetPosition(FindEntity("Siege - Jap DD SpawnPoint 03")))
		table.insert(Mission.MinekazePoints, GetPosition(FindEntity("Siege - Jap DD SpawnPoint 04")))
	Mission.PTPoints = {}
		table.insert(Mission.PTPoints, GetPosition(FindEntity("Siege - PT SpawnPoint 01")))
		table.insert(Mission.PTPoints, GetPosition(FindEntity("Siege - PT SpawnPoint 02")))
		table.insert(Mission.PTPoints, GetPosition(FindEntity("Siege - PT SpawnPoint 03")))
		table.insert(Mission.PTPoints, GetPosition(FindEntity("Siege - PT SpawnPoint 04")))
	Mission.ClemsonPoints = {}
		table.insert(Mission.ClemsonPoints, GetPosition(FindEntity("Siege - US DD SpawnPoint 01")))
		table.insert(Mission.ClemsonPoints, GetPosition(FindEntity("Siege - US DD SpawnPoint 02")))

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
	Mission.ResourceUSDestroyer = 15
	Mission.ResourceUSDauntless = 5
	Mission.ResourceUSPT = 10
	Mission.ResourceUSHQ = 4
	Mission.ResourceUSFortressLong = 90
	Mission.ResourceUSFortressMain = 120
	Mission.ResourceUSFortressTower = 60
	Mission.ResourceJapLST = 15
	Mission.ResourceJapDestroyer = 15
	Mission.ResourcePlayerUnit = 30

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
				["Text"] = "mp06.obj_siege_us_p1_text",
				["TextCompleted"] = "mp06.obj_siege_us_p1_comp",
				["TextFailed"] = "mp06.obj_siege_us_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_primary_1",
				["Text"] = "mp06.obj_siege_jap_p1_text",
				["TextCompleted"] = "mp06.obj_siege_jap_p1_comp",
				["TextFailed"] = "mp06.obj_siege_jap_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
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
				["ID"] = "us_obj_primary_2",
				["Text"] = "Destroy all of the landing ships!",
				["TextCompleted"] = "You have all of the landing ships!",
				["TextFailed"] = "You failed to destroy the landing ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 600,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_primary_2",
				["Text"] = "At least one landing ship must survive!",
				["TextCompleted"] = "You have protected at least one landing ship!",
				["TextFailed"] = "Your failed to protect at least one landing ship!",
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

	--AISetSpawnSceneUnitsWeightMul(0)

	luaInitNewSystems()

    SetThink(this, "luaQAS6Mission_think")
end

function luaQAS6Mission_think(this, msg)
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
		luaQAS6CheckLSTs()
		luaQAS6CheckDauntless()
		luaQAS6CheckForts()
		luaQAS6CheckShips()
		luaCheckPlayers()
		--luaQAS6CheckMissionEnd()
		luaQAS6HintManager()

	elseif not Mission.Started then
		luaQAS6StartMission()
		luaSetMultiScoreTable()
	end
end

function luaQAS6StartMission()
-- RELEASE_LOGOFF  	luaLog(" Starting mission...")
	Scoring_RealPlayTimeRunning(true)
	
	luaShowMissionHint()
	
	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	-- HQ
	AISetTargetWeight(70, 241, false, 0.75)
	AISetTargetWeight(71, 241, false, 0.85)
	-- fortress long
	AISetTargetWeight(70, 66, false, 7)
	AISetTargetWeight(71, 66, false, 8)
	-- fortress main
	AISetTargetWeight(70, 72, false, 9)
	AISetTargetWeight(71, 72, false, 10)
	-- fortress left tower
	AISetTargetWeight(70, 84, false, 6)
	AISetTargetWeight(71, 84, false, 7)

	-- De Ruyter vs Agano/Kuma/Type1QA/Minekaze
	AISetTargetWeight(20, 70, false, 5)
	AISetTargetWeight(20, 70, false, 5)
	AISetTargetWeight(20, 71, false, 5)
	AISetTargetWeight(20, 71, false, 5)
	AISetTargetWeight(20, 91, false, 7)
	AISetTargetWeight(20, 91, false, 7)
	AISetTargetWeight(20, 75, false, 3)
	AISetTargetWeight(20, 75, false, 3)

	-- Fletcher vs Agano/Kuma/Type1QA/Minekaze
	AISetTargetWeight(23, 70, false, 0)
	AISetTargetWeight(23, 70, false, 0)
	AISetTargetWeight(23, 71, false, 0)
	AISetTargetWeight(23, 71, false, 0)
	AISetTargetWeight(23, 91, false, 0)
	AISetTargetWeight(23, 91, false, 0)
	AISetTargetWeight(23, 75, false, 0)
	AISetTargetWeight(23, 75, false, 0)

	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2)
	luaObj_AddUnit("primary", 1, Mission.HQ)
	luaObj_AddUnit("primary", 2, Mission.HQ)
	luaObj_Add("secondary", 1)
	--luaObj_Add("primary", 3)
	--luaObj_Add("primary", 4)

	for index, unit in pairs (Mission.Fortresses) do
		luaObj_AddUnit("secondary", 1, unit)
		if index == 1 then
			AISetHintWeight(unit, 7)
		elseif index == 2 then
			AISetHintWeight(unit, 5)
		elseif index == 3 then
			AISetHintWeight(unit, 8)
		elseif index == 4 then
			AISetHintWeight(unit, 12)
		elseif index == 5 then
			AISetHintWeight(unit, 3)
		elseif index == 6 then
			AISetHintWeight(unit, 3)
		end			
	end

	if Mission.Players <= 2 then
		Mission.LSTToDestroy = 28
	elseif Mission.Players == 3 then
		Mission.LSTToDestroy = 32
	elseif Mission.Players == 4 then
		Mission.LSTToDestroy = 36
	elseif Mission.Players == 5 then
		Mission.LSTToDestroy = 40
	elseif Mission.Players == 6 then
		Mission.LSTToDestroy = 44
	elseif Mission.Players == 7 then
		Mission.LSTToDestroy = 48
	elseif Mission.Players == 8 then
		Mission.LSTToDestroy = 52
	end
-- RELEASE_LOGOFF  	luaLog(" KeyUnitCounter set to "..Mission.LSTToDestroy)
	Mission.KeyUnitCounter = Mission.LSTToDestroy
	--ModifyKeyUnitNumber(Mission.KeyUnitCounter)

	--for i = 1, 6 do
	for i = 1, 5 do
-- RELEASE_LOGOFF  		luaLog(" generating LST")
		local lst = GenerateObject(Mission.LSTTMPL.Name, Mission.LSTSpawnPositions[i])
		EntityTurnToEntity(lst, Mission.HQ)
		NavigatorMoveToRange(lst, Mission.HQ)
		NavigatorSetTorpedoEvasion(lst, false)
		NavigatorSetAvoidLandCollision(lst, false)
		--luaObj_AddUnit("primary", 3, lst)
		--luaObj_AddUnit("primary", 4, lst)
		table.insert(Mission.LSTs, lst)
	end

	--for i = 1, 2 do
	for i = 1, 1 do
-- RELEASE_LOGOFF  		luaLog(" generating Dauntless")
		local pos = GetPosition(Mission.HQ)
		local posmod = 150 * i
		local dauntless = GenerateObject(Mission.DauntlessTMPL.Name, {["x"] = pos.x + posmod, ["y"] = 100, ["z"] = pos.z + posmod})
		--luaLog({["x"] = pos.x + posmod, ["y"] = 100, ["z"] = pos.z + posmod})
		luaQAS6SelectTarget(dauntless)
		table.insert(Mission.Dauntlesses, dauntless)
	end

	for i = 1, 3 do
-- RELEASE_LOGOFF  		luaLog(" generating Minekaze")
		local minekaze = GenerateObject(Mission.MinekazeTMPL.Name, Mission.MinekazePoints[i])
		--luaLog(Mission.MinekazePoints[i])
		EntityTurnToEntity(minekaze, Mission.HQ)
		NavigatorMoveToRange(minekaze, Mission.HQ)
		table.insert(Mission.Minekazes, minekaze)
	end

	--for i = 1, 4 do
	for i = 1, 2 do
-- RELEASE_LOGOFF  		luaLog(" generating PT boat")
		local PT = GenerateObject(Mission.PTTMPL.Name, Mission.PTPoints[i])
		NavigatorMoveToRange(PT, Mission.MinekazePoints[i])
		--luaLog(Mission.PTPoints[i])
		table.insert(Mission.PTs, PT)
	end

	for i = 1, 2 do
-- RELEASE_LOGOFF  		luaLog(" generating Clemson")
		local clemson = GenerateObject(Mission.ClemsonTMPL.Name, Mission.ClemsonPoints[i])
		NavigatorMoveToRange(clemson, Mission.MinekazePoints[i])
		--luaLog(Mission.ClemsonPoints[i])
		table.insert(Mission.Clemsons, clemson)
	end

	Mission.Started = true
end

function luaQAS6CheckLSTs()
-- RELEASE_LOGOFF  	luaLog(" Checking landing ships...")
	if table.getn(Mission.LSTs) ~= 0 then
		for index, unit in pairs (Mission.LSTs) do
			if unit.Dead and Mission.KeyUnitCounter > table.getn(Mission.LSTs) then
				luaResourcePoolReducer("LST")
				Mission.LSTs[index] = GenerateObject(Mission.LSTTMPL.Name, Mission.LSTSpawnPositions[index])
				--Mission.KeyUnitCounter = Mission.KeyUnitCounter - 1
				--ModifyKeyUnitNumber(Mission.KeyUnitCounter)
				EntityTurnToEntity(Mission.LSTs[index], Mission.HQ)
				NavigatorMoveToRange(Mission.LSTs[index], Mission.HQ)
				NavigatorSetTorpedoEvasion(Mission.LSTs[index], false)
				NavigatorSetAvoidShipCollision(Mission.LSTs[index], false)
				NavigatorSetAvoidLandCollision(Mission.LSTs[index], false)
--[[
				if luaObj_IsActive("primary", 3) and luaObj_GetSuccess("primary", 3) == nil and luaObj_IsActive("primary", 4) and luaObj_GetSuccess("primary", 4) == nil then
					luaObj_AddUnit("primary", 3, Mission.LSTs[index])
					luaObj_AddUnit("primary", 4, Mission.LSTs[index])
				end
			elseif unit.Dead and not unit.deducted then
				unit.deducted = true
				--Mission.KeyUnitCounter = Mission.KeyUnitCounter - 1
				--ModifyKeyUnitNumber(Mission.KeyUnitCounter)
]]
			elseif not unit.Dead and not unit.landing then
				if luaGetDistance(unit, Mission.HQ) < 1250 then
					unit.landing = true
					StartLanding2(unit)
				end
			end
		end
	end
end

function luaQAS6CheckDauntless()
-- RELEASE_LOGOFF  	luaLog(" Checking dauntlesses...")
	if table.getn(Mission.Dauntlesses) ~= 0 then
		local mod = 1
		for index, unit in pairs (Mission.Dauntlesses) do
			if unit.Dead and Mission.KeyUnitCounter ~= 0 or unit.needstobereplaced and Mission.KeyUnitCounter ~= 0 then
				if unit.Dead then
-- RELEASE_LOGOFF  					luaLog("  dead dauntless found")
					by = luaCheckPlaneNumber(unit)
					luaResourcePoolReducer("dauntless", by)
				end
				local pos = GetPosition(Mission.HQ)
				if unit.needstobereplaced and not unit.Dead then
-- RELEASE_LOGOFF  					luaLog("  replacing dauntless")
					Kill(unit, true)
				end
				if mod == 1 then
					Mission.Dauntlesses[index] = GenerateObject(Mission.DauntlessTMPL.Name, {["x"] = pos.x, ["y"] = 100, ["z"] = pos.z})
				else
					local posmod = 150 * mod
					Mission.Dauntlesses[index] = GenerateObject(Mission.DauntlessTMPL.Name, {["x"] = pos.x + posmod, ["y"] = 100, ["z"] = pos.z + posmod})
				end
				luaQAS6SelectTarget(Mission.Dauntlesses[index])
				mod = mod + 1
			elseif not unit.Dead then
				previouscheck = luaCheckPlaneNumber(unit)
				local planesinsquad = table.getn(GetSquadronPlanes(unit))
				if planesinsquad < previouscheck then
					by = previouscheck - planesinsquad
					unit.checkednumber = planesinsquad
					luaResourcePoolReducer("dauntless", by)
				elseif planesinsquad == 3 then
					unit.checkednumber = planesinsquad
				end
				if table.getn(GetPayloads(unit)) == 0 and not unit.retreating then
-- RELEASE_LOGOFF  					luaLog("  no more payload on an dauntless, ordering it to retreat")
					unit.retreating = true
					PilotMoveToRange(unit, Mission.HQ)
					SquadronSetTravelAlt(unit, 100)
				elseif unit.retreating then
					local hqpos = GetPosition(Mission.HQ)
					local checkdistancepos = {["x"] = hqpos.x, ["y"] = 100, ["z"] = hqpos.z}
					if luaGetDistance(unit, checkdistancepos) < 250 then
-- RELEASE_LOGOFF  						luaLog("  an dauntless reached the HQ, it needs to be replaced")
						unit.needstobereplaced = true
					end
				elseif UnitGetAttackTarget(unit) == nil and table.getn(GetPayloads(unit)) ~= 0 then
-- RELEASE_LOGOFF  					luaLog("  dauntless found without a target, ordering it to attack the nearest enemy")
					luaQAS6SelectTarget(unit)
				end
			end
		end
	end
end

function luaQAS6SelectTarget(unit)
	local possibletargets = luaGetShipsAroundCoordinate(GetPosition(Mission.HQ), 30000, PARTY_JAPANESE, "own")
	if possibletargets ~= nil then
		for index, unit in pairs (possibletargets) do
			if unit.Class.Type ~= "LandingShip" then
				table.remove(possibletargets, index)
			end
		end
		if table.getn(possibletargets) ~= 0 then
			local randomtarget = luaPickRnd(possibletargets)
			PilotSetTarget(unit, randomtarget)
		end
	else
-- RELEASE_LOGOFF  		luaLog("   ERROR! possibletargets == nil")
	end
end

function luaQAS6CheckMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Checking mission end conditions...")
	if not Mission.MissionEndCalled then
		if Mission.HQ.Party ~= PARTY_ALLIED or Mission.KeyUnitCounter == 0 then
-- RELEASE_LOGOFF  			luaLog("  HQ party "..tostring(Mission.HQ.Party).." | key unit counter: "..tostring(Mission.KeyUnitCounter))
			Mission.ResourceUSPool = 0
			for i = 0, 7 do
				MultiScore[i][1] = 0
				MultiScore[i][2] = Mission.ResourceJapPool
			end
			Mission.MissionEndCalled = true
			luaQAS6MissionEnd()
		end
	end
end

function luaQAS6MissionEnd()
-- RELEASE_LOGOFF  	luaLog(" MissionEnd called...")
	Mission.Completed = true
	Scoring_RealPlayTimeRunning(false)

	local fortalive = 0
	if not Mission.AllFortsDown then
		for index, unit in pairs (Mission.Fortresses) do
			if not unit.Dead then
				fortalive = fortalive + 1
			end
		end	
		if fortalive == 0 then
			Mission.AllFortsDown = true
			luaObj_Completed("secondary", 1)
		else
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
	if Mission.HQ.Party == PARTY_ALLIED then
-- RELEASE_LOGOFF  		luaLog("  the HQ is still in Allied hands, Allied side wins")
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaObj_Completed("primary", 3)
		luaObj_Failed("primary", 4)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_ALLIED)
	else
-- RELEASE_LOGOFF  		luaLog("  the HQ is neutral, Japanese side wins")
		luaObj_Failed("primary", 1)
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 3)
		luaObj_Completed("primary", 4)
		luaMissionCompletedNew(Mission.HQ, "", nil, nil, nil, PARTY_JAPANESE)
	end
]]
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Siege06")
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

function luaResourcePoolReducer(unit, by)
-- RELEASE_LOGOFF  	luaLog(" luaResourcePoolReducer: "..unit)
	if unit == "usplayer" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourcePlayerUnit
	elseif unit == "japplayer" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourcePlayerUnit
	elseif unit == "usdestroyer" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSDestroyer
	elseif unit == "japdestroyer" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapDestroyer
	elseif unit == "LST" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapLST
	elseif unit == "PT" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSPT
	elseif unit == "dauntless" then
		local todeduct = Mission.ResourceUSDauntless * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "HQ" then
		local todeduct = Mission.ResourceUSHQ * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "fortresslong" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSFortressLong
	elseif unit == "fortressmain" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSFortressMain
	elseif unit == "fortresstower" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSFortressTower
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
		luaQAS6MissionEnd()
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" Jap pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaQAS6MissionEnd()
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool < 1 then
-- RELEASE_LOGOFF  		luaLog(" both pools are under 1 point")
		Mission.Randomize = luaRnd(1, 2)
		if Mission.Randomize == 1 then
			for i = 0, 7 do
				MultiScore[i][1] = 0
				MultiScore[i][2] = 1
			end
			Mission.MissionEndCalled = true
			luaQAS6MissionEnd()
		else
			for i = 0, 7 do
				MultiScore[i][1] = 1
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaQAS6MissionEnd()
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
				if unit.Class.ID == 25 then
					luaResourcePoolReducer("usdestroyer")
				else
					luaResourcePoolReducer("usplayer")
				end
				table.remove(Mission.USTable, index)
			end
		end
	end

	if table.getn(Mission.JapTable) ~= 0 then
		for index, unit in pairs (Mission.JapTable) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead player unit found in Mission.JapTable")
				if unit.Class.ID == 75 then
					luaResourcePoolReducer("japdestroyer")
				else
					luaResourcePoolReducer("japplayer")
				end
				table.remove(Mission.JapTable, index)
			end
		end
	end

	local usships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	local usplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_ALLIED, "own")
	local japships = luaGetShipsAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")
	local japplanes = luaGetPlanesAroundCoordinate({["x"] = 0, ["y"] = 0, ["z"] = 0}, 30000, PARTY_JAPANESE, "own")

	if usships ~= nil then
		for index, unit in pairs (usships) do
			if unit.Class.Type == "Cruiser" or unit.Class.ID == 23 then
				if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  					luaLog("  new player unit found, inserting it to Mission.USTable")
					table.insert(Mission.USTable, unit)
				end
			end
		end
	end
	if usplanes ~= nil then
		for index, unit in pairs (usplanes) do
			if unit.Class.ID == 133 or unit.Class.ID == 125 then
				if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  					luaLog("  new player unit found, inserting it to Mission.USTable")
					table.insert(Mission.USTable, unit)
				end
			end
		end
	end
	

	if japships ~= nil then
		for index, unit in pairs (japships) do
			if unit.Class.Type == "Cruiser"  or unit.Class.ID == 73 then
				if not luaIsInside(unit, Mission.JapTable) then
-- RELEASE_LOGOFF  					luaLog("  new player unit found, inserting it to Mission.JapTable")
					table.insert(Mission.JapTable, unit)
				end
			end
		end
	end

	if japplanes ~= nil then
		for index, unit in pairs (japplanes) do
			if unit.Class.ID == 154 or unit.Class.ID == 166 then
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

function luaQAS6CheckForts()
-- RELEASE_LOGOFF  	luaLog(" Checking fortresses..")
	local fortalive = 0
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
		else
			fortalive = fortalive + 1
		end
	end

	if fortalive == 0 and not Mission.AllFortsDown then
-- RELEASE_LOGOFF  		luaLog("  fortesses down, secondary 1 completed")
		Mission.AllFortsDown = true
		luaObj_Completed("secondary", 1)
	end

	local threshold = GetHpPercentage(Mission.HQ) + 0.01
	if threshold < Mission.PreviousHPPercentageHQ then
		local difference = Mission.PreviousHPPercentageHQ - GetHpPercentage(Mission.HQ)
		local percentage = difference * 100
		local by = luaRound(percentage)
		luaResourcePoolReducer("HQ", by)
		Mission.PreviousHPPercentageHQ = GetHpPercentage(Mission.HQ)
	end
end

function luaQAS6CheckShips()
-- RELEASE_LOGOFF  	luaLog(" Checking ships...")
	if table.getn(Mission.Minekazes) ~= 0 then
		for index, unit in pairs (Mission.Minekazes) do
			if unit.Dead and not unit.respawnset then
-- RELEASE_LOGOFF  				luaLog("  dead minekaze found")
				luaResourcePoolReducer("japdestroyer")
				unit.respawntime = GameTime() + Mission.RespawnTime
				unit.respawnset = true
			elseif unit.respawnset and GameTime() > unit.respawntime then
-- RELEASE_LOGOFF  				luaLog("  respawning minekaze")
				Mission.Minekazes[index] = GenerateObject(Mission.MinekazeTMPL.Name, Mission.MinekazePoints[index])
				EntityTurnToEntity(Mission.Minekazes[index], Mission.HQ)
				NavigatorMoveToRange(Mission.Minekazes[index], Mission.HQ)
			elseif not unit.Dead then
				if UnitGetAttackTarget(unit) == nil then
-- RELEASE_LOGOFF  					luaLog("  minekaze doesn't have a target")
					local target = luaQAS6SetTargetToAttack(unit)
					if target ~= nil then
						NavigatorAttackMove(unit, target, {})
					end
				end
			end
		end
	end

	if table.getn(Mission.Clemsons) ~= 0 then
		for index, unit in pairs (Mission.Clemsons) do
			if unit.Dead and not unit.respawnset then
-- RELEASE_LOGOFF  				luaLog("  dead clemson found")
				luaResourcePoolReducer("usdestroyer")
				unit.respawntime = GameTime() + Mission.RespawnTime
				unit.respawnset = true
			elseif unit.respawnset and GameTime() > unit.respawntime then
-- RELEASE_LOGOFF  				luaLog("  respawning clemson")
				Mission.Clemsons[index] = GenerateObject(Mission.ClemsonTMPL.Name, Mission.ClemsonPoints[index])
			elseif not unit.Dead then
				if UnitGetAttackTarget(unit) == nil then
-- RELEASE_LOGOFF  					luaLog("  clemson doesn't have a target")
					local target = luaQAS6SetTargetToAttack(unit)
					if target ~= nil then
						NavigatorAttackMove(unit, target, {})
					end
				end
			end
		end
	end

	if table.getn(Mission.PTs) ~= 0 then
		for index, unit in pairs (Mission.PTs) do
			if unit.Dead and not unit.respawnset then
-- RELEASE_LOGOFF  				luaLog("  dead PT found")
				luaResourcePoolReducer("PT")
				unit.respawntime = GameTime() + Mission.RespawnTime
				unit.respawnset = true
			elseif unit.respawnset and GameTime() > unit.respawntime then
-- RELEASE_LOGOFF  				luaLog("  respawning PT")
				Mission.PTs[index] = GenerateObject(Mission.PTTMPL.Name, Mission.PTPoints[index])
			elseif not unit.Dead then
				if UnitGetAttackTarget(unit) == nil then
-- RELEASE_LOGOFF  					luaLog("  PT doesn't have a target")
					local target = luaQAS6SetTargetToAttack(unit)
					if target ~= nil then
						NavigatorAttackMove(unit, target, {})
					end
				end
			end
		end
	end
end

function luaQAS6SetTargetToAttack(unit)
	local possibletargets = {}
	local target
	local cruiser = luaGetNearestEnemy(unit, "cruiser")
	local landingship = luaGetNearestEnemy(unit, "landingship")
	local patrolboat = luaGetNearestEnemy(unit, "torpedoboat")
	if cruiser ~= nil then
		table.insert(possibletargets, cruiser)
	end
	if landingship ~= nil then
		table.insert(possibletargets, landingship)
	end
	if patrolboat ~= nil then
		table.insert(possibletargets, patrolboat)
	end
	if table.getn(possibletargets) ~= nil then
		target = luaPickRnd(possibletargets)
		return target
	else
		return nil
	end
end

function luaQAS6HintManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 30 and not Mission.Hint1Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint1Shown")
			ShowHint("ID_Hint_Siege01_LST")
			ShowHint("ID_Hint_Siege01_PT")
			Mission.Hint1Shown = true
		elseif GameTime() > 60 and not Mission.Hint2Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint2Shown")
			ShowHint("ID_Hint_Siege06_Fort")
			Mission.Hint2Shown = true
		end
	end
end