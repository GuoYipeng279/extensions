--SceneFile="Missions\Multi\Scene5.scn"

function luaPrecacheUnits()
	PrepareClass(315) -- Yorktown
	PrepareClass(41) -- LST (spec QA)
	PrepareClass(150) -- Wildcat
	PrepareClass(108) -- Dauntless
	PrepareClass(101) -- Zero
	PrepareClass(75) -- Minekaze
	PrepareClass(73) -- Fubuki
	PrepareClass(25) -- Clemson
	PrepareClass(23) -- Fletcher
end

function luaStageInitMulti()
	luaLoadControlFunctionNames()
end

function luaStageInit()
	CreateScript("luaInitQAS5Mission")
end

function luaInitQAS5Mission(this)
	Mission = this

	local dateandtime = string.gsub(os.date(), "(%w+)/(%w+)/(%w+) (%w+):(%w+):(%w+)", "_%3_%1_%2_%4_%5")
	this.Name = "Siege5"..dateandtime

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
	Mission.MultiplayerNumber = 5

	AddListener("surrender", "surrender", {
		["callback"] = "luaSurrender",
		["party"] = {},
	})

	-- mission valtozok
	Mission.KeyUnitCounter = 3 -- 3 CV
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

	-- amerikai objektumok
	Mission.LSTs = {}
	Mission.LSTTMPL = luaFindHidden("Siege - LST TMPL")
	Mission.CVs = {}
	 table.insert(Mission.CVs, FindEntity("Siege - Yorktown TMPL 1"))
	 table.insert(Mission.CVs, FindEntity("Siege - Yorktown TMPL 2"))
	 table.insert(Mission.CVs, FindEntity("Siege - Yorktown TMPL 3"))
	Mission.CVSPs = {}
		table.insert(Mission.CVSPs, FindEntity("Siege - York 1 SP"))
		table.insert(Mission.CVSPs, FindEntity("Siege - York 2 SP"))
		table.insert(Mission.CVSPs, FindEntity("Siege - York 3 SP"))
	Mission.Bombers = {}
	Mission.DauntlessTMPL = luaFindHidden("Siege - Dauntless TMPL")
	Mission.Wildcats = {}
	Mission.WildcatTMPL = luaFindHidden("Siege - Wildcat TMPL")

	-- japan objektumok
	Mission.HQs = {}
		table.insert(Mission.HQs, FindEntity("Siege - HQ 1"))
		table.insert(Mission.HQs, FindEntity("Siege - HQ 2"))
	Mission.Fortresses = {}
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 1"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 2"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 3"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress 4"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress2 1"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress2 2"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress2 3"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Fortress2 4"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Coastal Gun 01"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Coastal Gun 02"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Coastal Gun 03"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Heavy AA 01"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Heavy AA 02"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Heavy AA 03"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Coastal Gun2 01"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Coastal Gun2 02"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Coastal Gun2 03"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Heavy AA2 01"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Heavy AA2 02"))
		table.insert(Mission.Fortresses, FindEntity("Siege - Heavy AA2 03"))

	Mission.Zeroes = {}
	Mission.ZeroTMPL = luaFindHidden("Siege - Zero TMPL")

-- RELEASE_LOGOFF  	luaLog("-- start of spawnpoint activation --")
	for index, entity in pairs (Mission.SpawnPoints) do
		local slotID = index - 1
		for index2, value in pairs (Mission.SlotIDTable) do
			if slotID == value then
-- RELEASE_LOGOFF  				luaLog(" activating SPID "..index.." for slotID "..value)
				ActivateSpawnpoint(entity, value)
			else
				DeactivateSpawnpoint(entity, value)
				DeactivateSpawnpoint(Mission.CVSPs[1], value)
				DeactivateSpawnpoint(Mission.CVSPs[2], value)
				DeactivateSpawnpoint(Mission.CVSPs[3], value)
			end
		end	
	end
-- RELEASE_LOGOFF  	luaLog("-- end of spawnpoint activation --")

	-- pathok, navpointok
	Mission.LSTSpawnPositions = {}
		table.insert(Mission.LSTSpawnPositions, GetPosition(FindEntity("Siege - LST Navpoint 1")))
		table.insert(Mission.LSTSpawnPositions, GetPosition(FindEntity("Siege - LST Navpoint 2")))
		table.insert(Mission.LSTSpawnPositions, GetPosition(FindEntity("Siege - LST Navpoint 3")))
		table.insert(Mission.LSTSpawnPositions, GetPosition(FindEntity("Siege - LST Navpoint 4")))
		table.insert(Mission.LSTSpawnPositions, GetPosition(FindEntity("Siege - LST Navpoint 5")))
		table.insert(Mission.LSTSpawnPositions, GetPosition(FindEntity("Siege - LST Navpoint 6")))
	Mission.CVSpawnPositions = {}
		table.insert(Mission.CVSpawnPositions, GetPosition(FindEntity("Siege - CV Navpoint 1")))
		table.insert(Mission.CVSpawnPositions, GetPosition(FindEntity("Siege - CV Navpoint 2")))
		table.insert(Mission.CVSpawnPositions, GetPosition(FindEntity("Siege - CV Navpoint 3")))
	Mission.MeetingPoint = GetPosition(FindEntity("Siege - Fighter Meeting Point"))

	Mission.LSTPaths = {}
		table.insert(Mission.LSTPaths, FindEntity("Siege - LST 1 Path"))
		table.insert(Mission.LSTPaths, FindEntity("Siege - LST 2 Path"))
		table.insert(Mission.LSTPaths, FindEntity("Siege - LST 3 Path"))
		table.insert(Mission.LSTPaths, FindEntity("Siege - LST 4 Path"))
		table.insert(Mission.LSTPaths, FindEntity("Siege - LST 5 Path"))
		table.insert(Mission.LSTPaths, FindEntity("Siege - LST 6 Path"))

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
	Mission.ResourceUSYorktown = 120
	Mission.ResourceUSLST = 8
	Mission.ResourceUSWildcat = 4
	Mission.ResourceUSDauntless = 4
	Mission.ResourceJapHQ = 5
	Mission.ResourceJapZero = 5
	Mission.ResourceJapFortressLong = 100
	Mission.ResourceJapFortressTower = 50
	Mission.ResourcePlayerUnit = 15
	Mission.ResourceJapCoastAA = 4

	Mission.PreviousHPPercentageHQ1 = 1
	Mission.PreviousHPPercentageHQ2 = 1

---------------------------

	-- objektivak
	DoFile("scripts/datatables/Scoring.lua") -- feltoltjuk a Scoring tablat (kesobb ki kell szedni)
		this.Objectives = {
		["primary"] = {
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_primary_1",
				["Text"] = "mp05.obj_siege_us_p1_text",
				["TextCompleted"] = "mp05.obj_siege_us_p1_comp",
				["TextFailed"] = "mp05.obj_siege_us_p1_fail",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 500,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_primary_1",
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
				["ID"] = "us_obj_primary_2",
				["Text"] = "At least one of carriers should survive!",
				["TextCompleted"] = "You have successfully protected a carrier!",
				["TextFailed"] = "You failed to protect the carriers!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 600,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[4] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_primary_2",
				["Text"] = "Destroy all of the carriers!",
				["TextCompleted"] = "You have successfully destroyed the carriers!",
				["TextFailed"] = "You failed destroy the carriers!",
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
			[1] = {
				["Party"] = PARTY_ALLIED,
				["ID"] = "us_obj_secondary_1",
				["Text"] = "At least one of the landing ships should survive!",
				["TextCompleted"] = "You have successfully protected some of the landing ships!",
				["TextFailed"] = "You failed to protect the landing ships!",
				["Active"] = false,
				["Success"] = nil,
				["Target"] = {},
				["ScoreCompleted"] = 200,	-- teljesitesert jaro pontszam,
				["ScoreFailed"] = 0
			},
			[2] = {
				["Party"] = PARTY_JAPANESE,
				["ID"] = "jap_obj_secondary_1",
				["Text"] = "Destroy the landing ships before they reach the shore!",
				["TextCompleted"] = "Your forces have successfully destroyed the landing boats!",
				["TextFailed"] = "Your forces have failed to destroy the landing boats!",
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

    SetThink(this, "luaQAS5Mission_think")
end

function luaQAS5Mission_think(this, msg)
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
--[[
-- RELEASE_LOGOFF  		luaLog("-- PLANE DEBUG --")
		local planesinscene = luaGetPlanesAroundCoordinate(GetPosition(Mission.HQs[1]), 20000, PARTY_JAPANESE, "own")
		if planesinscene ~= nil then
-- RELEASE_LOGOFF  			luaLog("  Japanese planesinscene (all): "..tostring(table.getn(planesinscene)))
		end
]]
		luaQAS5CheckCVs()
		luaQAS5CheckLSTs()
		luaQAS5CheckFighterPlanes()
		luaQAS5CheckBomberPlanes()
		luaCheckPlayers()
		luaQAS5CheckForts()
		--luaQAS5CheckMissionEnd()
		luaQAS5HintManager()

	elseif not Mission.Started then
		luaQAS5StartMission()
		luaSetMultiScoreTable()
	end
end

function luaQAS5StartMission()
-- RELEASE_LOGOFF  	luaLog(" Starting mission...")
	Scoring_RealPlayTimeRunning(true)

	luaShowMissionHint()
	
	luaMultiVoiceOverHandler()

	Music_Control_SetLevel(MUSIC_ACTION)

	-- fortress long
	AISetTargetWeight(23, 66, false, 4)
	AISetTargetWeight(25, 66, false, 4)
	-- fortress left tower
	AISetTargetWeight(23, 84, false, 5)
	AISetTargetWeight(25, 84, false, 5)

	luaObj_Add("primary", 1)
	luaObj_Add("primary", 2)
	luaObj_AddUnit("primary", 1, Mission.HQs[1])
	luaObj_AddUnit("primary", 1, Mission.HQs[2])
	luaObj_AddUnit("primary", 2, Mission.HQs[1])
	luaObj_AddUnit("primary", 2, Mission.HQs[2])
	luaObj_Add("secondary", 1)
	for index, unit in pairs (Mission.Fortresses) do
		luaObj_AddUnit("secondary", 1, unit)
		SetSkillLevel(unit, SKILL_SPNORMAL)
		if unit.Class.ID == 66 or unit.Class.ID == 84 then
			AISetHintWeight(unit, 4)
		else
			AISetHintWeight(unit, 1)
		end
	end
	--luaObj_Add("primary", 3)
	--luaObj_Add("primary", 4)
	--luaObj_Add("secondary", 1)
	--luaObj_Add("secondary", 2)

	--luaObj_AddUnit("primary", 1, Mission.HQs[1])
	--luaObj_AddUnit("primary", 2, Mission.HQs[1])

	for i = 1, 6 do
-- RELEASE_LOGOFF  		luaLog(" generating LST")
		local lst = GenerateObject(Mission.LSTTMPL.Name, Mission.LSTSpawnPositions[i])
		--PutTo(lst, Mission.LSTSpawnPositions[i])
		EntityTurnToEntity(lst, Mission.HQs[1])
		NavigatorMoveOnPath(lst, Mission.LSTPaths[i])
		NavigatorSetTorpedoEvasion(lst, false)
		NavigatorSetAvoidLandCollision(lst, false)
		--NavigatorMoveToRange(lst, Mission.HQs[1])
		--luaObj_AddUnit("secondary", 1, lst)
		--luaObj_AddUnit("secondary", 2, lst)
		table.insert(Mission.LSTs, lst)
	end
--[[
	for i = 1, 3 do
		PutTo(Mission.CVs[i], Mission.CVSpawnPositions[i])
		EntityTurnToEntity(Mission.CVs[i], Mission.HQs[1])
		--luaObj_AddUnit("primary", 3, Mission.CVs[i])
		--luaObj_AddUnit("primary", 4, Mission.CVs[i])
	end
]]
	--for i = 1, 3 do
	for i = 1, 2 do
		local hqpos = GetPosition(Mission.HQs[1])
		local posmod = 75 * i
		local pos = {["x"] = hqpos["x"] - posmod, ["y"] = 350, ["z"] = hqpos["z"] - posmod}
-- RELEASE_LOGOFF  		luaLog(" generating Zero")
		local zero = GenerateObject(Mission.ZeroTMPL.Name, pos)
		--PutTo(zero, pos)
		EntityTurnToEntity(zero, Mission.CVs[2])
		PilotMoveTo(zero, Mission.MeetingPoint)
		table.insert(Mission.Zeroes, zero)
	end
-- RELEASE_LOGOFF  	luaLog(" number of Zeroes in the scene: "..tostring(table.getn(Mission.Zeroes)))

	--for i = 1, 6 do
	for i = 1, 3 do
		local spawnpos = 0
		if i <= 2 then
			local cvpos = GetPosition(Mission.CVs[1])
			local posmod = 75 * i
			spawnpos = {["x"] = cvpos["x"] - posmod, ["y"] = 350, ["z"] = cvpos["z"] - posmod}
		elseif i <= 4 then
			local cvpos = GetPosition(Mission.CVs[2])
			local posmod = 75 * ( i - 2 )
			spawnpos = {["x"] = cvpos["x"] - posmod, ["y"] = 350, ["z"] = cvpos["z"] - posmod}
		elseif i <= 6 then
			local cvpos = GetPosition(Mission.CVs[3])
			local posmod = 75 * ( i - 4 )
			spawnpos = {["x"] = cvpos["x"] - posmod, ["y"] = 350, ["z"] = cvpos["z"] - posmod}
		end
-- RELEASE_LOGOFF  		luaLog(" generating Wildcat")
		local wildcat = GenerateObject(Mission.WildcatTMPL.Name, spawnpos)
		--PutTo(wildcat, spawnpos)
		EntityTurnToEntity(wildcat, Mission.HQs[1])
		PilotMoveTo(wildcat, Mission.MeetingPoint)
		table.insert(Mission.Wildcats, wildcat)
	end

	--for i = 1, 3 do
	for i = 1, 2 do
		local cvpos = GetPosition(Mission.CVs[i])
		local spawnpos = {["x"] = cvpos["x"], ["y"] = 200, ["z"] = cvpos["z"]}
		local bomber = GenerateObject(Mission.DauntlessTMPL.Name, spawnpos)
		--PutTo(bomber, spawnpos)
		EntityTurnToEntity(bomber, Mission.HQs[1])
		SetSkillLevel(bomber, SKILL_MPNORMAL)
		PilotSetTarget(bomber, Mission.Fortresses[4])
		table.insert(Mission.Bombers, bomber)
	end

	for i = 1, 3 do
		NavigatorSetAvoidShipCollision(Mission.CVs[i], false)
		NavigatorSetAvoidLandCollision(Mission.CVs[i], false)
	end

	Mission.Started = true
end

function luaQAS5CheckCVs()
-- RELEASE_LOGOFF  	luaLog(" Checking carriers...")
	if table.getn(Mission.CVs) ~= 0 then
		for index, unit in pairs (Mission.CVs) do
			if unit.Dead and not unit.ignore then
-- RELEASE_LOGOFF  				luaLog("  dead CV found, forcing adding ignore flag")
				luaResourcePoolReducer("yorktown")
				unit.ignore = true
				--Mission.KeyUnitCounter = Mission.KeyUnitCounter - 1
				--ModifyKeyUnitNumber(Mission.KeyUnitCounter)
			end
		end
	end
end

function luaQAS5CheckLSTs()
-- RELEASE_LOGOFF  	luaLog(" Checking landing ships...")
	if table.getn(Mission.LSTs) ~= 0 then
		for index, unit in pairs (Mission.LSTs) do
			if unit.Dead then
				Mission.LSTs[index] = GenerateObject(Mission.LSTTMPL.Name, Mission.LSTSpawnPositions[index])
				luaResourcePoolReducer("LST")
				--PutTo(Mission.LSTs[index], Mission.LSTSpawnPositions[index])
				EntityTurnToEntity(Mission.LSTs[index], Mission.HQs[1])
				NavigatorMoveToRange(Mission.LSTs[index], Mission.HQs[1])
				NavigatorSetTorpedoEvasion(Mission.LSTs[index], false)
				NavigatorSetAvoidLandCollision(Mission.LSTs[index], false)
				--if luaObj_IsActive("secondary", 1) and luaObj_GetSuccess("secondary", 1) == nil and luaObj_IsActive("secondary", 2) and luaObj_GetSuccess("secondary", 2) == nil then
					--luaObj_AddUnit("secondary", 1, Mission.LSTs[index])
					--luaObj_AddUnit("secondary", 2, Mission.LSTs[index])
				--end
			elseif not unit.landing then
				if luaGetDistance(unit, Mission.HQs[1]) < 1000 then
					unit.landing = true
					StartLanding2(unit)
				end
			end
		end
	end
end

function luaQAS5CheckFighterPlanes()
-- RELEASE_LOGOFF  	luaLog(" Checking fighter planes...")
	if Mission.HQs[1].Party ~= PARTY_JAPANESE then
-- RELEASE_LOGOFF  		luaLog("  no more planes allowed")
		return
	end

	if table.getn(Mission.Zeroes) ~= 0 then
		local mod = 1
		for index, unit in pairs (Mission.Zeroes) do
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead Zero found")
				local hqpos = GetPosition(Mission.HQs[1])
				local posmod = 75 * mod
				local pos = {["x"] = hqpos["x"] - posmod, ["y"] = 350, ["z"] = hqpos["z"] - posmod}
				Mission.Zeroes[index] = GenerateObject(Mission.ZeroTMPL.Name, pos)
				by = luaCheckPlaneNumber(unit)
				luaResourcePoolReducer("zero", by)
				--PutTo(Mission.Zeroes[index], pos)
				EntityTurnToPosition(Mission.Zeroes[index], Mission.MeetingPoint)
				PilotMoveTo(Mission.Zeroes[index], Mission.MeetingPoint)
				mod = mod + 1
			else
				previouscheck = luaCheckPlaneNumber(unit)
				local planesinsquad = table.getn(GetSquadronPlanes(unit))
				if planesinsquad < previouscheck then
					by = previouscheck - planesinsquad
					unit.checkednumber = planesinsquad
					luaResourcePoolReducer("zero", by)
				elseif planesinsquad == 3 then
					unit.checkednumber = planesinsquad
				end
			end
		end
	end

	if table.getn(Mission.Wildcats) ~= 0 then
		local mod1 = 1
		local mod2 = 1
		local mod3 = 1
		for index, unit in pairs (Mission.Wildcats) do
			local spawnpos = 0
			if unit.Dead then
-- RELEASE_LOGOFF  				luaLog("  dead wildcat found")
				if index <= 2 and not Mission.CVs[1].ignore then
-- RELEASE_LOGOFF  					luaLog("   CV1 spawn")
					local cvpos = GetPosition(Mission.CVs[1])
					local posmod = 75 * mod1
					spawnpos = {["x"] = cvpos["x"] - posmod, ["y"] = 350, ["z"] = cvpos["z"] - posmod}
					Mission.Wildcats[index] = GenerateObject(Mission.WildcatTMPL.Name, spawnpos)
					by = luaCheckPlaneNumber(unit)
					luaResourcePoolReducer("wildcat", by)
					mod1 = mod1 + 1
					EntityTurnToPosition(Mission.Wildcats[index], Mission.MeetingPoint)
					PilotMoveTo(Mission.Wildcats[index], Mission.MeetingPoint)
				elseif index <= 4 and not Mission.CVs[2].ignore then
-- RELEASE_LOGOFF  					luaLog("   CV2 spawn")
					local cvpos = GetPosition(Mission.CVs[2])
					local posmod = 75 * mod2
					spawnpos = {["x"] = cvpos["x"] - posmod, ["y"] = 350, ["z"] = cvpos["z"] - posmod}
					Mission.Wildcats[index] = GenerateObject(Mission.WildcatTMPL.Name, spawnpos)
					by = luaCheckPlaneNumber(unit)
					luaResourcePoolReducer("wildcat", by)
					mod2 = mod2 + 1
					EntityTurnToPosition(Mission.Wildcats[index], Mission.MeetingPoint)
					PilotMoveTo(Mission.Wildcats[index], Mission.MeetingPoint)
				elseif index <= 6 and not Mission.CVs[3].ignore then
-- RELEASE_LOGOFF  					luaLog("   CV3 spawn")
					local cvpos = GetPosition(Mission.CVs[3])
					local posmod = 75 * mod3
					spawnpos = {["x"] = cvpos["x"] - posmod, ["y"] = 350, ["z"] = cvpos["z"] - posmod}
					Mission.Wildcats[index] = GenerateObject(Mission.WildcatTMPL.Name, spawnpos)
					by = luaCheckPlaneNumber(unit)
					luaResourcePoolReducer("wildcat", by)
					mod3 = mod3 + 1
					EntityTurnToPosition(Mission.Wildcats[index], Mission.MeetingPoint)
					PilotMoveTo(Mission.Wildcats[index], Mission.MeetingPoint)
				end
			else
				previouscheck = luaCheckPlaneNumber(unit)
				local planesinsquad = table.getn(GetSquadronPlanes(unit))
				if planesinsquad < previouscheck then
					by = previouscheck - planesinsquad
					unit.checkednumber = planesinsquad
					luaResourcePoolReducer("wildcat", by)
				elseif planesinsquad == 3 then
					unit.checkednumber = planesinsquad
				end
			end
		end
	end
end

function luaQAS5CheckBomberPlanes()
-- RELEASE_LOGOFF  	luaLog(" Checking bomber planes...")
	if table.getn(Mission.Bombers) ~= 0 then
		for index, unit in pairs (Mission.Bombers) do
			if unit.Dead and not Mission.CVs[index].ignore then
				local cvpos = GetPosition(Mission.CVs[index])
				local spawnpos = {["x"] = cvpos["x"], ["y"] = 200, ["z"] = cvpos["z"]}
				Mission.Bombers[index] = GenerateObject(Mission.DauntlessTMPL.Name, spawnpos)
				by = luaCheckPlaneNumber(unit)
				luaResourcePoolReducer("dauntless", by)
				--PutTo(Mission.Bombers[index], spawnpos)
				EntityTurnToEntity(Mission.Bombers[index], Mission.HQs[1])
				SetSkillLevel(Mission.Bombers[index], SKILL_MPNORMAL)
				luaQAS5AssignTarget(Mission.Bombers[index])
			elseif not unit.Dead then
				if UnitGetAttackTarget(unit) == nil then
					luaQAS5AssignTarget(Mission.Bombers[index])
				end
				previouscheck = luaCheckPlaneNumber(unit)
				local planesinsquad = table.getn(GetSquadronPlanes(unit))
				if planesinsquad < previouscheck then
					by = previouscheck - planesinsquad
					unit.checkednumber = planesinsquad
					luaResourcePoolReducer("dauntless", by)
				elseif planesinsquad == 3 then
					unit.checkednumber = planesinsquad
				end
			end
		end
	end
end

function luaQAS5AssignTarget(unit)
	if not Mission.Fortresses[4].Dead then
		PilotSetTarget(unit, Mission.Fortresses[4])
	elseif not Mission.Fortresses[2].Dead then
		PilotSetTarget(unit, Mission.Fortresses[2])
	elseif not Mission.Fortresses[1].Dead then
		PilotSetTarget(unit, Mission.Fortresses[1])
	elseif not Mission.Fortresses[3].Dead then
		PilotSetTarget(unit, Mission.Fortresses[4])
	elseif not Mission.Fortresses[5].Dead then
		PilotSetTarget(unit, Mission.Fortresses[5])
	elseif not Mission.Fortresses[6].Dead then
		PilotSetTarget(unit, Mission.Fortresses[6])
	elseif not Mission.Fortresses[7].Dead then
		PilotSetTarget(unit, Mission.Fortresses[7])
	elseif not Mission.Fortresses[8].Dead then
		PilotSetTarget(unit, Mission.Fortresses[8])
	elseif Mission.HQs[1].Party == PARTY_JAPANESE then
		PilotSetTarget(unit, Mission.HQs[1])
	end
end

function luaQAS5CheckMissionEnd()
-- RELEASE_LOGOFF  	luaLog(" Checking mission end conditions...")
	if not Mission.MissionEndCalled then
		if Mission.HQs[1].Party ~= PARTY_JAPANESE or Mission.HQs[2].Party ~= PARTY_JAPANESE then -- or Mission.KeyUnitCounter == 0 then
-- RELEASE_LOGOFF  			luaLog("  HQ party "..tostring(Mission.HQs[1].Party).." | key unit counter: "..tostring(Mission.KeyUnitCounter))
			Mission.ResourceJapPool = 0
			for i = 0, 7 do
				MultiScore[i][1] = Mission.ResourceUSPool
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			for index, unit in pairs (Mission.LSTs) do
				if not unit.Dead then
					NavigatorMoveToRange(unit, Mission.CVSpawnPositions[2])
				end
			end
			luaQAS5MissionEnd()
		end
	end
end

function luaQAS5MissionEnd()
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
		luaMissionCompletedNew(Mission.HQs[1], "", nil, nil, nil, PARTY_JAPANESE)
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 or Mission.Randomize == 2 then
-- RELEASE_LOGOFF  		luaLog(" US side wins!")
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaMissionCompletedNew(Mission.HQs[1], "", nil, nil, nil, PARTY_ALLIED)
	end
--[[
	if Mission.HQs[1].Party == PARTY_JAPANESE then
-- RELEASE_LOGOFF  		luaLog("  the HQ is still in Japanese hands, Japanese side wins")
		luaObj_Failed("primary", 1)
		luaObj_Completed("primary", 2)
		luaObj_Failed("primary", 3)
		luaObj_Completed("primary", 4)
		luaObj_Failed("secondary", 1)
		luaObj_Completed("secondary", 2)
		luaMissionCompletedNew(Mission.HQs[1], "", nil, nil, nil, PARTY_JAPANESE)
	else
-- RELEASE_LOGOFF  		luaLog("  the HQ is neutral, Allied side wins")
		luaObj_Completed("primary", 1)
		luaObj_Failed("primary", 2)
		luaObj_Completed("primary", 3)
		luaObj_Failed("primary", 4)
		luaObj_Completed("secondary", 1)
		luaObj_Failed("secondary", 2)
		luaMissionCompletedNew(Mission.HQs[1], "", nil, nil, nil, PARTY_ALLIED)
	end
]]
end

function luaShowMissionHint()
	ShowHint("ID_Hint_Siege05")
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
	elseif unit == "zero" then
		local todeduct = Mission.ResourceJapZero * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "yorktown" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSYorktown
	elseif unit == "LST" then
		Mission.ResourceUSPool = Mission.ResourceUSPool - Mission.ResourceUSLST
	elseif unit == "wildcat" then
		local todeduct = Mission.ResourceUSWildcat * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "dauntless" then
		local todeduct = Mission.ResourceUSDauntless * by
		Mission.ResourceUSPool = Mission.ResourceUSPool - todeduct
	elseif unit == "japdestroyer" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapDestroyer
	elseif unit == "HQ" then
		local todeduct = Mission.ResourceJapHQ * by
		Mission.ResourceJapPool = Mission.ResourceJapPool - todeduct
	elseif unit == "fortresslong" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapFortressLong
	elseif unit == "fortresstower" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapFortressTower
	elseif unit == "coastaa" then
		Mission.ResourceJapPool = Mission.ResourceJapPool - Mission.ResourceJapCoastAA
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
		luaQAS5MissionEnd()
	elseif Mission.ResourceJapPool < 1 and Mission.ResourceUSPool > 0 then
-- RELEASE_LOGOFF  		luaLog(" Jap pool is under 1 point")
		for i = 0, 7 do
			MultiScore[i][1] = Mission.ResourceUSPool
			MultiScore[i][2] = 0
		end
		Mission.MissionEndCalled = true
		luaQAS5MissionEnd()
	elseif Mission.ResourceUSPool < 1 and Mission.ResourceJapPool < 1 then
-- RELEASE_LOGOFF  		luaLog(" both pools are under 1 point")
		Mission.Randomize = luaRnd(1, 2)
		if Mission.Randomize == 1 then
			for i = 0, 7 do
				MultiScore[i][1] = 0
				MultiScore[i][2] = 1
			end
			Mission.MissionEndCalled = true
			luaQAS5MissionEnd()
		else
			for i = 0, 7 do
				MultiScore[i][1] = 1
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaQAS5MissionEnd()
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
			if unit.Class.ID == 23 or unit.Class.ID == 25 then
				if not luaIsInside(unit, Mission.USTable) then
-- RELEASE_LOGOFF  					luaLog("  new player unit found, inserting it to Mission.USTable")
					table.insert(Mission.USTable, unit)
				end
			end
		end
	end

	if japships ~= nil then
		for index, unit in pairs (japships) do
			if unit.Class.ID == 73 or unit.Class.ID == 75 then
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

function luaQAS5CheckForts()
-- RELEASE_LOGOFF  	luaLog(" Checking fortresses..")
	local fortalive = 0
	for index, unit in pairs (Mission.Fortresses) do
		if unit.Dead and not unit.ignore then
-- RELEASE_LOGOFF  			luaLog("  dead fortress found ID: "..tostring(unit.Class.ID))
			if unit.Class.ID == 66 then
				luaResourcePoolReducer("fortresslong")
			elseif unit.Class.ID == 84 then
				luaResourcePoolReducer("fortresstower")
			elseif unit.Class.ID == 450 or unit.Class.ID == 452 then
				luaResourcePoolReducer("coastaa")
			end
			unit.ignore = true
		else
			fortalive = fortalive + 1
		end
	end

	if fortalive == 0 and not Mission.AllFortsDown then
		Mission.AllFortsDown = true
		luaObj_Completed("secondary", 1)
	end

	local threshold = GetHpPercentage(Mission.HQs[1]) + 0.01
	if threshold < Mission.PreviousHPPercentageHQ1 then
		local difference = Mission.PreviousHPPercentageHQ1 - GetHpPercentage(Mission.HQs[1])
		local percentage = difference * 100
		local by = luaRound(percentage)
		luaResourcePoolReducer("HQ", by)
		Mission.PreviousHPPercentageHQ1 = GetHpPercentage(Mission.HQs[1])
	end

	local threshold = GetHpPercentage(Mission.HQs[2]) + 0.01
	if threshold < Mission.PreviousHPPercentageHQ2 then
		local difference = Mission.PreviousHPPercentageHQ2 - GetHpPercentage(Mission.HQs[2])
		local percentage = difference * 100
		local by = luaRound(percentage)
		luaResourcePoolReducer("HQ", by)
		Mission.PreviousHPPercentageHQ2 = GetHpPercentage(Mission.HQs[2])
	end

	if not Mission.MissionEndCalled then
		if Mission.HQs[1].Party ~= PARTY_JAPANESE or Mission.HQs[1].Party ~= PARTY_JAPANESE then
			Mission.ResourceJapPool = 0
			for i = 0, 7 do
				MultiScore[i][1] = Mission.ResourceUSPool
				MultiScore[i][2] = 0
			end
			Mission.MissionEndCalled = true
			luaQAS5MissionEnd()
		end
	end
end

function luaQAS5HintManager()
	if not Mission.Completed and not Mission.MissionEnd then
-- RELEASE_LOGOFF  		luaLog(" Managing hints...")
		if GameTime() > 30 and not Mission.Hint1Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint1Shown")
			ShowHint("ID_Hint_Siege05_carriers")
			Mission.Hint1Shown = true
		elseif GameTime() > 60 and not Mission.Hint2Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint2Shown")
			ShowHint("ID_Hint_Siege05_Fort")
			Mission.Hint2Shown = true
		elseif GameTime() > 90 and not Mission.Hint3Shown then
-- RELEASE_LOGOFF  			luaLog("  Hint3Shown")
			ShowHint("ID_Hint_Siege05_bombers")
			Mission.Hint3Shown = true
		end
	end
end